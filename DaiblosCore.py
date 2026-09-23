from __future__ import annotations

import argparse
import hashlib
import http.client
import json
import os
import shutil
import struct
import subprocess
import sys
import tempfile
import threading
import time
import urllib.error
import urllib.request
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

UNITY_FS = b"UnityFS"
CHANNEL_SUFFIXES = "_TW"
ART_PREFIXES = ("textures_", "prefabs_", "shader")
SKIP_PREFIXES = ("sounds/", "videos/")
UA = "UnityPlayer/2022.3.62f2c1 (UnityWebRequest/1.0)"

class _R:
    def __init__(self, data: bytes):
        self.d = data
        self.p = 0

    def u8(self) -> int:
        b = self.d[self.p]
        self.p += 1
        return b

    def i32(self) -> int:
        v = int.from_bytes(self.d[self.p:self.p + 4], "little", signed=True)
        self.p += 4
        return v

    def i64(self) -> int:
        v = int.from_bytes(self.d[self.p:self.p + 8], "little", signed=True)
        self.p += 8
        return v

    def str7(self) -> str:
        n = sh = 0
        while True:
            b = self.u8()
            n |= (b & 0x7F) << sh
            if b < 128:
                break
            sh += 7
        raw = self.d[self.p:self.p + n]
        self.p += n
        return raw.decode()


class _Ref:
    def __init__(self, i: int):
        self.i = i


def _prim(r: _R, t: int):
    if t == 1:
        return r.u8() != 0
    if t in (2, 10):
        v = r.u8()
        return v if t == 2 else int.from_bytes(bytes([v]), "little", signed=True)
    if t in (3, 14):
        v = int.from_bytes(r.d[r.p:r.p + 2], "little", signed=(t == 7))
        r.p += 2
        return v
    if t == 7:
        v = int.from_bytes(r.d[r.p:r.p + 2], "little", signed=True)
        r.p += 2
        return v
    if t == 5:
        b = r.d[r.p:r.p + 16]
        r.p += 16
        return b.hex()
    if t == 6:
        v = struct.unpack_from("<d", r.d, r.p)[0]
        r.p += 8
        return v
    if t == 8:
        return r.i32()
    if t == 9 or t in (12, 13):
        return r.i64()
    if t == 11:
        v = struct.unpack_from("<f", r.d, r.p)[0]
        r.p += 4
        return v
    if t == 15:
        v = int.from_bytes(r.d[r.p:r.p + 4], "little")
        r.p += 4
        return v
    if t == 16:
        v = int.from_bytes(r.d[r.p:r.p + 8], "little")
        r.p += 8
        return v
    raise RuntimeError(f"NRBF 未知标量 {t} @{r.p}")


def _type_info(r: _R, bte: int):
    if bte == 0:
        return ("prim", r.u8())
    if bte == 1:
        return ("str", None)
    if bte == 2:
        return ("obj", None)
    if bte == 3:
        return ("sys", r.str7())
    if bte == 4:
        return ("cls", (r.str7(), r.i32()))
    if bte == 5:
        return ("objarr", None)
    if bte == 6:
        return ("strarr", None)
    if bte == 7:
        return ("primarr", r.u8())
    raise RuntimeError(f"NRBF 未知类型 {bte} @{r.p}")


class _Nrbf:
    def __init__(self, data: bytes):
        self.r = _R(data)
        self.objs: dict = {}
        self.classes: dict = {}

    def parse(self) -> dict:
        roots = []
        r = self.r
        while r.p < len(r.d):
            tag, val = self._rec()
            if tag == "end":
                break
            if tag == "obj":
                roots.append(val[1])
        if r.p != len(r.d):
            raise RuntimeError(f"NRBF 没读完，停在 {r.p}/{len(r.d)}")
        for obj in roots:
            got = self._resolve(obj)
            if isinstance(got, dict) and ("abDataList" in got or "bytes" in got):
                return got
        raise RuntimeError("NRBF 里没有 VerInfo / ABCustom")

    def _resolve(self, v, seen=None):
        if seen is None:
            seen = {}
        i = id(v)
        if i in seen:
            return seen[i]
        if isinstance(v, _Ref):
            return self._resolve(self.objs.get(v.i), seen)
        if isinstance(v, list):
            out = []
            seen[i] = out
            out.extend(self._resolve(x, seen) for x in v)
            return out
        if isinstance(v, dict):
            out = {}
            seen[i] = out
            for k, val in v.items():
                out[k] = self._resolve(val, seen)
            return out
        return v

    def _array(self, n: int, kind, info):
        r = self.r
        arr = []
        while len(arr) < n:
            if kind == "prim":
                arr.append(_prim(r, info))
                continue
            rt = r.d[r.p]
            if rt == 10:
                r.u8()
                arr.append(None)
            elif rt == 13:
                r.u8()
                arr.extend([None] * r.u8())
            elif rt == 14:
                r.u8()
                arr.extend([None] * r.i32())
            else:
                arr.append(self._value(kind, info))
        if len(arr) != n:
            raise RuntimeError(f"NRBF 数组长度 {len(arr)} != {n} @{r.p}")
        return arr

    def _value(self, kind, info):
        if kind == "prim":
            return _prim(self.r, info)
        tag, val = self._rec()
        if tag == "obj":
            return val[1]
        if tag in ("str", "ref", "null", "pt", "arr"):
            return val
        raise RuntimeError(f"NRBF 成员不是值 {tag} @{self.r.p}")

    def _rec(self):
        r = self.r
        rt = r.u8()
        if rt == 0:
            for _ in range(4):
                r.i32()
            return ("hdr", None)
        if rt == 12:
            r.i32()
            return ("lib", r.str7())
        if rt == 6:
            oid = r.i32()
            s = r.str7()
            self.objs[oid] = s
            return ("str", s)
        if rt == 9:
            return ("ref", _Ref(r.i32()))
        if rt == 10:
            return ("null", None)
        if rt == 11:
            return ("end", None)
        if rt in (4, 5):
            oid = r.i32()
            name = r.str7()
            mc = r.i32()
            members = [r.str7() for _ in range(mc)]
            btes = [r.u8() for _ in range(mc)]
            types = [_type_info(r, b) for b in btes]
            if rt == 5:
                r.i32()
            self.classes[oid] = (name, members, types)
            vals = [self._value(k, info) for k, info in types]
            obj = dict(zip(members, vals))
            self.objs[oid] = obj
            return ("obj", (name, obj))
        if rt == 1:
            oid = r.i32()
            name, members, types = self.classes[r.i32()]
            vals = [self._value(k, info) for k, info in types]
            obj = dict(zip(members, vals))
            self.objs[oid] = obj
            return ("obj", (name, obj))
        if rt == 16:
            oid = r.i32()
            n = r.i32()
            arr = self._array(n, "obj", None)
            self.objs[oid] = arr
            return ("arr", arr)
        if rt == 17:
            oid = r.i32()
            n = r.i32()
            arr = self._array(n, "str", None)
            self.objs[oid] = arr
            return ("arr", arr)
        if rt == 15:
            oid = r.i32()
            n = r.i32()
            pt = r.u8()
            if pt == 2:
                raw = r.d[r.p:r.p + n]
                r.p += n
                self.objs[oid] = raw
                return ("arr", raw)
            arr = [_prim(r, pt) for _ in range(n)]
            self.objs[oid] = arr
            return ("arr", arr)
        if rt == 7:
            oid = r.i32()
            bat = r.u8()
            rank = r.i32()
            lengths = [r.i32() for _ in range(rank)]
            if bat in (3, 4, 5):
                for _ in range(rank):
                    r.i32()
            kind, info = _type_info(r, r.u8())
            n = 1
            for ln in lengths:
                n *= ln
            arr = self._array(n, kind, info)
            self.objs[oid] = arr
            return ("arr", arr)
        if rt == 8:
            return ("pt", _prim(r, r.u8()))
        raise RuntimeError(f"NRBF 未知记录 {rt} @{r.p - 1}")


def parse_nrbf(data: bytes) -> dict:
    return _Nrbf(data).parse()


def manifest_rows(root: dict) -> list[dict]:
    blob = root["abDataList"]
    items = blob["_items"]
    size = int(blob["_size"])
    rows = []
    for raw in items[:size]:
        if not isinstance(raw, dict) or not raw.get("name"):
            continue
        pri = raw.get("downloadPriority")
        if isinstance(pri, dict):
            pri = pri.get("value__")
        crc = raw.get("crc")
        rows.append({
            "name": raw["name"].replace("\\", "/"),
            "version": raw.get("version"),
            "crc": None if crc is None else (crc & 0xFFFFFFFF),
            "size": raw.get("size"),
            "sizeB": int(raw.get("sizeB") or 0),
            "url": raw.get("url") or "",
            "md5": raw.get("md5") or "",
            "isEncypt": bool(raw.get("isEncypt")),
            "isFHX": bool(raw.get("isFHX")),
            "path": raw.get("path") or "",
            "FileMD5": (raw.get("FileMD5") or "").upper(),
            "FileSize": int(raw.get("FileSize") or 0),
            "downloadPriority": pri,
        })
    return rows



def ab_offset(name: str) -> int:
    """ABMgr.GetABOffset"""
    name = name.replace("_fhx", "")
    if not name:
        return 23
    total = 23
    for k in range(3):
        i = len(name) - 1 - k
        if i < 0:
            break
        c = ord(name[i])
        total += c | (c << 16)
    low = abs(total) & 0xFF
    return low or 1


def xor_sparse(data: bytes) -> bytes:
    """ABCustom.DdooEennccyypptt"""
    buf = bytearray(data)
    n = len(buf)
    step = n // 100
    if step <= 1:
        step = 1
    key = (n % 0xFE) + 1
    i = 0
    while i < n:
        old = buf[i]
        buf[i] = old ^ key
        key = (buf[i] + old) & 0xFF
        i += step
    return bytes(buf)


def restore_bytes(name: str, data: bytes, enc: bool) -> bytes:
    if enc:
        root = parse_nrbf(data)
        raw = root["bytes"]
        if not isinstance(raw, (bytes, bytearray)):
            raw = bytes(raw)
        return xor_sparse(raw)
    off = ab_offset(name)
    if off < len(data) and data[off:off + len(UNITY_FS)] == UNITY_FS:
        return data[off:]
    return data


def iter_bs(data: bytes):
    """ResPackMgr"""
    p = 0
    n = len(data)
    while p < n:
        if p + 4 > n:
            raise RuntimeError("bs 名长被截断")
        name_len = int.from_bytes(data[p:p + 4], "little", signed=True)
        p += 4
        if name_len < 0 or p + name_len + 4 > n:
            raise RuntimeError(f"bs 文件名非法 @{p}")
        name = data[p:p + name_len].decode().replace("\\", "/")
        p += name_len
        data_len = int.from_bytes(data[p:p + 4], "little", signed=True)
        p += 4
        if data_len < 0 or p + data_len > n:
            raise RuntimeError(f"bs 数据被截断 {name}")
        yield name, data[p:p + data_len]
        p += data_len


def safe_rel(name: str) -> Path:
    name = name.replace("\\", "/").lstrip("/")
    parts = Path(name).parts
    if not parts or any(part in ("", ".", "..") for part in parts):
        raise RuntimeError(f"拒绝写出的路径 {name!r}")
    return Path(*parts)


def game_root(args) -> Path:
    if getattr(args, "apk", None):
        p = Path(args.apk).expanduser().resolve()
        return p.parent if p.is_file() else p
    return Path(__file__).resolve().parent


def list_apks(root: Path) -> list[Path]:
    if root.is_file():
        root = root.parent
    return sorted(p for p in root.glob("*.apk") if p.is_file() and not p.name.endswith(".apks"))


def find_member(apks: list[Path], suffix: str):
    suffix = suffix.replace("\\", "/")
    for apk in apks:
        with zipfile.ZipFile(apk) as zf:
            for info in zf.infolist():
                if info.filename.replace("\\", "/").endswith(suffix):
                    return apk, info.filename
    return None


def read_member(apks: list[Path], suffix: str) -> bytes:
    found = find_member(apks, suffix)
    if not found:
        raise RuntimeError(f"APK 里没有 {suffix}")
    apk, name = found
    with zipfile.ZipFile(apk) as zf:
        return zf.read(name)


def parse_mjenv(text: str) -> dict[str, str]:
    out = {}
    for line in text.splitlines():
        if ":" not in line:
            continue
        k, v = line.split(":", 1)
        out[k.strip()] = v.strip()
    return out


def http_bytes(url: str, timeout: int, dest: Path | None = None) -> str:
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    md5 = hashlib.md5()
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        expect = resp.headers.get("Content-Length")
        expect = int(expect) if expect else None
        if dest is None:
            data = resp.read()
            if expect is not None and len(data) != expect:
                raise urllib.error.URLError(f"body {len(data)} != {expect}")
            return data  # type: ignore[return-value]
        dest.parent.mkdir(parents=True, exist_ok=True)
        got = 0
        with dest.open("wb") as f:
            while True:
                chunk = resp.read(1 << 20)
                if not chunk:
                    break
                f.write(chunk)
                md5.update(chunk)
                got += len(chunk)
    if expect is not None and got != expect:
        dest.unlink(missing_ok=True)
        raise urllib.error.URLError(f"body {got} != {expect}")
    return md5.hexdigest().upper()


def http_get(url: str, timeout: int, retries: int, dest: Path | None = None):
    err = None
    for attempt in range(retries):
        try:
            return http_bytes(url, timeout, dest)
        except (urllib.error.URLError, TimeoutError, OSError, http.client.HTTPException) as exc:
            err = exc
            if dest is not None and dest.exists():
                dest.unlink()
            if attempt + 1 == retries:
                break
            time.sleep(min(8, 2 ** attempt))
    raise RuntimeError(f"下载失败 {url}：{err}")


def file_url(hot: str, channel: str, item: dict) -> str:
    from urllib.parse import quote
    name = quote(item["name"], safe="/")
    base = f"{hot.rstrip('/')}/android/{channel}"
    if item["md5"]:
        return f"{base}/{name}"
    return f"{base}/Custom/{name}"


def load_state(path: Path) -> dict:
    if path.is_file():
        return json.loads(path.read_text(encoding="utf-8"))
    return {"files": {}}


def save_state(path: Path, state: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(state, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    os.replace(tmp, path)


def pick_channel(hot: str, env_path: str, local: bytes, timeout: int, retries: int):
    best = None
    best_diff = None
    best_data = None
    channel = f"{env_path}{CHANNEL_SUFFIXES}"
    url = f"{hot.rstrip('/')}/android/{channel}/ver.bytes"
    try:
        data = http_get(url, timeout, retries)
    except RuntimeError as exc:
        print(f"  跳过 {channel}：{exc}")
    diff = abs(len(data) - len(local))
    if best_diff is None or diff < best_diff:
        best, best_diff, best_data = channel, diff, data
    return best, best_data


def select_rows(rows: list[dict], args) -> list[dict]:
    only = {x.strip().replace("\\", "/") for x in (args.only or "").split(",") if x.strip()}
    if only:
        rows = [r for r in rows if r["name"] in only]
        missing = only - {r["name"] for r in rows}
        if missing:
            raise RuntimeError("清单里没有 " + ", ".join(sorted(missing)))
    rows = sorted(rows, key=lambda r: (not r["isEncypt"], r["name"]))
    if args.limit:
        rows = rows[:args.limit]
    return rows


def commit_file(dest: Path, name: str, raw: bytes, item: dict) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    part = dest.with_name(dest.name + ".part")
    if item["isEncypt"]:
        part.write_bytes(restore_bytes(name, raw, True))
        os.replace(part, dest)
        return
    part.write_bytes(raw)
    os.replace(part, dest)
    off = ab_offset(name)
    with dest.open("rb") as f:
        f.seek(off)
        magic = f.read(len(UNITY_FS))
    if magic != UNITY_FS:
        return
    stripped = dest.with_name(dest.name + ".strip")
    with dest.open("rb") as src, stripped.open("wb") as out:
        src.seek(off)
        shutil.copyfileobj(src, out, 1 << 20)
    os.replace(stripped, dest)


def harvest_packs(apks, wanted: dict[str, dict], assets: Path, state: dict, state_path: Path, force: bool):
    lock = threading.Lock()
    hit = 0
    for apk in apks:
        with zipfile.ZipFile(apk) as zf:
            members = [i for i in zf.infolist() if "/packs/" in i.filename.replace("\\", "/") and i.filename.endswith(".bs")]
            for info in members:
                blob = zf.read(info)
                for name, raw in iter_bs(blob):
                    item = wanted.get(name)
                    if item is None:
                        continue
                    dest = assets / safe_rel(name)
                    if not force and state["files"].get(name) == item["FileMD5"] and dest.is_file():
                        continue
                    digest = hashlib.md5(raw).hexdigest().upper()
                    if item["FileMD5"] and digest != item["FileMD5"]:
                        continue
                    commit_file(dest, name, raw, item)
                    with lock:
                        state["files"][name] = item["FileMD5"] or digest
                        hit += 1
                print(f"  {info.filename} 已对照")
    if hit:
        save_state(state_path, state)
    return hit


def download_missing(rows, hot, channel, assets: Path, state: dict, state_path: Path, args) -> int:
    pending = []
    for item in rows:
        dest = assets / safe_rel(item["name"])
        if not args.force and state["files"].get(item["name"]) == item["FileMD5"] and dest.is_file():
            continue
        pending.append(item)
    if not pending:
        print("没有需要下载的文件")
        return 0
    lock = threading.Lock()
    fails = []

    def one(item):
        dest = assets / safe_rel(item["name"])
        part = dest.with_name(dest.name + ".part")
        url = file_url(hot, channel, item)
        digest = http_get(url, args.timeout, args.retries, part)
        if item["FileMD5"] and digest != item["FileMD5"]:
            part.unlink(missing_ok=True)
            raise RuntimeError(f"{item['name']} MD5 {digest} != {item['FileMD5']}")
        if item["isEncypt"]:
            raw = part.read_bytes()
            part.write_bytes(restore_bytes(item["name"], raw, True))
        os.replace(part, dest)
        if not item["isEncypt"]:
            off = ab_offset(item["name"])
            with dest.open("rb") as f:
                f.seek(off)
                magic = f.read(len(UNITY_FS))
            if magic == UNITY_FS:
                stripped = dest.with_name(dest.name + ".strip")
                with dest.open("rb") as src, stripped.open("wb") as out:
                    src.seek(off)
                    shutil.copyfileobj(src, out, 1 << 20)
                os.replace(stripped, dest)
        with lock:
            state["files"][item["name"]] = item["FileMD5"] or digest
            save_state(state_path, state)
        return item["name"]

    try:
        from rich.progress import BarColumn, MofNCompleteColumn, Progress, TextColumn, TimeRemainingColumn
        progress = Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            MofNCompleteColumn(),
            TimeRemainingColumn(),
        )
    except ImportError:
        progress = None

    def run(update):
        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futs = {pool.submit(one, item): item for item in pending}
            for fut in as_completed(futs):
                item = futs[fut]
                try:
                    fut.result()
                except Exception as exc:
                    fails.append(f"{item['name']}: {exc}")
                update()

    print(f"下载 {len(pending)} 个文件，{args.jobs} 线程")
    if progress is None:
        done = 0

        def update():
            nonlocal done
            done += 1
            if done % 50 == 0 or done == len(pending):
                print(f"  {done}/{len(pending)}")

        run(update)
    else:
        with progress:
            task = progress.add_task("热更", total=len(pending))
            run(lambda: progress.advance(task))
    for line in fails:
        print("失败 " + line)
    return len(fails)


def ensure_manifest(args, root: Path, apks: list[Path]):
    assets = root / "Assets"
    assets.mkdir(parents=True, exist_ok=True)
    state_path = assets / ".state.json"
    state = load_state(state_path)
    cached = assets / ".ver.bytes"
    local = read_member(apks, "assets/ver.bytes")
    env = parse_mjenv(read_member(apks, "assets/MJEnv.txt").decode())
    hot = env["HotResUrl"]
    env_path = env.get("HotResEnvironmenPath") or "Advrelease"
    if cached.is_file() and state.get("channel") and not args.force:
        data = cached.read_bytes()
        channel = state["channel"]
        print(f"沿用 {channel}，ver.bytes {len(data)} 字节")
    else:
        print(f"热更 {hot} ，对照包体 ver.bytes {len(local)} 字节")
        channel, data = pick_channel(hot, env_path, local, args.timeout, args.retries)
        cached.write_bytes(data)
        state["channel"] = channel
        state["hot"] = hot
        save_state(state_path, state)
        print(f"选用 {channel}")
    rows = manifest_rows(parse_nrbf(data))
    if len(rows) < 1000:
        raise RuntimeError(f"清单只有 {len(rows)} 条")
    return rows, hot, channel, state, state_path, env


def cmd_assets(args) -> int:
    root = game_root(args)
    apks = list_apks(root)
    if not apks:
        print("目录里没有 apk")
        return 1
    rows, hot, channel, state, state_path, _env = ensure_manifest(args, root, apks)
    chosen = select_rows(rows, args)
    total = sum(r["FileSize"] for r in rows)
    print(f"清单 {len(rows)} 条，FileSize 合计 {total / 1024 / 1024:.1f} MiB，本次处理 {len(chosen)} 条")
    wanted = {r["name"]: r for r in chosen}
    assets = root / "Assets"
    hit = harvest_packs(apks, wanted, assets, state, state_path, args.force)
    print(f"包体命中并写出 {hit} 个")
    fails = download_missing(chosen, hot, channel, assets, state, state_path, args)
    return 1 if fails else 0


def decompile_lua(raw: bytes) -> str:
    if shutil.which("unluac") is None:
        raise RuntimeError("PATH 里没有 unluac")
    fd, tmp = tempfile.mkstemp(suffix=".luac")
    os.close(fd)
    path = Path(tmp)
    try:
        path.write_bytes(raw)
        proc = subprocess.run(["unluac", str(path)], capture_output=True, text=True)
        if proc.returncode != 0:
            raise RuntimeError(proc.stderr.strip() or "unluac 失败")
        return proc.stdout
    finally:
        path.unlink(missing_ok=True)


def write_text_asset(master: Path, bundle: str, name: str, raw: bytes) -> str:
    rel_name = str(safe_rel(name))
    if rel_name.endswith(".lua") or raw.startswith(b"\x1bLua"):
        dest = master / "lua" / safe_rel(rel_name if rel_name.endswith(".lua") else rel_name + ".lua")
        dest.parent.mkdir(parents=True, exist_ok=True)
        if raw.startswith(b"\x1bLua"):
            dest.write_text(decompile_lua(raw), encoding="utf-8")
            return "luac"
        dest.write_bytes(raw)
        return "lua"
    text = None
    for enc in ("utf-8-sig", "utf-8"):
        try:
            text = raw.decode(enc)
            break
        except UnicodeDecodeError:
            continue
    dest_dir = master / "config" / safe_rel(bundle)
    dest_dir.mkdir(parents=True, exist_ok=True)
    if text is None:
        (dest_dir / safe_rel(rel_name).name).write_bytes(raw)
        return "bin"
    stripped = text.lstrip("\ufeff").lstrip()
    if stripped[:1] in "{[":
        try:
            obj = json.loads(stripped)
        except json.JSONDecodeError:
            obj = None
        if obj is not None:
            out = dest_dir / (Path(rel_name).name if rel_name.endswith(".json") else Path(rel_name).name + ".json")
            out.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
            return "json"
    suffix = "" if Path(rel_name).suffix else ".txt"
    (dest_dir / (Path(rel_name).name + suffix if suffix else Path(rel_name).name)).write_text(text, encoding="utf-8")
    return "txt"


def interesting_bundle(name: str) -> bool:
    low = name.lower().replace("\\", "/")
    if low.startswith(SKIP_PREFIXES):
        return False
    base = low.rsplit("/", 1)[-1]
    return not base.startswith(ART_PREFIXES)


def check_xlua(root: Path, apks: list[Path]) -> None:
    path = root / "libxlua.so"
    data = path.read_bytes() if path.is_file() else None
    if data is None:
        found = find_member(apks, "libxlua.so")
        if found:
            apk, name = found
            with zipfile.ZipFile(apk) as zf:
                data = zf.read(name)
    if not data:
        print("没找到 libxlua.so，跳过 Lua 版本核对")
        return
    stock = b"Lua 5.3" in data and b"\x1bLua" in data and b"version mismatch" in data
    if stock:
        print("libxlua.so 是未改魔的 Lua 5.3（标准 \\x1bLua 字节码头）")
    else:
        print("libxlua.so 不像官方 Lua 5.3，字节码可能要先还原再 unluac")


def export_bundle(path: Path, bundle: str, master: Path) -> dict[str, int]:
    import UnityPy
    counts: dict[str, int] = {}
    env = UnityPy.load(str(path))
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        data = obj.read()
        script = data.m_Script
        raw = script.encode("utf-8") if isinstance(script, str) else bytes(script)
        kind = write_text_asset(master, bundle, data.m_Name or "unnamed", raw)
        counts[kind] = counts.get(kind, 0) + 1
    return counts


def cmd_masterdata(args) -> int:
    root = game_root(args)
    apks = list_apks(root)
    if not apks:
        print("目录里没有 apk")
        return 1
    master = root / "MasterData"
    master.mkdir(parents=True, exist_ok=True)
    check_xlua(root, apks)
    rows, hot, channel, state, state_path, env = ensure_manifest(args, root, apks)
    (master / "config").mkdir(parents=True, exist_ok=True)
    (master / "config" / "ver.json").write_text(
        json.dumps(rows, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    (master / "config" / "MJEnv.txt").write_text(
        "\n".join(f"{k}:{v}" for k, v in env.items()) + "\n", encoding="utf-8")
    print(f"写出 MasterData/config/ver.json （{len(rows)} 条）")
    by_name = {r["name"]: r for r in rows}
    lua_rows = [r for r in rows if "lua" in r["name"].lower()]
    if lua_rows:
        fails = download_missing(lua_rows, hot, channel, root / "Assets", state, state_path, args)
        if fails:
            return 1
    assets = root / "Assets"
    totals: dict[str, int] = {}
    scanned = 0
    for path in sorted(assets.rglob("*")):
        if not path.is_file() or path.name.startswith("."):
            continue
        rel = str(path.relative_to(assets)).replace("\\", "/")
        if not interesting_bundle(rel):
            continue
        with path.open("rb") as f:
            if f.read(len(UNITY_FS)) != UNITY_FS:
                continue
        scanned += 1
        try:
            counts = export_bundle(path, rel, master)
        except Exception as exc:
            print(f"跳过 {rel}：{exc}")
            continue
        if counts:
            print(f"  {rel} {counts}")
        for k, v in counts.items():
            totals[k] = totals.get(k, 0) + v
    print(f"扫描 {scanned} 个 bundle，导出 {totals or '无 TextAsset'}")
    return 0


GAME_TITLE = "交错战线"
_DRAW_PREFIX = "textures_bigs_character_"

# UILayerBlend.CountVal：pos 是表情贴图中心相对立绘中心的偏移，y 向上。
# 贴图按像素 1:1 盖住，缩放 = 立绘尺寸 / 表情尺寸。
def face_origin(base_w: int, base_h: int, face_w: int, face_h: int, pos: tuple[float, float]) -> tuple[float, float]:
    left = base_w / 2 + pos[0] - face_w / 2
    top = base_h / 2 - pos[1] - face_h / 2
    return left, top


def _safe_fs_name(text: str) -> str:
    table = str.maketrans({
        "/": "／", "\\": "＼", ":": "：", "*": "＊", "?": "？",
        '"': "'", "<": "＜", ">": "＞", "|": "｜", "\n": "", "\r": "", "\t": " ",
    })
    return text.translate(table).strip() or "未知"


def painting_filename(cha: str, skin: str, used: set[str], notes: list[str], keep_same: bool = False) -> str:
    cha_s = _safe_fs_name(cha)
    parts = [GAME_TITLE, cha_s]
    skin_s = _safe_fs_name(skin) if skin else ""
    if skin_s and skin_s != "未知" and (keep_same or skin_s != cha_s):
        parts.append(skin_s)
    for note in notes:
        cleaned = _safe_fs_name(note)
        if cleaned and cleaned != "未知":
            parts.append(cleaned)
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


def load_paint_index(master: Path) -> tuple[dict, dict, dict]:
    char_lua = master / "lua" / "cfgcharacter.lua"
    face_lua = master / "lua" / "cfgcharacterFace.lua"
    if not char_lua.is_file() or not face_lua.is_file():
        raise RuntimeError("缺 cfgcharacter.lua / cfgcharacterFace.lua，先跑 masterdata")
    if shutil.which("luajit") is None:
        raise RuntimeError("PATH 里没有 luajit")
    script = f"""
local function q(s)
  s = tostring(s or "")
  s = s:gsub("\\\\", "\\\\\\\\"):gsub('"', '\\\\"'):gsub("\\r", ""):gsub("\\n", "\\\\n")
  return '"' .. s .. '"'
end
dofile([=[{char_lua}]=])
dofile([=[{face_lua}]=])
io.write('{{"rows":[')
local first = true
for id, row in pairs(_G.character) do
  if type(row.img) == "string" and row.img ~= "" then
    if not first then io.write(",") end
    first = false
    local shop = type(row.shopImg) == "string" and row.shopImg or ""
    local face = type(row.faceID) == "number" and row.faceID or 0
    local desc = type(row.desc) == "string" and row.desc or ""
    io.write(string.format('{{"key":%s,"img":%s,"shop":%s,"face":%d,"desc":%s}}', q(row.key), q(row.img), q(shop), face, q(desc)))
  end
end
io.write('],"faces":[')
first = true
for _, row in pairs(_G.characterFace) do
  if type(row.item) == "table" then
    for _, item in ipairs(row.item) do
      if type(item.img) == "string" and type(item.pos) == "table" then
        if not first then io.write(",") end
        first = false
        io.write(string.format('{{"img":%s,"x":%s,"y":%s}}', q(item.img), tostring(item.pos[1]), tostring(item.pos[2])))
      end
    end
  end
end
io.write("]}}")
"""
    proc = subprocess.run(["luajit", "-e", script], capture_output=True, text=True)
    if proc.returncode != 0:
        raise RuntimeError(proc.stderr.strip() or "读取角色表失败")
    data = json.loads(proc.stdout)
    by_img: dict[str, dict] = {}
    prefix: dict[str, set[str]] = {}
    for row in data["rows"]:
        img = row["img"].lower()
        prev = by_img.get(img)
        if prev is None or (not prev.get("face") and row.get("face")):
            by_img[img] = row
        shop = (row.get("shop") or "").lower()
        if shop and shop not in by_img:
            by_img[shop] = row
        pre = img.split("_", 1)[0]
        if pre:
            prefix.setdefault(pre, set()).add(row["key"] or "未知")
    one_key = {pre: next(iter(keys)) for pre, keys in prefix.items() if len(keys) == 1}
    faces = {}
    for item in data["faces"]:
        faces[item["img"].lower()] = (float(item["x"]), float(item["y"]))
    return by_img, one_key, faces


def _lookup_character(stem: str, by_img: dict, one_key: dict) -> dict | None:
    row = by_img.get(stem.lower())
    if row:
        return row
    pre = stem.split("_", 1)[0]
    key = one_key.get(pre)
    if not key:
        return None
    return {"key": key, "img": stem, "shop": "", "face": 0}


def _texture_names(path: Path) -> list[str]:
    import UnityPy
    env = UnityPy.load(str(path))
    names = []
    for obj in env.objects:
        if obj.type.name != "Texture2D":
            continue
        names.append(str(obj.read().m_Name or ""))
    return names


def _bundle_textures(path: Path) -> list[tuple[str, object]]:
    import UnityPy
    env = UnityPy.load(str(path))
    out = []
    for obj in env.objects:
        if obj.type.name != "Texture2D":
            continue
        data = obj.read()
        image = data.image
        if image is not None:
            out.append((str(data.m_Name or ""), image.convert("RGBA")))
    return out


def _expr_name(skin_stem: str, face_name: str) -> str:
    skin = skin_stem[:-5] if skin_stem.lower().endswith("_draw") else skin_stem
    low = face_name.lower()
    prefix = skin.lower() + "_"
    if low.startswith(prefix):
        return face_name[len(prefix):]
    return face_name.rsplit("_", 1)[-1]


def cmd_painting(args) -> int:
    root = game_root(args)
    assets = root / "Assets"
    master = root / "MasterData"
    out_dir = root / "Painting"
    if not assets.is_dir():
        print("缺 Assets，先跑 assets")
        return 1
    by_img, one_key, faces = load_paint_index(master)
    only = {x.strip() for x in (args.only or "").split(",") if x.strip()}
    bundles = []
    for path in sorted(assets.glob(_DRAW_PREFIX + "*_draw")):
        if not path.is_file() or path.name.endswith("_draw_face"):
            continue
        if only and path.name not in only:
            continue
        bundles.append(path)
    if args.limit:
        bundles = bundles[:args.limit]
    if not bundles:
        print("没有 textures_bigs_character_*_draw")
        return 1
    used: set[str] = set()
    used_old: set[str] = set()
    jobs = []
    named = 0
    for path in bundles:
        stem = path.name[len(_DRAW_PREFIX):]
        row = _lookup_character(stem, by_img, one_key)
        cha = (row or {}).get("key") or "未知"
        matched = by_img.get(stem.lower())
        if matched:
            named += 1
            row = matched
        label = stem
        if row:
            for cand in (row.get("img"), row.get("shop")):
                if cand and cand.lower() == stem.lower():
                    label = cand
                    break
        asset_skin = label[:-5] if label.lower().endswith("_draw") else label
        skin = ((row or {}).get("desc") or "").strip() or asset_skin
        face_path = path.with_name(path.name + "_face")
        face_jobs = []
        if face_path.is_file():
            face_jobs.append(face_path)
        old_base = painting_filename(cha, skin, used_old, [], keep_same=True)
        dest = out_dir / painting_filename(cha, skin, used, [])
        jobs.append((path, stem, dest, face_jobs, cha, skin, asset_skin, old_base))
    print(f"立绘 {len(jobs)} 张，角色表命中 {named}，表情包 {sum(1 for j in jobs if j[3])} → {out_dir}")
    return _paint_run(args, jobs, faces, out_dir, used, used_old)


def _legacy_painting_name(cha: str, asset_skin: str, expr: str = "") -> str:
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(asset_skin)]
    if expr:
        cleaned = _safe_fs_name(expr)
        if cleaned and cleaned != "未知":
            parts.append(cleaned)
    return "_".join(parts) + ".png"


def _take_legacy(out_dir: Path, cha: str, asset_skin: str, dest: Path, expr: str = "") -> bool:
    old = out_dir / _legacy_painting_name(cha, asset_skin, expr)
    if old.is_file() and old != dest and not dest.is_file():
        dest.parent.mkdir(parents=True, exist_ok=True)
        old.rename(dest)
        return True
    return False


def _rename_to(out_dir: Path, old_name: str, dest: Path) -> bool:
    old = out_dir / old_name
    if old.is_file() and old != dest and not dest.is_file():
        dest.parent.mkdir(parents=True, exist_ok=True)
        old.rename(dest)
        return True
    return False


def _paint_run(args, jobs, faces, out_dir: Path, used: set[str], used_old: set[str]) -> int:
    from PIL import Image
    planned = []
    renamed = 0
    for path, stem, dest, face_paths, cha, skin, asset_skin, old_base in jobs:
        if not args.force:
            if _rename_to(out_dir, old_base, dest):
                renamed += 1
            elif _take_legacy(out_dir, cha, asset_skin, dest):
                renamed += 1
        exprs = []
        for face_path in face_paths:
            for name in _texture_names(face_path):
                pos = faces.get(name.lower())
                if pos is None:
                    continue
                expr = _expr_name(stem, name)
                old_face = painting_filename(cha, skin, used_old, [expr], keep_same=True)
                face_dest = out_dir / painting_filename(cha, skin, used, [expr])
                if not args.force:
                    if _rename_to(out_dir, old_face, face_dest):
                        renamed += 1
                    elif _take_legacy(out_dir, cha, asset_skin, face_dest, expr):
                        renamed += 1
                exprs.append((name, pos, face_dest))
        planned.append((path, stem, dest, face_paths, exprs))
    if renamed:
        print(f"按皮肤名改名 {renamed} 张")
    written = skipped = fail = 0
    lock = threading.Lock()

    def work(item):
        path, stem, dest, _face_paths, exprs = item
        ok = skip = 0
        try:
            base = None
            if dest.is_file() and not args.force:
                skip += 1
            else:
                textures = _bundle_textures(path)
                if not textures:
                    return 0, 0, f"{stem} 没有贴图"
                base = max(textures, key=lambda it: it[1].width * it[1].height)[1]
                dest.parent.mkdir(parents=True, exist_ok=True)
                base.save(dest, "PNG", compress_level=1)
                ok += 1
            if exprs and base is None:
                textures = _bundle_textures(path)
                base = max(textures, key=lambda it: it[1].width * it[1].height)[1]
            face_images = {}
            for face_path in _face_paths:
                for name, image in _bundle_textures(face_path):
                    face_images[name.lower()] = image
            for name, pos, face_dest in exprs:
                image = face_images.get(name.lower())
                if image is None:
                    continue
                if face_dest.is_file() and not args.force:
                    skip += 1
                    continue
                left, top = face_origin(base.width, base.height, image.width, image.height, pos)
                layer = Image.new("RGBA", base.size, (0, 0, 0, 0))
                layer.paste(image, (int(round(left)), int(round(top))))
                Image.alpha_composite(base, layer).save(face_dest, "PNG", compress_level=1)
                ok += 1
            return ok, skip, None
        except Exception as exc:
            return ok, skip, f"{stem}: {exc}"

    with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
        futs = [pool.submit(work, item) for item in planned]
        for fut in as_completed(futs):
            ok, skip, err = fut.result()
            with lock:
                written += ok
                skipped += skip
                if err:
                    fail += 1
                    print("立绘失败 " + err)
    print(f"Painting 写出 {written}  跳过 {skipped}  失败 {fail} → {out_dir}")
    return 1 if fail else 0


def cmd_update(args) -> int:
    code = cmd_assets(args)
    if code:
        return code
    code = cmd_masterdata(args)
    if code:
        return code
    if args.skip_painting:
        return 0
    return cmd_painting(args)


def cmd_status(args) -> int:
    root = game_root(args)
    apks = list_apks(root)
    print(f"游戏目录 {root}")
    print(f"apk {len(apks)} 个：" + ", ".join(p.name for p in apks))
    assets = root / "Assets"
    master = root / "MasterData"
    if assets.is_dir():
        files = [p for p in assets.rglob("*") if p.is_file() and not p.name.startswith(".")]
        total = sum(p.stat().st_size for p in files)
        state = load_state(assets / ".state.json")
        print(f"Assets {len(files)} 个文件，{total / 1024 / 1024:.1f} MiB，记录 {len(state.get('files', {}))} 条，频道 {state.get('channel')}")
    else:
        print("Assets 还不存在")
    if master.is_dir():
        lua = list((master / "lua").rglob("*.lua")) if (master / "lua").is_dir() else []
        cfg = list((master / "config").rglob("*")) if (master / "config").is_dir() else []
        cfg = [p for p in cfg if p.is_file()]
        print(f"MasterData lua {len(lua)} 个，config {len(cfg)} 个")
    else:
        print("MasterData 还不存在")
    painting = root / "Painting"
    if painting.is_dir():
        pngs = list(painting.glob("*.png"))
        print(f"Painting {len(pngs)} 张")
    else:
        print("Painting 还不存在")
    return 0





def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", type=Path, help="游戏目录或其中一个 apk，默认脚本所在目录")
    shared.add_argument("--jobs", type=int, default=8, help="下载线程")
    shared.add_argument("--timeout", type=int, default=60)
    shared.add_argument("--retries", type=int, default=4)
    shared.add_argument("--force", action="store_true", help="忽略 Assets/.state.json 重新拉取")
    shared.add_argument("--limit", type=int, default=0, help="只处理清单前 N 条，0 为全部")
    shared.add_argument("--only", default="", help="只处理这些资源名，逗号分隔")
    shared.add_argument("--skip-painting", action="store_true", help="update 时跳过立绘")
    parser = argparse.ArgumentParser(prog="DaiblosCore.py", parents=[shared])
    sub = parser.add_subparsers(dest="cmd", required=True)
    sub.add_parser("assets", parents=[shared], help="包体 .bs + 热更，解密后写入 Assets")
    sub.add_parser("masterdata", aliases=["data"], parents=[shared], help="导出 Lua 和配置到 MasterData")
    sub.add_parser("painting", parents=[shared], help="导出立绘到 Painting，表情差分贴回脸上")
    sub.add_parser("update", parents=[shared], help="assets、masterdata，再导出立绘")
    sub.add_parser("status", parents=[shared], help="看 apk / Assets / MasterData")
    return parser


def main(argv=None) -> int:
    args = build_parser().parse_args(argv)
    cmds = {
        "assets": cmd_assets,
        "masterdata": cmd_masterdata,
        "data": cmd_masterdata,
        "update": cmd_update,
        "painting": cmd_painting,
        "status": cmd_status,
    }
    return cmds[args.cmd](args)


if __name__ == "__main__":
    sys.exit(main())
