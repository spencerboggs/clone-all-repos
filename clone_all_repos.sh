#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./filename.sh username"
    exit 1
fi

USERNAME="$1"
PAGE=1

while :; do
    REPOS=$(curl -s "https://api.github.com/users/$USERNAME/repos?page=$PAGE&per_page=100" | jq -r '.[].clone_url')

    if [[ -z "$REPOS" ]]; then
        echo "All repositories for $USERNAME have been cloned."
        break
    fi

    for REPO in $REPOS; do
        echo "Cloning $REPO..."
        git clone "$REPO"
    done

    PAGE=$((PAGE + 1))
done
