#!/bin/sh

C='\033[0;32m'
N='\033[0m'

say() {
    echo "\n${C}>${N} $1"
}

say "Installing Node.js packages..."
npm install --loglevel error

say "Installing type definitions..."
typings install 2>/dev/null

say "Creating initial development build..."
gulp build
gulp bundle

say "Initializing Git repository..."
git init
git add .
git commit -m "Initial commit from generator-phaser-ts"

HEROKU_USER="$(heroku auth:whoami)"
if hash heroku 2>/dev/null && [ "$HEROKU_USER" != "not logged in" ]; then
    say "Heroku user detected. Creating Heroku app..."
    heroku create
else
    say "Not creating Heroku app. Install the Heroku CLI, login, and then `heroku create`."
fi

say "All done! Run \`npm start\` to preview your new game."
