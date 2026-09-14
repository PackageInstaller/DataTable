from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
CACHE_DIR = ROOT / "_cache"

#: 热更 CDN
CDN_HOST = "https://drc1bk94f7rq8.cloudfront.net/"

#: 资源版本目录 换版本请自己抓包
ASSET_PATH = "909964b32d0d1717b5fbb50314f41208d69cf0b8"
MANIFEST_NAMES = {
    "base": "0fnnrb7mgd65pwa1uyu2u7jpsf0n0ge4",
    "full": "1fp32igvpoxnb521p9dqypak5cal0xv0",
}

USER_AGENT = "Dalvik/2.1.0 (Linux; U; Android 15; PIE110 Build/TP1A.220905.001)"
HTTP_TIMEOUT = 60
HTTP_RETRIES = 4


def manifest_url(name: str = "base", asset_path: str | None = None) -> str:
    return f"{CDN_HOST}{asset_path or ASSET_PATH}/{MANIFEST_NAMES[name]}"


def ensure_dirs() -> None:
    for path in (ASSETS_DIR, MASTER_DIR, CACHE_DIR):
        path.mkdir(parents=True, exist_ok=True)
