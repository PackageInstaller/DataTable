#!/usr/bin/env python3
"""奥奇传说：APK + 双通道热更整合到 Assets/，LuaJIT 反编译与序列化配置导出到 MasterData/。

热更两套（BootstrapOnlineResMgr / GameUpdateHelper）：
  1) CC2D zip（cc2dhotupdate.100bt.com）— 增量补丁，约数百 MB
  2) OnlineRes（api-mobilegame-hotupdate.172tt.com）— 完整资源清单，约数 GB

子命令：
  version     CC2D + OnlineRes 远端清单摘要
  assets      APK + CC2D zip + OnlineRes 文件 → Assets/
  masterdata  luascripts → 反编译 Lua；序列化 JSON → indent=2
  （无子命令 = 全流程）

参考 DataTable：CatFantasy / Reverse1999 / Seer / IllusionConnect / MoeCove。
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

try:
    import UnityPy

    UnityPy.config.FALLBACK_UNITY_VERSION = "2017.4.37f1"
except ImportError:
    UnityPy = None  # type: ignore

ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
CACHE_DIR = ROOT / "Cache"

GAME_TITLE = "奥奇传说"
APP_CODE = "aqsy"
DEFAULT_PACKAGE = "com.baitian.aqcs.aqcssy.bt"
DEFAULT_HOTUPDATE = "https://cc2dhotupdate.100bt.com"
# OnlineResUpdateDefs.MAIN_URL（libil2cpp 字符串 / BootstrapOnlineResMgr）
DEFAULT_ONLINE_API = "https://api-mobilegame-hotupdate.172tt.com"
DEFAULT_ONLINE_API_BAK = "https://api-mobilegame-hotupdate-bak.172tt.com"
DEFAULT_GAME_ID = 100044
DEFAULT_PLATFORM = 0  # CC2D Android p=
DEFAULT_PLATFORM_ID = 2  # OnlineRes platformId（HAR）
DEFAULT_CHANNEL1 = 2
DEFAULT_CHANNEL2 = "140004"
DEFAULT_COCHANNEL = "20001"
DEFAULT_URL_VER = 4
UNITY_FS = b"UnityFS"
LUA_JIT = b"\x1bLJ"
LUA_BC = b"\x1bLua"
CHUNK_SIZE = 1 << 20
DEFAULT_JOBS = 8
ONLINE_JOBS = 16
UA = "LegendOfAoqi/1.0"

# arm64 包优先；没有再退回 32 位目录
LUA_BUNDLE_DIRS = ("luascripts/64", "luascripts")
LUA_BUNDLE_NAMES = (
    "bootstrap",
    "framework",
    "frameworkext",
    "tolua",
    "logicstarter",
    "logiccommon",
    "logic",
    "logicconfig",
    "logicscene",
)
# 从这些 AB 里掏「已经是 JSON / 文本」的序列化配置（不是把 Lua 表转 JSON）
SERIALIZED_BUNDLES = (
    "config.data",
    "storyconfig.data",
)

console = Console()
_INVALID_FS = re.compile(r'[\\/:*?"<>|\x00-\x1f]')


# ---------------------------------------------------------------------------
# 基础
# ---------------------------------------------------------------------------


def format_size(n: int) -> str:
    x = float(n)
    for u in ("B", "KB", "MB", "GB"):
        if x < 1024 or u == "GB":
            return f"{x:.2f} {u}"
        x /= 1024
    return f"{n} B"


def md5_bytes(data: bytes) -> str:
    return hashlib.md5(data).hexdigest()


def md5_file(path: Path) -> str:
    h = hashlib.md5()
    with path.open("rb") as fh:
        while True:
            b = fh.read(CHUNK_SIZE)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def http_get(url: str, timeout: int = 60) -> bytes:
    req = Request(url, headers={"User-Agent": UA})
    with urlopen(req, timeout=timeout) as resp:
        return resp.read()


def http_download(url: str, dest: Path, expected_size: int = 0, expected_md5: str = "") -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file():
        if expected_md5 and md5_file(dest) == expected_md5.lower():
            return "skip"
        if expected_size > 0 and dest.stat().st_size == expected_size and not expected_md5:
            return "skip"
    part = Path(str(dest) + ".part")
    last_err: Exception | None = None
    for attempt in range(1, 5):
        try:
            req = Request(url, headers={"User-Agent": UA})
            with urlopen(req, timeout=120) as resp, part.open("wb") as out:
                while True:
                    chunk = resp.read(CHUNK_SIZE)
                    if not chunk:
                        break
                    out.write(chunk)
            if expected_size > 0 and part.stat().st_size != expected_size:
                raise RuntimeError(f"大小不符 {part.stat().st_size} != {expected_size}")
            if expected_md5:
                got = md5_file(part)
                if got != expected_md5.lower():
                    raise RuntimeError(f"MD5 不符 {got} != {expected_md5}")
            part.replace(dest)
            return "ok"
        except Exception as e:
            last_err = e
            part.unlink(missing_ok=True)
            time.sleep(min(2 * attempt, 8))
    raise RuntimeError(f"下载失败 {url}: {last_err}")


def find_apk(explicit: str | None = None) -> Path:
    if explicit:
        p = Path(explicit)
        if not p.is_file():
            raise FileNotFoundError(p)
        return p
    apks = sorted(ROOT.glob("*.apk"), key=lambda x: x.stat().st_size, reverse=True)
    if not apks:
        raise FileNotFoundError("工作区没有 .apk")
    return apks[0]


def read_apk_meta(apk: Path) -> tuple[str, int, str]:
    """返回 (versionName, versionCode, packageName)。"""
    ver, vc, pkg = "8.0.2329", 1185, DEFAULT_PACKAGE
    try:
        out = subprocess.check_output(
            ["aapt", "dump", "badging", str(apk)], text=True, errors="replace"
        )
        m = re.search(r"package: name='([^']+)' versionCode='(\d+)' versionName='([^']+)'", out)
        if m:
            pkg, vc, ver = m.group(1), int(m.group(2)), m.group(3)
    except Exception:
        pass
    return ver, vc, pkg


def which_decompiler() -> tuple[str | None, str]:
    """(path, kind) kind in luajit|unluac|none。用户口头 luajit-decompier = 本机 luajit-decompiler。"""
    for name in ("luajit-decompiler", "luajit-decompier"):
        p = shutil.which(name)
        if p:
            return p, "luajit"
    p = shutil.which("unluac") or (Path("/usr/bin/unluac") if Path("/usr/bin/unluac").is_file() else None)
    if p:
        return str(p), "unluac"
    return None, "none"


def safe_name(name: str) -> str:
    return _INVALID_FS.sub("_", name).strip().rstrip(".") or "unnamed"


# ---------------------------------------------------------------------------
# 热更 manifest
# ---------------------------------------------------------------------------


def version_manifest_url(
    host: str,
    app: str,
    url_ver: int,
    platform: int,
    c1: int,
    version: str,
    vc: int,
    package: str,
    c2: str,
) -> str:
    base = host.rstrip("/")
    return (
        f"{base}/manifest/{app}/version_v{url_ver}.manifest"
        f"?p={platform}&c1={c1}&v={version}&vc={vc}&pn={package}&c2={c2}"
    )


def project_manifest_url(
    host: str,
    app: str,
    url_ver: int,
    platform: int,
    c1: int,
    version: str,
    vc: int,
    package: str,
    c2: str,
    target_ver: str,
) -> str:
    base = host.rstrip("/")
    return (
        f"{base}/manifest/{app}/project_v{url_ver}.manifest"
        f"?p={platform}&c1={c1}&v={version}&vc={vc}&pn={package}&c2={c2}&tv={target_ver}"
    )


def fetch_version_manifest(args) -> dict[str, Any]:
    apk = find_apk(getattr(args, "apk", None))
    ver, vc, pkg = read_apk_meta(apk)
    ver = getattr(args, "app_version", None) or ver
    vc = int(getattr(args, "version_code", None) or vc)
    pkg = getattr(args, "package", None) or pkg
    host = getattr(args, "host", None) or DEFAULT_HOTUPDATE
    url = version_manifest_url(
        host,
        APP_CODE,
        int(getattr(args, "url_ver", DEFAULT_URL_VER)),
        int(getattr(args, "platform", DEFAULT_PLATFORM)),
        int(getattr(args, "channel1", DEFAULT_CHANNEL1)),
        ver,
        vc,
        pkg,
        str(getattr(args, "channel2", DEFAULT_CHANNEL2)),
    )
    data = json.loads(http_get(url).decode("utf-8"))
    data["_meta"] = {"url": url, "localVersion": ver, "versionCode": vc, "package": pkg}
    return data


def fetch_project_manifest(args, target_ver: str | None = None) -> dict[str, Any]:
    apk = find_apk(getattr(args, "apk", None))
    ver, vc, pkg = read_apk_meta(apk)
    ver = getattr(args, "app_version", None) or ver
    vc = int(getattr(args, "version_code", None) or vc)
    pkg = getattr(args, "package", None) or pkg
    host = getattr(args, "host", None) or DEFAULT_HOTUPDATE
    if not target_ver:
        target_ver = fetch_version_manifest(args).get("version") or ver
    url = project_manifest_url(
        host,
        APP_CODE,
        int(getattr(args, "url_ver", DEFAULT_URL_VER)),
        int(getattr(args, "platform", DEFAULT_PLATFORM)),
        int(getattr(args, "channel1", DEFAULT_CHANNEL1)),
        ver,
        vc,
        pkg,
        str(getattr(args, "channel2", DEFAULT_CHANNEL2)),
        target_ver,
    )
    data = json.loads(http_get(url).decode("utf-8"))
    data["_meta"] = {"url": url, "localVersion": ver, "targetVersion": target_ver}
    return data


# ---------------------------------------------------------------------------
# OnlineRes（172tt）— BootstrapSimpleResDownloadMgr.read_manifest
# ---------------------------------------------------------------------------


def online_query_params(args, *, hot_version: str = "0.0.0", hot_version_id: str = "", target_version: str = "") -> str:
    apk = find_apk(getattr(args, "apk", None))
    ver, vc, pkg = read_apk_meta(apk)
    vc = int(getattr(args, "version_code", None) or vc)
    pkg = getattr(args, "package", None) or pkg
    parts = {
        "deviceId": getattr(args, "device_id", None) or "LegendOfAoqi",
        "gameId": int(getattr(args, "game_id", None) or DEFAULT_GAME_ID),
        "sdkType": 0,
        "zoneId": 1,
        "packageName": pkg,
        "packageVersionCode": vc,
        "platformId": int(getattr(args, "platform_id", None) or DEFAULT_PLATFORM_ID),
        "channelId": str(getattr(args, "channel2", DEFAULT_CHANNEL2)),
        "cochannelId": str(getattr(args, "cochannel", DEFAULT_COCHANNEL)),
        "hotVersion": hot_version,
        "hotVersionId": hot_version_id,
    }
    if target_version:
        parts["targetVersion"] = target_version
    return "&".join(f"{k}={v}" for k, v in parts.items())


def fetch_online_version(args) -> dict[str, Any]:
    api = (getattr(args, "online_api", None) or DEFAULT_ONLINE_API).rstrip("/")
    url = f"{api}/open-api/version/manifest/v2?{online_query_params(args)}"
    try:
        data = json.loads(http_get(url).decode("utf-8"))
    except Exception:
        bak = DEFAULT_ONLINE_API_BAK.rstrip("/")
        url = f"{bak}/open-api/version/manifest/v2?{online_query_params(args)}"
        data = json.loads(http_get(url).decode("utf-8"))
    if data.get("code") != 0:
        raise RuntimeError(f"OnlineRes version 失败: {data}")
    data["_meta"] = {"url": url}
    return data


def parse_online_manifest(blob: bytes) -> dict[str, Any]:
    """与 BootstrapSimpleResDownloadMgr:read_manifest 一致。"""
    off = 0

    def u32() -> int:
        nonlocal off
        v = struct.unpack_from("<I", blob, off)[0]
        off += 4
        return v

    def u64() -> int:
        nonlocal off
        v = struct.unpack_from("<Q", blob, off)[0]
        off += 8
        return v

    def s(n: int) -> str:
        nonlocal off
        out = blob[off : off + n].decode("utf-8", "replace")
        off += n
        return out

    t = blob[off]
    off += 1
    if t == 1:
        code = u32()
        msg_len = u32()
        msg = s(msg_len) if msg_len else ""
        if code != 0:
            raise RuntimeError(f"OnlineRes manifest code={code} msg={msg}")
    ver_len = u32()
    version = s(ver_len) if ver_len else ""
    vid_len = u32()
    version_id = s(vid_len) if vid_len else ""
    count = u32()
    files: list[dict[str, Any]] = []
    for _ in range(count):
        flen = u32()
        fname = s(flen)
        md5 = s(32)
        size = u64()
        dlen = u32()
        d = s(dlen) if dlen else ""
        files.append({"File": fname, "MD5": md5, "Size": size, "Dir": d})
    return {"Version": version, "VersionId": version_id, "files": files}


def fetch_online_manifest(args, ver_data: dict[str, Any] | None = None) -> dict[str, Any]:
    ver_data = ver_data or fetch_online_version(args)
    d = ver_data.get("data") or {}
    target = str(d.get("hotVersion") or "0.0.0")
    api = (getattr(args, "online_api", None) or DEFAULT_ONLINE_API).rstrip("/")
    q = online_query_params(args, target_version=target)
    url = f"{api}/open-api/project/manifest/v2?{q}"
    try:
        blob = http_get(url, timeout=180)
    except Exception:
        bak = DEFAULT_ONLINE_API_BAK.rstrip("/")
        url = f"{bak}/open-api/project/manifest/v2?{q}"
        blob = http_get(url, timeout=180)
    parsed = parse_online_manifest(blob)
    hosts = list(d.get("hosts") or [])
    project = str(d.get("projectPath") or "")
    parsed["hosts"] = hosts
    parsed["projectPath"] = project
    parsed["hotVersion"] = target
    parsed["hotVersionId"] = str(d.get("hotVersionId") or "")
    parsed["_meta"] = {"url": url, "rawSize": len(blob)}
    # 缓存二进制 + JSON 摘要
    meta = ASSETS_DIR / "_online"
    meta.mkdir(parents=True, exist_ok=True)
    (meta / "simple_manifest.bin").write_bytes(blob)
    (meta / "version.json").write_text(
        json.dumps(ver_data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    summary = {
        "Version": parsed["Version"],
        "VersionId": parsed["VersionId"],
        "hotVersion": parsed["hotVersion"],
        "hotVersionId": parsed["hotVersionId"],
        "hosts": hosts,
        "projectPath": project,
        "fileCount": len(parsed["files"]),
        "totalSize": sum(int(f["Size"]) for f in parsed["files"]),
    }
    (meta / "manifest_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return parsed


def online_file_url(hosts: list[str], project: str, item: dict[str, Any]) -> list[str]:
    """url = host/projectPath/Dir/File（BootstrapSimpleResDownloadMgr）。"""
    rel = f"{project}/{item['Dir']}/{item['File']}".replace("//", "/")
    return [f"{h.rstrip('/')}/{rel}" for h in hosts if h]


def download_online_res(args, dest: Path, mani: dict[str, Any] | None = None) -> dict[str, int]:
    mani = mani or fetch_online_manifest(args)
    hosts = list(mani.get("hosts") or [])
    project = str(mani.get("projectPath") or "")
    files = list(mani.get("files") or [])
    if not hosts or not project or not files:
        raise RuntimeError("OnlineRes manifest 缺 hosts/projectPath/files")

    jobs = max(1, int(getattr(args, "online_jobs", None) or getattr(args, "jobs", ONLINE_JOBS)))
    force = bool(getattr(args, "force", False))
    limit = int(getattr(args, "online_limit", 0) or 0)

    pending: list[dict[str, Any]] = []
    skip = 0
    for item in files:
        path = dest / item["File"]
        size = int(item["Size"])
        if not force and path.is_file() and path.stat().st_size == size:
            skip += 1
            continue
        pending.append(item)
    if limit > 0:
        pending = pending[:limit]

    need_bytes = sum(int(i["Size"]) for i in pending)
    console.print(
        f"[cyan]OnlineRes[/cyan] {mani.get('hotVersion')}  "
        f"清单 {len(files)}  已有 {skip}  待下 {len(pending)}  "
        f"({format_size(need_bytes)})  jobs={jobs}"
    )
    if not pending:
        return {"ok": 0, "skip": skip, "fail": 0}

    stats = {"ok": 0, "skip": skip, "fail": 0}
    fail_samples: list[str] = []

    def one(item: dict[str, Any]) -> str:
        path = dest / item["File"]
        size = int(item["Size"])
        md5 = str(item.get("MD5") or "")
        urls = online_file_url(hosts, project, item)
        last: Exception | None = None
        for url in urls:
            try:
                # 大文件不做全量 md5（太慢）；尺寸对齐即可。--force 仍校 md5。
                http_download(
                    url,
                    path,
                    expected_size=size,
                    expected_md5=md5 if force and md5 else "",
                )
                return "ok"
            except Exception as e:
                last = e
        raise RuntimeError(f"{item['File']}: {last}")

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("OnlineRes", total=need_bytes)
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = {pool.submit(one, it): it for it in pending}
            for fut in as_completed(futs):
                it = futs[fut]
                try:
                    fut.result()
                    stats["ok"] += 1
                    progress.advance(task, int(it["Size"]))
                except Exception as e:
                    stats["fail"] += 1
                    if len(fail_samples) < 8:
                        fail_samples.append(str(e))
                    progress.advance(task, int(it["Size"]))

    if fail_samples:
        console.print("[red]失败样例[/red]")
        for s in fail_samples:
            console.print(f"  {s}")
    console.print(
        f"[bold green]OnlineRes 完成[/bold green] ok={stats['ok']} skip={stats['skip']} fail={stats['fail']}"
    )
    (dest / ".online_hotversion").write_text(
        f"{mani.get('hotVersion')}\n{mani.get('hotVersionId')}\n", encoding="utf-8"
    )
    return stats


# ---------------------------------------------------------------------------
# Assets：APK + CC2D + OnlineRes
# ---------------------------------------------------------------------------


def extract_apk_android(apk: Path, dest: Path, force: bool = False) -> None:
    stamp = dest / ".apk_extracted"
    if stamp.is_file() and not force:
        console.print("[yellow]已提取过 APK，跳过[/yellow]（--force 可重提）")
        return
    if UnityPy is None:
        pass  # 提取不依赖 UnityPy
    tmp = CACHE_DIR / "apk_extract"
    if tmp.exists():
        shutil.rmtree(tmp)
    tmp.mkdir(parents=True, exist_ok=True)
    console.print(f"[cyan]从 APK 提取 assets/Android/ ...[/cyan] {apk.name}")
    proc = subprocess.run(
        ["unzip", "-qo", str(apk), "assets/Android/*", "-d", str(tmp)],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.PIPE,
    )
    if proc.returncode not in (0, 11):
        raise RuntimeError(proc.stderr.decode("utf-8", "replace"))
    src = tmp / "assets" / "Android"
    if not src.is_dir():
        raise RuntimeError("APK 里没有 assets/Android/")
    dest.mkdir(parents=True, exist_ok=True)
    # 合并进 Assets/（热更路径相对 Android 根）
    for item in src.rglob("*"):
        if item.is_dir():
            continue
        rel = item.relative_to(src)
        target = dest / rel
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(item, target)
    shutil.rmtree(tmp, ignore_errors=True)
    stamp.write_text(f"{apk}\n", encoding="utf-8")
    console.print(f"[green]APK ->[/green] {dest}")


def apply_hotupdate_zip(zip_path: Path, dest: Path) -> int:
    """热更 zip 成员已是相对 Android 根的路径（含 dwp/）。"""
    n = 0
    with zipfile.ZipFile(zip_path) as zf:
        for info in zf.infolist():
            name = info.filename.replace("\\", "/")
            if not name or name.endswith("/") or ".." in Path(name).parts:
                continue
            target = dest / name
            if info.is_dir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(info) as src, target.open("wb") as out:
                shutil.copyfileobj(src, out, CHUNK_SIZE)
            n += 1
    return n


def cmd_version(args) -> dict[str, Any]:
    console.print("[bold]— CC2D 热更 zip —[/bold]")
    ver = fetch_version_manifest(args)
    console.print_json(data={k: v for k, v in ver.items() if not k.startswith("_")})
    proj = fetch_project_manifest(args, target_ver=ver.get("version"))
    assets = proj.get("assets") or []
    total = sum(int(a.get("size") or 0) for a in assets)
    console.print(
        f"[cyan]CC2D 包[/cyan] {len(assets)} 个  [cyan]合计[/cyan] {format_size(total)}  "
        f"[cyan]version[/cyan] {proj.get('version')}  "
        f"[cyan]packageUrl[/cyan] {proj.get('packageUrl')}"
    )
    for a in assets:
        console.print(
            f"  ver={a.get('ver')}  {a.get('path')}  "
            f"{format_size(int(a.get('size') or 0))}  md5={a.get('md5')}"
        )
    meta_dir = ASSETS_DIR / "_hotupdate"
    meta_dir.mkdir(parents=True, exist_ok=True)
    (meta_dir / "version.manifest.json").write_text(
        json.dumps(ver, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    (meta_dir / "project.manifest.json").write_text(
        json.dumps(proj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    console.print("[bold]— OnlineRes（172tt）—[/bold]")
    online_ver = fetch_online_version(args)
    od = online_ver.get("data") or {}
    console.print_json(data=od)
    # 只拉摘要：解析 bin 统计，不打印 8 万路径
    online = fetch_online_manifest(args, online_ver)
    osize = sum(int(f["Size"]) for f in online["files"])
    console.print(
        f"[cyan]OnlineRes[/cyan] files={len(online['files'])}  "
        f"size={format_size(osize)}  "
        f"hotVersion={online.get('hotVersion')}  "
        f"project={online.get('projectPath')}"
    )
    return {"cc2d": proj, "online": online}


def apply_cc2d_hotupdate(args) -> dict[str, Any]:
    proj = fetch_project_manifest(args)
    # 也落盘 version
    try:
        ver = fetch_version_manifest(args)
        meta_dir = ASSETS_DIR / "_hotupdate"
        meta_dir.mkdir(parents=True, exist_ok=True)
        (meta_dir / "version.manifest.json").write_text(
            json.dumps(ver, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )
        (meta_dir / "project.manifest.json").write_text(
            json.dumps(proj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )
    except Exception:
        pass

    package_url = (proj.get("packageUrl") or "").rstrip("/")
    backup = (proj.get("packageUrl_backup") or "").rstrip("/")
    assets = list(proj.get("assets") or [])
    if not assets:
        console.print("[yellow]CC2D project manifest 无 assets[/yellow]")
        return proj

    cache_zips = CACHE_DIR / "hotupdate_zips"
    cache_zips.mkdir(parents=True, exist_ok=True)

    def one(a: dict[str, Any]) -> tuple[str, Path]:
        rel = str(a["path"]).lstrip("/")
        md5 = str(a.get("md5") or "")
        size = int(a.get("size") or 0)
        dest = cache_zips / Path(rel).name
        urls = [f"{package_url}/{rel}"]
        if backup:
            urls.append(f"{backup}/{rel}")
        err: Exception | None = None
        for url in urls:
            try:
                http_download(url, dest, expected_size=size, expected_md5=md5)
                return rel, dest
            except Exception as e:
                err = e
        raise RuntimeError(f"{rel}: {err}")

    console.print(f"[cyan]下载 CC2D zip[/cyan] {len(assets)} 个 -> {cache_zips}")
    zips: list[tuple[str, Path]] = []
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total}"),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("CC2D", total=len(assets))
        with ThreadPoolExecutor(max_workers=max(1, int(getattr(args, "jobs", DEFAULT_JOBS)))) as pool:
            futs = {pool.submit(one, a): a for a in assets}
            for fut in as_completed(futs):
                rel, path = fut.result()
                zips.append((rel, path))
                progress.advance(task)

    order = {str(a["path"]).lstrip("/"): i for i, a in enumerate(assets)}
    zips.sort(key=lambda x: order.get(x[0], 10**9))

    console.print(f"[cyan]解压 CC2D 覆盖到[/cyan] {ASSETS_DIR}")
    total_files = 0
    for rel, path in zips:
        n = apply_hotupdate_zip(path, ASSETS_DIR)
        total_files += n
        console.print(f"  [green]+[/green] {path.name}  ({n} files)")

    (ASSETS_DIR / ".hotupdate_version").write_text(
        str(proj.get("version") or "") + "\n", encoding="utf-8"
    )
    console.print(
        f"[bold green]CC2D 完成[/bold green] 写入 {total_files} 文件  version={proj.get('version')}"
    )
    return proj


def cmd_assets(args) -> None:
    apk = find_apk(getattr(args, "apk", None))
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    if not getattr(args, "skip_apk", False):
        extract_apk_android(apk, ASSETS_DIR, force=getattr(args, "force", False))

    if not getattr(args, "skip_hotupdate", False):
        apply_cc2d_hotupdate(args)
    else:
        console.print("[yellow]跳过 CC2D 热更[/yellow]")

    if not getattr(args, "skip_online", False):
        download_online_res(args, ASSETS_DIR)
    else:
        console.print("[yellow]跳过 OnlineRes[/yellow]")

    console.print(f"[bold green]Assets 完成[/bold green] {ASSETS_DIR}")


# ---------------------------------------------------------------------------
# MasterData：Lua 反编译 + 序列化 JSON
# ---------------------------------------------------------------------------


def text_asset_bytes(obj) -> tuple[str, bytes]:
    d = obj.read()
    name = d.m_Name or "unnamed"
    raw = d.m_Script
    if isinstance(raw, str):
        raw = raw.encode("utf-8", "surrogateescape")
    return name, raw


def extract_bundle_textassets(bundle: Path) -> list[tuple[str, bytes]]:
    if UnityPy is None:
        raise RuntimeError("需要 UnityPy：pip install UnityPy")
    env = UnityPy.load(str(bundle))
    out: list[tuple[str, bytes]] = []
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        out.append(text_asset_bytes(obj))
    return out


def detect_lua_kind(data: bytes) -> str:
    if data.startswith(LUA_JIT):
        return "luajit"
    if data.startswith(LUA_BC):
        return "lua"
    head = data.lstrip()[:64]
    if head.startswith((b"--", b"local", b"function", b"return", b"module")):
        return "source"
    return "unknown"


def write_pretty_json(dest: Path, raw: bytes) -> bool:
    """若 raw 是 JSON，写成 indent=2；否则 False。"""
    try:
        text = raw.decode("utf-8")
        obj = json.loads(text)
    except Exception:
        return False
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return True


def pick_lua_root(assets: Path) -> Path | None:
    for rel in LUA_BUNDLE_DIRS:
        p = assets / rel
        if p.is_dir() and any(p.glob("*.data")):
            return p
    return None


def export_lua_bundles(assets: Path, master: Path, jobs: int, force: bool) -> dict[str, int]:
    stats = {"bundles": 0, "files": 0, "luajit": 0, "lua": 0, "source": 0, "skip": 0, "fail": 0}
    root = pick_lua_root(assets)
    if root is None:
        console.print(f"[yellow]Assets 下没有 luascripts[/yellow] {assets}")
        return stats

    decomp, kind = which_decompiler()
    console.print(f"[cyan]Lua 根[/cyan] {root.relative_to(assets)}  [cyan]反编译器[/cyan] {decomp or '无'} ({kind})")

    staging = CACHE_DIR / "lua_bytecode"
    if staging.exists() and force:
        shutil.rmtree(staging)
    staging.mkdir(parents=True, exist_ok=True)

    for stem in LUA_BUNDLE_NAMES:
        bundle = root / f"{stem}.data"
        if not bundle.is_file():
            continue
        stats["bundles"] += 1
        out_bc = staging / stem
        out_bc.mkdir(parents=True, exist_ok=True)
        console.print(f"[cyan]拆包[/cyan] {bundle.relative_to(assets)}")
        try:
            assets_list = extract_bundle_textassets(bundle)
        except Exception as e:
            console.print(f"[red]拆包失败[/red] {bundle.name}: {e}")
            stats["fail"] += 1
            continue
        for name, raw in assets_list:
            fname = name if name.endswith(".lua") else f"{name}.lua"
            path = out_bc / safe_name(fname)
            path.write_bytes(raw)
            stats["files"] += 1
            k = detect_lua_kind(raw)
            if k == "luajit":
                stats["luajit"] += 1
            elif k == "lua":
                stats["lua"] += 1
            elif k == "source":
                stats["source"] += 1
                # 源码直接进 MasterData
                dest = master / stem / safe_name(fname)
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(raw)

    # LuaJIT 批量反编译
    if stats["luajit"] and kind == "luajit" and decomp:
        console.print(f"[cyan]luajit-decompiler[/cyan] {stats['luajit']} -> {master}")
        log = CACHE_DIR / "luajit-decompile.log"
        with log.open("w", encoding="utf-8") as logf:
            proc = subprocess.run(
                [decomp, str(staging), "-o", str(master), "-f", "-s", "-j", str(max(1, jobs))],
                stdout=logf,
                stderr=subprocess.STDOUT,
                check=False,
            )
        if proc.returncode != 0:
            console.print(f"[red]反编译退出码 {proc.returncode}[/red] 日志 {log}")
    elif stats["luajit"] and kind != "luajit":
        console.print("[red]有 LuaJIT 字节码但未找到 luajit-decompiler[/red]")

    # 标准 Lua 字节码：逐个 unluac
    if stats["lua"] and kind == "unluac" and decomp:
        console.print(f"[cyan]unluac[/cyan] {stats['lua']}")
        for bc in staging.rglob("*.lua"):
            if not bc.read_bytes().startswith(LUA_BC):
                continue
            rel = bc.relative_to(staging)
            dest = master / rel
            dest.parent.mkdir(parents=True, exist_ok=True)
            try:
                out = subprocess.check_output([decomp, str(bc)], stderr=subprocess.DEVNULL)
                dest.write_bytes(out)
            except Exception:
                stats["fail"] += 1
    elif stats["lua"] and not (kind == "unluac" and decomp):
        # 若主工具是 luajit，再单独找 unluac
        unluac = shutil.which("unluac")
        if unluac:
            for bc in staging.rglob("*.lua"):
                if not bc.read_bytes().startswith(LUA_BC):
                    continue
                rel = bc.relative_to(staging)
                dest = master / rel
                dest.parent.mkdir(parents=True, exist_ok=True)
                try:
                    out = subprocess.check_output([unluac, str(bc)], stderr=subprocess.DEVNULL)
                    dest.write_bytes(out)
                except Exception:
                    stats["fail"] += 1
        else:
            console.print("[yellow]有 Lua 5.x 字节码但未找到 unluac，已保留 bytecode 在 Cache[/yellow]")

    return stats


def export_serialized_configs(assets: Path, master: Path) -> dict[str, int]:
    """序列化配置：TextAsset 里已是 JSON 的 pretty 写出；纯文本原样保存。不碰 Lua 表。"""
    stats = {"json": 0, "text": 0, "skip": 0, "fail": 0}
    if UnityPy is None:
        console.print("[red]需要 UnityPy 才能导出 config/storyconfig[/red]")
        return stats

    for rel in SERIALIZED_BUNDLES:
        bundle = assets / rel
        if not bundle.is_file():
            console.print(f"[yellow]缺少[/yellow] {rel}")
            continue
        sub = master / Path(rel).stem
        console.print(f"[cyan]导出序列化配置[/cyan] {rel} -> {sub}/")
        try:
            items = extract_bundle_textassets(bundle)
        except Exception as e:
            console.print(f"[red]失败[/red] {rel}: {e}")
            stats["fail"] += 1
            continue
        for name, raw in items:
            base = safe_name(name)
            if write_pretty_json(sub / f"{base}.json", raw):
                stats["json"] += 1
                continue
            # 非 JSON：按文本落盘
            dest = sub / f"{base}.txt"
            dest.parent.mkdir(parents=True, exist_ok=True)
            try:
                dest.write_bytes(raw)
                stats["text"] += 1
            except Exception:
                stats["fail"] += 1
    return stats


def dump_bin_manifest_json(assets: Path, master: Path) -> None:
    """bin_manifest.data 是路径索引（非加密），导出为 JSON 方便查阅。"""
    path = assets / "bin_manifest.data"
    if not path.is_file():
        return
    data = path.read_bytes()
    if len(data) < 8:
        return
    # u32 unk, u32 count, then (u8 len, path, u32 flag)*
    count = struct.unpack_from("<I", data, 4)[0]
    off = 8
    entries = []
    try:
        for _ in range(count):
            n = data[off]
            off += 1
            p = data[off : off + n].decode("utf-8", "replace")
            off += n
            flag = struct.unpack_from("<I", data, off)[0]
            off += 4
            entries.append({"path": p, "flag": flag})
    except Exception as e:
        console.print(f"[yellow]bin_manifest 解析中断[/yellow] {e}")
        return
    dest = master / "bin_manifest.json"
    dest.write_text(json.dumps(entries, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    console.print(f"[green]bin_manifest.json[/green] {len(entries)} 条")


def cmd_masterdata(args) -> None:
    if not ASSETS_DIR.is_dir() or not any(ASSETS_DIR.iterdir()):
        console.print("[yellow]Assets 为空，先跑 assets[/yellow]")
        cmd_assets(args)

    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    jobs = int(getattr(args, "jobs", DEFAULT_JOBS))
    force = bool(getattr(args, "force", False))

    lua_stats = export_lua_bundles(ASSETS_DIR, MASTER_DIR, jobs=jobs, force=force)
    ser_stats = export_serialized_configs(ASSETS_DIR, MASTER_DIR)
    dump_bin_manifest_json(ASSETS_DIR, MASTER_DIR)

    lua_count = sum(1 for _ in MASTER_DIR.rglob("*.lua"))
    json_count = sum(1 for _ in MASTER_DIR.rglob("*.json"))
    console.print(
        f"[bold green]MasterData 完成[/bold green]  "
        f"lua文件={lua_count} (拆包 {lua_stats['files']}, LJ {lua_stats['luajit']})  "
        f"json={json_count} (序列化JSON {ser_stats['json']}, 文本 {ser_stats['text']})  "
        f"-> {MASTER_DIR}"
    )


def cmd_all(args) -> None:
    cmd_assets(args)
    cmd_masterdata(args)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", help="APK 路径")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="CC2D/通用并发")
    shared.add_argument("--online-jobs", type=int, default=ONLINE_JOBS, help="OnlineRes 下载并发")
    shared.add_argument("--force", action="store_true", help="强制重提/重做")
    shared.add_argument("--host", default=DEFAULT_HOTUPDATE, help="CC2D manifest 域名")
    shared.add_argument("--online-api", default=DEFAULT_ONLINE_API, help="OnlineRes API")
    shared.add_argument("--app-version", dest="app_version", help="本地客户端版本名")
    shared.add_argument("--version-code", type=int, help="versionCode")
    shared.add_argument("--package", default=DEFAULT_PACKAGE, help="包名")
    shared.add_argument("--game-id", type=int, default=DEFAULT_GAME_ID, help="OnlineRes gameId")
    shared.add_argument("--channel1", type=int, default=DEFAULT_CHANNEL1, help="CC2D c1")
    shared.add_argument("--channel2", default=DEFAULT_CHANNEL2, help="渠道 / OnlineRes channelId")
    shared.add_argument("--cochannel", default=DEFAULT_COCHANNEL, help="OnlineRes cochannelId")
    shared.add_argument("--platform", type=int, default=DEFAULT_PLATFORM, help="CC2D p")
    shared.add_argument("--platform-id", type=int, default=DEFAULT_PLATFORM_ID, help="OnlineRes platformId")
    shared.add_argument("--url-ver", type=int, default=DEFAULT_URL_VER, help="version_vN / project_vN")
    shared.add_argument("--online-limit", type=int, default=0, help="OnlineRes 只下前 N 个（调试）")

    p = argparse.ArgumentParser(
        description=f"{GAME_TITLE}：APK + CC2D zip + OnlineRes → Assets/；Lua + 序列化配置 → MasterData/",
        parents=[shared],
    )
    p.add_argument("--skip-apk", action="store_true", help="不从 APK 提取")
    p.add_argument("--skip-hotupdate", action="store_true", help="跳过 CC2D zip 热更")
    p.add_argument("--skip-online", action="store_true", help="跳过 OnlineRes（172tt 大资源）")
    sub = p.add_subparsers(dest="command", required=False)

    sub.add_parser("version", aliases=["list"], parents=[shared], help="CC2D + OnlineRes 远端清单")

    p_assets = sub.add_parser("assets", parents=[shared], help="APK + CC2D + OnlineRes → Assets/")
    p_assets.add_argument("--skip-apk", action="store_true")
    p_assets.add_argument("--skip-hotupdate", action="store_true", help="跳过 CC2D")
    p_assets.add_argument("--skip-online", action="store_true", help="跳过 OnlineRes")

    sub.add_parser(
        "masterdata",
        aliases=["data", "lua"],
        parents=[shared],
        help="Lua 反编译 + 序列化配置 JSON → MasterData/",
    )
    return p


def _self_check() -> None:
    # ponytail: 最小自检，逻辑回归时直接炸
    assert detect_lua_kind(b"\x1bLJ\x02\x00") == "luajit"
    assert detect_lua_kind(b"\x1bLua") == "lua"
    assert detect_lua_kind(b"local x = 1") == "source"
    sample = b'{"a":1}'
    with tempfile.TemporaryDirectory() as td:
        dest = Path(td) / "t.json"
        assert write_pretty_json(dest, sample)
        assert '"a": 1' in dest.read_text(encoding="utf-8")
    # OnlineRes manifest 头：type=1, code=0, msg="", then version lens
    blob = (
        bytes([1])
        + struct.pack("<I", 0)
        + struct.pack("<I", 0)
        + struct.pack("<I", 3)
        + b"1.0"
        + struct.pack("<I", 2)
        + b"id"
        + struct.pack("<I", 1)
        + struct.pack("<I", 12)
        + b"atlas/a.data"
        + b"0123456789abcdef0123456789abcdef"
        + struct.pack("<Q", 12)
        + struct.pack("<I", 7)
        + b"84-58A0"
    )
    m = parse_online_manifest(blob)
    assert m["Version"] == "1.0" and len(m["files"]) == 1
    assert m["files"][0]["Dir"] == "84-58A0"


def main(argv: list[str] | None = None) -> int:
    _self_check()
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        if not args.command:
            cmd_all(args)
        elif args.command in ("version", "list"):
            cmd_version(args)
        elif args.command == "assets":
            cmd_assets(args)
        elif args.command in ("masterdata", "data", "lua"):
            cmd_masterdata(args)
        else:
            parser.error(f"未知子命令 {args.command}")
            return 2
    except (HTTPError, URLError, RuntimeError, FileNotFoundError) as e:
        console.print(f"[red]失败[/red] {e}")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
