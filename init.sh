#!/bin/sh

set -e  # Exit on error
echo "Starting initialization script..."

# Function to log with timestamp
log() {
    echo "[$(date +%T)] $1"
}

# Function to handle errors
handle_error() {
    log "Error occurred in script at line $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

if [ ! -f package.json ]; then
    log "Creating Next.js project..."
    
    # Create project directly in /app (no temp directory)
    create-next-app . \
        --typescript \
        --tailwind \
        --eslint \
        --app \
        --use-npm \
        --no-src-dir \
        --yes
    
    log "Next.js project created. Current directory contents:"
    ls -la
    
    log "Installing additional dependencies..."
    npm install --verbose
    
    log "Project initialization completed."
fi

log "Starting development server..."
npm run dev