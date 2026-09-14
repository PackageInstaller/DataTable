from __future__ import annotations

import argparse
import base64
import hashlib
import json
import os
import sys
import time
import zlib
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from threading import Lock
from typing import Any, Optional
from urllib.parse import urlparse

import requests
import UnityPy
from Crypto.Cipher import DES3
from Crypto.Util.Padding import unpad
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DATA_DIR = ROOT / "MasterData"
PAINTING_DIR = ROOT / "Painting"
UNITS_TABLE = MASTER_DATA_DIR / "mUnits.json"
LAYERS_TABLE = MASTER_DATA_DIR / "mLayers.json"
SUBUNITS_TABLE = MASTER_DATA_DIR / "mSubunits.json"
NAVI_ID = 1
NAVI_NAME = "ナビキャラクター"

GAME_TITLE = "草画"

APP_KEY = "amvBZLfOUWwAXoVu8xxGwibrwqGsneLR"
PLATFORM = "webgl"
REGION = "r18"
INITIAL_MANIFEST_URL = f"https://www-r18.gc.dmmgames.com/manifest/{PLATFORM}/{REGION}"
MANIFEST_JSON_FILES = ("master.json", "assetbundle.json")
DECRYPTION_KEY_HEX = "c53f2d9bd457d4a9985294b5e51fef04"

DEFAULT_JOBS = 32
MAX_RETRIES = 3
CHUNK_SIZE = 64 * 1024

console = Console()


def generate_secure_link(url: str, app_key: str, timestamp: int) -> str:
    parsed_url = urlparse(url)
    md5_input = f"{app_key}{parsed_url.path}{timestamp}"
    md5_hash = hashlib.md5(md5_input.encode("utf-8")).digest()
    s_value = base64.urlsafe_b64encode(md5_hash).decode("utf-8").rstrip("=")
    return f"{url}?s={s_value}&t={timestamp}"


def triple_des_text(encrypted_data: bytes | str) -> str:
    key_bytes = bytes.fromhex(DECRYPTION_KEY_HEX)
    full_key = key_bytes + key_bytes[:8]
    encrypted_bytes = base64.b64decode(
        encrypted_data.strip()
        if isinstance(encrypted_data, bytes)
        else encrypted_data.strip().encode("utf-8")
    )
    cipher = DES3.new(full_key, DES3.MODE_ECB)
    decrypted_bytes = unpad(cipher.decrypt(encrypted_bytes), DES3.block_size)
    intermediate_string = decrypted_bytes.decode("utf-8")
    compressed_bytes = base64.b64decode(intermediate_string.strip())
    decompressed_data = zlib.decompress(compressed_bytes, -zlib.MAX_WBITS)
    return decompressed_data.decode("utf-8")


def decrypt_master(master_dmm_bytes: bytes) -> int:
    MASTER_DATA_DIR.mkdir(parents=True, exist_ok=True)
    bundle = UnityPy.load(master_dmm_bytes)
    decrypted_count = 0
    for obj in bundle.objects:
        if obj.type.name != "TextAsset":
            continue
        data = obj.read()
        try:
            json_text = triple_des_text(data.m_Script)
            obj_data = json.loads(json_text)
        except Exception as exc:
            console.print(f"[red]解密失败[/red] {data.m_Name}: {exc}")
            continue
        output_path = MASTER_DATA_DIR / f"{data.m_Name}.json"
        output_path.write_text(
            json.dumps(obj_data, ensure_ascii=False, indent=1), encoding="utf-8"
        )
        decrypted_count += 1
    return decrypted_count


class Downloader:
    def __init__(self, jobs: int = DEFAULT_JOBS, asset_filter=None):
        self.session = requests.Session()
        self.jobs = jobs
        self.asset_filter = asset_filter
        self.files_to_download: list[dict[str, Any]] = []
        self.total_download_size = 0
        self.completed_files_count = 0
        self.lock = Lock()
        self.secure_timestamp = int(time.time()) + 3600
        self.master_dmm_bytes: Optional[bytes] = None
        self.base_resource_url = ""
        self.failures: list[tuple[str, str]] = []

    def _get_json(self, url: str) -> dict[str, Any]:
        response = self.session.get(url, timeout=(10, 60))
        response.raise_for_status()
        return response.json()

    def fetch_asset_lists(self) -> bool:
        initial_data = self._get_json(INITIAL_MANIFEST_URL)
        manifest_url = initial_data["contents"]["path"]
        manifest_data = self._get_json(manifest_url)
        self.base_resource_url = manifest_data["url"]["resource"]
        base_manifest_path = manifest_url.rsplit("/", 1)[0]

        console.print("[cyan]获取资源清单...[/cyan]")
        all_assets: list[dict[str, Any]] = []
        for json_file in MANIFEST_JSON_FILES:
            asset_data = self._get_json(f"{base_manifest_path}/{json_file}")
            rows = asset_data.get("d", []) if isinstance(asset_data, dict) else []
            console.print(f"{json_file}: {len(rows)} 条")
            all_assets.extend(rows)

        for asset in all_assets:
            if "n" not in asset or "s" not in asset:
                continue
            file_name = asset["n"]
            if self.asset_filter and not self.asset_filter(file_name):
                continue
            server_size = int(asset["s"])
            if file_name == "master.dmm":
                local_path = ROOT / MASTER_DATA_DIR.parent / MASTER_DATA_DIR.name / "master.dmm"
                local_path = MASTER_DATA_DIR / "master.dmm"
            else:
                local_path = ASSETS_DIR / file_name
            if local_path.is_file() and local_path.stat().st_size == server_size:
                if file_name == "master.dmm":
                    self.master_dmm_bytes = local_path.read_bytes()
                continue
            self.files_to_download.append(asset)
            self.total_download_size += server_size

        if not self.files_to_download:
            console.print("[green]所有目标文件都已是最新。[/green]")
            return False

        console.print(
            f"[yellow]待下载/更新[/yellow] {len(self.files_to_download)} 个，"
            f"共 {self.total_download_size / 1024 / 1024:.2f} MB"
        )
        return True

    def download_file(self, asset_info: dict[str, Any], progress: Progress, task_id) -> str:
        file_name = asset_info["n"]
        server_size = int(asset_info["s"])
        full_url = f"{self.base_resource_url}/{file_name}"
        secure_url = generate_secure_link(full_url, APP_KEY, self.secure_timestamp)
        local_path = MASTER_DATA_DIR / "master.dmm" if file_name == "master.dmm" else ASSETS_DIR / file_name
        local_path.parent.mkdir(parents=True, exist_ok=True)

        last_error: Optional[Exception] = None
        for attempt in range(1, MAX_RETRIES + 1):
            try:
                with self.session.get(secure_url, stream=True, timeout=(10, 120)) as resp:
                    resp.raise_for_status()
                    data = bytearray()
                    with local_path.open("wb") as f:
                        for chunk in resp.iter_content(CHUNK_SIZE):
                            if not chunk:
                                continue
                            f.write(chunk)
                            data.extend(chunk)
                            progress.update(task_id, advance=len(chunk))
                if local_path.stat().st_size != server_size:
                    raise RuntimeError(f"大小不符: {local_path.stat().st_size()} != {server_size}")
                if file_name == "master.dmm":
                    self.master_dmm_bytes = bytes(data)
                return "ok"
            except Exception as exc:
                last_error = exc
                if attempt < MAX_RETRIES:
                    time.sleep(2)
        with self.lock:
            self.failures.append((file_name, str(last_error)))
        return "fail"

    def run(self) -> bool:
        has_files = self.fetch_asset_lists()
        if has_files and self.files_to_download:
            with Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                BarColumn(),
                MofNCompleteColumn(),
                DownloadColumn(),
                TransferSpeedColumn(),
                TimeRemainingColumn(),
                console=console,
                transient=True,
            ) as progress:
                task_id = progress.add_task(
                    "下载资源", total=self.total_download_size or None
                )
                with ThreadPoolExecutor(max_workers=self.jobs) as pool:
                    futures = [pool.submit(self.download_file, x, progress, task_id) for x in self.files_to_download]
                    for future in as_completed(futures):
                        future.result()
                progress.remove_task(task_id)
        if self.failures:
            console.print("[yellow]失败清单(前 50):[/yellow]")
            for name, err in self.failures[:50]:
                console.print(f"  [red]{name}[/red]: {err}")
            return False
        return True


def should_download_painting(file_name: str) -> bool:
    return file_name.startswith(("image_unit_full/", "image_sub_unit_full/", "image_navi_chara_full/"))


def ml_name(value: Any, fallback: str = "") -> str:
    if isinstance(value, (list, tuple)):
        return str(value[0]).strip() if value and str(value[0]).strip() else fallback
    if isinstance(value, str):
        return value.strip() or fallback
    return fallback


def load_painting_tables():
    required = (UNITS_TABLE, LAYERS_TABLE, SUBUNITS_TABLE)
    missing = [str(x) for x in required if not x.is_file()]
    if missing:
        raise FileNotFoundError(f"缺数据表 {' / '.join(missing)}，先跑 data")

    units = json.loads(UNITS_TABLE.read_text(encoding="utf-8"))
    layers = json.loads(LAYERS_TABLE.read_text(encoding="utf-8"))
    subunits = json.loads(SUBUNITS_TABLE.read_text(encoding="utf-8"))

    unit_by_id = {str(x.get("id", "")): x for x in units}
    layer_by_image = {}
    for row in layers:
        image_index = str(row.get("image_index", ""))
        if image_index and image_index not in layer_by_image:
            layer_by_image[image_index] = row

    subunit_by_image = {}
    for row in subunits:
        image_index = str(row.get("image_index", ""))
        rid = str(row.get("id", ""))
        if image_index and image_index not in subunit_by_image:
            subunit_by_image[image_index] = row

    return unit_by_id, layer_by_image, subunit_by_image


def safe_fs_name(text: str) -> str:
    table = str.maketrans(
        {
            "/": "／", "\\": "＼", ":": "：", "*": "＊", "?": "？",
            '"': "'", "<": "＜", ">": "＞", "|": "｜",
            "\n": "", "\r": "", "\t": " ",
        }
    )
    out = text.translate(table).strip()
    return out or "未知"


def painting_filename(unit_name: str, layer_name: str, used: set[str]) -> str:
    parts = [GAME_TITLE, safe_fs_name(unit_name), safe_fs_name(layer_name)]
    base = "_".join(parts) + ".png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while True:
        name = "_".join(parts + [str(n)]) + ".png"
        if name not in used:
            used.add(name)
            return name
        n += 1


def resolve_painting_name(
    file_name: str,
    units: dict[str, dict[str, Any]],
    layers: dict[str, dict[str, Any]],
    subunits: dict[str, dict[str, Any]],
) -> tuple[str, str, bool]:
    stem = Path(file_name).stem
    prefix, image_index = stem[:1], stem[1:]
    if prefix == "u" and stem.startswith("uf"):
        image_index = stem[2:]
    elif prefix == "s" and stem.startswith("sf"):
        image_index = stem[2:]
        subunit = subunits.get(image_index)
        if subunit:
            unit = units.get(str(subunit.get("unit_id", "")))
            unit_name = ml_name(unit.get("ml_name"), image_index) if unit else image_index
            subunit_name = ml_name(subunit.get("ml_name"), image_index)
            return unit_name, subunit_name, True
        return image_index, image_index, False
    elif stem.isdigit():
        if int(stem) == NAVI_ID:
            return NAVI_NAME, "默认", True
        return stem, "默认", False
    else:
        return stem, stem, False

    layer = layers.get(image_index)
    if not layer:
        return image_index, image_index, False
    unit = units.get(str(layer.get("unit_id", "")))
    unit_name = ml_name(unit.get("ml_name"), image_index) if unit else image_index
    layer_name = ml_name(layer.get("ml_name"), image_index)
    return unit_name, layer_name, True


def export_painting_bundle(bundle_path: Path, dest: Path) -> str:
    env = UnityPy.load(str(bundle_path))
    textures = []
    for obj in env.objects:
        if obj.type.name not in ("Texture2D", "Sprite"):
            continue
        try:
            data = obj.read()
            image = data.image
            if image is not None:
                textures.append(image)
        except Exception:
            continue
    if not textures:
        return "skip"
    picked = max(textures, key=lambda x: x.width * x.height)
    dest.parent.mkdir(parents=True, exist_ok=True)
    picked.save(dest, "PNG")
    return "ok"


def cmd_assets(args) -> int:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    downloader = Downloader(jobs=args.jobs)
    if not downloader.run():
        return 1
    master = MASTER_DATA_DIR / "master.dmm"
    if master.is_file():
        count = decrypt_master(master.read_bytes())
        console.print(f"[green]数据表[/green] 解密 {count} 个 → {MASTER_DATA_DIR}")
    return 0


def cmd_data(args) -> int:
    MASTER_DATA_DIR.mkdir(parents=True, exist_ok=True)
    downloader = Downloader(jobs=args.jobs, asset_filter=lambda n: n == "master.dmm")
    if not downloader.run():
        return 1
    master = MASTER_DATA_DIR / "master.dmm"
    if not master.is_file():
        console.print(f"[red]缺文件[/red] {master}")
        return 1
    count = decrypt_master(master.read_bytes())
    console.print(f"[green]数据表[/green] 解密 {count} 个 → {MASTER_DATA_DIR}")
    return 0


def cmd_painting(args) -> int:
    units, layers, subunits = load_painting_tables()
    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    downloader = Downloader(
        jobs=args.jobs,
        asset_filter=should_download_painting,
    )
    # Painting bundles do not decrypt master data.
    downloader.run()
    source_dirs = (
        ASSETS_DIR / "image_unit_full",
        ASSETS_DIR / "image_sub_unit_full",
        ASSETS_DIR / "image_navi_chara_full",
    )
    existing = [x for x in source_dirs if x.is_dir()]
    if not existing:
        console.print(f"[red]缺立绘目录[/red] {source_dirs[0]}，先跑 painting/assets")
        return 1
    files = sorted(p for d in existing for p in d.glob("*.dmm"))
    if args.limit > 0:
        files = files[: args.limit]
    used_names: set[str] = set()
    jobs: list[tuple[Path, Path]] = []
    named = 0
    for bundle in files:
        unit_name, layer_name, hit = resolve_painting_name(
            bundle.name, units, layers, subunits
        )
        named += int(hit)
        dest = PAINTING_DIR / painting_filename(unit_name, layer_name, used_names)
        jobs.append((bundle, dest))
    console.print(
        f"[cyan]立绘名称[/cyan] mUnits/mLayers/mSubunits 命中 {named}/{len(jobs)} → {PAINTING_DIR}"
    )
    if not jobs:
        console.print("[yellow]没有 *_full/*.dmm 可导出[/yellow]")
        return 0

    written = skipped = failed = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=len(jobs))

        def work(item: tuple[Path, Path]) -> tuple[str, str, Optional[str]]:
            bundle, dest = item
            if dest.is_file() and not args.force:
                return "skip", bundle.name, None
            try:
                return export_painting_bundle(bundle, dest), bundle.name, None
            except Exception as exc:
                dest.unlink(missing_ok=True)
                return "fail", bundle.name, str(exc)

        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futures = [pool.submit(work, x) for x in jobs]
            for future in as_completed(futures):
                status, name, err = future.result()
                if status == "ok":
                    written += 1
                elif status == "skip":
                    skipped += 1
                else:
                    failed += 1
                    if err:
                        console.print(f"[red]立绘失败[/red] {name}: {err}")
                progress.advance(task)
    console.print(
        f"[bold green]Painting[/bold green] 写出 {written} 跳过 {skipped} 失败 {failed} → {PAINTING_DIR}"
    )
    return 0 if failed == 0 else 1


def cmd_all(args) -> int:
    if cmd_assets(args) != 0:
        return 1
    return cmd_painting(args)


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发线程数")

    parser = argparse.ArgumentParser(
        description=f"{GAME_TITLE} 资产 / 数据表 / 立绘下载导出",
        parents=[shared],
    )
    sub = parser.add_subparsers(dest="command")

    sub.add_parser("all", parents=[shared], help="全资产 + 数据表 + 立绘")
    sub.add_parser("assets", parents=[shared], help="全资产到 Assets/，master.dmm 解密到 MasterData/")
    sub.add_parser("data", aliases=["masterdata"], parents=[shared], help="仅下载并解密 master.dmm 到 MasterData/")
    p_painting = sub.add_parser("painting", parents=[shared], help="下载/导出角色立绘到 Painting/")
    p_painting.add_argument("--limit", type=int, default=0, help="只导出前 N 张，调试用")
    p_painting.add_argument("--force", action="store_true", help="覆盖已有 PNG")
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    if not args.command:
        parser.print_help()
        return 1
    if args.command == "all":
        return cmd_all(args)
    if args.command == "assets":
        return cmd_assets(args)
    if args.command in ("data", "masterdata"):
        return cmd_data(args)
    if args.command == "painting":
        return cmd_painting(args)
    return 1


if __name__ == "__main__":
    sys.exit(main())
