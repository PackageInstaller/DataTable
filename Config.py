from pathlib import Path

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
SWF_DIR = ROOT / "SWF"
CACHE_DIR = ROOT / "_cache"
PAINTING_DIR = ROOT / "Painting"


def _dir_has_entries(path: Path) -> bool:
    return path.is_dir() and any(path.iterdir())


def resolve_assets() -> Path:
    """优先使用 Assets/；若只有旧的 assets/，则挂成 Assets -> assets。"""
    if _dir_has_entries(ASSETS_DIR):
        return ASSETS_DIR
    legacy = ROOT / "assets"
    if _dir_has_entries(legacy):
        if not ASSETS_DIR.exists():
            try:
                ASSETS_DIR.symlink_to("assets")
            except OSError:
                return legacy
            return ASSETS_DIR
        return legacy
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    return ASSETS_DIR

INDEX_URL = "https://jdindex.gameduchy.com/index.txt"
USER_AGENT = (
    "Mozilla/5.0 (Android; U; zh-CN) "
    "AppleWebKit/533.19.4 (KHTML, like Gecko) AdobeAIR/51.2"
)
REFERER = "app:/ENCRYPTTank2014xMobilePreloader.swf"

GAME_SWFS = (
    "ENCRYPTTank2014xMobilePreloader.swf",
    "ENCRYPTTank2014xMobileContent.swf",
    "worker/TankWorker.swf",
    "worker/UnzipWorker.swf",
)

CUSTOM_B64_ALPHABET = (
    "ABCDEFGHIJKLMN0PQRSTUVWXYZabcdefghijklmnopqrstuvwxyzO123456789,;"
)
CUSTOM_B64_PAD = "("
