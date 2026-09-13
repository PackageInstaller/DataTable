from __future__ import annotations

import argparse
import json
import shutil
import threading
import warnings
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any

import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.table import Table

import ReslerianaApk as Apk
import ReslerianaMasterData as MasterData
import ReslerianaText as TextAsset
import ReslerianaVersion as Version
from ReslerianaBundle import BundleInfo, decrypt_bundle, is_aktk_bundle
from ReslerianaCatalog import Catalog

GAME_TITLE = "Atelier Resleriana / レスレリ"
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
CACHE_DIR = ROOT / "Cache"
VERSIONS_FILE = ROOT / "versions.json"

DEFAULT_SERVER = "Japan"
DEFAULT_PLATFORM = "Android"
CONCURRENT = 8
RETRY = 4
TIMEOUT = 120
CHUNK = 1 << 20

console = Console()
HTTP_HEADERS = {
    "User-Agent": "UnityPlayer/2022.3.62f2 (Android)",
    "Accept": "*/*",
}

_tls = threading.local()


def session() -> requests.Session:
    """每个线程一个 Session，复用连接（否则 5600 个文件要握手 5600 次）。"""
    sess = getattr(_tls, "session", None)
    if sess is None:
        sess = requests.Session()
        sess.headers.update(HTTP_HEADERS)
        _tls.session = sess
    return sess



def format_size(size: float) -> str:
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{size:.0f} B"


def make_progress(*extra: Any) -> Progress:
    return Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        *extra,
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
    )


def catalog_url(server: str, version: str, platform: str) -> str:
    return Version.CATALOG_URL[server].format(version=version, platform=platform)


def bundle_url(server: str, version: str, platform: str, relative_path: str) -> str:
    base = Version.CDN_HOSTS[server]
    return f"{base}/asset/{version}/{platform}/{relative_path}"


def download(url: str, dest: Path, *, force: bool = False, on_bytes: Any | None = None) -> bool:
    """带重试的下载；已存在且大小一致则跳过。返回是否真的下载了。"""
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_suffix(dest.suffix + ".part")
    last: Exception | None = None
    for attempt in range(1, RETRY + 1):
        got = 0
        try:
            with session().get(url, stream=True, timeout=TIMEOUT) as resp:
                resp.raise_for_status()
                total = int(resp.headers.get("Content-Length") or 0)
                if not force and dest.is_file() and total and dest.stat().st_size == total:
                    return False
                with tmp.open("wb") as handle:
                    for chunk in resp.iter_content(CHUNK):
                        if not chunk:
                            continue
                        handle.write(chunk)
                        got += len(chunk)
                        if on_bytes is not None:
                            on_bytes(len(chunk))
                tmp.replace(dest)
                return True
        except Exception as exc:  # noqa: BLE001
            last = exc
            if on_bytes is not None and got:
                on_bytes(-got)
            tmp.unlink(missing_ok=True)
    raise RuntimeError(f"下载失败 {url}: {last}")


def download_and_decrypt(
    bundle: BundleInfo,
    url: str,
    dest: Path,
    *,
    force: bool = False,
    on_bytes: Any | None = None,
) -> bool:
    """下载 → 流式解密 → 落盘（内存占用与文件大小无关）。"""
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file() and not force:
        with dest.open("rb") as handle:
            if handle.read(8).startswith(b"UnityFS"):
                return False
    tmp = dest.with_suffix(dest.suffix + ".part")
    download(url, tmp, force=True, on_bytes=on_bytes)
    dec = dest.with_suffix(dest.suffix + ".dec")
    try:
        decrypt_bundle_file(tmp, dec, bundle)
        dec.replace(dest)
    finally:
        tmp.unlink(missing_ok=True)
        dec.unlink(missing_ok=True)
    return True


def decrypt_bundle_file(src: Path, dest: Path, bundle: BundleInfo) -> None:
    """流式解密（走 ReslerianaBundle.transform_file）。"""
    import ReslerianaBundle as RB

    RB.transform_file(src, dest, bundle)


def load_or_fetch_catalog(
    server: str,
    version: str,
    platform: str,
    *,
    force: bool = False,
) -> tuple[Catalog, Path]:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    dest = CACHE_DIR / f"catalog_{server}_{platform}_{version}.json"
    if not dest.is_file() or force:
        url = catalog_url(server, version, platform)
        console.print(f"[cyan]下载 catalog[/cyan] {url}")
        download(url, dest, force=force)
    catalog = Catalog.load(dest)
    return catalog, dest


def resolve_versions(args: argparse.Namespace) -> dict[str, str]:
    server = args.server
    versions = Version.resolve(
        server,
        fileassets_version=getattr(args, "fileassets_version", "") or "",
        masterdata_version=getattr(args, "masterdata_version", "") or "",
        cache_path=VERSIONS_FILE,
        use_cdn=not getattr(args, "no_cdn_version", False),
        use_mirror=not getattr(args, "no_mirror_version", False),
        use_login=getattr(args, "login", False),
        platform=getattr(args, "platform", DEFAULT_PLATFORM),
        on_info=lambda message: console.print(f"[yellow]{message}[/yellow]"),
    )
    _warn_stale_asset_version(versions)
    return versions


def _warn_stale_asset_version(versions: dict[str, str]) -> None:
    asset = versions.get("fileassets_version") or ""
    master = versions.get("masterdata_version") or ""

    def stamp(value: str) -> int:
        try:
            return int(value.split("_", 1)[0])
        except (ValueError, IndexError):
            return 0

    asset_ts, master_ts = stamp(asset), stamp(master)
    if asset_ts and master_ts and master_ts - asset_ts > 45 * 86400:
        console.print(
            f"[red]注意[/red]：CDN 列表里的 asset 版本（{asset}）明显早于 masterdata "
            f"（{master}），CDN 列表可能只列出了最旧的一页。\n"
            "       请用 [bold]--fileassets-version[/bold] 指定当前版本，"
            "或在 versions.json 里填好后重跑。"
        )


# ---------------------------------------------------------------------------
# 子命令：version
# ---------------------------------------------------------------------------

def cmd_version(args: argparse.Namespace) -> None:
    versions = resolve_versions(args)
    table = Table(title=f"{GAME_TITLE} / {args.server}")
    table.add_column("字段")
    table.add_column("值")
    table.add_row("fileassets_version", versions.get("fileassets_version") or "-")
    table.add_row("masterdata_version", versions.get("masterdata_version") or "-")
    table.add_row("platform", args.platform)
    console.print(table)
    console.print(f"版本缓存：[green]{VERSIONS_FILE}[/green]")


# ---------------------------------------------------------------------------
# 子命令：catalog
# ---------------------------------------------------------------------------

def cmd_catalog(args: argparse.Namespace) -> None:
    versions = resolve_versions(args)
    version = versions.get("fileassets_version")
    if not version:
        console.print("[red]缺少 fileassets_version[/red]，先跑 version 或手工指定")
        return
    catalog, raw_path = load_or_fetch_catalog(args.server, version, args.platform, force=args.force)
    console.print(
        f"[green]catalog[/green] {args.platform} {version}  "
        f"{len(catalog.bundles)} 个 bundle  {format_size(sum(b.file_size for b in catalog.bundles))}"
    )
    out_dir = ASSETS_DIR / "Catalog"
    out_dir.mkdir(parents=True, exist_ok=True)
    readable_path = out_dir / f"{args.server}_{args.platform}_catalog.json"
    readable_path.write_text(
        json.dumps(catalog.readable(include_resources=args.with_resources), ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    console.print(f"[green]写出[/green] {readable_path}")
    console.print(f"原始 catalog 缓存：{raw_path}")


# ---------------------------------------------------------------------------
# 子命令：assets
# ---------------------------------------------------------------------------

def _decrypt_apk_bundles(force: bool) -> int:
    """解密 APK 里 Embed 目录的 bundle（元数据来自 apk 自带的 catalog）。"""
    aa_dir = ASSETS_DIR / "aa"
    catalog_path = aa_dir / "catalog.json"
    if not catalog_path.is_file():
        console.print("[yellow]没有 assets/aa/catalog.json，跳过 Embed 解密[/yellow]")
        return 0
    catalog = Catalog.load(catalog_path)
    done = 0
    for bundle in catalog.bundles:
        src = aa_dir / bundle.relative_path
        if not src.is_file():
            continue
        head = src.read_bytes()[:12]
        if not is_aktk_bundle(head + b"\x00" * max(0, 16 - len(head))):
            continue
        data = src.read_bytes()
        if not force and data[:8] == b"UnityFS\x00":
            continue
        try:
            plain = decrypt_bundle(data, bundle)
        except Exception as exc:  # noqa: BLE001
            console.print(f"[red]解密失败[/red] {bundle.relative_path}: {exc}")
            continue
        if plain != data:
            src.write_bytes(plain)
            done += 1
    return done


def _hotfix_todo(
    catalog: Catalog,
    *,
    only_text: bool,
    force: bool,
) -> list[BundleInfo]:
    todo: list[BundleInfo] = []
    if only_text:
        wanted = {b.relative_path for b in catalog.text_asset_bundles()}
    else:
        wanted = set()
    for bundle in catalog.bundles:
        if only_text and bundle.relative_path not in wanted:
            continue
        dest = ASSETS_DIR / "aa" / bundle.relative_path
        if dest.is_file() and not force:
            continue
        todo.append(bundle)
    return todo


def cmd_assets(args: argparse.Namespace) -> None:
    versions = resolve_versions(args)
    version = versions.get("fileassets_version")
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)

    apks = Apk.find_apks(ROOT, args.apk)
    console.print("[cyan]APK[/cyan] " + ", ".join(p.name for p in apks))
    for apk in apks:
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task(f"拆 {apk.name}", total=None)

            def on_file(_apk: Path, name: str, wrote: bool, _task: int = task) -> None:
                if wrote:
                    progress.update(_task, advance=1)

            progress.update(task, total=len(Apk.apk_entries(apk, args.apk_prefix)))
            count = Apk.extract_apk(
                apk, ASSETS_DIR, prefixes=args.apk_prefix, force=args.force, on_file=on_file
            )
        console.print(f"  [green]{apk.name}[/green] 写出 {count} 个文件")

    decrypted = _decrypt_apk_bundles(args.force)
    console.print(f"[green]APK Embed 解密[/green] {decrypted} 个 bundle")

    if not version:
        console.print("[red]缺少 fileassets_version[/red]，跳过热更下载")
        return
    catalog, _ = load_or_fetch_catalog(args.server, version, args.platform, force=args.force)
    readable = ASSETS_DIR / "Catalog" / f"{args.server}_{args.platform}_catalog.json"
    readable.parent.mkdir(parents=True, exist_ok=True)
    readable.write_text(
        json.dumps(catalog.readable(), ensure_ascii=False, indent=2), encoding="utf-8"
    )
    todo = _hotfix_todo(
        catalog,
        only_text=args.only_text,
        force=args.force,
    )
    if args.limit:
        todo = todo[: args.limit]
    total = sum(b.file_size for b in todo)
    console.print(
        f"[cyan]热更[/cyan] {args.platform} {version}  待下 {len(todo)} 个 / {format_size(total)}"
    )
    if not todo:
        _write_manifest(catalog, args.server, version, args.platform)
        return

    written = failed = 0
    with make_progress(DownloadColumn(), TransferSpeedColumn()) as progress:
        task = progress.add_task("下载热更 bundle", total=total)

        def work(bundle: BundleInfo) -> tuple[bool, str, str | None]:
            dest = ASSETS_DIR / "aa" / bundle.relative_path
            url = bundle_url(args.server, version, args.platform, bundle.relative_path)
            try:
                download_and_decrypt(
                    bundle,
                    url,
                    dest,
                    force=args.force,
                    on_bytes=lambda n: progress.update(task, advance=n),
                )
                return True, bundle.relative_path, None
            except Exception as exc:  # noqa: BLE001
                return False, bundle.relative_path, str(exc)

        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futures = [pool.submit(work, bundle) for bundle in todo]
            for future in as_completed(futures):
                ok, name, err = future.result()
                if ok:
                    written += 1
                else:
                    failed += 1
                    console.print(f"[red]失败[/red] {name}: {err}")
    console.print(f"[bold green]热更[/bold green] 写出 {written}  失败 {failed}")
    _write_manifest(catalog, args.server, version, args.platform)


def _write_manifest(catalog: Catalog, server: str, version: str, platform: str) -> None:
    manifest = {
        "server": server,
        "platform": platform,
        "fileassets_version": version,
        "uniqueBuildId": catalog.unique_build_id,
        "mainAssetLabel": catalog.raw.get("_mainAssetLabel"),
        "bundleCount": len(catalog.bundles),
        "totalSize": sum(b.file_size for b in catalog.bundles),
        "bundles": [
            {
                "relativePath": b.relative_path,
                "bundleName": b.bundle_name,
                "hash": b.hash,
                "crc": b.crc,
                "fileSize": b.file_size,
                "compression": b.compression,
            }
            for b in catalog.bundles
        ],
    }
    dest = ASSETS_DIR / "manifest.json"
    dest.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    console.print(f"[green]manifest[/green] {dest}")


# ---------------------------------------------------------------------------
# 子命令：masterdata
# ---------------------------------------------------------------------------

def cmd_masterdata(args: argparse.Namespace) -> None:
    versions = resolve_versions(args)
    version = versions.get("masterdata_version")
    if not version:
        console.print("[red]缺少 masterdata_version[/red]，先跑 version 或手工指定")
        return
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    MASTER_DIR.mkdir(parents=True, exist_ok=True)

    raw_path = CACHE_DIR / f"masterdata_{args.server}_{version}.bin"
    url = MasterData.masterdata_url(args.server, version, args.language)
    console.print(f"[cyan]master data[/cyan] {url}")
    download(url, raw_path, force=args.force)
    payload = MasterData.decrypt_masterdata(raw_path.read_bytes(), version)
    (CACHE_DIR / f"masterdata_{args.server}_{version}.decoded.bin").write_bytes(payload)

    catalog = MasterData.dump_catalog(payload, MASTER_DIR / "_catalog.json")
    console.print(f"[green]目录[/green] {len(catalog)} 张表")

    tables = MasterData.unpack_masterdata(payload)
    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("写出数据表", total=len(tables))

        def on_table(name: str, dest: Path, rows: int) -> None:
            progress.advance(task)

        written = MasterData.dump_tables(tables, MASTER_DIR, on_table=on_table)
    console.print(f"[bold green]MasterData[/bold green] {written} 张表 → {MASTER_DIR}")

    _copy_important_configs(args)
    if not args.skip_text:
        _extract_text_assets(args, versions)


def _copy_important_configs(args: argparse.Namespace) -> None:
    """把 settings/abcache/Unity 配置等一并放进 MasterData/Config。"""
    targets = [
        ASSETS_DIR / "aa" / "settings.json",
        ASSETS_DIR / "aa" / "abcache.json",
        ASSETS_DIR / "aa" / "catalog.json",
        ASSETS_DIR / "UnityServicesProjectConfiguration.json",
        ASSETS_DIR / "google-services-desktop.json",
        ASSETS_DIR / "bin" / "Data" / "RuntimeInitializeOnLoads.json",
        ASSETS_DIR / "bin" / "Data" / "ScriptingAssemblies.json",
        ASSETS_DIR / "bin" / "Data" / "boot.config",
    ]
    copied = 0
    for src in targets:
        if not src.is_file():
            continue
        dest = MASTER_DIR / "Config" / src.name
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest)
        copied += 1
    if copied:
        console.print(f"[green]配置[/green] {copied} 个 → MasterData/Config")


def _extract_text_assets(args: argparse.Namespace, versions: dict[str, str]) -> None:
    """从 bundle 里提取 TextAsset（剧情对话 / 系统文本）并转 JSON。"""
    version = versions.get("fileassets_version")
    if not version:
        console.print("[yellow]没有 fileassets_version，跳过剧情文本[/yellow]")
        return

    catalog, _ = load_or_fetch_catalog(args.server, version, args.platform, force=False)
    bundles = catalog.text_asset_bundles()
    if not bundles:
        console.print("[yellow]catalog 里没有 TextAsset[/yellow]")
        return
    console.print(f"[cyan]剧情文本[/cyan] {len(bundles)} 个 bundle")

    missing = [b for b in bundles if not (ASSETS_DIR / "aa" / b.relative_path).is_file()]
    if missing:
        total = sum(b.file_size for b in missing)
        console.print(f"  需要先下 {len(missing)} 个 bundle / {format_size(total)}")
        with make_progress(DownloadColumn(), TransferSpeedColumn()) as progress:
            task = progress.add_task("下载文本 bundle", total=total)

            def work(bundle: BundleInfo) -> None:
                dest = ASSETS_DIR / "aa" / bundle.relative_path
                url = bundle_url(args.server, version, args.platform, bundle.relative_path)
                download_and_decrypt(
                    bundle, url, dest, on_bytes=lambda n: progress.update(task, advance=n)
                )

            with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
                list(pool.map(work, missing))

    import UnityPy

    if args.unity_version:
        UnityPy.config.FALLBACK_UNITY_VERSION = args.unity_version
    elif not UnityPy.config.FALLBACK_UNITY_VERSION:
        detected = Apk.unity_version_from_apks(Apk.find_apks(ROOT, args.apk))
        if detected:
            UnityPy.config.FALLBACK_UNITY_VERSION = detected

    out_dir = MASTER_DIR / "Text"
    ok = fail = 0
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        with make_progress(MofNCompleteColumn()) as progress:
            task = progress.add_task("解包 TextAsset", total=len(bundles))
            for bundle in bundles:
                src = ASSETS_DIR / "aa" / bundle.relative_path
                blobs: dict[str, bytes] = {}
                try:
                    env = UnityPy.load(str(src))
                    for obj in env.objects:
                        if obj.type.name != "TextAsset":
                            continue
                        data = obj.read()
                        name = str(getattr(data, "m_Name", "") or obj.path_id)
                        script = getattr(data, "m_Script", None)
                        if script is None:
                            continue
                        if isinstance(script, str):
                            blobs[name] = script.encode("utf-8", "surrogateescape")
                        else:
                            blobs[name] = bytes(script)
                except Exception as exc:  # noqa: BLE001
                    console.print(f"[red]读取失败[/red] {src.name}: {exc}")
                done, bad = TextAsset.dump_text_assets(blobs, out_dir)
                ok += done
                fail += bad
                progress.advance(task)
    console.print(f"[bold green]TextAsset[/bold green] 写出 {ok}  失败 {fail} → {out_dir}")

    # 热更 DLL（TextAsset 里以 .dll 结尾的）单独放一份
    dll_dir = MASTER_DIR / "Dll"
    dll_count = 0
    for path in out_dir.rglob("*.json"):
        if path.stem.lower().endswith(".dll") or "assembly" in path.stem.lower():
            dll_dir.mkdir(parents=True, exist_ok=True)
            shutil.copy2(path, dll_dir / path.name)
            dll_count += 1
    if dll_count:
        console.print(f"[green]热更 DLL/程序集[/green] {dll_count} 个 → {dll_dir}")


# ---------------------------------------------------------------------------
# 子命令：all
# ---------------------------------------------------------------------------

def cmd_all(args: argparse.Namespace) -> None:
    cmd_assets(args)
    cmd_masterdata(args)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def _add_shared_args(parser: argparse.ArgumentParser, suppress: bool) -> None:
    def default(value: Any) -> Any:
        return argparse.SUPPRESS if suppress else value

    parser.add_argument("--server", choices=("Japan", "Global"), default=default(DEFAULT_SERVER), help="服务器")
    parser.add_argument(
        "--platform", choices=("Android", "iOS", "StandaloneWindows64"), default=default(DEFAULT_PLATFORM)
    )
    parser.add_argument("--fileassets-version", default=default(""), help="资源版本（默认自动获取）")
    parser.add_argument("--masterdata-version", default=default(""), help="MasterData 版本（默认自动获取）")
    parser.add_argument("--no-cdn-version", action="store_true", default=default(False), help="不查询 CDN 列表")
    parser.add_argument(
        "--no-mirror-version",
        action="store_true",
        default=default(False),
        help="不使用社区版本镜像兜底",
    )
    parser.add_argument(
        "--login", action="store_true", default=default(False), help="尝试走游戏登录接口取版本（实验性）"
    )
    parser.add_argument("--force", action="store_true", default=default(False), help="忽略本地文件强制重做")
    parser.add_argument("--jobs", type=int, default=default(CONCURRENT), help="并发下载线程数")
    parser.add_argument("--apk", nargs="*", default=default(None), help="APK 路径（默认自动搜索工作区）")
    parser.add_argument(
        "--apk-prefix",
        action="append",
        default=default(None),
        help="APK 内提取前缀（可重复，默认 assets/ 与 lib/）",
    )
    parser.add_argument(
        "--language", default=default("en"), help="Global 服 masterdata 语言（en/zh_cn/zh_tw，Japan 服忽略）"
    )
    parser.add_argument("--skip-text", action="store_true", default=default(False), help="跳过剧情文本提取")
    parser.add_argument(
        "--only-text", action="store_true", default=default(False), help="assets 只下文本相关 bundle"
    )
    parser.add_argument("--limit", type=int, default=default(0), help="最多下载多少个 bundle")
    parser.add_argument("--unity-version", default=default(""), help="UnityPy 回退版本（默认自动识别）")
    parser.add_argument("--with-resources", action="store_true", default=default(False), help="catalog 附带资源定位")


def build_parser() -> argparse.ArgumentParser:
    main_shared = argparse.ArgumentParser(add_help=False)
    _add_shared_args(main_shared, suppress=False)
    sub_shared = argparse.ArgumentParser(add_help=False, argument_default=argparse.SUPPRESS)
    _add_shared_args(sub_shared, suppress=True)

    parser = argparse.ArgumentParser(
        description=f"{GAME_TITLE} 资产 / MasterData 还原工具",
        parents=[main_shared],
    )
    sub = parser.add_subparsers(dest="command", required=False)

    sub.add_parser("version", parents=[sub_shared], help="获取并打印版本号")
    sub.add_parser("catalog", parents=[sub_shared], help="下载 catalog.json 并导出可读 JSON")
    sub.add_parser("assets", parents=[sub_shared], help="APK 拆包 + 热更下载 + 解密 → Assets/")
    sub.add_parser("masterdata", parents=[sub_shared], help="MasterData + 剧情文本 → MasterData/")
    sub.add_parser("all", parents=[sub_shared], help="assets + masterdata")
    return parser


def _fix_args(args: argparse.Namespace) -> argparse.Namespace:
    defaults: dict[str, Any] = {
        "server": DEFAULT_SERVER,
        "platform": DEFAULT_PLATFORM,
        "fileassets_version": "",
        "masterdata_version": "",
        "no_cdn_version": False,
        "no_mirror_version": False,
        "login": False,
        "force": False,
        "jobs": CONCURRENT,
        "apk": None,
        "apk_prefix": None,
        "language": "en",
        "skip_text": False,
        "only_text": False,
        "limit": 0,
        "unity_version": "",
        "with_resources": False,
    }
    for key, value in defaults.items():
        if getattr(args, key, None) is None and key != "apk":
            setattr(args, key, value)
        elif not hasattr(args, key):
            setattr(args, key, value)
    if getattr(args, "apk_prefix", None) is None:
        args.apk_prefix = Apk.DEFAULT_PREFIXES
    if not getattr(args, "jobs", None):
        args.jobs = CONCURRENT
    return args


def main() -> None:
    parser = build_parser()
    args = _fix_args(parser.parse_args())
    command = getattr(args, "command", None) or "all"
    if command == "version":
        cmd_version(args)
    elif command == "catalog":
        cmd_catalog(args)
    elif command == "assets":
        cmd_assets(args)
    elif command == "masterdata":
        cmd_masterdata(args)
    elif command == "all":
        cmd_all(args)
    else:
        parser.error(f"未知子命令 {command}")


if __name__ == "__main__":
    main()
