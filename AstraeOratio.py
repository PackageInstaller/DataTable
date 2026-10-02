from __future__ import annotations

import argparse
import json
import shutil
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Dict, List, Optional

import requests
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
from rich.table import Table

import AstraeOratioMasterData as MasterData
import AstraeOratioUpdater as Updater
import AstraeOratioUnity as Unity

GAME_TITLE = "ASTRAE ORATIO"
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
MANIFEST_PATH = ASSETS_DIR / ".manifest.json"
THREADS = 12
CHUNK = 1 << 20

console = Console()


def load_manifest() -> Dict:
    if MANIFEST_PATH.exists():
        try:
            return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
        except Exception:
            return {}
    return {}


def save_manifest(mani: Dict) -> None:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    tmp = MANIFEST_PATH.with_suffix(".tmp")
    tmp.write_text(json.dumps(mani, ensure_ascii=False, indent=2), encoding="utf-8")
    tmp.replace(MANIFEST_PATH)


def resolve_update_info(args) -> Updater.UpdateInfo:
    if args.game_id and args.updater:
        return Updater.UpdateInfo(0, "", "", args.updater, args.game_id)
    console.print("[cyan]获取 Purpleworks 平台配置...[/cyan]")
    try:
        platform = Updater.fetch_platform_config()
        updater = platform.get("address_for_updater") or Updater.UPDATER_ADDR_FALLBACK
        game_id = platform.get("game_id_for_updater") or Updater.GAME_ID_FALLBACK
    except Exception as e:
        console.print(f"[yellow]配置接口失败({e})，使用内置地址[/yellow]")
        updater, game_id = Updater.UPDATER_ADDR_FALLBACK, Updater.GAME_ID_FALLBACK
    return Updater.UpdateInfo(0, "", "", updater, game_id)


def probe_version(args) -> Updater.UpdateInfo:
    info = resolve_update_info(args)
    console.print(f"updater {info.updater_addr}:{Updater.DEFAULT_UPDATER_PORT}")
    console.print(f"game_id {info.game_id}")
    with console.status("连接更新服务器..."):
        full = Updater.fetch_update_info(info.game_id, info.updater_addr)
    console.print(
        f"版本 [green]{full.global_version}[/green]\n"
        f"file_info_hash {full.file_info_hash}\n"
        f"仓库 {full.repo_address}"
    )
    return full


def cmd_status(args) -> int:
    info = probe_version(args)
    mani = load_manifest()
    local_files = mani.get("files", {})
    done = sum(1 for f in local_files.values() if f.get("ok"))
    size = sum(f.get("size", 0) for f in local_files.values() if f.get("ok"))

    tbl = Table(title=f"{GAME_TITLE} 状态", show_lines=True)
    tbl.add_column("项目", style="cyan")
    tbl.add_column("值", style="green")
    tbl.add_row("线上版本", str(info.global_version))
    tbl.add_row("本地记录版本", str(mani.get("version", "-")))
    tbl.add_row("本地文件", f"{done} / {len(local_files)} ({size / 1024 ** 3:.2f} GiB)")
    tbl.add_row("Assets 目录", str(ASSETS_DIR))
    master = list(MASTER_DIR.glob("*.json")) if MASTER_DIR.exists() else []
    tbl.add_row("MasterData", f"{len(master)} 个表")
    console.print(tbl)
    return 0


def cmd_version(args) -> int:
    info = probe_version(args)
    if args.raw:
        print(info.global_version)
    return 0


def dest_of(entry: Dict) -> Path:
    return ASSETS_DIR / entry["path"]


def file_complete(entry: Dict, mani: Dict) -> bool:
    rec = mani.get("files", {}).get(entry["path"])
    if not rec or not rec.get("ok"):
        return False
    p = dest_of(entry)
    return p.is_file() and p.stat().st_size == entry["_size"]


def cmd_assets(args) -> int:
    info = probe_version(args)
    session = requests.Session()
    console.print("下载 files_info.json ...")
    files = Updater.fetch_file_list(info, session)
    total = sum(f["_size"] for f in files)
    console.print(
        f"  {len(files)} 个文件, 共 [green]{total / 1024 ** 3:.2f} GiB[/green]"
    )

    mani = load_manifest()
    force = getattr(args, "force", False)
    if mani.get("version") != info.global_version or force:
        for rec in mani.get("files", {}).values():
            rec["ok"] = False
        mani = {"version": info.global_version, "files": mani.get("files", {})}

    pending = [] if force else [
        f for f in files if not file_complete(f, mani)
    ]
    skip = len(files) - len(pending)
    if skip:
        console.print(f"  跳过已完成 {skip} 个")
    if not pending:
        console.print("[green]已是最新[/green]")
        return 0
    if args.limit:
        pending = pending[:args.limit]
        console.print(f"  --limit 只处理 {len(pending)} 个")

    lock = threading.Lock()
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TransferSpeedColumn(),
        DownloadColumn(),
        TimeRemainingColumn(),
        console=console,
    )
    t_size = progress.add_task("下载", total=sum(f["_size"] for f in pending))
    t_file = progress.add_task("文件", total=len(pending))
    ok = fail = 0
    fails = []

    def work(entry: Dict):
        nonlocal ok, fail
        dest = dest_of(entry)
        try:
            data = Updater.retry_download(info, entry, session)
            dest.parent.mkdir(parents=True, exist_ok=True)
            tmp = dest.with_suffix(dest.suffix + ".part")
            tmp.write_bytes(data)
            tmp.replace(dest)
            with lock:
                ok += 1
                mani["files"][entry["path"]] = {
                    "ok": True, "size": entry["_size"], "hash": entry.get("hash", "")
                }
                progress.update(t_size, advance=entry["_size"])
                progress.update(t_file, advance=1)
            return True, entry["path"], ""
        except Exception as e:  # noqa: BLE001
            with lock:
                fail += 1
                progress.update(t_file, advance=1)
                fails.append((entry["path"], str(e)))
            return False, entry["path"], str(e)

    if args.dry_run:
        for f in pending[:20]:
            console.print(f"  {f['path']} ({f['_size'] / 1e6:.1f} MB)")
        console.print(f"  ... 共 {len(pending)} 个")
        return 0

    if shutil.which("aria2c") and args.aria2:
        console.print("使用 aria2c 并发下载")
        cmd_aria2(info, pending, progress)
        for f in pending:
            if file_complete(f, mani):
                ok += 1
                mani["files"][f["path"]] = {"ok": True, "size": f["_size"], "hash": f.get("hash", "")}
            else:
                fail += 1
                fails.append((f["path"], "aria2"))
        save_manifest(mani)
        console.print(f"[bold]完成[/bold] ok={ok} fail={fail}")
        return 0 if not fail else 1

    with progress:
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = [pool.submit(work, f) for f in pending]
            for i, fut in enumerate(as_completed(futs)):
                fut.result()
                if (i + 1) % 50 == 0:
                    with lock:
                        save_manifest(mani)
    save_manifest(mani)
    for name, err in fails[:10]:
        console.print(f"  [red]FAIL[/red] {name}: {err}")
    console.print(f"[bold]完成[/bold] ok={ok} fail={fail} -> {ASSETS_DIR}")
    return 0 if not fail else 1


def cmd_aria2(info: Updater.UpdateInfo, pending: List[Dict], progress) -> None:
    import subprocess
    list_file = ROOT / ".aria2.list"
    with list_file.open("w", encoding="utf-8") as fh:
        for f in pending:
            dest = dest_of(f)
            dest.parent.mkdir(parents=True, exist_ok=True)
            url = f"http://{info.repo_address}/{f['encodedInfo']['path']}"
            fh.write(f"{url}\n  out={dest.name}\n  dir={dest.parent}\n")
    subprocess.run(
        ["aria2c", "-i", str(list_file), "-j", "16", "-x", "4", "-s", "4",
         "--file-allocation=none", "--console-log-level=warn", "--summary-interval=0",
         "-d", str(ASSETS_DIR)],
        cwd=str(ROOT),
    )
    list_file.unlink(missing_ok=True)



def cmd_catalog(args) -> int:
    """用 UnityCatalogReader 解析 catalog_at.bin 导出 json。"""
    src = Path(args.catalog) if args.catalog else Path("/nonexistent")
    if not src.exists():
        for cand in ASSETS_DIR.rglob("catalog_at.bin"):
            src = cand
            break
    if not src.exists():
        console.print("[red]找不到 catalog_at.bin，请先 assets 下载[/red]")
        return 1
    out = Path(args.output)
    result = MasterData.export_catalog(src, out)
    if result:
        console.print(f"[green]catalog 导出[/green] {src} -> {result}")
        return 0
    console.print("[red]catalog 解析失败[/red]")
    return 1



def cmd_masterdata(args) -> int:
    info = probe_version(args)
    session = requests.Session()
    console.print("下载 files_info.json ...")
    files = Updater.fetch_file_list(info, session)
    by_name = {f["path"]: f for f in files}

    MASTER_DIR.mkdir(parents=True, exist_ok=True)

    entry = by_name.get("Table/Table.dat")
    if not entry:
        console.print("[red]远端没有 Table/Table.dat[/red]")
        return 1
    rev_entry = by_name.get("Table/TableRevision.json")
    table_rev = getattr(args, "table_revision", 0)
    if not table_rev and rev_entry:
        raw = Updater.retry_download(info, rev_entry, session)
        try:
            table_rev = int(json.loads(raw)["Revision"])
        except Exception:
            table_rev = None
    if not table_rev:
        local = ROOT / "TableRevision.txt"
        if local.exists():
            table_rev = int(json.loads(local.read_text())["Revision"])
    if not table_rev:
        console.print("[red]无法确定 TableRevision[/red]")
        return 1
    console.print(f"  TableRevision = {table_rev}")
    console.print("  下载 Table.dat ...")
    data = Updater.retry_download(info, entry, session)
    zip_data = MasterData.decrypt_table_dat_entry(data, table_rev)
    written = MasterData.extract_tables(zip_data, MASTER_DIR)
    console.print(f"[green]数据表[/green] {len(written)} 个 XML -> {MASTER_DIR}")
    (MASTER_DIR / "TableRevision.json").write_text(
        json.dumps({"Revision": str(table_rev)}, indent=2), encoding="utf-8"
    )

    cat_entry = by_name.get("Android/catalog_at.bin")
    if cat_entry:
        raw = Updater.retry_download(info, cat_entry, session)
        cat_bin = MASTER_DIR / "catalog_at.bin"
        cat_bin.write_bytes(raw)
        MasterData.export_catalog(cat_bin, MASTER_DIR / "catalog_at.json")
        cat_bin.unlink(missing_ok=True)
        console.print("[green]catalog_at[/green] -> MasterData/catalog_at.json")

    ds_entry = next((f for k, f in by_name.items() if "datasheetdb" in k), None)
    if ds_entry:
        console.print("下载 datasheetdb bundle ...")
        raw = Updater.retry_download(info, ds_entry, session)
        bundle = MASTER_DIR / "datasheetdb.bundle"
        bundle.write_bytes(raw)
        scenario_dir = MASTER_DIR / "Scenario"
        scenario_dir.mkdir(parents=True, exist_ok=True)
        count = 0
        for name, payload in Unity.extract_text_assets(bundle):
            if not name.startswith("ScenarioScript_"):
                continue
            db_path = scenario_dir / f"{name}.db"
            db_path.write_bytes(payload)
            try:
                MasterData.scenario_db_to_json(db_path, scenario_dir, name)
                db_path.unlink(missing_ok=True)
                count += 1
            except Exception as e: 
                console.print(f"  [yellow]{name}: {e}[/yellow]")
        bundle.unlink(missing_ok=True) 
        console.print(f"[green]剧情库[/green] {count} 个 -> {scenario_dir}")
    return 0



def cmd_all(args) -> int:
    ret = cmd_masterdata(args)
    if ret:
        return ret
    return cmd_assets(args)

def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--updater", default="", help="覆盖 updater 地址")
    shared.add_argument("--game-id", default="", help="覆盖 game_id")
    shared.add_argument("--jobs", "-j", type=int, default=THREADS, help="并发线程数")

    p = argparse.ArgumentParser(
        prog="AstraeOratio.py",
        description=f"{GAME_TITLE} 热更下载 / 资产还原 / 数据表导出",
        epilog=(
            "示例:\n"
            "  python AstraeOratio.py status        # 线上版本与本地状态\n"
            "  python AstraeOratio.py masterdata    # 数据表(xml) + 剧情库(json) -> MasterData/\n"
            "  python AstraeOratio.py assets        # 热更资产 -> Assets/ (2.29 GiB)\n"
            "  python AstraeOratio.py all           # 全部\n"
            "  python AstraeOratio.py catalog       # catalog_at.bin -> assets.json\n"
        ),
    )
    sub = p.add_subparsers(dest="cmd", required=True)

    sub.add_parser("status", parents=[shared], help="线上版本与本地状态")
    v = sub.add_parser("version", parents=[shared], help="只打印线上版本")
    v.add_argument("--raw", action="store_true", help="只输出版本数字")

    a = sub.add_parser("assets", aliases=["download"], parents=[shared], help="下载热更资产到 Assets/")
    a.add_argument("--limit", type=int, default=0, help="只下载前 N 个（调试）")
    a.add_argument("--force", "-f", action="store_true", help="忽略本地清单全量重下")
    a.add_argument("--dry-run", action="store_true", help="只打印清单")
    a.add_argument("--aria2", action="store_true", help="使用 aria2c 下载")

    m = sub.add_parser("masterdata", aliases=["data"], parents=[shared],
                       help="数据表(*.xml) + 剧情库(Scenario/*.json) -> MasterData/")
    m.add_argument("--table-revision", type=int, default=0, help="覆盖 TableRevision")

    c = sub.add_parser("catalog", parents=[shared], help="解析 catalog_at.bin")
    c.add_argument("--catalog", default="", help="catalog_at.bin 路径（默认在 Assets 中查找）")
    c.add_argument("--output", default=str(MASTER_DIR / "catalog_at.json"), help="输出 json 路径")
    sub.add_parser("all", parents=[shared], help="masterdata + assets")
    return p


def main(argv: Optional[List[str]] = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        if args.cmd == "status":
            return cmd_status(args)
        if args.cmd == "version":
            return cmd_version(args)
        if args.cmd in ("assets", "download"):
            return cmd_assets(args)
        if args.cmd in ("masterdata", "data"):
            return cmd_masterdata(args)
        if args.cmd == "catalog":
            return cmd_catalog(args)
        if args.cmd == "all":
            return cmd_all(args)
        parser.print_help()
        return 0
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        return 130
    except Exception as e:  # noqa: BLE001
        console.print(f"[red]错误[/red] {e}")
        return 1


if __name__ == "__main__":
    sys.exit(main())
