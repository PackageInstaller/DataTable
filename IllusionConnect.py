from __future__ import annotations

import argparse
import ast
import hashlib
import json
import os
import re
import shutil
import sqlite3
import struct
import subprocess
import threading
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

import requests
from PIL import Image
from rich.console import Console
from rich.progress import (
    BarColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TotalFileSizeColumn,
    TransferSpeedColumn,
)

from ZipUtils import ZipUtils, compose_rgb_alpha, load_image

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
ZIPS_DIR = SCRIPT_DIR / "Zips"
MASTER_DIR = SCRIPT_DIR / "MasterData"
PAINTING_DIR = SCRIPT_DIR / "Paintings"
APK_ASSETS_DEFAULT = SCRIPT_DIR / "assets"

VMS_URL = "http://mddqz-vms.52ttqy.net:20180/vmsw"
CDN = "http://mddqz_res.52ttqy.net"
CPU = "64"
BASE_VER = 16164
DEFAULT_JOBS = 8
GAME_TITLE = "梦境链接"
DB_KEY = b"dpstorm.or.2019.07.24"
_DELTA = 0x9E3779B9
USER_AGENT = "curl/7.52.1"

KEYBYTES = bytes(
    [
        0xF6, 0x99, 0xE9, 0x90, 0xE2, 0x8B, 0xEC, 0x84,
        0xF0, 0xD8, 0x9B, 0xB2, 0x9E, 0xAC, 0x9C, 0xAD,
        0x9A, 0xB6, 0xF2, 0x80, 0xE1, 0x86, 0xE9, 0x87,
        0xD7, 0xA2, 0xCC, 0xAF, 0xC7, 0x94, 0xE0, 0x8F,
        0xFD, 0x90, 0xB0, 0xE4, 0x81, 0xE2, 0x8A, 0xA4,
        0xE7, 0x88, 0xA6, 0x8A, 0xC6, 0xB2, 0xD6, 0xF8,
        0xF8,
    ]
)
SIGN_LUA = b"@D#P$S%"
SIGN_OTHER = b"@S#T$O%"
_UNSAFE = re.compile(r'[\\/:*?"<>|\n\r\t]')

console = Console()
_ZIP_UTILS = ZipUtils()


def _long2str(v, w):
    n = (len(v) - 1) << 2
    if w:
        m = v[-1]
        if m < n - 3 or m > n:
            return b""
        n = m
    s = struct.pack("<%iL" % len(v), *v)
    return s[:n] if w else s


def _str2long(s, w):
    n = len(s)
    m = (4 - (n & 3) & 3) + n
    s = s.ljust(m, b"\0")
    v = list(struct.unpack("<%iL" % (m >> 2), s))
    if w:
        v.append(n)
    return v


def xxtea_decrypt(data: bytes, key: bytes) -> bytes:
    if not data:
        return data
    v = _str2long(data, False)
    k = _str2long(key.ljust(16, b"\0"), False)
    n = len(v) - 1
    y = v[0]
    q = 6 + 52 // (n + 1)
    s = (q * _DELTA) & 0xFFFFFFFF
    while s:
        e = (s >> 2) & 3
        for p in range(n, 0, -1):
            z = v[p - 1]
            v[p] = (
                v[p]
                - (
                    ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4))
                    ^ (s ^ y)
                    + (k[(p & 3) ^ e] ^ z)
                )
            ) & 0xFFFFFFFF
            y = v[p]
        z = v[n]
        v[0] = (
            v[0]
            - (
                ((z >> 5 ^ y << 2) + (y >> 3 ^ z << 4))
                ^ (s ^ y)
                + (k[e] ^ z)
            )
        ) & 0xFFFFFFFF
        y = v[0]
        s = (s - _DELTA) & 0xFFFFFFFF
    return _long2str(v, True)


def _global_key() -> bytes:
    key = bytearray(48)
    var = (-75) & 0xFF
    for i in range(49):
        if i < 48:
            key[i] = var ^ KEYBYTES[i]
        var = KEYBYTES[i]
    return bytes(key)


GLOBAL_KEY = _global_key()


def generate_xxtea_key(c1: int, c2: int) -> bytes:
    delta = (c2 + c1) % 13
    if delta < 8:
        delta = 8
    dk = bytearray(16)
    dk[0] = GLOBAL_KEY[c1 % 48]
    dk[1] = GLOBAL_KEY[c2 % 48]
    for i in range(2, delta):
        var1 = c2 + c1
        c1 = c2
        c2 = var1
        dk[i] = GLOBAL_KEY[var1 % 48]
    return bytes(dk)


def try_xxtea_decrypt(data: bytes) -> bytes | None:
    if len(data) < 10:
        return None
    if data[:7] == SIGN_LUA:
        src = data[7:]
        key = generate_xxtea_key(src[0], src[1])
        return xxtea_decrypt(src[2:], key)
    if data[:7] == SIGN_OTHER:
        src = data[7:]
        key = generate_xxtea_key(src[0], src[1])
        dec_len = src[5] | ((src[4] | ((src[3] | (src[2] << 8)) << 8)) << 8)
        clean = src[6:]
        out = xxtea_decrypt(clean[:dec_len], key)
        return out + clean[dec_len:]
    return None


def dpstorm_decrypt(blob, key: bytes = DB_KEY) -> bytes:
    s = blob.decode("ascii", "strict") if isinstance(blob, bytes) else blob
    if s.startswith("`"):
        s = s[1:]
    raw = bytes.fromhex(s)
    n = len(key)
    out = bytearray(len(raw))
    for i, b in enumerate(raw):
        out[i] = b ^ key[(i + 1) % n] ^ key[i % n]
    return bytes(out)


def is_xxtea(data: bytes) -> bool:
    return data.startswith(SIGN_LUA) or data.startswith(SIGN_OTHER)


def write_atomic(path: Path, data: bytes | None = None, image: Image.Image | None = None):
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + ".tmp")
    try:
        if image is not None:
            image.save(tmp, format="PNG", compress_level=3)
        else:
            tmp.write_bytes(data or b"")
        os.replace(tmp, path)
    finally:
        tmp.unlink(missing_ok=True)


def _file_md5(path: Path) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def get_session() -> requests.Session:
    s = requests.Session()
    s.headers["User-Agent"] = USER_AGENT
    return s


def _progress() -> Progress:
    return Progress(
        SpinnerColumn(),
        TextColumn("{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TextColumn("•"),
        TotalFileSizeColumn(),
        TextColumn("•"),
        TransferSpeedColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )


def _count_progress() -> Progress:
    return Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )


def _download_curl(url: str, tmp: Path, size: int, progress_cb=None) -> None:
    existing = tmp.stat().st_size if tmp.exists() else 0
    if existing > size:
        tmp.unlink()
        existing = 0
    if existing == size:
        return
    cmd = [
        "curl", "-fL", "--silent", "--show-error", "--http1.1",
        "--max-redirs", "5", "--speed-limit", "1", "--speed-time", "5",
        "--connect-timeout", "30", "-A", USER_AGENT, "-o", str(tmp),
    ]
    if existing:
        cmd.extend(["-C", str(existing)])
    cmd.extend(["--", url])
    proc = subprocess.Popen(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, text=True)
    reported = existing
    try:
        while True:
            ret = proc.poll()
            now = tmp.stat().st_size if tmp.exists() else reported
            if progress_cb and now > reported:
                progress_cb(now - reported)
                reported = now
            if ret is not None:
                break
            time.sleep(0.2)
        err = proc.stderr.read() if proc.stderr else ""
        if ret != 0:
            raise RuntimeError((err or f"curl exit {ret}").strip())
        now = tmp.stat().st_size if tmp.exists() else reported
        if progress_cb and now > reported:
            progress_cb(now - reported)
    except BaseException:
        if proc.poll() is None:
            proc.kill()
            proc.wait()
        raise


def _download_requests(session: requests.Session, url: str, tmp: Path, size: int, progress_cb=None):
    existing = tmp.stat().st_size if tmp.exists() else 0
    if existing > size:
        tmp.unlink()
        existing = 0
    if existing == size:
        return
    headers = {"Range": f"bytes={existing}-"} if existing else {}
    last_data = time.time()
    with session.get(url, stream=True, timeout=(30, 30), headers=headers) as r:
        if r.status_code == 416:
            if existing >= size:
                return
            raise ValueError("416 range error")
        r.raise_for_status()
        if r.status_code == 206:
            mode = "ab"
        else:
            if existing:
                tmp.unlink()
                existing = 0
            mode = "wb"
        wrote = existing
        with open(tmp, mode) as f:
            for chunk in r.iter_content(1 << 20):
                if not chunk:
                    if time.time() - last_data >= 5:
                        raise TimeoutError("stalled 5s")
                    continue
                f.write(chunk)
                wrote += len(chunk)
                last_data = time.time()
                if progress_cb:
                    progress_cb(len(chunk))
                if wrote >= size:
                    break
    if wrote != size:
        raise ValueError(f"size mismatch {wrote} != {size}")


def download_zip(session, base_url: str, item: dict, dest: Path, progress_cb=None) -> str:
    size = int(item["size"])
    digest = (item.get("hash") or item.get("md5") or "").lower()
    if dest.exists() and dest.stat().st_size == size:
        if not digest or _file_md5(dest) == digest:
            return "skip"
        dest.unlink()
    tmp = dest.with_suffix(dest.suffix + ".part")
    url = f"{base_url.rstrip('/')}/{item['url'].lstrip('/')}"
    last_err: Exception | None = None
    for attempt in range(3):
        try:
            if shutil.which("curl"):
                _download_curl(url, tmp, size, progress_cb)
            else:
                _download_requests(session, url, tmp, size, progress_cb)
            if tmp.exists() and tmp.stat().st_size == size:
                if digest and _file_md5(tmp) != digest:
                    raise ValueError("md5 mismatch")
                os.replace(tmp, dest)
                return "ok"
            last_err = ValueError("size mismatch")
            tmp.unlink(missing_ok=True)
        except Exception as e:
            last_err = e
            if tmp.exists() and "range" in str(e).lower():
                tmp.unlink()
        if attempt < 2:
            time.sleep(min(2 ** attempt, 8))
    raise last_err or RuntimeError("download failed")


def fetch_vms(session: requests.Session, version: int = BASE_VER) -> dict:
    params = json.dumps({"pass": "0", "channel": "", "version": version, "did": "0"})
    last_err = None
    for attempt in range(3):
        try:
            r = session.post(
                VMS_URL,
                data=f"opCode=100101&params={params}",
                headers={"Content-Type": "application/x-www-form-urlencoded"},
                timeout=30,
            )
            r.raise_for_status()
            data = r.json()["data"]["data"]
            console.print(
                f"[cyan]VMS currentV={data.get('currentV')} targetV={data.get('targetV')} "
                f"cdn={data.get('cdnUrl')}[/cyan]"
            )
            return data
        except Exception as e:
            last_err = e
            time.sleep(min(2 ** attempt, 8))
    raise SystemExit(f"VMS 失败: {last_err}")


def collect_pack_items(vms: dict, cpu: str = CPU) -> list[dict]:
    pack = vms.get("pack") or {}
    items = []
    for idx in sorted(pack, key=lambda x: int(x)):
        for it in pack[idx].get(cpu) or pack[idx].get("64") or []:
            items.append(it)
    return items


def download_items(session, base_url: str, items: list[dict], dest_dir: Path, jobs: int) -> list[Path]:
    dest_dir.mkdir(parents=True, exist_ok=True)
    if not items:
        return []
    total = sum(int(i["size"]) for i in items)
    console.print(f"[cyan]待下载 {len(items)} 个 zip / {total / 1024 ** 2:.1f} MB（{jobs} 线程）[/cyan]")
    stats = {"ok": 0, "skip": 0, "fail": 0}
    failures = {}
    lock = threading.Lock()
    done = [0]
    progress = _progress()

    def worker(item):
        dest = dest_dir / Path(item["url"]).name

        def cb(n):
            with lock:
                progress.advance(task, n)

        try:
            state = download_zip(session, base_url, item, dest, progress_cb=cb)
            if state == "skip":
                with lock:
                    progress.advance(task, int(item["size"]))
            with lock:
                done[0] += 1
                progress.update(task, description=f"[cyan]下载 {done[0]}/{len(items)} 文件[/cyan]")
            return state, dest
        except Exception as e:
            with lock:
                failures[item["url"]] = str(e)
                done[0] += 1
                progress.update(task, description=f"[cyan]下载 {done[0]}/{len(items)} 文件[/cyan]")
            return "fail", dest

    with progress:
        task = progress.add_task(f"[cyan]下载 0/{len(items)} 文件", total=total)
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(worker, it) for it in items]
            for fut in as_completed(futs):
                state, _ = fut.result()
                stats[state] += 1
    if failures:
        (SCRIPT_DIR / "update_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]下载完成[/bold green] 新下载 {stats['ok']}，跳过 {stats['skip']}，失败 {stats['fail']}"
    )
    return [dest_dir / Path(it["url"]).name for it in items]


def _safe_zip_dest(dest_dir: Path, name: str) -> Path | None:
    name = name.replace("\\", "/").lstrip("/")
    if not name or name.endswith("/"):
        return None
    parts = name.split("/")
    if any(p in ("", "..") for p in parts):
        return None
    return dest_dir.joinpath(*parts)


def extract_zips(zips: list[Path], apk_assets: Path, force: bool) -> list[tuple[int, Path]]:
    updates = []
    wrote = skipped = 0
    for zp in zips:
        if not zp.exists():
            continue
        console.print(f"[cyan]解压 {zp.name}[/cyan]")
        with zipfile.ZipFile(zp) as zf:
            update_text = zf.read("update") if "update" in zf.namelist() else None
            version = None
            if update_text:
                version = int(update_text.decode().splitlines()[0].split(":", 1)[1])
            for info in zf.infolist():
                if info.is_dir() or info.filename == "update":
                    continue
                dest = _safe_zip_dest(apk_assets, info.filename)
                if dest is None:
                    continue
                if dest.exists() and not force and dest.stat().st_size == info.file_size:
                    skipped += 1
                    continue
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(zf.read(info))
                wrote += 1
            if update_text is not None and version is not None:
                up = ZIPS_DIR / f"update_{version}"
                up.write_bytes(update_text)
                updates.append((version, up))
    updates.sort()
    console.print(f"[green]解压写入 {wrote}，跳过已有 {skipped}[/green]")
    return updates


def load_updates_from_zips(zips_dir: Path) -> list[tuple[int, Path]]:
    updates = []
    for p in zips_dir.glob("update_*"):
        try:
            updates.append((int(p.name.split("_", 1)[1]), p))
        except ValueError:
            continue
    if updates:
        return sorted(updates)
    for zp in sorted(zips_dir.glob("*.zip")):
        try:
            with zipfile.ZipFile(zp) as zf:
                if "update" not in zf.namelist():
                    continue
                text = zf.read("update")
                version = int(text.decode().splitlines()[0].split(":", 1)[1])
                up = zips_dir / f"update_{version}"
                if not up.exists():
                    up.write_bytes(text)
                updates.append((version, up))
        except Exception:
            continue
    return sorted(updates)


def apply_updates(db_src: Path, db_dst: Path, updates: list[tuple[int, Path]]) -> None:
    db_dst.parent.mkdir(parents=True, exist_ok=True)
    if not db_dst.exists() or db_src.stat().st_mtime > db_dst.stat().st_mtime:
        shutil.copy2(db_src, db_dst)
    con = sqlite3.connect(db_dst)
    cur = con.cursor()
    n = 0
    for version, up in updates:
        for line in up.read_text().splitlines():
            if not line.startswith("["):
                continue
            logic, real, size, digest = ast.literal_eval(line)
            cur.execute(
                "INSERT OR REPLACE INTO assets(logic, version, real, size, hash, external) "
                "VALUES (?,?,?,?,?,0)",
                (logic, version, real, int(size), digest),
            )
            n += 1
    con.commit()
    cur.execute("SELECT min(version), max(version), count(*) FROM assets")
    console.print(f"[green]assets.db {cur.fetchone()}，upsert {n}[/green]")
    con.close()


def remap_assets(db_path: Path, apk_assets: Path, out_dir: Path, jobs: int, force: bool) -> None:
    con = sqlite3.connect(db_path)
    rows = con.execute("SELECT logic, real FROM assets").fetchall()
    con.close()
    rows = [(logic, real) for logic, real in rows if logic and real]
    console.print(f"[cyan]还原逻辑路径 {len(rows)} 条[/cyan]")
    stats = {"ok": 0, "skip": 0, "miss": 0, "xxtea": 0}
    lock = threading.Lock()

    def one(logic: str, real: str) -> str:
        src = apk_assets / real
        dst = out_dir / logic
        if not src.is_file():
            return "miss"
        if dst.exists() and not force:
            return "skip"
        raw = src.read_bytes()
        dec = try_xxtea_decrypt(raw)
        if dec is not None:
            write_atomic(dst, dec)
            return "xxtea"
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        return "ok"

    progress = _count_progress()
    with progress:
        task = progress.add_task("[cyan]还原", total=len(rows))
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(one, logic, real) for logic, real in rows]
            for fut in as_completed(futs):
                stats[fut.result()] += 1
                progress.advance(task)
    console.print(
        f"[bold green]还原完成[/bold green] 写入 {stats['ok']+stats['xxtea']} "
        f"（xxtea {stats['xxtea']}），跳过 {stats['skip']}，缺失 {stats['miss']}"
    )


def _alpha_path(path: Path) -> Path:
    return Path(str(path) + "@alpha")


def _is_texture_bytes(data: bytes) -> bool:
    return (
        data.startswith(b"CCZ!")
        or data.startswith(b"CCZp")
        or data[:4] == b"PVR\x03"
        or data.startswith(b"\xff\xd8")
        or (len(data) >= 52 and data[:4] == b"\x34\x00\x00\x00" and data[44:48] == b"PVR!")
    )


def convert_texture(path: Path, force: bool = False) -> str:
    if path.name.endswith("@alpha"):
        return "alpha"
    raw = path.read_bytes()
    dec = try_xxtea_decrypt(raw)
    if dec is not None:
        raw = dec
    sidecar = _alpha_path(path)
    already_png = raw.startswith(b"\x89PNG")
    if already_png and not sidecar.exists() and dec is None and not force:
        return "skip"
    img = None
    if _is_texture_bytes(raw) or (already_png and sidecar.exists()):
        img = load_image(raw, _ZIP_UTILS)
    if img is None:
        if dec is not None:
            write_atomic(path, dec)
            return "dec"
        return "plain"
    if sidecar.exists():
        adata = sidecar.read_bytes()
        adec = try_xxtea_decrypt(adata)
        aimg = load_image(adec if adec is not None else adata, _ZIP_UTILS)
        if aimg is not None:
            img = compose_rgb_alpha(img, aimg)
    if img.mode not in ("RGB", "RGBA", "L", "LA"):
        img = img.convert("RGBA")
    write_atomic(path, image=img)
    if sidecar.exists():
        sidecar.unlink()
    return "png"


def process_file(path: Path, convert_images: bool, force: bool = False) -> str:
    if path.name.endswith("@alpha"):
        return "alpha"
    if convert_images:
        try:
            return convert_texture(path, force)
        except Exception:
            raw = path.read_bytes()
            dec = try_xxtea_decrypt(raw)
            if dec is not None:
                write_atomic(path, dec)
                return "dec"
            raise
    raw = path.read_bytes()
    dec = try_xxtea_decrypt(raw)
    if dec is None:
        return "plain"
    write_atomic(path, dec)
    return "dec"


def collect_files(paths, lua_only=False):
    files = []
    for t in paths:
        p = Path(t)
        if p.is_dir():
            cand = [
                x for x in p.rglob("*")
                if x.is_file() and (not lua_only or x.suffix.lower() == ".lua")
            ]
        elif p.is_file() and (not lua_only or p.suffix.lower() == ".lua"):
            cand = [p]
        else:
            cand = []
        files += cand
    return sorted(set(files))


def cmd_decrypt(args):
    targets = args.paths or [str(ASSETS_DIR)]
    files = [p for p in collect_files(targets, getattr(args, "lua_only", False)) if not p.name.endswith("@alpha")]
    if not files:
        console.print("[green]没有待处理文件，跳过[/green]")
        return
    convert_images = not getattr(args, "no_images", False)
    force = getattr(args, "force", False)
    console.print(f"[cyan]待处理 {len(files)} 个文件[/cyan]")
    stats = {"png": 0, "dec": 0, "skip": 0, "plain": 0, "alpha": 0, "fail": 0}
    failures = []
    progress = _count_progress()
    with progress:
        task = progress.add_task("[cyan]解密/转图", total=len(files))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = {pool.submit(process_file, p, convert_images, force): p for p in files}
            for fut in as_completed(futs):
                try:
                    stats[fut.result()] += 1
                except Exception as e:
                    stats["fail"] += 1
                    failures.append(f"{futs[fut]}\t{e}")
                progress.advance(task)
    if failures:
        (SCRIPT_DIR / "decrypt_failed.txt").write_text("\n".join(failures), encoding="utf-8")
    console.print(
        f"[bold green]解密完成[/bold green] PNG {stats['png']}，解密 {stats['dec']}，"
        f"跳过 {stats['skip']}，原样 {stats['plain']}，失败 {stats['fail']}"
    )


def cleanup_luac(src_dir: Path) -> int:
    n = 0
    for p in src_dir.rglob("*.luac"):
        if p.with_suffix(".lua").is_file():
            p.unlink()
            n += 1
    return n


def decompile_luac(src_dir: Path, jobs: int, force: bool = False) -> None:
    luacs = [p for p in src_dir.rglob("*.luac") if p.is_file()]
    if not luacs:
        console.print("[yellow]没有 .luac[/yellow]")
        return
    dest_lua = [p.with_suffix(".lua") for p in luacs]
    if not force:
        pending = [p for p, d in zip(luacs, dest_lua) if not d.exists()]
    else:
        pending = luacs
    if pending:
        console.print(f"[cyan]反编译 {len(pending)} 个 luac[/cyan]")
        tmp = SCRIPT_DIR / ".luajit_out"
        if tmp.exists():
            shutil.rmtree(tmp)
        tmp.mkdir()
        r = subprocess.run(
            ["luajit-decompiler", str(src_dir), "-e", "luac", "-o", str(tmp), "-f", "-s", "-j", str(jobs)],
            capture_output=True,
            text=True,
        )
        if r.returncode != 0 and r.stderr:
            console.print(f"[yellow]luajit-decompiler: {r.stderr[-500:]}[/yellow]")
        n = 0
        for p in tmp.rglob("*.luac.lua"):
            rel = p.relative_to(tmp)
            dest = src_dir / (str(rel).removesuffix(".luac.lua") + ".lua")
            dest.parent.mkdir(parents=True, exist_ok=True)
            if dest.exists() and not force:
                continue
            shutil.copy2(p, dest)
            n += 1
        shutil.rmtree(tmp, ignore_errors=True)
        console.print(f"[green]反编译写入 {n}[/green]")
    else:
        console.print("[green]Lua 已反编译，跳过[/green]")
    removed = cleanup_luac(src_dir)
    if removed:
        console.print(f"[green]清理 luac {removed}[/green]")


def collect_masterdata(out_assets: Path, force: bool = False) -> None:
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    n = 0
    for p in out_assets.rglob("*"):
        if not p.is_file():
            continue
        rel = p.relative_to(out_assets)
        suf = p.suffix.lower()
        if suf in (".json", ".lua"):
            dest = MASTER_DIR / rel
        else:
            continue
        if dest.exists() and not force:
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(p, dest)
        n += 1
    console.print(f"[green]MasterData lua/json {n}[/green]")


def convert_type(val: str, typ: str):
    if typ == "string":
        return val
    if typ in ("int", "long", "double"):
        if val == "":
            return None
        try:
            return float(val) if typ == "double" or "." in val else int(val)
        except ValueError:
            return val
    if typ in ("array", "dict", "auto"):
        if val == "":
            return None
        try:
            return json.loads(val)
        except json.JSONDecodeError:
            return val
    if typ == "bool":
        return val == "True"
    return val


def merge_and_export_gameconfig(
    apk_assets: Path, db_path: Path, updates: list[tuple[int, Path]], force: bool
) -> None:
    gcfg_dir = MASTER_DIR / "gameConfig"
    dest_db = MASTER_DIR / "gameConfig.db"
    if dest_db.exists() and (gcfg_dir / "HeroBase.json").exists() and not force:
        console.print("[green]gameConfig 已导出，跳过[/green]")
        return
    con0 = sqlite3.connect(db_path)
    row = con0.execute("SELECT real FROM assets WHERE logic=?", ("gameConfig.db.zip",)).fetchone()
    con0.close()
    zip_real = apk_assets / row[0] if row else None
    if zip_real is None or not zip_real.is_file():
        raise SystemExit("找不到 gameConfig.db.zip")
    gcfg_dir.mkdir(parents=True, exist_ok=True)
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(zip_real) as zf:
        zf.extract("gameConfig.db", MASTER_DIR)
    con = sqlite3.connect(dest_db)
    for version, up in updates:
        patch_real = None
        for line in up.read_text().splitlines():
            if line.startswith("[") and '"gameUpdateConfig.db"' in line:
                rec = ast.literal_eval(line)
                patch_real = apk_assets / rec[1]
                break
        if patch_real is None or not patch_real.exists():
            continue
        console.print(f"[cyan]合并 gameUpdateConfig {version}[/cyan]")
        con.execute("ATTACH ? AS new", (str(patch_real),))
        try:
            sql = con.execute("SELECT sql FROM new.sql LIMIT 1").fetchone()
            if sql:
                con.executescript(sql[0])
                con.commit()
        except Exception as e:
            console.print(f"[yellow]merge fail {version}: {e}[/yellow]")
            con.rollback()
        con.execute("DETACH new")
    tables = [
        r[0]
        for r in con.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall()
        if r[0] != "sqlite_sequence"
    ]
    console.print(f"[cyan]导出 {len(tables)} 张表[/cyan]")
    progress = _count_progress()
    with progress:
        task = progress.add_task("[cyan]导出 JSON", total=len(tables))
        for t in tables:
            cols = [c[1] for c in con.execute(f'PRAGMA table_info("{t}")').fetchall()]
            out = gcfg_dir / f"{t}.json"
            if "DpstormData" not in cols:
                rows = [dict(zip(cols, r)) for r in con.execute(f'SELECT * FROM "{t}"')]
                out.write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding="utf-8")
                progress.advance(task)
                continue
            raw_rows = con.execute(f'SELECT Id, DpstormData FROM "{t}"').fetchall()
            names = types = None
            records = {}
            for rid, blob in raw_rows:
                try:
                    dec = dpstorm_decrypt(blob).decode("utf-8")
                except Exception:
                    continue
                if rid == "Id":
                    names = dec.split("#@#")
                    continue
                if rid == "DataType":
                    types = dec.split("#@#")
                    continue
                vals = dec.split("#@#")
                rec = {"Id": rid}
                if names:
                    for i, name in enumerate(names):
                        typ = types[i] if types and i < len(types) else "string"
                        rec[name] = convert_type(vals[i] if i < len(vals) else "", typ)
                else:
                    rec["DpstormData"] = dec
                records[rid] = rec
            out.write_text(json.dumps(records, ensure_ascii=False, indent=2), encoding="utf-8")
            progress.advance(task)
    con.close()
    console.print(f"[green]gameConfig → {gcfg_dir}[/green]")


def decrypt_pkg_config(apk_assets: Path) -> dict:
    raw = (apk_assets / "cocos_app.conf").read_bytes()
    dec = try_xxtea_decrypt(raw)
    if not dec:
        raise SystemExit("cocos_app.conf 解密失败")
    obj = json.loads(dec)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    (ASSETS_DIR / "cocos_app.conf.json").write_text(
        json.dumps(obj, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    return obj


def run_pipeline(args, do_download: bool):
    apk_assets = Path(args.apk_assets)
    jobs = args.jobs
    force = getattr(args, "force", False)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    ZIPS_DIR.mkdir(parents=True, exist_ok=True)
    session = get_session()
    updates: list[tuple[int, Path]] = []
    if do_download:
        vms = fetch_vms(session, getattr(args, "version", None) or BASE_VER)
        items = collect_pack_items(vms, getattr(args, "cpu", CPU))
        cdn = (vms.get("cdnUrl") or CDN).rstrip("/")
        zips = download_items(session, cdn, items, ZIPS_DIR, jobs)
        updates = extract_zips(zips, apk_assets, force)
    if not updates:
        updates = load_updates_from_zips(ZIPS_DIR)
    db_src = apk_assets / CPU / "assets.db"
    if not db_src.exists():
        db_src = apk_assets / "64" / "assets.db"
    if not db_src.exists():
        raise SystemExit(f"找不到 assets.db: {apk_assets}")
    work_db = ASSETS_DIR / "_assets.db"
    apply_updates(db_src, work_db, updates)
    remap_assets(work_db, apk_assets, ASSETS_DIR, jobs, force)
    if not getattr(args, "no_decrypt", False):
        cmd_decrypt(
            argparse.Namespace(
                paths=[str(ASSETS_DIR)],
                lua_only=False,
                no_images=getattr(args, "no_images", False),
                jobs=jobs,
                force=force,
            )
        )
    if not getattr(args, "no_decompile", False):
        decompile_luac(ASSETS_DIR, jobs, force)
    if not getattr(args, "no_master", False):
        collect_masterdata(ASSETS_DIR, force)
        merge_and_export_gameconfig(apk_assets, work_db, updates, force)
    try:
        decrypt_pkg_config(apk_assets)
    except Exception as e:
        console.print(f"[yellow]跳过 cocos_app.conf: {e}[/yellow]")


def cmd_update(args):
    run_pipeline(args, do_download=True)


def cmd_apk(args):
    run_pipeline(args, do_download=False)


def _cn(tr: dict, key: str | None) -> str:
    if not key:
        return ""
    rec = tr.get(key) or {}
    data = rec.get("DpstormData") or ""
    return data.split("#@#")[0].strip() if data else ""


def _safe_name(s: str) -> str:
    s = _UNSAFE.sub("", (s or "").strip())
    return s.replace(" ", "")


def _load_json(name: str) -> dict:
    p = MASTER_DIR / "gameConfig" / name
    if not p.exists():
        raise SystemExit(f"缺少 {p}，先跑 update 或 apk")
    return json.loads(p.read_text(encoding="utf-8"))


def _load_painting_tables():
    hero = _load_json("HeroBase.json")
    surface = _load_json("Surface.json")
    role = _load_json("RoleModel.json")
    tr = _load_json("Translate.json")
    by_file: dict[str, dict] = {}
    by_model: dict[str, list[dict]] = {}
    for rec in role.values():
        for key in (rec.get("Filename"), rec.get("Portrait")):
            if key:
                by_file[str(key).strip().lower()] = rec
        model = (rec.get("Model") or "").strip()
        if model:
            by_model.setdefault(model.lower(), []).append(rec)
    surf_by_model = {}
    surf_by_hero: dict[str, list[dict]] = {}
    for s in surface.values():
        if s.get("Model"):
            surf_by_model[s["Model"]] = s
        surf_by_model[s["Id"]] = s
        hid = s.get("Hero")
        if hid:
            surf_by_hero.setdefault(hid, []).append(s)
    hero_lower = {k.lower(): k for k in hero}
    return hero, surface, tr, by_file, by_model, surf_by_model, surf_by_hero, hero_lower


def _match_role(stem: str, by_file: dict) -> tuple[dict | None, list[str]]:
    key = stem.lower()
    if key in by_file:
        return by_file[key], []
    best = None
    for fn, rec in by_file.items():
        if key.startswith(fn + "_") and (best is None or len(fn) > len(best[0])):
            rem = key[len(fn) + 1 :]
            best = (fn, rec, [x for x in rem.split("_") if x])
    if best:
        return best[1], best[2]
    return None, []


def _type1_skin(hero_id: str, hero: dict, surface: dict, tr: dict) -> str:
    sl = (hero.get(hero_id) or {}).get("SurfaceList") or []
    for sid in sl:
        s = surface.get(sid)
        if s and s.get("Type") == 1:
            return _cn(tr, s.get("Name"))
    if sl and sl[0] in surface:
        return _cn(tr, surface[sl[0]].get("Name"))
    return ""


def _base_model_id(rid: str) -> str:
    if rid.startswith("Model_Story_"):
        return "Model_" + rid[len("Model_Story_") :]
    return rid


def _awake_surface(hero_id: str, surf_by_hero: dict) -> dict | None:
    for s in surf_by_hero.get(hero_id, []):
        sid = s.get("Id") or ""
        if s.get("Type") == 5 or sid.endswith("_Awake"):
            return s
    return None


def _surface_for_role(rec: dict, hero_id: str, surf_by_model: dict, surf_by_hero: dict) -> dict | None:
    rid = rec.get("Id") or ""
    is_unawake = "UnAwake" in rid
    is_awake = ("Awake" in rid) and not is_unawake
    if (is_unawake or is_awake) and hero_id:
        hit = _awake_surface(hero_id, surf_by_hero)
        if hit:
            return hit
    for key in (rid, _base_model_id(rid)):
        if key in surf_by_model:
            return surf_by_model[key]
    model = rec.get("Model") or ""
    if model and not is_unawake:
        cand = model if model.startswith("Model_") else "Model_" + model
        if cand in surf_by_model:
            return surf_by_model[cand]
    if hero_id:
        for s in surf_by_hero.get(hero_id, []):
            if s.get("Model") in {rid, _base_model_id(rid), model, "Model_" + model}:
                return s
    return None


def _hero_id_of(rec: dict, folder: str, hero: dict, hero_lower: dict) -> str:
    hid = rec.get("Hero") or ""
    if hid in hero:
        return hid
    name_key = rec.get("Name") or ""
    if name_key.startswith("HeroBase_Name_"):
        cand = name_key[len("HeroBase_Name_") :]
        if cand in hero:
            return cand
    if folder in hero:
        return folder
    return hero_lower.get(folder.lower(), hid or folder)


def resolve_painting(
    path: Path,
    tables,
) -> tuple[str, str, list[str], bool]:
    hero, surface, tr, by_file, by_model, surf_by_model, surf_by_hero, hero_lower = tables
    folder = path.parent.name
    stem = path.stem
    rec, remarks = _match_role(stem, by_file)
    mapped = rec is not None
    if rec is None:
        recs = by_model.get(folder.lower()) or []
        rec = next((r for r in recs if (r.get("Type") or "") == "Hero"), recs[0] if recs else None)
    hero_id = _hero_id_of(rec, folder, hero, hero_lower) if rec else (
        folder if folder in hero else hero_lower.get(folder.lower(), folder)
    )
    char = (
        _cn(tr, (hero.get(hero_id) or {}).get("Name"))
        or _cn(tr, (rec or {}).get("Name"))
        or _cn(tr, f"HeroBase_Name_{hero_id}")
        or hero_id
    )
    skin = ""
    model_skip: set[str] = set()
    if rec:
        surf = _surface_for_role(rec, hero_id, surf_by_model, surf_by_hero)
        if surf:
            skin = _cn(tr, surf.get("Name"))
            sm = (surf.get("Model") or "").replace("Model_", "")
            if sm:
                model_skip.add(sm.lower())
                if hid := str(hero_id or ""):
                    if sm.lower().startswith(hid.lower() + "_"):
                        model_skip.add(sm[len(hid) + 1 :].lower())
        rid = rec.get("Id") or ""
        if "UnAwake" in rid and "未觉醒" not in remarks:
            remarks.append("未觉醒")
        if "Story" in rid and "story" not in {r.lower() for r in remarks}:
            remarks.append("story")
        fn = (rec.get("Filename") or rec.get("Portrait") or "").lower()
        if fn.endswith("_story") and "story" not in {r.lower() for r in remarks}:
            remarks.append("story")
        tail = _base_model_id(rid).replace("Model_", "")
        extra = ""
        if hero_id and tail.lower().startswith(str(hero_id).lower()):
            extra = tail[len(hero_id) :].lstrip("_")
        skip_extra = {"awake", "unawake", "story"}
        if extra:
            extra_l = extra.lower()
            surf_model = ((surf.get("Model") if surf else "") or "").replace("Model_", "").lower()
            if extra_l not in skip_extra and extra_l != (skin or "").lower() and extra_l != surf_model:
                if not (surf_model and surf_model.endswith(extra_l)):
                    if not skin:
                        skin = extra
                    elif extra_l not in {r.lower() for r in remarks}:
                        remarks.append(extra)
    if not mapped:
        rest = stem
        for pref in ("portraitpic_", "portrait_"):
            if rest.lower().startswith(pref):
                rest = rest[len(pref) :]
                break
        if hero_id and rest.lower().startswith(str(hero_id).lower()):
            rest = rest[len(hero_id) :].lstrip("_")
        extra = [x for x in rest.split("_") if x]
        remarks = extra + remarks
        mapped = folder in hero or folder.lower() in hero_lower or rec is not None
    if not skin:
        skin = _type1_skin(hero_id, hero, surface, tr) or "原皮"
    rest = stem
    for pref in ("portraitpic_", "portrait_"):
        if rest.lower().startswith(pref):
            rest = rest[len(pref) :]
            break
    hid = str(hero_id or "")
    if hid and rest.lower().startswith(hid.lower()):
        tail = rest[len(hid) :]
        if tail.startswith("_") or (tail[:1].isdigit()):
            for tok in tail.lstrip("_").split("_"):
                if tok and tok.lower() not in {r.lower() for r in remarks}:
                    remarks.append(tok)
    if hero_id not in hero and not remarks and folder and folder.lower() not in {char.lower(), skin.lower()}:
        remarks.append(folder)
    skip = {skin.lower(), char.lower(), "awake", "unawake"} | model_skip
    remarks = [x for x in remarks if x and x.lower() not in skip]
    return char, skin, remarks, mapped


def painting_dest_name(char: str, skin: str, remarks: list[str]) -> str:
    parts = [GAME_TITLE, _safe_name(char) or "未知", _safe_name(skin) or "原皮"]
    parts += [_safe_name(r) for r in remarks if _safe_name(r)]
    return "_".join(parts) + ".png"


def export_one_painting(src: Path, dest: Path, force: bool) -> str:
    if dest.exists() and not force:
        return "skip"
    raw = src.read_bytes()
    img = load_image(raw, _ZIP_UTILS)
    if img is None:
        img = Image.open(src)
        img.load()
    sidecar = _alpha_path(src)
    if sidecar.exists():
        aimg = load_image(sidecar.read_bytes(), _ZIP_UTILS)
        if aimg is not None:
            img = compose_rgb_alpha(img, aimg)
    elif img.mode != "RGBA":
        img = img.convert("RGBA")
    write_atomic(dest, image=img)
    return "ok"


def cmd_painting(args):
    src_dir = Path(args.src)
    out_dir = Path(args.out)
    if not src_dir.is_dir():
        raise SystemExit(f"没有立绘目录 {src_dir}")
    tables = _load_painting_tables()
    files = sorted(
        p
        for p in src_dir.rglob("*")
        if p.is_file()
        and "portrait" in p.name.lower()
        and not p.name.endswith("@alpha")
        and p.suffix.lower() in {".png", ".jpg", ".jpeg", ".ccz", ".pvr"}
    )
    console.print(f"[cyan]立绘 {len(files)} 张[/cyan]")
    out_dir.mkdir(parents=True, exist_ok=True)
    stats = {"ok": 0, "skip": 0, "fail": 0, "unknown": 0}
    used: dict[str, int] = {}
    missing = []
    jobs = []
    for src in files:
        char, skin, remarks, mapped = resolve_painting(src, tables)
        name = painting_dest_name(char, skin, remarks)
        if name in used:
            name = painting_dest_name(char, skin, remarks + [src.parent.name])
        if name in used:
            name = painting_dest_name(char, skin, remarks + [src.parent.name, src.stem])
        used[name] = used.get(name, 0) + 1
        dest = out_dir / name
        if not mapped:
            stats["unknown"] += 1
            missing.append(f"{src.relative_to(src_dir)}\t{name}")
        jobs.append((src, dest))
    progress = _count_progress()
    with progress:
        task = progress.add_task("[cyan]导出立绘", total=len(jobs))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = {
                pool.submit(export_one_painting, src, dest, args.force): (src, dest)
                for src, dest in jobs
            }
            for fut in as_completed(futs):
                src, dest = futs[fut]
                try:
                    stats[fut.result()] += 1
                except Exception as e:
                    stats["fail"] += 1
                    missing.append(f"{src}\tFAIL\t{e}")
                progress.advance(task)
    if missing:
        (SCRIPT_DIR / "painting_unmapped.txt").write_text("\n".join(missing), encoding="utf-8")
    console.print(
        f"[bold green]立绘导出完成[/bold green] 写入 {stats['ok']}，跳过 {stats['skip']}，"
        f"未映射 {stats['unknown']}，失败 {stats['fail']} -> {out_dir}"
    )


def main():
    parser = argparse.ArgumentParser(description="梦境连接 Illusion Connect 资源下载/解密")
    sub = parser.add_subparsers(dest="command", required=True)

    p_update = sub.add_parser("update", help="下载热更，叠到 APK assets/ 后还原并解密")
    p_update.add_argument("--apk-assets", default=str(APK_ASSETS_DEFAULT), help="APK 解压后的 assets/ 目录")
    p_update.add_argument("--version", type=int, default=BASE_VER, help="VMS 本地版本，默认安装包 16164")
    p_update.add_argument("--cpu", default=CPU)
    p_update.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_update.add_argument("--no-decrypt", action="store_true")
    p_update.add_argument("--no-images", action="store_true", help="不把 CCZ/JPEG+@alpha 转 PNG")
    p_update.add_argument("--no-decompile", action="store_true")
    p_update.add_argument("--no-master", action="store_true")
    p_update.add_argument("--force", action="store_true")

    p_dec = sub.add_parser("decrypt", help="对目录内 XXTEA 文件原地解密，并可转 PNG")
    p_dec.add_argument("paths", nargs="*", help="目录或文件，默认 Assets/")
    p_dec.add_argument("--lua-only", action="store_true")
    p_dec.add_argument("--no-images", action="store_true", help="不把 CCZ/JPEG+@alpha 转 PNG")
    p_dec.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_dec.add_argument("--force", action="store_true")

    p_apk = sub.add_parser("apk", help="处理 APK 解压后的 assets/：按 assets.db 还原逻辑路径并解密")
    p_apk.add_argument("--apk-assets", default=str(APK_ASSETS_DEFAULT), help="APK 解压后的 assets/ 目录")
    p_apk.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_apk.add_argument("--no-decrypt", action="store_true")
    p_apk.add_argument("--no-images", action="store_true")
    p_apk.add_argument("--no-decompile", action="store_true")
    p_apk.add_argument("--no-master", action="store_true")
    p_apk.add_argument("--force", action="store_true")

    p_pt = sub.add_parser("painting", help="按角色名/皮肤名导出 heros 立绘")
    p_pt.add_argument("--src", default=str(ASSETS_DIR / "asset" / "heros"))
    p_pt.add_argument("--out", default=str(PAINTING_DIR), help="导出目录，默认 Paintings/")
    p_pt.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_pt.add_argument("--force", action="store_true")

    args = parser.parse_args()
    if args.command == "update":
        cmd_update(args)
    elif args.command == "decrypt":
        cmd_decrypt(args)
    elif args.command == "apk":
        cmd_apk(args)
    elif args.command == "painting":
        cmd_painting(args)


if __name__ == "__main__":
    main()
