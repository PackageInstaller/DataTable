from __future__ import annotations

import argparse
import os
import queue
import shutil
import sys
import threading
import time
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Dict, List, Optional, Tuple

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

import AzurPromiliaCatalog as Catalog
import AzurPromiliaDecrypt as Decrypt
import AzurPromiliaMasterData as MasterData

GAME_TITLE = "蓝色星原：旅谣 / Azur Promilia"
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
MANIFEST_DIR = ROOT / "pc_manifests"

CDN_BASE = "https://syncstation.manjuu.com/azurpromilia/pg_item_v2/target/c000_20260826175730_b3AtNzkwMDM=/AzurPromilia_Data/StreamingAssets"

PACKAGES = [
    "raw_base_package",
    "raw_nostreaming_package",
    "raw_streaming_package",
    "default_package",
    "static_package",
]

DEFAULT_JOBS = 16
DEFAULT_DECRYPT_JOBS = 4
TIMEOUT = 30
CHUNK_SIZE = 1 << 20

console = Console()
_tls = threading.local()

def get_session() -> requests.Session:
    sess = getattr(_tls, "session", None)
    if sess is None:
        sess = requests.Session()
        sess.headers.update({"User-Agent": "UnityPlayer/2022.3.21f1 (Windows)"})
        _tls.session = sess
    return sess

def ensure_manifests(force_refresh: bool = False) -> Dict[str, Catalog.ManifestInfo]:
    MANIFEST_DIR.mkdir(parents=True, exist_ok=True)
    results: Dict[str, Catalog.ManifestInfo] = {}

    for pkg in PACKAGES:
        # PC CBT3 版本标识为 1938420
        manifest_filename = f"30_{pkg}_1938420.bytes"
        local_path = MANIFEST_DIR / manifest_filename
        url = f"{CDN_BASE}/.res/{pkg}/{manifest_filename}"

        if force_refresh or not local_path.exists():
            console.print(f"[dim]正在拉取远端清单: {pkg}...[/dim]")
            try:
                r = requests.get(url, timeout=TIMEOUT)
                if r.status_code == 200:
                    with open(local_path, "wb") as f:
                        f.write(r.content)
                else:
                    console.print(f"[red]获取清单失败 [{r.status_code}]: {url}[/red]")
                    continue
            except Exception as e:
                console.print(f"[red]下载清单异常: {e}[/red]")
                continue

        info = Catalog.load_manifest(local_path)
        results[pkg] = info

    return results

def cmd_catalog(args: argparse.Namespace) -> None:
    """打印清单摘要信息。"""
    manifests = ensure_manifests(force_refresh=args.refresh)
    table = Table(title=f"【{GAME_TITLE}】Package 资产清单一览", header_style="bold magenta")
    table.add_column("包名称", style="cyan")
    table.add_column("版本", justify="center")
    table.add_column("资产总数", justify="right")
    table.add_column("Bundle 数量", justify="right")
    table.add_column("PackRes 容器数", justify="right")

    for pkg, info in manifests.items():
        table.add_row(
            pkg,
            info.package_version,
            str(info.asset_count),
            str(info.bundle_count),
            str(info.pack_res_count),
        )
    console.print(table)

def cmd_masterdata(args: argparse.Namespace) -> None:
    """提取游戏全量数据表（底层MMap + 1881张总管表 + 任务决策表 + 行为树）、Lua 源码、HybridCLR 元数据并反编译。"""
    manifests = ensure_manifests(force_refresh=args.refresh)
    force = getattr(args, "force", False)

    base_info = manifests.get("raw_base_package")
    if base_info:
        cdn_url = f"{CDN_BASE}/.res/raw_base_package"
        out_cfg = MASTER_DIR / "Config"
        MasterData.extract_configs(base_info.bundles, cdn_url, out_cfg, force=force)

    streaming_info = manifests.get("raw_streaming_package")
    if streaming_info:
        cdn_url = f"{CDN_BASE}/.res/raw_streaming_package"
        out_cfg = MASTER_DIR / "Config"
        MasterData.extract_streaming_configs(streaming_info.bundles, cdn_url, out_cfg, limit=args.limit, force=force)

    nostream_info = manifests.get("raw_nostreaming_package")
    if nostream_info:
        cdn_url = f"{CDN_BASE}/.res/raw_nostreaming_package"
        out_bt = MASTER_DIR / "BehaviorTree"
        MasterData.extract_behavior_trees(nostream_info.bundles, cdn_url, out_bt, limit=args.limit, force=force)

        out_lua = MASTER_DIR / "Lua"
        lua_bundles = [b for b in nostream_info.bundles if "lua" in b.bundle_name.lower() or "pb_bytes" in b.bundle_name.lower()]
        MasterData.extract_and_decompile_lua(
            lua_bundles,
            cdn_url,
            out_lua,
            max_workers=args.jobs,
            limit=args.limit,
            force=force,
        )

    out_mv = MASTER_DIR / "MetaVersions"
    MasterData.extract_meta_versions(CDN_BASE, out_mv, force=force)
    out_csharp = MASTER_DIR / "CSharp"
    MasterData.decompile_csharp_dlls(ROOT / "dll", out_csharp, force=force)


def is_bundle_complete(out_path: Path, b: Catalog.BundleInfo) -> bool:
    if not out_path.exists() or not out_path.is_file():
        return False
    sz = out_path.stat().st_size
    if sz <= 0:
        return False
    try:
        with open(out_path, 'rb') as fp:
            head = fp.read(64)
        if head.startswith(b'UnityFS'):
            idx = 12
            idx = head.find(b'\x00', idx) + 1
            idx = head.find(b'\x00', idx) + 1
            idx += 8 + 4 + 4
            if idx + 4 <= len(head):
                flags = int.from_bytes(head[idx : idx + 4], 'big')
                if flags & 0x700 != 0:
                    return False  # 仍包含 0x100 / 0x200 / 0x400 加密位，需解密
            return True
        return True
    except Exception:
        return False

def _decrypt_worker_job(args_tuple: Tuple[str, str, bool]) -> str:
    tmp_path_str, out_path_str, no_decrypt = args_tuple
    tmp_p = Path(tmp_path_str)
    out_p = Path(out_path_str)
    try:
        if no_decrypt:
            out_p.parent.mkdir(parents=True, exist_ok=True)
            tmp_p.replace(out_p)
            return "raw"
        res = Decrypt.decrypt_unitycn_file(tmp_p, out_p)
        if tmp_p.exists():
            try:
                tmp_p.unlink()
            except OSError:
                pass
        return res
    except Exception as e:
        if tmp_p.exists():
            tmp_p.replace(out_p)
        return f"err: {e}"

def cmd_assets(args: argparse.Namespace) -> None:
    manifests = ensure_manifests(force_refresh=args.refresh)
    target_pkg = args.package or "default_package"

    if target_pkg not in manifests:
        console.print(f"[red]未找到包: {target_pkg}，可选: {', '.join(manifests.keys())}[/red]")
        return

    info = manifests[target_pkg]
    bundles = info.bundles
    if args.limit > 0:
        bundles = bundles[:args.limit]

    force = getattr(args, "force", False)
    if not force:
        pending_bundles = []
        skipped_count = 0
        skipped_bytes = 0
        for b in bundles:
            out_path = ASSETS_DIR / b.relative_path
            if is_bundle_complete(out_path, b):
                skipped_count += 1
                skipped_bytes += b.file_size
            else:
                pending_bundles.append(b)

        if skipped_count > 0:
            console.print(
                f"[bold green]✓ 本地已存在且完整: [yellow]{skipped_count:,}[/yellow] 个 Bundle "
                f"({skipped_bytes / (1024*1024):.2f} MB)，直接跳过[/bold green]"
            )
        if not pending_bundles:
            console.print(f"[bold green]✓ 所有资产均为最新版本，无需重复下载！[/bold green]")
            return
        bundles = pending_bundles

    total_bytes = sum(b.file_size for b in bundles)
    console.print(f"[bold cyan]正在启动资产热更双轨流水线：[yellow]{target_pkg}[/yellow]（待下载更新: {len(bundles):,} 个 Bundle，{total_bytes / (1024*1024):.2f} MB）...[/bold cyan]")
    cdn_url = f"{CDN_BASE}/.res/{target_pkg}"

    Decrypt.install_unitycn()

    decrypt_queue: queue.Queue = queue.Queue(maxsize=0)
    stop_token = object()

    with Progress(
        SpinnerColumn(),
        TextColumn("[bold]{task.description}"),
        BarColumn(),
        TransferSpeedColumn(),
        DownloadColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task_down = progress.add_task("[bold blue]云端资产下载[/bold blue]", total=total_bytes)
        task_dec = progress.add_task("[bold green]标准重构解密[/bold green]", total=len(bundles))

        dec_futures = []
        def decrypt_consumer(executor: ProcessPoolExecutor):
            while True:
                item = decrypt_queue.get()
                if item is stop_token:
                    decrypt_queue.task_done()
                    break
                bundle_info, tmp_path = item
                out_path = ASSETS_DIR / bundle_info.relative_path
                out_path.parent.mkdir(parents=True, exist_ok=True)
                fut = executor.submit(_decrypt_worker_job, (str(tmp_path), str(out_path), args.no_decrypt))
                fut.add_done_callback(lambda _: progress.advance(task_dec, 1))
                dec_futures.append(fut)
                decrypt_queue.task_done()

        dec_workers = getattr(args, "decrypt_workers", 4)
        with ProcessPoolExecutor(max_workers=dec_workers) as dec_executor:
            dec_thread = threading.Thread(target=decrypt_consumer, args=(dec_executor,), daemon=True)
            dec_thread.start()

            def download_item(b: Catalog.BundleInfo):
                sess = get_session()
                url = f"{cdn_url}/{b.pack_res_name}"
                headers = {}
                if b.file_size > 0:
                    headers["Range"] = f"bytes={b.file_offset}-{b.file_offset + b.file_size - 1}"
                try:
                    r = sess.get(url, headers=headers, timeout=TIMEOUT)
                    if r.status_code in (200, 206):
                        progress.advance(task_down, b.file_size)
                        out_path = ASSETS_DIR / b.relative_path
                        out_path.parent.mkdir(parents=True, exist_ok=True)
                        tmp_path = out_path.with_name(out_path.name + ".dl.tmp")
                        with open(tmp_path, "wb") as f:
                            f.write(r.content)
                        decrypt_queue.put((b, tmp_path))
                        return True
                    else:
                        return False
                except Exception:
                    return False

            with ThreadPoolExecutor(max_workers=args.threads) as pool:
                futures = [pool.submit(download_item, b) for b in bundles]
                for fut in as_completed(futures):
                    fut.result()

            decrypt_queue.put(stop_token)
            decrypt_queue.join()
            dec_thread.join()
            for fut in as_completed(dec_futures):
                fut.result()

    console.print(f"[bold green]✓ 资产处理完成！文件已还原至: {ASSETS_DIR}[/bold green]")

def cmd_decrypt(args: argparse.Namespace) -> None:
    target_path = Path(args.path)
    if not target_path.exists():
        console.print(f"[red]路径不存在: {target_path}[/red]")
        return
    console.print(f"[cyan]正在就地解密: {target_path}[/cyan]")
    if target_path.is_file():
        files = [target_path]
    else:
        files = [p for p in target_path.rglob("*") if p.is_file()]

    for f in files:
        with open(f, "rb") as fp:
            head = fp.read(32)
        if head.startswith(b"UnityFS"):
            res = Decrypt.decrypt_unitycn_file(f, f)
            console.print(f" [green]UnityCN 解密 ({res}):[/green] {f.name}")
        elif head.startswith(b"\x13\x57\xfe\xda"):
            with open(f, "rb") as fp:
                data = fp.read()
            dec = Decrypt.decrypt_codephil_vm(data)
            with open(f, "wb") as fp:
                fp.write(dec)
            console.print(f" [green]CodePhil VM 解密成功:[/green] {f.name}")

def cmd_all(args: argparse.Namespace) -> None:
    console.print(f"[bold green]=== 开始执行《{GAME_TITLE}》全流程提取 ===[/bold green]")
    cmd_masterdata(args)
    cmd_assets(args)

def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="AzurPromilia.py",
        description=f"【{GAME_TITLE}】资源热更下载、解密与数据表反编译工具",
    )
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--refresh", action="store_true", help="强制从 CDN 刷新清单")
    shared.add_argument("--force", "-f", action="store_true", help="强制重新下载并解密/反编译，忽略本地缓存")
    shared.add_argument("--jobs", "-j", type=int, default=DEFAULT_JOBS, help=f"并发处理进程/线程数，默认 {DEFAULT_JOBS}")


    sub = p.add_subparsers(dest="command", required=False)
    sub.add_parser("catalog", aliases=["list", "version"], parents=[shared], help="查看 5 个 Package 清单信息")
    p_master = sub.add_parser("masterdata", aliases=["data", "lua", "config"], parents=[shared], help="提取配置表与反编译 Lua 源码")
    p_master.add_argument("--limit", type=int, default=0, help="限制提取/反编译文件数量（调试用）")
    p_assets = sub.add_parser("assets", aliases=["download"], parents=[shared], help="多线程下载并解密 Unity 资产到 Assets/")
    p_assets.add_argument("--package", choices=PACKAGES, default="default_package", help="指定下载的 Package，默认 default_package")
    p_assets.add_argument("--limit", type=int, default=0, help="限制下载数量（调试用）")
    p_assets.add_argument("--threads", type=int, default=DEFAULT_JOBS, help=f"网络下载线程数，默认 {DEFAULT_JOBS}")
    p_assets.add_argument("--decrypt-workers", "--dec-jobs", dest="decrypt_workers", type=int, default=4, help="后台重构解密进程数，默认 4")
    p_assets.add_argument("--no-decrypt", action="store_true", help="只下载，不执行解密")
    p_dec = sub.add_parser("decrypt", help="对本地已有目录/文件进行解密")
    p_dec.add_argument("path", help="待解密文件或目录路径")
    sub.add_parser("all", parents=[shared], help="完整执行 masterdata 与 assets")

    return p

def main() -> None:
    parser = build_parser()
    args = parser.parse_args()

    if not hasattr(args, "refresh"):
        args.refresh = False
    if not hasattr(args, "jobs"):
        args.jobs = DEFAULT_JOBS

    if not args.command or args.command == "all":
        cmd_all(args)
    elif args.command in ("catalog", "list", "version"):
        cmd_catalog(args)
    elif args.command in ("masterdata", "data", "lua", "config"):
        cmd_masterdata(args)
    elif args.command in ("assets", "download"):
        cmd_assets(args)
    elif args.command == "decrypt":
        cmd_decrypt(args)

if __name__ == "__main__":
    main()
