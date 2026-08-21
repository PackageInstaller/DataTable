import argparse
import hashlib
import json
import os
import re
import socket
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
import requests
from requests.adapters import HTTPAdapter
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

DEFAULT_CDNS = [
    "https://blhx-patch-oss.oss-cn-hangzhou.aliyuncs.com",
    "https://line3-patch-blhx.bilibiligame.net",
    "https://line1-patch-blhx.bilibiligame.net",
    "https://line4-patch-blhx.bilibiligame.net",
]
DEFAULT_PLATFORM = "android"
LOGIN_HOST = "line1-login-bili-blhx.bilibiligame.net"
LOGIN_PORT = 80
LOGIN_HEX = "000a002a300000083d120130"
DEFAULT_MANIFESTS = [
    "$azhash$9$7$324$b485153420a85ef9",
    "$maphash$331$cb6c048ebea2844d",
    "$dormhash$1529$40634b51c332f14d",
    "$cipherhash$1304$a289769c12c76172",
    "$mangahash$1334$690943546c0baa7c",
    "$paintinghash$1721$522baf6dc3f4f431",
    "$bgmhash$1300$d10f89b716830704",
    "$pichash$1311$757c596c4ef21956",
    "$l2dhash$1522$120e2ce1a981ac61",
    "$cvhash$1415$d53050872f4174ea",
]
DEFAULT_JOBS = os.cpu_count() or 1
LUA_DIR = "Lua"
STATE_FILE = "version.json"
STATE_VERSION = 1

console = Console()
session = requests.Session()
session.mount("https://", HTTPAdapter(pool_connections=32, pool_maxsize=32))
session.mount("http://", HTTPAdapter(pool_connections=32, pool_maxsize=32))


def fetch(url: str, timeout: int = 30) -> bytes:
    r = session.get(url, timeout=timeout)
    r.raise_for_status()
    return r.content


def fetch_live_manifest_names(timeout: float = 3.0):
    data = b""
    with socket.create_connection((LOGIN_HOST, LOGIN_PORT), timeout=timeout) as s:
        s.settimeout(timeout)
        s.sendall(bytes.fromhex(LOGIN_HEX))
        deadline = time.time() + timeout
        while time.time() < deadline:
            try:
                chunk = s.recv(4096)
                if not chunk:
                    break
                data += chunk
            except socket.timeout:
                break
    txt = data.decode("utf-8", "ignore")
    names = [f"${k}hash{v}" for k, v in re.findall(r"\$(.*?)hash(.*?)\"", txt)]
    if not names:
        raise RuntimeError("登录服响应中未找到 hash 清单")
    apks = re.findall(r"https?://[^\"\s]+", txt)
    return names, (apks[0] if apks else None)


def cached_manifest_names(out_root):
    try:
        with open(os.path.join(out_root, "assethash.json"), encoding="utf-8") as f:
            meta = json.load(f)
        names = meta.get("manifests") or meta.get("manifest")
        if isinstance(names, str):
            names = [names]
        return [n for n in (names or []) if n] or None
    except Exception:
        return None


def md5_of(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def load_manifest(cdns, platform, manifest_name, retries: int = 2) -> dict:
    last_err = None
    for cdn in cdns:
        for _ in range(retries):
            url = f"{cdn}/{platform}/hash/{manifest_name}"
            try:
                data = fetch(url)
                entries = {}
                for line in data.decode("utf-8", "replace").splitlines():
                    line = line.strip()
                    if not line:
                        continue
                    path, size, md5 = line.split(",")
                    entries[path] = (int(size), md5)
                console.print(f"[green]清单 {manifest_name}: {len(entries)} 条 ({cdn})[/green]")
                return entries
            except Exception as e:
                last_err = e
                console.print(f"[yellow]清单失败 {cdn}: {e}[/yellow]")
    raise RuntimeError(f"清单下载失败: {last_err}")


def load_manifests(cdns, platform, manifest_names) -> dict:
    merged = {}
    for name in manifest_names:
        entries = load_manifest(cdns, platform, name)
        before = len(merged)
        for path, value in entries.items():
            if path in merged and merged[path] != value:
                console.print(f"[yellow]路径冲突 {path}: {merged[path]} vs {value}[/yellow]")
            merged[path] = value
        dup = before + len(entries) - len(merged)
        if dup:
            console.print(f"[yellow]合并去重 {dup} 条[/yellow]")
    return merged


def need_download(local_path: str, size: int, md5: str) -> bool:
    if not os.path.exists(local_path):
        return True
    if os.path.getsize(local_path) != size:
        return True
    if md5_of(open(local_path, "rb").read()) != md5:
        return True
    return False


def download_one(cdns, platform, path, size, md5, dest_dir, progress, task_id):
    dest = os.path.join(dest_dir, path)
    os.makedirs(os.path.dirname(dest) or ".", exist_ok=True)
    tmp = dest + ".tmp"
    last_err = None
    for cdn in cdns:
        try:
            url = f"{cdn}/{platform}/resource/{md5}"
            with session.get(url, stream=True, timeout=60) as r:
                r.raise_for_status()
                window_start = time.time()
                window_bytes = 0
                with open(tmp, "wb") as f:
                    for chunk in r.iter_content(1 << 16):
                        f.write(chunk)
                        progress.advance(task_id, len(chunk))
                        window_bytes += len(chunk)
                        if window_bytes >= 1 << 20:
                            if time.time() - window_start > 10:
                                raise RuntimeError(f"速度过慢 {cdn}")
                            window_start = time.time()
                            window_bytes = 0
            if os.path.getsize(tmp) != size or md5_of(open(tmp, "rb").read()) != md5:
                raise RuntimeError(f"校验失败 {path}")
            os.replace(tmp, dest)
            return path, None
        except Exception as e:
            last_err = e
            try:
                os.remove(tmp)
            except OSError:
                pass
    return path, last_err


def is_script_package(path):
    base = os.path.basename(path).lower()
    if base.endswith(".ys"):
        base = base[:-3]
    # 必须用 ==。`base in ("scripts64")` 会变成子串判断,
    # 把 auctionicon/4、emoji/6 这类资源包也当成脚本。
    return base == "scripts64"


def script_packages(manifest):
    return [(p, v[0], v[1]) for p, v in manifest.items() if is_script_package(p)]


def filter_lua(manifest):
    return {p: v for p, v in manifest.items() if is_script_package(p)}


def effective_script(out_root, path, size, md5):
    for base in ("Updates", "Assets"):
        p = os.path.join(out_root, base, path)
        if os.path.exists(p) and os.path.getsize(p) == size and md5_of(open(p, "rb").read()) == md5:
            return p
    for base in ("Updates", "Assets"):
        p = os.path.join(out_root, base, path)
        if os.path.exists(p):
            return p
    return None


def sync_lua(out_root, manifest, jobs=8):
    packages = script_packages(manifest)
    if not packages:
        return

    import AzurLaneDecompile
    lua_dir = os.path.join(out_root, LUA_DIR)
    os.makedirs(lua_dir, exist_ok=True)
    state_path = os.path.join(out_root, STATE_FILE)
    state = {}
    if os.path.exists(state_path):
        try:
            state = json.load(open(state_path, encoding="utf-8"))
        except Exception:
            state = {}

    if state.get("version") != STATE_VERSION:
        console.print("[yellow]反编译状态版本变更, 将重新反编译[/yellow]")
        state = {}

    for path, size, md5 in packages:
        src = effective_script(out_root, path, size, md5)
        if not src:
            console.print(f"[yellow]脚本包源文件缺失: {path}[/yellow]")
            continue

        local_md5 = md5_of(open(src, "rb").read())
        old = state.get(path) or {}
        has_output = False
        for root, _, names in os.walk(lua_dir):
            if any(n.endswith(".lua") for n in names):
                has_output = True
                break
        if old.get("md5") == local_md5 and old.get("count") and has_output:
            console.print(f"[green]脚本已是最新: {path}[/green]")
            continue

        console.print(f"[cyan]解密并反编译: {path} -> {lua_dir} ({jobs} 线程)[/cyan]")
        try:
            result = AzurLaneDecompile.decompile_bundle(src, lua_dir, jobs=jobs)
        except Exception as exc:
            console.print(f"[red]反编译失败 {path}: {exc}[/red]")
            continue
        state[path] = {
            "md5": local_md5,
            "count": result["ok"],
            "fail": result["fail"],
            "time": time.strftime("%Y-%m-%d %H:%M:%S"),
        }

    state["version"] = STATE_VERSION
    with open(state_path, "w", encoding="utf-8") as f:
        json.dump(state, f, ensure_ascii=False, indent=2)


def main():
    ap = argparse.ArgumentParser(description="碧蓝航线全资产下载/更新器")
    ap.add_argument("--assets", action="store_true", help="只下载资产, 不反编译脚本")
    ap.add_argument("--lua", action="store_true", help="只下载 scripts64 并反编译到 Lua/")
    ap.add_argument("--painting", action="store_true", help="下载立绘与数据表并还原到 Painting/")
    ap.add_argument("--only", default=None, help="过滤关键字, 如 lua / hybridclr")
    ap.add_argument("--cdn", default=None, help="CDN 地址, 默认 OSS 源站")
    ap.add_argument("--platform", default=DEFAULT_PLATFORM, help="平台目录, 默认 android")
    ap.add_argument("--manifest", default=None, help="只下载指定清单, 默认自动获取全部清单")
    ap.add_argument(
        "-j",
        "--jobs",
        type=int,
        default=DEFAULT_JOBS,
        help=f"并发线程数, 默认 CPU 核心数 ({DEFAULT_JOBS})",
    )
    ap.add_argument("--out", default=None, help="输出根目录, 默认当前目录")
    args = ap.parse_args()

    if args.assets and args.lua:
        ap.error("--assets 与 --lua 不能同时使用")
    if args.painting and (args.assets or args.lua):
        ap.error("--painting 不能与 --assets / --lua 同时使用")

    out_root = args.out or os.getcwd()
    assets_dir = os.path.join(out_root, "Assets")
    updates_dir = os.path.join(out_root, "Updates")
    os.makedirs(assets_dir, exist_ok=True)
    os.makedirs(updates_dir, exist_ok=True)

    cdns = [args.cdn] if args.cdn else DEFAULT_CDNS
    apk_url = None
    if args.manifest:
        manifest_names = [args.manifest]
    else:
        try:
            manifest_names, apk_url = fetch_live_manifest_names()
            console.print(f"[green]登录服握手成功, 获取 {len(manifest_names)} 份清单[/green]")
            if apk_url:
                console.print(f"[cyan]安装包: {apk_url}[/cyan]")
        except Exception as e:
            cached = cached_manifest_names(out_root)
            if cached:
                manifest_names = cached
                console.print(f"[yellow]握手失败({e}), 使用上次清单[/yellow]")
            else:
                manifest_names = list(DEFAULT_MANIFESTS)
                console.print(f"[yellow]握手失败({e}), 使用内置清单[/yellow]")
    manifest = load_manifests(cdns, args.platform, manifest_names)

    do_lua = True
    if args.lua:
        manifest = filter_lua(manifest)
        console.print(f"[cyan]脚本模式, 选中 {len(manifest)} 条[/cyan]")
    elif args.painting:
        keywords = ("painting/", "sharecfgdata/", "scripts64")
        manifest = {
            p: v for p, v in manifest.items() if any(k in p.lower() for k in keywords)
        }
        console.print(f"[cyan]立绘模式, 选中 {len(manifest)} 条[/cyan]")
    elif args.assets:
        do_lua = False
        console.print(f"[cyan]纯资产模式, 不反编译脚本[/cyan]")
    elif args.only:
        only = args.only.lower()
        if only == "lua":
            keywords = ("scripts64", "hybridclr")
        else:
            keywords = (only,)
        manifest = {
            p: v for p, v in manifest.items() if any(k in p.lower() for k in keywords)
        }
        console.print(f"[cyan]过滤后 {len(manifest)} 条[/cyan]")

    total_size = sum(v[0] for v in manifest.values())
    console.print(f"[cyan]选中 {len(manifest)} 条, 约 {total_size / 1e9:.2f} GB, {args.jobs} 线程[/cyan]")

    meta = {
        "manifest": manifest_names[0] if manifest_names else None,
        "manifests": manifest_names,
        "platform": args.platform,
        "entries": len(manifest),
        "total_size": total_size,
        "apk": apk_url,
        "time": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    with open(os.path.join(out_root, "assethash.json"), "w", encoding="utf-8") as f:
        json.dump(meta, f, ensure_ascii=False, indent=2)

    pending_assets = []
    pending_updates = []
    for path, (size, md5) in manifest.items():
        if need_download(os.path.join(assets_dir, path), size, md5):
            if not os.path.exists(os.path.join(assets_dir, path)):
                pending_assets.append((path, size, md5))
            else:
                pending_updates.append((path, size, md5))

    if not pending_assets and not pending_updates:
        console.print("[green]全部已是最新[/green]")
        if do_lua:
            sync_lua(out_root, manifest, jobs=args.jobs)
        if args.painting:
            import AzurLanePainting
            AzurLanePainting.run(out_root, jobs=args.jobs)
        return

    console.print(f"[cyan]首次下载 {len(pending_assets)} 条 -> Assets[/cyan]")
    console.print(f"[cyan]增量更新 {len(pending_updates)} 条 -> Updates[/cyan]")

    tasks = [(p, s, m, assets_dir) for p, s, m in pending_assets]
    tasks += [(p, s, m, updates_dir) for p, s, m in pending_updates]
    tasks.sort(key=lambda t: -t[1])

    fail = 0
    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task_id = progress.add_task("下载", total=sum(s for _, s, _, _ in tasks))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futures = [
                pool.submit(download_one, cdns, args.platform, p, s, m, d, progress, task_id)
                for p, s, m, d in tasks
            ]
            for fut in as_completed(futures):
                path, err = fut.result()
                if err:
                    fail += 1
                    console.print(f"[red]失败 {path}: {err}[/red]")

    if do_lua:
        sync_lua(out_root, manifest, jobs=args.jobs)

    if args.painting:
        import AzurLanePainting
        AzurLanePainting.run(out_root, jobs=args.jobs)

    console.print(f"[green]完成, 失败 {fail}[/green]")
    sys.exit(1 if fail else 0)


if __name__ == "__main__":
    main()
