from __future__ import annotations
import io
import re
from typing import Dict, List, Optional, Tuple

import argparse
import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
import warnings
import threading
import time
import struct
import traceback
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from rich.console import Console
from rich.live import Live
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TaskID,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)
from rich.table import Table

GAME_TITLE = "深空之眼"
SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_ASSET_OUT = "./AetherGazer"
DEFAULT_MASTER_DIR = SCRIPT_DIR / "MasterData"
DEFAULT_SCHEMA = SCRIPT_DIR / "Schema.json"
DEFAULT_JOBS = 8
ARCH_DIR = {"64": "x64", "32": "x86"}
LUA_BUNDLE = {"64": "scripts64", "32": "scripts32"}
LUA_ROOT = "assets/luabuilds/luajit2.0/"
TABLE_ASSETS = ("config.ys",)

DEFAULT_API = (
    "https://open.ys4fun.com/game-website-server/pass/sdk/"
    "get_game_hot_update_version?gameId=1"
)
USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
)


def _opener() -> urllib.request.OpenerDirector:
    return urllib.request.build_opener(urllib.request.ProxyHandler({}))


def http_get_text(url: str, timeout: int = 30) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with _opener().open(req, timeout=timeout) as resp:
        return resp.read()


def fetch_hot_version(api_url: str, timeout: int = 30) -> Dict:
    data = json.loads(http_get_text(api_url, timeout).decode("utf-8"))
    if data.get("errorCode") not in ("0", None):
        raise RuntimeError(f"热更新版本接口返回错误: {data}")
    info = data.get("data") or {}
    if not info.get("downloadUrl"):
        raise RuntimeError("热更新版本接口未返回 downloadUrl")
    if not info.get("assethash"):
        raise RuntimeError("热更新版本接口未返回 assethash")
    return info

def load_schema(path: str | Path) -> dict[str, dict[int, list[dict]]]:
    s = json.loads(Path(path).read_text(encoding="utf-8"))
    by_name: dict[str, dict[int, list[dict]]] = {}
    for m in s.get("messages", []):
        if not m:
            continue
        fields: dict[int, list[dict]] = {}
        for f in m.get("fields", []):
            fields.setdefault(f["fieldNumber"], []).append(f)
        by_name[m["message"]] = fields
    return by_name


class VarintReader:
    def __init__(self, buf: bytes):
        self.b = buf
        self.i = 0

    def read_varint(self) -> int:
        v = 0
        s = 0
        while True:
            if self.i >= len(self.b):
                raise ValueError("varint 越界")
            x = self.b[self.i]
            self.i += 1
            v |= (x & 0x7F) << s
            if not x & 0x80:
                return v
            s += 7
            if s > 70:
                raise ValueError("varint 过长")

    def read_bytes(self, n: int) -> bytes:
        if self.i + n > len(self.b):
            raise ValueError("bytes 越界")
        out = self.b[self.i : self.i + n]
        self.i += n
        return out


def clean_str(raw: bytes) -> str:
    try:
        return raw.decode("utf-8")
    except UnicodeDecodeError:
        return raw.hex()


def decode_message(buf: bytes, msg_name: str, schema, depth: int = 0) -> dict:
    if depth > 16:
        return {"__depth_exceeded__": buf.hex()}
    fields = schema.get(msg_name, {})
    r = VarintReader(buf)
    out: dict = {}
    unknown = []
    while r.i < len(r.b):
        tag = r.read_varint()
        fnum = tag >> 3
        wt = tag & 7
        if fnum == 0:
            raise ValueError("field 0")
        specs = fields.get(fnum)
        if wt == 0:
            v = r.read_varint()
            if specs:
                for f in specs:
                    nm = f["name"]
                    if (
                        f.get("type") in ("bool", "Boolean")
                        or f.get("elementType") == "bool"
                    ):
                        vv = bool(v)
                    else:
                        vv = v
                    if f.get("repeated"):
                        out.setdefault(nm, []).append(vv)
                    else:
                        out[nm] = vv
            else:
                unknown.append([fnum, "varint", v])
        elif wt == 2:
            ln = r.read_varint()
            raw = r.read_bytes(ln)
            if specs:
                for f in specs:
                    nm = f["name"]
                    t = f.get("type", "")
                    et = f.get("elementType")
                    if f.get("repeated"):
                        lst = out.setdefault(nm, [])
                        if et in ("int", "uint", "long", "ulong", "int32", "uint32"):
                            pr = VarintReader(raw)
                            try:
                                while pr.i < len(raw):
                                    lst.append(pr.read_varint())
                            except ValueError:
                                lst.append(clean_str(raw))
                        elif et in schema:
                            lst.append(decode_message(raw, et, schema, depth + 1))
                        elif et == "string":
                            lst.append(clean_str(raw))
                        else:
                            lst.append(clean_str(raw))
                    else:
                        if t in schema:
                            out[nm] = decode_message(raw, t, schema, depth + 1)
                        elif t in ("string", "String", "ByteString"):
                            out[nm] = clean_str(raw)
                        elif t in ("bytes",):
                            out[nm] = raw.hex()
                        else:
                            out[nm] = clean_str(raw)
            else:
                unknown.append([fnum, "len", raw])
        elif wt == 5:
            raw = r.read_bytes(4)
            v = struct.unpack("<I", raw)[0]
            if specs:
                out.setdefault(specs[0]["name"], v)
            else:
                unknown.append([fnum, "fixed32", v])
        elif wt == 1:
            raw = r.read_bytes(8)
            v = struct.unpack("<Q", raw)[0]
            if specs:
                out.setdefault(specs[0]["name"], v)
            else:
                unknown.append([fnum, "fixed64", v])
        else:
            raise ValueError(f"bad wire type {wt}")
    if unknown:
        out["__unknown__"] = [
            [n, k, v if isinstance(v, (str, int)) else v.hex()] for n, k, v in unknown
        ]
    return out


def find_next_header(data: bytes, p: int):
    q = p
    while q + 8 <= len(data):
        nl2 = struct.unpack_from("<I", data, q)[0]
        if 1 <= nl2 <= 128 and q + 4 + nl2 <= len(data):
            b = data[q + 4 : q + 4 + nl2]
            if all(32 <= x < 127 for x in b):
                return q, None, nl2, b.decode(), 4
        rc = struct.unpack_from("<I", data, q)[0]
        nl = struct.unpack_from("<I", data, q + 4)[0]
        if 1 <= nl <= 128 and q + 8 + nl <= len(data):
            b = data[q + 8 : q + 8 + nl]
            if all(32 <= x < 127 for x in b) and rc <= 200000:
                return q, rc, nl, b.decode(), 8
        q += 1
    return None


def parse_config(data: bytes, schema) -> list[dict]:
    tables = []
    off = 8
    guard = 0
    while off + 8 <= len(data) and guard < 500:
        guard += 1
        rc = struct.unpack_from("<I", data, off)[0]
        nl = struct.unpack_from("<I", data, off + 4)[0]
        name = None
        hdr = None
        if 1 <= nl <= 128 and off + 8 + nl <= len(data):
            b = data[off + 8 : off + 8 + nl]
            if all(32 <= x < 127 for x in b) and rc <= 200000:
                name = b.decode()
                hdr = 8
        if name is None:
            nl2 = struct.unpack_from("<I", data, off)[0]
            if 1 <= nl2 <= 128 and off + 4 + nl2 <= len(data):
                b = data[off + 4 : off + 4 + nl2]
                if all(32 <= x < 127 for x in b):
                    name = b.decode()
                    hdr = 4
                    rc = None
        if name is None:
            nxt = find_next_header(data, off)
            if nxt is None:
                break
            off, rc, nl, name, hdr = nxt
        p = off + hdr + nl
        rows = []
        limit = rc if rc is not None else (1 << 30)
        while len(rows) < limit and p + 8 <= len(data):
            rid = struct.unpack_from("<I", data, p)[0]
            rl = struct.unpack_from("<I", data, p + 4)[0]
            if rl > 50_000_000 or p + 8 + rl > len(data):
                break
            rowbuf = data[p + 8 : p + 8 + rl]
            try:
                dec = decode_message(rowbuf, name, schema)
            except Exception:
                dec = {"__raw__": rowbuf.hex()}
            rows.append({"id": rid, "data": dec})
            p += 8 + rl
        tables.append({"name": name, "rowCount": len(rows), "rows": rows})
        off = p
    return tables


def write_masterdata(tables: list[dict], out_dir: Path, compact: bool = False) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    indent = None if compact else 2
    stats = []
    for t in tables:
        rows = [{"id": r["id"], **r["data"]} for r in t["rows"]]
        (out_dir / f"{t['name']}.json").write_text(
            json.dumps(rows, ensure_ascii=False, indent=indent), encoding="utf-8"
        )
        stats.append({"table": t["name"], "rows": t["rowCount"]})
    (out_dir / "masterdata_index.json").write_text(
        json.dumps(stats, ensure_ascii=False, indent=2), encoding="utf-8"
    )

def fetch_manifest(info: Dict, timeout: int = 60) -> Dict:
    bases = [b for b in info["downloadUrl"].split(";") if b]
    last_err: Optional[Exception] = None
    for base in bases:
        url = base.rstrip("/") + "/" + info["assethash"]
        try:
            raw = http_get_text(url, timeout)
            manifest = json.loads(raw.decode("utf-8"))
            if "assetHashList" not in manifest:
                raise RuntimeError("清单缺少 assetHashList")
            manifest["_mirror"] = base
            return manifest
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            print(f"[!] 从 {url} 获取清单失败: {exc}", file=sys.stderr)
    raise RuntimeError(f"所有 CDN 镜像均无法获取清单: {last_err}")


def parse_entries(manifest: Dict) -> List[Dict]:
    entries: List[Dict] = []
    for line in manifest.get("assetHashList", []):
        parts = line.split("|")
        if len(parts) < 3:
            continue
        path, md5, size = parts[0], parts[1], parts[2]
        try:
            size_i = int(size)
        except ValueError:
            size_i = 0
        entries.append({"path": path, "hash": md5, "size": size_i})
    return entries


def build_path_index(entries: List[Dict]) -> Dict[str, Dict]:
    index: Dict[str, Dict] = {}
    for entry in entries:
        index.setdefault(entry["path"], entry)
        index.setdefault(entry["hash"], entry)
    return index


def select_entries(entries: List[Dict], manifest: Dict, only: List[str]) -> List[Dict]:
    """按下载包/分类筛选。only=['all'] 表示全部资源。"""
    if "all" in only:
        return entries

    pend = manifest.get("assetPendDict") or {}
    wanted_paths: set[str] = set()
    known_groups = {
        "assetList": pend.get("assetList") or [],
        "voiceList": pend.get("voiceList") or [],
        "newbieList": pend.get("newbieList") or [],
        "advanceList": pend.get("advanceList") or [],
        "permanentList": pend.get("permanentList") or [],
    }

    for group in only:
        group = group.strip().lower()
        if group == "voice":
            for key in ("voiceList", "allVoice"):
                wanted_paths.update(pend.get(key) or [])
            for paths in (pend.get("voiceDict") or {}).values():
                wanted_paths.update(paths)
            continue
        if group == "single":
            wanted_paths.update(known_groups["assetList"])
            wanted_paths.update(known_groups["voiceList"])
            continue
        if group in known_groups:
            wanted_paths.update(known_groups[group])
            continue
        if group == "lua":
            # Lua bundle：scripts32 / scripts64（热更分发），外加 tolua 原生运行时
            for e in entries:
                if e["path"] in ("scripts32", "scripts64") or e["path"].endswith(
                    "/p08_tolua_dll.ys"
                ):
                    wanted_paths.add(e["path"])
            continue
        # 具体包名，例如 assetpend_common_chapter_2
        wanted_paths.update((pend.get("pendDict") or {}).get(group, []))
        wanted_paths.update((pend.get("voiceDict") or {}).get(group, []))

    if not wanted_paths:
        raise RuntimeError(f"没有匹配到任何资源: {only}")

    path_index = build_path_index(entries)
    wanted_hashes: set[str] = set()
    for p in wanted_paths:
        entry = path_index.get(p)
        if entry:
            wanted_hashes.add(entry["hash"])

    # 按清单顺序输出（同一 md5 只取一条），保证结果稳定、--limit 可复现
    selected: List[Dict] = []
    seen: set[str] = set()
    for entry in entries:
        h = entry["hash"]
        if h in wanted_hashes and h not in seen:
            seen.add(h)
            selected.append(entry)
    return selected


def safe_join(root: Path, rel: str) -> Path:
    """按清单原始路径保存，防止路径穿越。"""
    target = (root / rel).resolve()
    root_resolved = root.resolve()
    if root_resolved not in target.parents and target != root_resolved:
        raise ValueError(f"非法路径: {rel}")
    return target


def local_path_for(entry: Dict, root: Path) -> Path:
    rel = entry.get("rel_path") or entry["path"]
    return safe_join(root, rel)


def entry_key(entry: Dict) -> str:
    """状态里使用的唯一键：语音带语言前缀，避免中日同名文件互相覆盖。"""
    return entry.get("rel_path") or entry["path"]


def remote_urls_for(entry: Dict, bases: List[str]) -> List[str]:
    return [b.rstrip("/") + "/" + entry["hash"] + ".ys" for b in bases]


def fetch_voice_entries(
    bases: List[str],
    langs: List[str],
    app_version: str,
    res_version: str,
    timeout: int,
) -> Tuple[List[Dict], Dict]:
    """从 voice_package_list_{app}_{res}.bytes 读取各语言语音包版本，
    再逐个下载 voice_hash_<lang>_<version>.bytes 并合并解析。"""
    list_filename = f"voice_package_list_{app_version}_{res_version}.bytes"
    raw = None
    last_err = ""
    for base in bases:
        url = base.rstrip("/") + "/" + list_filename
        try:
            raw = http_get_text(url, timeout)
            break
        except Exception as exc:  # noqa: BLE001
            last_err = f"{url}: {exc}"
    if raw is None:
        raise RuntimeError(f"无法下载 {list_filename}: {last_err}")

    pkg = json.loads(raw.decode("utf-8"))
    infos = pkg.get("infos") or []
    all_entries: List[Dict] = []
    languages: List[Dict] = []
    errors: List[str] = []

    for lang in langs:
        info = next((i for i in infos if i.get("name") == lang), None)
        if info is None:
            errors.append(f"语音包列表中没有语言 {lang}")
            continue

        version = info.get("version")
        filename = f"voice_hash_{lang}_{version}.bytes"
        fetched = False
        for base in bases:
            url = base.rstrip("/") + "/" + filename
            try:
                raw = http_get_text(url, timeout)
                voice_manifest = json.loads(raw.decode("utf-8"))
                if "assetHashList" not in voice_manifest:
                    raise RuntimeError("语音哈希清单缺少 assetHashList")
                voice_entries = parse_entries(voice_manifest)
                for e in voice_entries:
                    e["rel_path"] = f"voice/{lang}/{e['path']}"
                print(f"[*] 语音包 {lang} v{version}: {len(voice_entries)} 条")
                all_entries.extend(voice_entries)
                languages.append({"lang": lang, "version": version, "mirror": base})
                fetched = True
                break
            except Exception as exc:  # noqa: BLE001
                last_err = f"{url}: {exc}"
        if not fetched:
            errors.append(f"无法获取语音哈希清单 {filename}: {last_err}")

    if not all_entries:
        raise RuntimeError("所有语音哈希清单均获取失败: " + "; ".join(errors))
    if errors:
        print(f"[!] 部分语音包获取失败: {'; '.join(errors)}", file=sys.stderr)

    return all_entries, {"languages": languages}


def file_md5(path: Path) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


class Downloader:
    def __init__(
        self,
        bases: List[str],
        jobs: int,
        retries: int,
        verify: bool,
        force: bool,
        timeout: int,
        status_interval: int = 10,
        log_path: Optional[Path] = None,
    ):
        self.bases = bases
        self.jobs = jobs
        self.retries = retries
        self.verify = verify
        self.force = force
        self.timeout = timeout
        self.status_interval = status_interval
        self.log_path = log_path
        self.lock = threading.Lock()
        self.done = 0
        self.total = 0
        self.total_bytes = 0
        self.completed_bytes = 0
        self.failures: List[Tuple[str, str]] = []
        self.ok_hashes: set[str] = set()
        self._stop_status = threading.Event()
        self.console = Console()
        self.progress: Optional[Progress] = None
        self.task_id: Optional[TaskID] = None

    def _report(self, path: str, ok: bool, detail: str = "", size: int = 0) -> None:
        with self.lock:
            self.done += 1
            if ok:
                self.completed_bytes += size
                if self.progress is not None and self.task_id is not None and size:
                    self.progress.advance(self.task_id, size)
            else:
                if self.log_path is not None:
                    try:
                        with self.log_path.open("a", encoding="utf-8") as f:
                            f.write(f"{path}\t{detail}\n")
                    except Exception:  # noqa: BLE001
                        pass
                self.failures.append((path, detail))

    def _status_loop(self) -> None:
        while not self._stop_status.wait(self.status_interval):
            with self.lock:
                done = self.done
                total = self.total
                failed = len(self.failures)
            if total:
                print(
                    f"[进度] {done}/{total} 已处理，失败 {failed}，"
                    f"耗时 {time.time() - self.start_time:.0f}s",
                    flush=True,
                )

    def _download_one_url(
        self, url: str, target: Path, expected_size: int, pos: int
    ) -> bool:
        headers = {
            "User-Agent": USER_AGENT,
        }
        if pos:
            headers["Range"] = f"bytes={pos}-"
        req = urllib.request.Request(url, headers=headers)
        mode = "ab" if pos else "wb"
        with _opener().open(req, timeout=self.timeout) as resp, target.open(
            mode
        ) as out:
            while True:
                chunk = resp.read(1024 * 1024)
                if not chunk:
                    break
                out.write(chunk)
                if self.progress is not None and self.task_id is not None:
                    self.progress.advance(self.task_id, len(chunk))
        return target.stat().st_size >= expected_size

    def download_entry(self, entry: Dict, root: Path) -> bool:
        target = local_path_for(entry, root)
        target.parent.mkdir(parents=True, exist_ok=True)
        expected = entry.get("size", 0)

        if not self.force and target.exists() and target.stat().st_size == expected:
            if not self.verify or file_md5(target) == entry["hash"]:
                self._report(entry["path"], True, "skip", size=expected)
                self.ok_hashes.add(entry["hash"])
                return True
            target.unlink()

        urls = remote_urls_for(entry, self.bases)
        last_err = ""
        for attempt in range(max(1, self.retries)):
            for url in urls:
                pos = target.stat().st_size if target.exists() else 0
                if expected and pos > expected:
                    target.unlink()
                    pos = 0
                try:
                    self._download_one_url(url, target, expected, pos)
                    if expected and target.stat().st_size < expected:
                        raise RuntimeError(
                            f"大小不足 {target.stat().st_size}/{expected}"
                        )
                    if self.verify and file_md5(target) != entry["hash"]:
                        raise RuntimeError("MD5 校验失败")
                    self._report(entry["path"], True, size=expected)
                    self.ok_hashes.add(entry["hash"])
                    return True
                except Exception as exc:  # noqa: BLE001
                    last_err = f"{url}: {exc}"
                    # 服务器忽略 Range 时，重写整个文件
                    if target.exists() and target.stat().st_size > pos:
                        target.unlink()
        self._report(entry["path"], False, last_err)
        return False

    def _build_display(self, progress: Progress, task: TaskID) -> Table:
        """进度条 + 状态信息表（参考 DataTable/MementoMori 的 rich 写法）。"""
        with self.lock:
            done = self.done
            failed = len(self.failures)
        elapsed = time.time() - self.start_time
        pct = done / self.total * 100 if self.total else 0.0

        box = Table(show_header=False, box=None, padding=(0, 1))
        box.add_row(progress)
        info = Table(show_header=False, box=None)
        info.add_column(style="cyan", no_wrap=True)
        info.add_column(style="white")
        info.add_row("文件", f"{done}/{self.total} ({pct:.1f}%)")
        info.add_row("失败", f"{failed}")
        info.add_row("耗时", f"{elapsed:.0f}s")
        box.add_row(info)
        return box

    def run(self, entries: List[Dict], root: Path) -> bool:
        self.total = len(entries)
        self.total_bytes = sum(e.get("size", 0) for e in entries)
        self.done = 0
        self.failures = []
        self.ok_hashes = set()
        self.completed_bytes = 0
        self.start_time = time.time()

        tty = sys.stdout.isatty()
        progress = Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            "•",
            DownloadColumn(),
            "•",
            TransferSpeedColumn(),
            "•",
            TimeRemainingColumn(),
            console=self.console,
            disable=not tty,
        )
        task = progress.add_task(
            f"[cyan]下载 {self.total} 个文件[/cyan]", total=self.total_bytes or 1
        )
        self.progress = progress
        self.task_id = task

        def periodic(live: Live, prog: Progress, t: TaskID) -> None:
            while not prog.tasks[t].finished:
                live.update(self._build_display(prog, t))
                time.sleep(0.2)

        if tty:
            with Live(
                self._build_display(progress, task),
                refresh_per_second=8,
                console=self.console,
            ) as live:
                updater = threading.Thread(
                    target=periodic, args=(live, progress, task), daemon=True
                )
                updater.start()
                try:
                    self._dispatch(entries, root)
                finally:
                    updater.join(timeout=1)
                    live.update(self._build_display(progress, task))
        else:
            status_thread = threading.Thread(target=self._status_loop, daemon=True)
            status_thread.start()
            try:
                self._dispatch(entries, root)
            finally:
                self._stop_status.set()
                status_thread.join(timeout=1)
        return not self.failures

    def _dispatch(self, entries: List[Dict], root: Path) -> None:
        """并发下载主体（Live 与非 TTY 两种模式共用）。"""
        with ThreadPoolExecutor(max_workers=self.jobs) as pool:
            futures = [pool.submit(self.download_entry, e, root) for e in entries]
            for fut in as_completed(futures):
                try:
                    fut.result()
                except Exception as exc:  # noqa: BLE001
                    traceback.print_exc()
                    with self.lock:
                        self.done += 1
                        self.failures.append(("<task>", str(exc)))


def write_artifact_files(
    output: Path,
    info: Dict,
    manifest: Dict,
    entries: List[Dict],
    bases: List[str],
) -> None:
    output.mkdir(parents=True, exist_ok=True)

    manifest_copy = dict(manifest)
    manifest_copy.pop("_mirror", None)
    (output / "hot_version.json").write_text(
        json.dumps(info, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    (output / "assethash.json").write_text(
        json.dumps(manifest_copy, ensure_ascii=False, indent=2), encoding="utf-8"
    )

    with (output / "download_urls.txt").open("w", encoding="utf-8") as f:
        for e in entries:
            for url in remote_urls_for(e, bases):
                f.write(f"{url}\t{e['path']}\t{e['size']}\n")

    with (output / "filelist.txt").open("w", encoding="utf-8") as f:
        for e in sorted(entries, key=lambda x: x["path"]):
            f.write(f"{e['path']}\t{e['hash']}\t{e['size']}\n")


def write_voice_artifacts(
    output: Path,
    voice_entries: List[Dict],
    voice_meta: Dict,
    bases: List[str],
) -> None:
    with (output / "voice_urls.txt").open("w", encoding="utf-8") as f:
        for e in voice_entries:
            for url in remote_urls_for(e, bases):
                f.write(f"{url}\t{e['path']}\t{e['size']}\n")
    (output / "voice_info.json").write_text(
        json.dumps(voice_meta, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def load_state(path: Path) -> Dict:
    if path.exists():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except Exception:  # noqa: BLE001
            pass
    return {}


def save_state(
    path: Path,
    info: Dict,
    entries: List[Dict],
    voice_meta: Dict,
    full_complete: bool = True,
) -> None:
    state = {
        "hot_version": info,
        "entries": {entry_key(e): e["hash"] for e in entries},
        "voice": voice_meta,
        "full_complete": full_complete,
        "entry_count": len(entries),
    }
    path.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8")


# ---------------------------------------------------------------------------
# 数据表：config.ys -> MasterData/*.json
# ---------------------------------------------------------------------------


def extract_config_bin(ys_path: Path) -> bytes:
    """从 config.ys（UnityFS）里取出 TextAsset "Config" 的原始字节。"""
    import UnityPy
    import UnityPy.config as ucfg
    from UnityPy.config import UnityVersionFallbackWarning

    warnings.filterwarnings("ignore", category=UnityVersionFallbackWarning)
    ucfg.FALLBACK_UNITY_VERSION = "2022.3.62f1c1"

    raw = ys_path.read_bytes()
    off = raw.find(b"UnityFS")
    if off <= 0:
        raise ValueError(f"{ys_path} 不是 UnityFS AssetBundle")

    env = UnityPy.load(io.BytesIO(raw[off:]))
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        ta = obj.read()
        if getattr(ta, "m_Name", None) != "Config":
            continue
        data = obj.get_raw_data()
        script_len = struct.unpack_from("<I", data, 0x0C)[0]
        return bytes(data[0x10 : 0x10 + script_len])
    raise ValueError("config.ys 内未找到 TextAsset 'Config'")


def parse_masterdata(
    out_dir: Path, schema_path: Path, compact: bool = False
) -> Tuple[int, int, int, int]:
    """解析 out_dir/config.ys 到 out_dir/*.json（每表一个文件 + 索引）。

    返回 (表数, 行数, 未解码行数, 未知字段数)。
    """
    ys = out_dir / "config.ys"
    if not ys.exists():
        raise FileNotFoundError(f"未找到数据表资产 {ys}")
    if not schema_path.exists():
        raise FileNotFoundError(
            f"未找到字段映射 {schema_path}（可用 schema 子命令重新生成）"
        )
    print("[*] 提取 Config 数据表 ...")
    cfg = extract_config_bin(ys)
    tables = parse_config(cfg, load_schema(schema_path))
    write_masterdata(tables, out_dir, compact)
    raw_rows = sum(1 for t in tables for r in t["rows"] if "__raw__" in r["data"])
    unknown = sum(
        len(r["data"].get("__unknown__", []))
        for t in tables
        for r in t["rows"]
        if "__unknown__" in r["data"]
    )
    return len(tables), sum(t["rowCount"] for t in tables), raw_rows, unknown


# ---------------------------------------------------------------------------
# Lua：scripts64/scripts32 -> Lua/x64、Lua/x86
# ---------------------------------------------------------------------------


def extract_lua_bundle(
    bundle: Path, out_dir: Path, keep_prefix: bool = False, limit: int = 0
) -> Tuple[int, int]:
    """剥掉 10 字节填充头，用 UnityPy 导出 bundle 内全部 .lua.bytes。"""
    import UnityPy

    raw = bundle.read_bytes()
    if raw[:10] != b"\x00" * 10:
        print(
            f"[!] {bundle.name} 未检测到 10 字节填充头，仍按原样尝试",
            file=sys.stderr,
        )
    payload = raw[10:] if raw[:10] == b"\x00" * 10 else raw
    stripped = bundle.with_name(bundle.name + ".stripped")
    stripped.write_bytes(payload)

    env = UnityPy.load(str(stripped))
    out_dir.mkdir(parents=True, exist_ok=True)

    count = 0
    total = 0
    for path, obj in env.container.items():
        if not path.endswith(".lua.bytes"):
            continue
        if keep_prefix:
            rel = Path(path)
        elif path.startswith(LUA_ROOT):
            # assets/luabuilds/luajit2.0/<arch>/<rest> -> <rest>（架构已作为目录）
            rest = path[len(LUA_ROOT) :]
            parts = rest.split("/", 1)
            rel = Path(parts[1]) if len(parts) > 1 else Path(rest)
        else:
            rel = Path(path)
        target = out_dir / rel
        target.parent.mkdir(parents=True, exist_ok=True)
        # m_Script 是 surrogateescape 解码的 str，反向编码可无损还原原始字节
        script = obj.read().m_Script.encode("utf-8", "surrogateescape")
        target.write_bytes(script)
        count += 1
        total += len(script)
        if limit and count >= limit:
            break
    return count, total


def normalize_lua_eol(root: Path) -> int:
    """把反编译输出的 CRLF 统一成 LF，与仓库内已提交的 Lua 保持一致。"""
    fixed = 0
    for path in root.rglob("*.lua"):
        data = path.read_bytes()
        if b"\r\n" in data:
            path.write_bytes(data.replace(b"\r\n", b"\n"))
            fixed += 1
    return fixed


def decompile_lua(src_dir: Path, out_dir: Path, jobs: int) -> bool:
    """调用系统命令 luajit-decompiler 把 src_dir 反编译到 out_dir。"""
    cmd = shutil.which("luajit-decompiler")
    if not cmd:
        print(
            "[!] 未找到系统命令 luajit-decompiler，保留 LuaJIT 字节码\n"
            "    安装：cd ~/ArchPackages/luajit-decompiler-git && makepkg -i\n"
            "    或从 fork 构建：cmake -B build -S . && cmake --build build",
            file=sys.stderr,
        )
        return False

    if out_dir.exists():
        shutil.rmtree(out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    proc = subprocess.run(
        [cmd, str(src_dir), "-o", str(out_dir), "-s", "-j", str(max(1, jobs))],
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode != 0:
        tail = (proc.stderr or proc.stdout or "").strip().splitlines()[-3:]
        print(
            f"[!] 反编译失败（exit={proc.returncode}）: {' / '.join(tail)}",
            file=sys.stderr,
        )
        return False
    return True


def fetch_lua(
    out_root: Path,
    entries: List[Dict],
    bases: List[str],
    args: argparse.Namespace,
    state: Dict,
) -> Tuple[int, Dict[str, str]]:
    """下载 scripts32/scripts64，提取（默认反编译）到 out_root/Lua/<arch>。

    返回 (返回码, {架构: bundle md5})，由调用方写入状态文件。
    """
    archs = ["64", "32"] if args.arch == "all" else [args.arch]
    by_path = {e["path"]: e for e in entries}
    hashes = dict(state.get("lua") or {})
    debug_limited = args.limit > 0
    if debug_limited:
        print(f"[!] --limit {args.limit}：调试模式，只处理前 N 个脚本（不写入状态）")
    rc = 0
    tmp_root: Optional[Path] = None
    try:
        for arch in archs:
            name = LUA_BUNDLE[arch]
            arch_name = ARCH_DIR[arch]
            target_dir = out_root / "Lua" / arch_name
            source = by_path.get(name)
            if source is None:
                print(f"[!] 热更清单中没有 {name}", file=sys.stderr)
                rc = 1
                continue

            entry = dict(source)
            entry["rel_path"] = name
            if (
                not args.force
                and not debug_limited
                and hashes.get(arch) == entry["hash"]
                and target_dir.exists()
                and any(target_dir.iterdir())
            ):
                print(f"[*] Lua/{arch_name} 已是最新（md5={entry['hash']}）")
                continue

            if tmp_root is None:
                tmp_root = Path(tempfile.mkdtemp(prefix="ag_lua_"))
            print(
                f"[*] Lua bundle {name}: {entry['size'] / 1048576:.1f} MiB "
                f"md5={entry['hash']}"
            )
            dl = Downloader(
                bases=bases,
                jobs=1,
                retries=args.retries,
                verify=True,
                force=True,
                timeout=args.timeout,
                status_interval=args.status_interval,
                log_path=out_root / "download_errors.log",
            )
            if not dl.run([entry], tmp_root):
                print(f"[!] {name} 下载失败", file=sys.stderr)
                rc = 1
                continue

            bytecode_dir = tmp_root / "bytecode" / arch_name
            count, total = extract_lua_bundle(
                tmp_root / name,
                bytecode_dir,
                keep_prefix=args.keep_prefix,
                limit=args.limit,
            )
            print(
                f"[*] Lua/{arch_name}: 提取 {count} 个脚本（{total / 1048576:.1f} MiB）"
            )
            if args.keep_bytecode:
                shutil.copytree(
                    bytecode_dir,
                    out_root / "LuaBytecode" / arch_name,
                    dirs_exist_ok=True,
                )
            if args.decompile:
                if decompile_lua(bytecode_dir, target_dir, args.jobs):
                    fixed = normalize_lua_eol(target_dir)
                    written = sum(1 for _ in target_dir.rglob("*.lua"))
                    print(
                        f"[*] Lua/{arch_name}: 反编译 {written} 个脚本 -> {target_dir}"
                    )
                    if fixed:
                        print(f"[*] Lua/{arch_name}: 统一 {fixed} 个文件为 LF 行尾")
                else:
                    shutil.copytree(bytecode_dir, target_dir, dirs_exist_ok=True)
                    print(
                        f"[!] {name} 未反编译，已保留字节码 -> {target_dir}",
                        file=sys.stderr,
                    )
                    rc = 1
            else:
                shutil.copytree(bytecode_dir, target_dir, dirs_exist_ok=True)
                print(f"[*] Lua/{arch_name}: 字节码 -> {target_dir}")
            if not debug_limited:
                hashes[arch] = entry["hash"]
    finally:
        if tmp_root is not None:
            shutil.rmtree(tmp_root, ignore_errors=True)
    return rc, hashes


# ---------------------------------------------------------------------------
# Schema：il2cpp.cs -> Schema.json
# ---------------------------------------------------------------------------


class _BlockMatch:
    def __init__(self, name: str, body: str):
        self._name = name
        self._body = body

    def group(self, n):
        return self._name if n == 1 else self._body


def extract_class_blocks(src: str):
    """提取所有 `public sealed class X : IMessage<X>` 的类体。"""
    pattern = re.compile(
        r"public sealed class (\w+) : IMessage<(?:Config\.)?\1>[^{]*\{",
        re.DOTALL,
    )
    for m in pattern.finditer(src):
        j = m.end() - 1  # 指向 '{'
        depth = 0
        k = j
        while k < len(src):
            if src[k] == "{":
                depth += 1
            elif src[k] == "}":
                depth -= 1
                if depth == 0:
                    break
            k += 1
        if depth != 0:
            continue
        yield _BlockMatch(m.group(1), src[m.start() : k + 1])


def extract_enums(src: str) -> dict[str, dict[str, int]]:
    enums: dict[str, dict[str, int]] = {}
    pattern = re.compile("public enum (\\w+)[^\\{]*\\{([^}]*)\\}", re.DOTALL)
    for m in pattern.finditer(src):
        values: dict[str, int] = {}
        for vm in re.finditer(r"(\w+)\s*=\s*(-?\d+)", m.group(2)):
            values[vm.group(1)] = int(vm.group(2))
        enums[m.group(1)] = values
    return enums


def parse_class(body: str, class_name: str) -> dict:
    """从类体里取 XxxFieldNumber 常量 + 属性类型，还原出字段表。"""
    fields: list[dict] = []
    field_nums: dict[str, int] = {}
    for m in re.finditer(r"public const int (\w+)FieldNumber = (\d+);", body):
        field_nums[m.group(1)] = int(m.group(2))

    prop_types: dict[str, str] = {}
    prop_pattern = re.compile(
        r"public (?:static\s+)?([A-Za-z_][\w.<>, ]*?)\s+(\w+)\s*\{[^}]*\}",
        re.DOTALL,
    )
    for m in prop_pattern.finditer(body):
        if m.group(2) in field_nums:
            prop_types[m.group(2)] = m.group(1).strip()

    for prop, num in sorted(field_nums.items(), key=lambda x: x[1]):
        ptype = prop_types.get(prop, "?")
        repeated = False
        elem = ptype
        mrep = re.fullmatch(r"RepeatedField<(.+)>", ptype)
        if mrep:
            repeated = True
            elem = mrep.group(1)
        fields.append(
            {
                "fieldNumber": num,
                "name": prop,
                "type": ptype,
                "repeated": repeated,
                "elementType": elem if repeated else None,
            }
        )
    return {"message": class_name, "fields": fields}


# ---------------------------------------------------------------------------
# 子命令实现
# ---------------------------------------------------------------------------


def load_remote(args: argparse.Namespace) -> Tuple[Dict, Dict, List[Dict], List[str]]:
    """取热更版本 + 资源清单，返回 (info, manifest, entries, bases)。"""
    print("[*] 获取热更新版本信息 ...")
    info = fetch_hot_version(args.api, args.timeout)
    print(
        f"[*] 版本 {info.get('versionName')} "
        f"(app={info.get('matchedAppVersion')}, res={info.get('version')})"
    )
    print(f"[*] 资源 CDN: {info['downloadUrl']}")
    print(f"[*] 清单文件: {info['assethash']}")

    print("[*] 下载资源清单 ...")
    manifest = fetch_manifest(info, args.timeout)
    entries = parse_entries(manifest)
    print(f"[*] 清单条目: {len(entries)}")
    bases = [b for b in info["downloadUrl"].split(";") if b]
    return info, manifest, entries, bases


def cmd_assets(args: argparse.Namespace) -> int:
    """资产全量下载 / 增量更新。"""
    output = Path(args.output)
    output.mkdir(parents=True, exist_ok=True)
    assets_dir = output / "Assets"
    updates_dir = output / "Updates"
    state_path = output / "updater_state.json"

    info, manifest, entries_all, bases = load_remote(args)

    only = [x.strip().lower() for x in args.only.split(",") if x.strip()]
    want_voice = "voice" in only
    only_main = [x for x in only if x != "voice"]
    entries = select_entries(entries_all, manifest, only_main) if only_main else []
    voice_entries: List[Dict] = []
    voice_meta: Dict = {}

    if want_voice:
        try:
            voice_entries, voice_meta = fetch_voice_entries(
                bases,
                [x.strip().lower() for x in args.voice_lang.split(",") if x.strip()],
                info.get("matchedAppVersion"),
                info.get("version"),
                args.timeout,
            )
            entries = entries + voice_entries
        except Exception as exc:  # noqa: BLE001
            if only == ["voice"]:
                raise
            print(f"[!] 语音包获取失败（继续主资源下载）: {exc}", file=sys.stderr)

    if args.limit > 0:
        entries = entries[: args.limit]

    total_size = sum(e["size"] for e in entries)
    print(f"[*] 选中条目: {len(entries)}，预计 {total_size / 1073741824:.2f} GiB")

    write_artifact_files(output, info, manifest, entries, bases)
    if voice_entries:
        write_voice_artifacts(output, voice_entries, voice_meta, bases)
    print("[*] 已写出 hot_version.json / assethash.json / download_urls.txt")

    if args.list_only:
        print("[*] --list-only，不执行下载。")
        return 0

    state = load_state(state_path)
    full_complete = (
        bool(state.get("full_complete"))
        and state.get("entry_count") == len(entries)
        and assets_dir.exists()
    )
    first_run = args.force_full or not full_complete
    if first_run:
        target_dir = assets_dir
        mode_name = "首次全量下载到 Assets"
        force_download = args.force
        old_map = {} if args.force_full else state.get("entries", {})
        download_entries = [
            e for e in entries if old_map.get(entry_key(e)) != e["hash"]
        ]
        if not download_entries:
            print("[*] Assets 已完整，标记为已完成。")
            save_state(state_path, info, entries, voice_meta, full_complete=True)
            return 0
        diff = download_entries
    else:
        old_map = state.get("entries", {})
        diff = [e for e in entries if old_map.get(entry_key(e)) != e["hash"]]
        target_dir = updates_dir
        mode_name = f"检查更新（{len(diff)} 个变更）"
        force_download = True  # Updates 里同路径旧文件直接覆盖
        download_entries = diff
        if not diff:
            print("[*] 没有检测到更新。")
            save_state(state_path, info, entries, voice_meta, full_complete=True)
            return 0

    print(f"[*] {mode_name} -> {target_dir}")
    target_dir.mkdir(parents=True, exist_ok=True)
    dl = Downloader(
        bases=bases,
        jobs=args.jobs,
        retries=args.retries,
        verify=args.verify,
        force=force_download,
        timeout=args.timeout,
        status_interval=args.status_interval,
        log_path=output / "download_errors.log",
    )
    dl.run(download_entries, target_dir)

    merged = dict(old_map)
    for e in diff:
        if e["hash"] in dl.ok_hashes:
            merged[entry_key(e)] = e["hash"]
    saved_entries = [{"path": p, "hash": h} for p, h in merged.items()]
    save_state(
        state_path,
        info,
        saved_entries,
        voice_meta,
        full_complete=(not dl.failures) if first_run else True,
    )

    if dl.failures:
        print(f"[!] 失败 {len(dl.failures)} 个文件：", file=sys.stderr)
        for p, err in dl.failures[:20]:
            print(f"    {p}: {err}", file=sys.stderr)
        return 1
    done_count = sum(1 for e in download_entries if e["hash"] in dl.ok_hashes)
    print(f"[*] 完成：{done_count}/{len(download_entries)} 个文件已就绪。")
    return 0


def cmd_painting(args: argparse.Namespace) -> int:
    """立绘模式：只下载 textureconfig/character/portrait* 到 Illustration/。"""
    output = Path(args.output)
    output.mkdir(parents=True, exist_ok=True)

    info, manifest, entries_all, bases = load_remote(args)
    prefixes = (
        "textureconfig/character/portrait/",
        "textureconfig/character/portraitdlc/",
    )
    entries = [e for e in entries_all if e["path"].startswith(prefixes)]
    for e in entries:
        e["rel_path"] = e["path"][len("textureconfig/character/") :]
    if args.limit > 0:
        entries = entries[: args.limit]

    total_size = sum(e["size"] for e in entries)
    print(f"[*] 选中立绘: {len(entries)}，预计 {total_size / 1048576:.1f} MiB")
    write_artifact_files(output, info, manifest, entries, bases)
    if args.list_only:
        print("[*] --list-only，不执行下载。")
        return 0

    target_dir = output / "Illustration"
    print(f"[*] 立绘模式 -> {target_dir}")
    target_dir.mkdir(parents=True, exist_ok=True)
    dl = Downloader(
        bases=bases,
        jobs=args.jobs,
        retries=args.retries,
        verify=args.verify,
        force=args.force,
        timeout=args.timeout,
        status_interval=args.status_interval,
        log_path=output / "download_errors.log",
    )
    dl.run(entries, target_dir)
    if dl.failures:
        print(f"[!] 立绘下载失败 {len(dl.failures)} 个文件：", file=sys.stderr)
        for p, err in dl.failures[:20]:
            print(f"    {p}: {err}", file=sys.stderr)
        return 1
    print(f"[*] 立绘完成：{len(entries)} 个文件。")
    return 0


def cmd_masterdata(args: argparse.Namespace) -> int:
    """数据表模式：只下载数据表资产（config.ys）与 Lua，解析到 MasterData/。"""
    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)
    state_path = out_dir / "masterdata_state.json"
    state = load_state(state_path)

    info, _manifest, entries_all, bases = load_remote(args)

    # 1) 数据表资产（config.ys），不碰整包资源
    state_entries = dict(state.get("entries") or {})
    table_entries = [e for e in entries_all if e["path"] in TABLE_ASSETS]
    if not table_entries:
        raise RuntimeError(
            f"热更清单中没有数据表资产（{'、'.join(TABLE_ASSETS)}）"
        )
    todo: List[Dict] = []
    for e in table_entries:
        if (
            not args.force
            and state_entries.get(e["path"]) == e["hash"]
            and local_path_for(e, out_dir).exists()
        ):
            print(f"[*] 数据表资产已是最新: {e['path']}（md5={e['hash']}）")
            continue
        todo.append(e)
    if todo:
        size = sum(e["size"] for e in todo)
        print(f"[*] 下载数据表资产 {len(todo)} 个（{size / 1048576:.1f} MiB）-> {out_dir}")
        dl = Downloader(
            bases=bases,
            jobs=max(1, min(args.jobs, len(todo))),
            retries=args.retries,
            verify=True,
            force=True,
            timeout=args.timeout,
            status_interval=args.status_interval,
            log_path=out_dir / "download_errors.log",
        )
        if not dl.run(todo, out_dir):
            print(f"[!] 数据表资产下载失败 {len(dl.failures)} 个", file=sys.stderr)
            for p, err in dl.failures[:20]:
                print(f"    {p}: {err}", file=sys.stderr)
            return 1
        for e in todo:
            state_entries[e["path"]] = e["hash"]

    # 2) 解析 -> MasterData/*.json
    tables, rows, raw_rows, unknown = parse_masterdata(
        out_dir, Path(args.schema), args.compact
    )
    print(
        f"[*] 数据表: {tables} 表 / {rows} 行，未解码行 {raw_rows}，"
        f"未知字段 {unknown}"
    )
    print(f"[*] 数据表 JSON -> {out_dir}")

    # 3) Lua（默认下载 scripts64/scripts32 并反编译到 MasterData/Lua）
    rc = 0
    if args.no_lua:
        print("[*] --no-lua，跳过 Lua。")
    else:
        rc, lua_hashes = fetch_lua(out_dir, entries_all, bases, args, state)
        state["lua"] = lua_hashes

    state["hot_version"] = info
    state["entries"] = state_entries
    state["masterdata"] = {
        "tables": tables,
        "rows": rows,
        "raw_rows": raw_rows,
        "unknown_fields": unknown,
        "updated": time.strftime("%Y-%m-%d %H:%M:%S"),
    }
    state_path.write_text(
        json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(f"[*] 状态 -> {state_path}")
    return rc


def cmd_lua(args: argparse.Namespace) -> int:
    """只下载并提取（可选反编译）Lua 脚本。"""
    out_dir = Path(args.out)
    out_dir.mkdir(parents=True, exist_ok=True)
    state_path = out_dir / "masterdata_state.json"
    state = load_state(state_path)

    info, _manifest, entries_all, bases = load_remote(args)
    rc, lua_hashes = fetch_lua(out_dir, entries_all, bases, args, state)
    state["hot_version"] = info
    state["lua"] = lua_hashes
    state_path.write_text(
        json.dumps(state, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(f"[*] 状态 -> {state_path}")
    return rc


def cmd_schema(args: argparse.Namespace) -> int:
    """从 il2cpp.cs 重新生成数据表字段映射 Schema.json。"""
    cs = Path(args.cs)
    if not cs.exists():
        print(
            f"[!] 未找到 {cs}（il2cpp.cs 由 IL 还原流程生成，"
            "可用 --cs 指定路径）",
            file=sys.stderr,
        )
        return 2

    print(f"[*] 解析 {cs} ...")
    src = cs.read_text(encoding="utf-8", errors="replace")
    enums = extract_enums(src)
    messages: List[Dict] = []
    for m in extract_class_blocks(src):
        parsed = parse_class(m.group(0), m.group(1))
        if parsed["fields"]:
            messages.append(parsed)

    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        json.dumps(
            {
                "source": str(cs.resolve()),
                "messageCount": len(messages),
                "enumCount": len(enums),
                "messages": messages,
                "enums": enums,
            },
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    print(f"[*] messages={len(messages)} enums={len(enums)} -> {out}")
    return 0


def cmd_status(args: argparse.Namespace) -> int:
    """查看远端版本与本地状态（不下载）。"""
    asset_out = Path(args.output)
    master_out = Path(args.out)

    print(f"[*] {GAME_TITLE} 状态")
    try:
        info = fetch_hot_version(args.api, args.timeout)
        print(
            f"    远端版本: {info.get('versionName')} "
            f"(app={info.get('matchedAppVersion')}, res={info.get('version')})"
        )
    except Exception as exc:  # noqa: BLE001
        print(f"    远端版本: 获取失败（{exc}）")

    state = load_state(asset_out / "updater_state.json")
    if state:
        hot = state.get("hot_version") or {}
        print(
            f"    本地资产: {hot.get('versionName')} "
            f"条目 {state.get('entry_count')} "
            f"全量完成={bool(state.get('full_complete'))} -> {asset_out}"
        )
        for name in ("Assets", "Updates"):
            d = asset_out / name
            if d.exists():
                files = [p for p in d.rglob("*") if p.is_file()]
                size = sum(p.stat().st_size for p in files)
                print(f"      {name}/: {len(files)} 个文件（{size / 1073741824:.2f} GiB）")
    else:
        print(f"    本地资产: 未下载（{asset_out / 'updater_state.json'}）")

    if not master_out.exists():
        print(f"    数据表: 未生成（{master_out}）")
        return 0

    skip = {"masterdata_index.json", "masterdata_state.json"}
    tables = [p for p in master_out.glob("*.json") if p.name not in skip]
    print(f"    数据表: {len(tables)} 张表 -> {master_out}")
    ys = master_out / "config.ys"
    if ys.exists():
        print(f"      config.ys: {ys.stat().st_size / 1048576:.1f} MiB")
    md_state = load_state(master_out / "masterdata_state.json")
    if md_state:
        hot = md_state.get("hot_version") or {}
        md = md_state.get("masterdata") or {}
        print(
            f"      状态版本: {hot.get('versionName')} "
            f"更新于 {md.get('updated', '-')}"
        )
    for arch_name in ("x64", "x86"):
        d = master_out / "Lua" / arch_name
        if not d.exists():
            continue
        lua_files = list(d.rglob("*.lua"))
        byte_files = list(d.rglob("*.lua.bytes"))
        files = lua_files or byte_files
        if not files:
            continue
        size = sum(p.stat().st_size for p in files)
        kind = "反编译" if lua_files else "字节码"
        print(
            f"      Lua/{arch_name}: {len(files)} 个脚本"
            f"（{size / 1048576:.1f} MiB，{kind}）"
        )
    return 0


def cmd_all(args: argparse.Namespace) -> int:
    """assets + masterdata。"""
    rc = cmd_assets(args)
    if rc:
        return rc
    return cmd_masterdata(args)


# ---------------------------------------------------------------------------
# 命令行
# ---------------------------------------------------------------------------


def add_lua_args(
    parser: argparse.ArgumentParser, out_help: str, limit_help: str = ""
) -> None:
    """masterdata / lua / all 共用的 Lua 相关参数。"""
    parser.add_argument("--out", default=str(DEFAULT_MASTER_DIR), help=out_help)
    parser.add_argument(
        "--arch",
        default="all",
        choices=("all", "32", "64"),
        help="Lua 架构：all=64+32（默认），32 / 64 只处理单个",
    )
    parser.add_argument(
        "--no-decompile",
        dest="decompile",
        action="store_false",
        help="不调用 luajit-decompiler，只保留 LuaJIT 字节码",
    )
    parser.add_argument(
        "--keep-bytecode",
        action="store_true",
        help="反编译后额外保留字节码到 LuaBytecode/",
    )
    parser.add_argument(
        "--keep-prefix",
        action="store_true",
        help="保留 bundle 内部完整路径（assets/luabuilds/...）",
    )
    if limit_help:
        parser.add_argument("--limit", type=int, default=0, help=limit_help)
    parser.set_defaults(decompile=True)


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--api", default=DEFAULT_API, help="热更新版本接口")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发下载数")
    shared.add_argument("--retries", type=int, default=3, help="每个文件重试次数")
    shared.add_argument("--timeout", type=int, default=30, help="单请求超时秒数")
    shared.add_argument(
        "--status-interval",
        type=int,
        default=10,
        help="无文件完成时打印一次进度的间隔秒数",
    )
    shared.add_argument("--force", action="store_true", help="忽略本地状态重新下载")

    parser = argparse.ArgumentParser(
        prog="AetherGazer.py",
        description=f"{GAME_TITLE} PC 资源工具：资产下载 / 数据表 / Lua / 立绘",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="示例:\n"
        "  python AetherGazer.py assets --output ./AetherGazer --jobs 8\n"
        "  python AetherGazer.py masterdata\n"
        "  python AetherGazer.py masterdata --arch 64 --no-lua\n"
        "  python AetherGazer.py lua --arch 64 --no-decompile\n"
        "  python AetherGazer.py painting --limit 20\n"
        "  python AetherGazer.py status\n",
    )
    sub = parser.add_subparsers(dest="cmd", required=True)

    assets = sub.add_parser(
        "assets",
        parents=[shared],
        help="资产全量下载 / 增量更新 -> Assets/、Updates/",
    )
    assets.add_argument(
        "--output",
        default=DEFAULT_ASSET_OUT,
        help=f"输出根目录（默认 {DEFAULT_ASSET_OUT}）",
    )
    assets.add_argument(
        "--only",
        default="all,voice",
        help="下载范围: all / single / voice / lua / newbie / advance / permanent / 具体包名(逗号分隔)",
    )
    assets.add_argument(
        "--voice-lang",
        default="zh,ja",
        help="语音包语言缩写，逗号分隔，例如 zh / ja / zh,ja",
    )
    assets.add_argument("--verify", action="store_true", help="下载后做 MD5 校验")
    assets.add_argument(
        "--force-full",
        action="store_true",
        help="忽略已有状态，重新全量下载到 Assets",
    )
    assets.add_argument(
        "--list-only",
        action="store_true",
        help="只生成清单和下载链接，不下载文件",
    )
    assets.add_argument(
        "--limit", type=int, default=0, help="只处理前 N 条资源（调试用）"
    )

    masterdata = sub.add_parser(
        "masterdata",
        aliases=["data"],
        parents=[shared],
        help="数据表模式：只下载 config.ys 与 Lua，解析到 MasterData/",
    )
    add_lua_args(
        masterdata,
        "MasterData 输出目录（默认 ./MasterData）",
        "每个架构只提取前 N 个 Lua（调试用）",
    )
    masterdata.add_argument(
        "--no-lua", action="store_true", help="只解析数据表，不下载 Lua"
    )
    masterdata.add_argument("--compact", action="store_true", help="紧凑 JSON 输出")
    masterdata.add_argument(
        "--schema", default=str(DEFAULT_SCHEMA), help="字段映射 Schema.json 路径"
    )

    lua = sub.add_parser(
        "lua",
        parents=[shared],
        help="只下载并提取 Lua（scripts64 -> Lua/x64，scripts32 -> Lua/x86）",
    )
    add_lua_args(
        lua,
        "输出根目录，Lua 在其下（默认 ./MasterData）",
        "每个架构只提取前 N 个 Lua（调试用）",
    )

    painting = sub.add_parser(
        "painting",
        aliases=["illustration"],
        parents=[shared],
        help="立绘模式：只下载 textureconfig/character/portrait* -> Illustration/",
    )
    painting.add_argument(
        "--output",
        default=DEFAULT_ASSET_OUT,
        help=f"输出根目录（默认 {DEFAULT_ASSET_OUT}）",
    )
    painting.add_argument("--verify", action="store_true", help="下载后做 MD5 校验")
    painting.add_argument(
        "--list-only",
        action="store_true",
        help="只生成清单和下载链接，不下载文件",
    )
    painting.add_argument(
        "--limit", type=int, default=0, help="只下载前 N 个立绘（调试用）"
    )

    schema = sub.add_parser("schema", help="从 il2cpp.cs 重新生成数据表字段映射")
    schema.add_argument(
        "--cs", default="cs/il2cpp.cs", help="il2cpp.cs 路径（默认 cs/il2cpp.cs）"
    )
    schema.add_argument(
        "--out", default=str(DEFAULT_SCHEMA), help=f"输出（默认 {DEFAULT_SCHEMA}）"
    )

    status = sub.add_parser(
        "status", parents=[shared], help="查看远端版本与本地状态（不下载）"
    )
    status.add_argument(
        "--output", default=DEFAULT_ASSET_OUT, help="资产输出根目录"
    )
    status.add_argument("--out", default=str(DEFAULT_MASTER_DIR), help="MasterData 目录")

    all_cmd = sub.add_parser(
        "all", parents=[shared], help="assets + masterdata"
    )
    all_cmd.add_argument("--output", default=DEFAULT_ASSET_OUT, help="资产输出根目录")
    all_cmd.add_argument("--only", default="all,voice", help="assets 下载范围")
    all_cmd.add_argument("--voice-lang", default="zh,ja", help="语音包语言缩写")
    all_cmd.add_argument("--verify", action="store_true", help="下载后做 MD5 校验")
    all_cmd.add_argument(
        "--force-full", action="store_true", help="忽略已有状态重新全量下载"
    )
    all_cmd.add_argument(
        "--no-lua", action="store_true", help="数据表模式不下载 Lua"
    )
    all_cmd.add_argument("--compact", action="store_true", help="紧凑 JSON 输出")
    all_cmd.add_argument("--schema", default=str(DEFAULT_SCHEMA), help="字段映射路径")
    all_cmd.add_argument(
        "--limit",
        type=int,
        default=0,
        help="调试用：assets 只处理前 N 条资源 / Lua 每个架构只提取前 N 个",
    )
    add_lua_args(all_cmd, "MasterData 输出目录（默认 ./MasterData）")
    all_cmd.add_argument(
        "--list-only", action="store_true", help="只生成清单和下载链接"
    )
    return parser


def main(argv: List[str] | None = None) -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(line_buffering=True)

    args = build_parser().parse_args(argv)
    handlers = {
        "assets": cmd_assets,
        "masterdata": cmd_masterdata,
        "data": cmd_masterdata,
        "lua": cmd_lua,
        "painting": cmd_painting,
        "illustration": cmd_painting,
        "schema": cmd_schema,
        "status": cmd_status,
        "all": cmd_all,
    }
    try:
        return handlers[args.cmd](args)
    except RuntimeError as exc:
        print(f"[!] {exc}", file=sys.stderr)
        return 1
    except KeyboardInterrupt:
        print("\n[!] 已中断", file=sys.stderr)
        return 130
    except Exception:  # noqa: BLE001
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(main())
