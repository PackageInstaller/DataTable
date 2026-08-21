"""
锚点降临 CDN 资源下载 / Lua 解密

用法:
    python3 AnchorPanic.py assets            # 全量下载到 Assets/
    python3 AnchorPanic.py masterdata        # 只下载 Lua 数据并解密到 MasterData/
    python3 AnchorPanic.py portrait          # 只下载 herorecord 立绘并导出到 Painting/
    python3 AnchorPanic.py decrypt <目录>    # 对已有目录中的 .lua 原地解密
    python3 AnchorPanic.py list              # 打印当前版本文件清单统计

版本清单 (.b) 是 .NET BinaryFormatter 序列化的 Dictionary，本脚本内置了一个
纯 Python 的 NRBF 解码器，不依赖 mono/nrbf 等外部库。
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import struct
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from urllib.parse import quote

import requests
from Crypto.Cipher import DES
from Crypto.Util.Padding import unpad
from rich.console import Console
from rich.progress import (
    BarColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
)

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
MANIFEST_PATH = MASTER_DIR / ".versions.json"
PORTRAIT_DIR = SCRIPT_DIR / "Painting"
PORTRAIT_LUA_FILES = [
    "LuaScripts/ref/zh/hero_fashion_data.lua",
    "LuaScripts/ref/zh/hero_data.lua",
    "LuaScripts/ref/zh/language.lua",
    "LuaScripts/ref/zh/harmony/hero_fashion_data.lua",
    "LuaScripts/ref/zh/harmony/hero_data.lua",
]

CDN_BASE = "http://res-laoqb.leiyangame.com/android/laoqb_r/"
USER_AGENT = "Mozilla/5.0"
DEFAULT_JOBS = 16
IV = bytes.fromhex("6F9732CD7BDEB92D")

console = Console()


class NRBFError(Exception):
    pass


PRIMITIVE, STRING, OBJECT, SYSTEMCLASS, CLASS, OBJECTARRAY, STRINGARRAY, PRIMITIVEARRAY = range(8)

PT_BOOLEAN, PT_BYTE, PT_CHAR, PT_DECIMAL, PT_DOUBLE = 1, 2, 3, 5, 6
PT_INT16, PT_INT32, PT_INT64, PT_SBYTE, PT_SINGLE = 7, 8, 9, 10, 11
PT_TIMESPAN, PT_DATETIME, PT_UINT16, PT_UINT32, PT_UINT64 = 12, 13, 14, 15, 16


def _read_lenpref(buf: bytes, off: int):
    n = 0
    shift = 0
    while True:
        b = buf[off]
        off += 1
        n |= (b & 0x7F) << shift
        if not (b & 0x80):
            break
        shift += 7
    s = buf[off:off + n].decode("utf-8", "replace")
    return s, off + n


class NRBFReader:
    def __init__(self, data: bytes):
        self.d = data
        self.off = 0
        self.objects: dict = {}
        self.libraries: dict = {}
        self.classdefs: dict = {}

    def u1(self) -> int:
        v = self.d[self.off]
        self.off += 1
        return v

    def i4(self) -> int:
        v = struct.unpack_from("<i", self.d, self.off)[0]
        self.off += 4
        return v

    def lpstr(self) -> str:
        s, self.off = _read_lenpref(self.d, self.off)
        return s

    def parse(self):
        if self.u1() != 0:
            raise NRBFError("不是 BinaryFormatter 流")
        self.i4()
        self.i4()
        self.i4()
        self.i4()
        while self.off < len(self.d):
            rec = self.u1()
            if rec == 11:
                break
            elif rec == 12:
                lib = self.i4()
                self.libraries[lib] = self.lpstr()
            elif rec == 1:
                self.read_class_with_id()
            elif rec in (4, 5):
                self.read_map(rec)
            elif rec == 6:
                self.read_string_record()
            elif rec == 8:
                self.read_primitive_typed()
            elif rec == 9:
                self.i4()
            elif rec == 10:
                pass
            elif rec == 13:
                self.u1()
            elif rec == 14:
                self.i4()
            elif rec == 15:
                self.read_array_primitive()
            elif rec == 16:
                self.read_array_object()
            elif rec == 17:
                self.read_array_string()
            elif rec == 7:
                self.read_binary_array()
            else:
                raise NRBFError(f"未处理的记录 {rec} @ {self.off - 1:#x}")
        return self.resolve(self.objects.get(1))

    def read_map(self, rec: int):
        oid = self.i4()
        name = self.lpstr()
        count = self.i4()
        names = [self.lpstr() for _ in range(count)]
        bts = [self.u1() for _ in range(count)]
        extra = []
        for bt in bts:
            if bt == PRIMITIVE:
                extra.append(("prim", self.u1()))
            elif bt == STRING:
                extra.append(("string",))
            elif bt == OBJECT:
                extra.append(("object",))
            elif bt == SYSTEMCLASS:
                extra.append(("sysclass", self.lpstr()))
            elif bt == CLASS:
                extra.append(("class", self.lpstr(), self.i4()))
            elif bt == OBJECTARRAY:
                extra.append(("objarr",))
            elif bt == STRINGARRAY:
                extra.append(("strarr",))
            elif bt == PRIMITIVEARRAY:
                extra.append(("primarr", self.u1()))
            else:
                raise NRBFError(f"未知 BinaryType {bt}")
        if rec == 5:
            self.i4()
        self.classdefs[oid] = (name, names, extra)
        values = [self.read_value(info) for info in extra]
        obj = dict(zip(names, values))
        self.objects[oid] = obj
        return obj

    def read_class_with_id(self):
        oid = self.i4()
        mid = self.i4()
        name, names, extra = self.classdefs[mid]
        values = [self.read_value(info) for info in extra]
        obj = dict(zip(names, values))
        self.objects[oid] = obj
        return obj

    def read_string_record(self):
        oid = self.i4()
        s = self.lpstr()
        self.objects[oid] = s
        return s

    def read_primitive_typed(self):
        return self.read_primitive(self.u1())

    def read_primitive(self, tc: int):
        if tc == PT_BOOLEAN:
            return self.u1() != 0
        if tc == PT_BYTE:
            return self.u1()
        if tc == PT_CHAR:
            v = struct.unpack_from("<H", self.d, self.off)[0]
            self.off += 2
            return chr(v)
        if tc == PT_DECIMAL:
            return self.lpstr()
        if tc == PT_DOUBLE:
            v = struct.unpack_from("<d", self.d, self.off)[0]
            self.off += 8
            return v
        if tc == PT_INT16:
            v = struct.unpack_from("<h", self.d, self.off)[0]
            self.off += 2
            return v
        if tc == PT_INT32:
            return self.i4()
        if tc == PT_INT64:
            v = struct.unpack_from("<q", self.d, self.off)[0]
            self.off += 8
            return v
        if tc == PT_SBYTE:
            v = struct.unpack_from("<b", self.d, self.off)[0]
            self.off += 1
            return v
        if tc == PT_SINGLE:
            v = struct.unpack_from("<f", self.d, self.off)[0]
            self.off += 4
            return v
        if tc in (PT_TIMESPAN, PT_DATETIME):
            v = struct.unpack_from("<q", self.d, self.off)[0]
            self.off += 8
            return v
        if tc == PT_UINT16:
            v = struct.unpack_from("<H", self.d, self.off)[0]
            self.off += 2
            return v
        if tc == PT_UINT32:
            v = struct.unpack_from("<I", self.d, self.off)[0]
            self.off += 4
            return v
        if tc == PT_UINT64:
            v = struct.unpack_from("<Q", self.d, self.off)[0]
            self.off += 8
            return v
        raise NRBFError(f"原始类型 {tc}")

    def read_value(self, info):
        if info[0] == "prim":
            return self.read_primitive(info[1])
        return self.read_inline_value()

    def read_inline_value(self):
        tag = self.u1()
        if tag == 8:
            return self.read_primitive_typed()
        if tag == 6:
            return self.read_string_record()
        if tag == 9:
            return ("REF", self.i4())
        if tag == 10:
            return None
        if tag == 13:
            self.u1()
            return None
        if tag == 14:
            self.i4()
            return None
        if tag in (4, 5):
            return self.read_map(tag)
        if tag == 15:
            return self.read_array_primitive()
        if tag == 16:
            return self.read_array_object()
        if tag == 17:
            return self.read_array_string()
        if tag == 7:
            return self.read_binary_array()
        if tag == 1:
            return self.read_class_with_id()
        if tag == 12:
            lib = self.i4()
            self.libraries[lib] = self.lpstr()
            return self.read_inline_value()
        raise NRBFError(f"内联记录 {tag} @ {self.off - 1:#x}")

    def read_array_primitive(self):
        oid = self.i4()
        length = self.i4()
        tc = self.u1()
        vals = [self.read_primitive(tc) for _ in range(length)]
        self.objects[oid] = vals
        return vals

    def read_array_elements(self, count: int):
        vals = []
        i = 0
        while i < count:
            tag = self.u1()
            if tag == 10:
                vals.append(None)
                i += 1
            elif tag == 13:
                n = self.u1()
                vals.extend([None] * n)
                i += n
            elif tag == 14:
                n = self.i4()
                vals.extend([None] * n)
                i += n
            else:
                self.off -= 1
                vals.append(self.read_inline_value())
                i += 1
        return vals

    def read_array_object(self):
        oid = self.i4()
        length = self.i4()
        vals = self.read_array_elements(length)
        self.objects[oid] = vals
        return vals

    def read_array_string(self):
        oid = self.i4()
        length = self.i4()
        vals = self.read_array_elements(length)
        self.objects[oid] = vals
        return vals

    def read_binary_array(self):
        oid = self.i4()
        arrtype = self.u1()
        rank = self.i4()
        lengths = [self.i4() for _ in range(rank)]
        if arrtype in (3, 4, 5):
            for _ in range(rank):
                self.i4()
        bt = self.u1()
        total = 1
        for n in lengths:
            total *= n
        if bt == PRIMITIVE:
            tc = self.u1()
            vals = [self.read_primitive(tc) for _ in range(total)]
        else:
            if bt == SYSTEMCLASS:
                self.lpstr()
            elif bt == CLASS:
                self.lpstr()
                self.i4()
            elif bt == PRIMITIVEARRAY:
                self.u1()
            vals = self.read_array_elements(total)
        self.objects[oid] = vals
        return vals

    def resolve(self, v, path=()):
        if isinstance(v, tuple) and len(v) == 2 and v[0] == "REF":
            ref = v[1]
            if ref not in self.objects or ref in path:
                return v
            return self.resolve(self.objects[ref], path + (ref,))
        if isinstance(v, dict):
            return {k: self.resolve(x, path) for k, x in v.items()}
        if isinstance(v, list):
            return [self.resolve(x, path) for x in v]
        return v


def decode_nrbf(data: bytes):
    return NRBFReader(data).parse()


def get_des_key() -> bytes:
    md5_hasher = hashlib.md5()
    md5_hasher.update("qdiazawh".encode("utf-8"))
    return md5_hasher.hexdigest()[-8:].encode("utf-8")


def decrypt_bytes(data: bytes) -> bytes:
    return unpad(
        DES.new(get_des_key(), DES.MODE_CBC, IV).decrypt(data),
        DES.block_size,
    )


def decrypt_file_inplace(path: Path) -> None:
    data = path.read_bytes()
    path.write_bytes(decrypt_bytes(data))



_thread_local = threading.local()


def get_session() -> requests.Session:
    session = getattr(_thread_local, "session", None)
    if session is None:
        session = requests.Session()
        session.headers["User-Agent"] = USER_AGENT
        _thread_local.session = session
    return session


def fetch_cdn_entries(session: requests.Session):
    now = quote(time.strftime("%Y/%m/%d %H:%M:%S"), safe="")
    version = session.get(
        f"{CDN_BASE}version/version.json?timestamp={now}", timeout=30
    ).json()
    md5 = version["versionFileListMd5"]
    file_name = version["fileListAppendHashNameKey"]
    url = f"{CDN_BASE}version/{file_name}?v={md5}"
    raw = session.get(url, timeout=60).content
    if len(raw) != int(version["versionFileListSize"]):
        raise RuntimeError("VersionFileList 大小与 version.json 不一致")
    root = decode_nrbf(raw)
    entries = []
    for pair in root["KeyValuePairs"]:
        entry = dict(pair["value"])
        entry["Name"] = pair["key"]
        entries.append(entry)
    return version, entries


def make_cdn_url(name: str, entry: dict) -> str:
    md5 = entry["FileMd5"]
    root, ext = os.path.splitext(name)
    url_name = f"{root}(HASH-{md5}){ext}" if ext else f"{name}(HASH-{md5})"
    return f"{CDN_BASE}{url_name}?v={entry['CheckMd5']}"


def safe_rel_path(name: str) -> Path:
    p = Path(name)
    if p.is_absolute() or ".." in p.parts:
        raise ValueError(f"非法路径: {name}")
    return p


def file_md5(path: Path) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def download_to_file(
    url: str,
    dest: Path,
    expect_size: int,
    expect_md5: str | None,
    retries: int = 5,
) -> int:
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_name(dest.name + ".part")
    for attempt in range(retries):
        try:
            with get_session().get(url, stream=True, timeout=60) as resp:
                resp.raise_for_status()
                hasher = hashlib.md5()
                total = 0
                with open(tmp, "wb") as f:
                    for chunk in resp.iter_content(1 << 16):
                        f.write(chunk)
                        hasher.update(chunk)
                        total += len(chunk)
            if expect_size and total != expect_size:
                raise ValueError(f"大小不符 {total} != {expect_size}")
            if expect_md5 and hasher.hexdigest() != expect_md5:
                raise ValueError(f"MD5 不符 {hasher.hexdigest()} != {expect_md5}")
            os.replace(tmp, dest)
            return total
        except Exception:
            tmp.unlink(missing_ok=True)
            if attempt == retries - 1:
                raise
            time.sleep(min(2 ** attempt, 8))
    raise RuntimeError("不可达")


def download_bytes(
    url: str,
    expect_size: int,
    expect_md5: str,
    retries: int = 5,
) -> bytes:
    for attempt in range(retries):
        try:
            resp = get_session().get(url, timeout=60)
            resp.raise_for_status()
            data = resp.content
            if len(data) != expect_size:
                raise ValueError(f"大小不符 {len(data)} != {expect_size}")
            if hashlib.md5(data).hexdigest() != expect_md5:
                raise ValueError("MD5 不符")
            return data
        except Exception:
            if attempt == retries - 1:
                raise
            time.sleep(min(2 ** attempt, 8))
    raise RuntimeError("不可达")


class LuaTableParser:
    """解析游戏导出的 Lua 配置表（local x = { ... } / return x）。"""

    def __init__(self, text: str):
        self.s = text
        self.i = 0
        self.n = len(text)

    def parse(self):
        self._skip()
        brace = self.s.find("{", self.i)
        if brace == -1:
            return {}
        self.i = brace
        return self._table()

    def _skip(self):
        while self.i < self.n:
            c = self.s[self.i]
            if c.isspace():
                self.i += 1
            elif c == "-" and self.s.startswith("--", self.i):
                e = self.s.find("\n", self.i)
                self.i = self.n if e == -1 else e + 1
            else:
                break

    def _table(self):
        self._skip()
        if self.s[self.i] != "{":
            raise ValueError(f"expected {{ at {self.i}")
        self.i += 1
        out = {}
        idx = 1
        while True:
            self._skip()
            if self.i >= self.n:
                raise ValueError("未闭合的表")
            if self.s[self.i] == "}":
                self.i += 1
                return out
            if self.s[self.i] == "[":
                self.i += 1
                self._skip()
                if self.s[self.i] == '"':
                    key = self._string()
                else:
                    key = self._number()
                self._skip()
                if self.s[self.i] != "]":
                    raise ValueError(f"expected ] at {self.i}")
                self.i += 1
                self._skip()
                if self.s[self.i] != "=":
                    raise ValueError(f"expected = at {self.i}")
                self.i += 1
            else:
                m = re.match(r"[A-Za-z_][A-Za-z0-9_]*", self.s[self.i:])
                if m:
                    nxt = self.i + m.end()
                    if nxt < self.n and self.s[nxt] == "=":
                        key = m.group()
                        self.i = nxt + 1
                    else:
                        key = idx
                        idx += 1
                else:
                    key = idx
                    idx += 1
            self._skip()
            out[key] = self._value()
            self._skip()
            if self.i < self.n and self.s[self.i] == ",":
                self.i += 1

    def _value(self):
        self._skip()
        c = self.s[self.i]
        if c == "{":
            return self._table()
        if c == '"':
            return self._string()
        m = re.match(r"-?\d+(?:\.\d+)?", self.s[self.i:])
        if m:
            t = m.group()
            self.i += len(t)
            return int(t) if "." not in t else float(t)
        m = re.match(r"true|false|nil", self.s[self.i:])
        if m:
            t = m.group()
            self.i += len(t)
            return {"true": True, "false": False, "nil": None}[t]
        raise ValueError(f"无法解析的值 @ {self.i}: {self.s[self.i:self.i + 20]!r}")

    def _string(self):
        if self.s[self.i] != '"':
            raise ValueError(f"expected string at {self.i}")
        self.i += 1
        out = []
        escapes = {"n": "\n", "r": "\r", "t": "\t", "\\": "\\", '"': '"'}
        while self.i < self.n:
            c = self.s[self.i]
            if c == '"':
                self.i += 1
                return "".join(out)
            if c == "\\":
                self.i += 1
                out.append(escapes.get(self.s[self.i], self.s[self.i]))
                self.i += 1
            else:
                out.append(c)
                self.i += 1
        raise ValueError("未闭合的字符串")

    def _number(self):
        m = re.match(r"-?\d+(?:\.\d+)?", self.s[self.i:])
        if not m:
            raise ValueError(f"bad number at {self.i}")
        t = m.group()
        self.i += len(t)
        return int(t) if "." not in t else float(t)


def _parse_lua_file(path: Path):
    if not path.exists():
        return {}
    return LuaTableParser(path.read_text(encoding="utf-8")).parse()


def load_portrait_mappings() -> dict:
    """从 MasterData 的 Lua 配置建立 立绘 -> (角色, 皮肤) 映射。"""
    base = MASTER_DIR / "LuaScripts" / "ref" / "zh"
    fashion = {}
    hero_names = {}
    languages = {}
    model_to_hero = {}

    for sub in ("", "harmony/"):
        fashion_data = _parse_lua_file(base / sub / "hero_fashion_data.lua")
        for hero_id, hero_block in fashion_data.items():
            if not isinstance(hero_block, dict):
                continue
            for fashion_id, fv in (hero_block.get("fashion_body") or {}).items():
                if not isinstance(fv, dict):
                    continue
                img = fv.get("img_body") or fv.get("img_painting")
                if isinstance(img, str) and img.startswith("record_pic_"):
                    fashion.setdefault(img, (hero_id, fv.get("fashion_name")))

        hero_data = _parse_lua_file(base / sub / "hero_data.lua")
        for hero_id, hb in hero_data.items():
            if not isinstance(hb, dict):
                continue
            name = hb.get("name")
            if isinstance(name, str):
                hero_names.setdefault(hero_id, name)
            for key in ("model", "show_model"):
                model = hb.get(key)
                if isinstance(model, (int, str)):
                    try:
                        model_to_hero.setdefault(int(model), hero_id)
                    except (TypeError, ValueError):
                        pass

    lang_data = _parse_lua_file(base / "language.lua")
    for lang_id, entry in lang_data.items():
        if isinstance(entry, dict) and isinstance(entry.get("language"), str):
            try:
                languages[int(lang_id)] = entry["language"]
            except (TypeError, ValueError):
                pass

    return {
        "fashion": fashion,
        "hero_names": hero_names,
        "languages": languages,
        "model_to_hero": model_to_hero,
    }


def ensure_portrait_lua(session: requests.Session, entries: list) -> bool:
    """按需下载/更新立绘命名所需的几个 Lua 配置（不全量拉 MasterData）。"""
    by_name = {e["Name"]: e for e in entries}
    todo = []
    for name in PORTRAIT_LUA_FILES:
        entry = by_name.get(name)
        if not entry:
            continue
        dest = MASTER_DIR / name
        if dest.exists():
            try:
                if hashlib.md5(dest.read_bytes()).hexdigest() == entry["CheckMd5"]:
                    continue
            except OSError:
                pass
        todo.append((name, entry))
    if not todo:
        return False

    console.print(f"[cyan]自动下载立绘所需 Lua 配置（{len(todo)} 个）...[/cyan]")
    for name, entry in todo:
        raw = download_bytes(
            make_cdn_url(name, entry),
            entry["TotalSize"],
            entry["FileMd5"],
        )
        plain = decrypt_bytes(raw)
        if hashlib.md5(plain).hexdigest() != entry["CheckMd5"]:
            bom_plain = b"\xef\xbb\xbf" + plain
            if hashlib.md5(bom_plain).hexdigest() == entry["CheckMd5"]:
                plain = bom_plain
            else:
                raise RuntimeError(f"解密后 MD5 不符: {name}")
        dest = MASTER_DIR / name
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(plain)
        console.print(f"  [green]✓[/green] {name}")
    return True


def _sanitize_filename(name: str) -> str:
    return re.sub(r'[\\/:*?"<>|\x00-\x1f]', "_", name).strip()


def portrait_output_name(texture_name: str, variant: str, mapping: dict) -> str:
    hero_name = ""
    skin_name = ""
    texture_stem = (
        texture_name[:-4]
        if texture_name.lower().endswith(".png")
        else texture_name
    )
    entry = mapping["fashion"].get(texture_name)
    if entry:
        hero_id, fashion_lang_id = entry
        hero_name = mapping["hero_names"].get(hero_id, "")
        if fashion_lang_id is not None:
            try:
                skin_name = mapping["languages"].get(int(fashion_lang_id), "")
            except (TypeError, ValueError):
                skin_name = ""
    else:
        m = re.match(r"record_pic_(\d+)", texture_name)
        if m:
            hero_id = mapping["model_to_hero"].get(int(m.group(1)))
            if hero_id is not None:
                hero_name = mapping["hero_names"].get(hero_id, "")

    if hero_name and skin_name:
        base = f"锚点降临_{hero_name}_{skin_name}"
    elif hero_name:
        base = f"锚点降临_{hero_name}_{texture_stem}"
    else:
        base = f"锚点降临_{texture_stem}"
    return _sanitize_filename(base) + ".png"


_UNITYFS_MAGIC = b"UnityFS\x00"


def find_bundle_offset(data: bytes) -> int:
    """部分 .k 文件开头有重复的 UnityFS 前缀，需要跳到真正的 bundle 起点。"""
    offsets = []
    start = 0
    while True:
        idx = data.find(_UNITYFS_MAGIC, start)
        if idx == -1:
            break
        offsets.append(idx)
        start = idx + 1
    if len(offsets) <= 1:
        return offsets[0] if offsets else 0

    try:
        pos = offsets[0] + 8 + 4
        for _ in range(2):
            end = data.find(b"\x00", pos)
            if end == -1:
                raise ValueError
            pos = end + 1
        first_size = struct.unpack_from(">q", data, pos)[0]
        if offsets[0] + first_size < offsets[-1]:
            return offsets[0]
    except Exception:
        pass
    return offsets[-1]


def extract_texture_from_bundle(data: bytes):
    """返回 (Texture2D 名字, PIL Image)。"""
    import UnityPy

    offset = find_bundle_offset(data)
    env = UnityPy.load(data[offset:])
    for obj in env.objects:
        if obj.type.name == "Texture2D":
            tex = obj.read()
            img = tex.image
            if img is None:
                raise ValueError("Texture2D 无图像数据")
            name = str(getattr(tex, "m_Name", "") or "")
            return name, img
    raise ValueError("未找到 Texture2D")


def process_asset(
    name: str,
    entry: dict,
    args,
    progress: Progress,
    file_task: int,
    lock: threading.Lock,
    failures: dict,
):
    try:
        rel = safe_rel_path(name)
        dest = ASSETS_DIR / rel
        if dest.exists() and dest.stat().st_size == entry["TotalSize"]:
            if not args.verify or file_md5(dest) == entry["FileMd5"]:
                with lock:
                    progress.advance(file_task)
                return "skip", 0
        size = download_to_file(
            make_cdn_url(name, entry),
            dest,
            entry["TotalSize"],
            entry["FileMd5"],
        )
        with lock:
            progress.advance(file_task)
        return "ok", size
    except Exception as exc:
        with lock:
            failures[name] = str(exc)
            progress.advance(file_task)
        return "fail", 0


def process_lua(
    name: str,
    entry: dict,
    args,
    progress: Progress,
    file_task: int,
    lock: threading.Lock,
    failures: dict,
    manifest: dict,
):
    try:
        rel = safe_rel_path(name)
        dest = MASTER_DIR / rel
        prev = manifest.get(name)
        if (
            not args.force
            and prev
            and prev.get("FileMd5") == entry["FileMd5"]
            and prev.get("CheckMd5") == entry["CheckMd5"]
            and dest.exists()
            and dest.stat().st_size == prev.get("size")
        ):
            with lock:
                progress.advance(file_task)
            return "skip", 0

        data = download_bytes(
            make_cdn_url(name, entry),
            entry["TotalSize"],
            entry["FileMd5"],
        )
        plain = decrypt_bytes(data)
        plain_md5 = hashlib.md5(plain).hexdigest()
        if plain_md5 != entry["CheckMd5"]:
            bom_plain = b"\xef\xbb\xbf" + plain
            if hashlib.md5(bom_plain).hexdigest() == entry["CheckMd5"]:
                plain = bom_plain
            else:
                raise ValueError(f"解密后 MD5 不符: {plain_md5} != {entry['CheckMd5']}")
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(plain)
        with lock:
            manifest[name] = {
                "FileMd5": entry["FileMd5"],
                "CheckMd5": entry["CheckMd5"],
                "size": len(plain),
            }
            progress.advance(file_task)
        return "ok", len(data)
    except Exception as exc:
        with lock:
            failures[name] = str(exc)
            progress.advance(file_task)
        return "fail", 0


def run_pool(
    entries: list,
    worker,
    args,
    progress: Progress,
    file_task: int,
    lock: threading.Lock,
    failures: dict,
    manifest: dict | None = None,
):
    stats = {"ok": 0, "skip": 0, "fail": 0, "downloaded": 0}
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = {
            pool.submit(
                worker,
                entry["Name"],
                entry,
                args,
                progress,
                file_task,
                lock,
                failures,
                *( (manifest,) if manifest is not None else () ),
            ): entry
            for entry in entries
        }
        for fut in as_completed(futures):
            try:
                state, size = fut.result()
            except Exception as exc:
                state, size = "fail", 0
                with lock:
                    failures[futures[fut]["Name"]] = str(exc)
            stats[state] += 1
            if state == "ok":
                stats["downloaded"] += size
    return stats


def parse_herorecord_name(name: str):
    m = re.search(r"herorecord_([a-z]+)_(record_pic_[0-9_]+\.png)\.k$", name)
    if not m:
        return None, None
    return m.group(1), m.group(2)


def process_portrait(
    name: str,
    entry: dict,
    args,
    mapping: dict,
    variant_sets: dict,
    progress: Progress,
    file_task: int,
    lock: threading.Lock,
    failures: dict,
):
    try:
        variant, texture_name = parse_herorecord_name(name)
        if not texture_name:
            raise ValueError("不是 herorecord 立绘")
        out_name = portrait_output_name(texture_name, variant, mapping)
        variants = variant_sets.get(texture_name, ())
        # lymden = 未和谐（无和谐版），har 为主立绘
        if variant == "lymden":
            out_name = out_name[:-4] + "_未和谐.png"
        elif len(variants) > 1 and variant != "har":
            out_name = out_name[:-4] + f"_{variant}.png"
        dest = PORTRAIT_DIR / out_name
        if dest.exists() and not args.force:
            with lock:
                progress.advance(file_task)
            return "skip", 0

        data = download_bytes(
            make_cdn_url(name, entry),
            entry["TotalSize"],
            entry["FileMd5"],
        )
        try:
            _, img = extract_texture_from_bundle(data)
        except Exception:
            cache_dir = PORTRAIT_DIR / ".cache"
            cache_dir.mkdir(parents=True, exist_ok=True)
            (cache_dir / Path(name).name).write_bytes(data)
            raise
        dest.parent.mkdir(parents=True, exist_ok=True)
        img.save(dest)
        with lock:
            progress.advance(file_task)
        return "ok", len(data)
    except Exception as exc:
        with lock:
            failures[name] = str(exc)
            progress.advance(file_task)
        return "fail", 0


def run_portrait_pool(
    entries: list,
    args,
    mapping: dict,
    variant_sets: dict,
    progress: Progress,
    file_task: int,
    lock: threading.Lock,
    failures: dict,
):
    stats = {"ok": 0, "skip": 0, "fail": 0, "downloaded": 0}
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = {
            pool.submit(
                process_portrait,
                entry["Name"],
                entry,
                args,
                mapping,
                variant_sets,
                progress,
                file_task,
                lock,
                failures,
            ): entry
            for entry in entries
        }
        for fut in as_completed(futures):
            try:
                state, size = fut.result()
            except Exception as exc:
                state, size = "fail", 0
                with lock:
                    failures[futures[fut]["Name"]] = str(exc)
            stats[state] += 1
            if state == "ok":
                stats["downloaded"] += size
    return stats


def make_progress(desc: str):
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


def cmd_list():
    with requests.Session() as session:
        session.headers["User-Agent"] = USER_AGENT
        version, entries = fetch_cdn_entries(session)
    total_size = sum(e["TotalSize"] for e in entries)
    lua = [e for e in entries if e["Name"].lower().endswith(".lua")]
    console.print(f"[cyan]版本[/cyan] {version['packageVersion']}  清单 {len(entries)} 个文件 / "
                  f"{total_size / 1024 ** 3:.2f} GB")
    console.print(f"其中 Lua 数据 {len(lua)} 个文件 / "
                  f"{sum(e['TotalSize'] for e in lua) / 1024 ** 2:.1f} MB")


def cmd_assets(args):
    with requests.Session() as session:
        session.headers["User-Agent"] = USER_AGENT
        console.print("[cyan]获取版本清单...[/cyan]")
        version, entries = fetch_cdn_entries(session)
    total_size = sum(e["TotalSize"] for e in entries)
    console.print(
        f"[cyan]开始下载 {len(entries)} 个资源 / {total_size / 1024 ** 3:.2f} GB"
        f"（{args.jobs} 线程）[/cyan]"
    )
    failures: dict = {}
    lock = threading.Lock()
    progress = make_progress("全资产")
    with progress:
        file_task = progress.add_task("[cyan]文件数", total=len(entries))
        stats = run_pool(
            entries, process_asset, args, progress, file_task,
            lock, failures,
        )
    if failures:
        (SCRIPT_DIR / "download_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 新下载 {stats['ok']}，跳过 {stats['skip']}，"
        f"失败 {stats['fail']}，实际下载 {stats['downloaded'] / 1024 ** 3:.2f} GB"
    )


def cmd_masterdata(args):
    with requests.Session() as session:
        session.headers["User-Agent"] = USER_AGENT
        console.print("[cyan]获取版本清单...[/cyan]")
        version, entries = fetch_cdn_entries(session)
    entries = [e for e in entries if e["Name"].lower().endswith(".lua")]
    total_size = sum(e["TotalSize"] for e in entries)
    console.print(
        f"[cyan]开始下载 {len(entries)} 个 Lua 数据 / {total_size / 1024 ** 2:.1f} MB"
        f"（{args.jobs} 线程）[/cyan]"
    )
    manifest: dict = {}
    if MANIFEST_PATH.exists():
        try:
            manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
        except Exception:
            manifest = {}
    failures: dict = {}
    lock = threading.Lock()
    progress = make_progress("MasterData")
    with progress:
        file_task = progress.add_task("[cyan]文件数", total=len(entries))
        stats = run_pool(
            entries, process_lua, args, progress, file_task,
            lock, failures, manifest,
        )
    MANIFEST_PATH.parent.mkdir(parents=True, exist_ok=True)
    MANIFEST_PATH.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    if failures:
        (SCRIPT_DIR / "masterdata_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 新下载 {stats['ok']}，跳过 {stats['skip']}，"
        f"失败 {stats['fail']}，实际下载 {stats['downloaded'] / 1024 ** 2:.1f} MB"
    )
    current_names = {e["Name"] for e in entries}
    stale = [
        str(p.relative_to(MASTER_DIR))
        for p in MASTER_DIR.rglob("*.lua")
        if str(p.relative_to(MASTER_DIR)) not in current_names
    ]
    if stale:
        console.print(
            f"[yellow]另有 {len(stale)} 个旧文件不在当前清单中（未删除）[/yellow]"
        )


def cmd_portrait(args):
    with requests.Session() as session:
        session.headers["User-Agent"] = USER_AGENT
        console.print("[cyan]获取版本清单...[/cyan]")
        version, entries = fetch_cdn_entries(session)
        ensure_portrait_lua(session, entries)
    entries = [
        e for e in entries
        if "herorecord" in e["Name"] and e["Name"].endswith(".png.k")
    ]
    if not entries:
        console.print("[yellow]清单中没有 herorecord 立绘[/yellow]")
        return

    mapping = load_portrait_mappings()
    if not mapping["fashion"] and not mapping["hero_names"]:
        console.print(
            "[yellow]未找到 MasterData Lua 映射，将使用文件名兜底命名。"
            "可先执行 masterdata 下载数据。[/yellow]"
        )

    variant_sets = {}
    for e in entries:
        variant, texture_name = parse_herorecord_name(e["Name"])
        if texture_name:
            variant_sets.setdefault(texture_name, set()).add(variant)

    if not args.keep_small:
        all_textures = set(variant_sets)
        kept = []
        removed = 0
        for e in entries:
            _, texture_name = parse_herorecord_name(e["Name"])
            m = re.match(r"record_pic_(\d+)_1\.png$", texture_name or "")
            base_name = f"record_pic_{m.group(1)}.png" if m else None
            if (
                m
                and texture_name not in mapping["fashion"]
                and base_name in all_textures
            ):
                removed += 1
                continue
            kept.append(e)
        if removed:
            console.print(
                f"[yellow]跳过 {removed} 个低清 _1 重复立绘"
                f"（Lua 未引用，可用 --keep-small 保留）[/yellow]"
            )
        entries = kept

    total_size = sum(e["TotalSize"] for e in entries)
    console.print(
        f"[cyan]开始下载 {len(entries)} 个立绘 / {total_size / 1024 ** 2:.1f} MB"
        f"（{args.jobs} 线程）[/cyan]"
    )
    failures: dict = {}
    lock = threading.Lock()
    progress = make_progress("立绘")
    with progress:
        file_task = progress.add_task("[cyan]立绘", total=len(entries))
        stats = run_portrait_pool(
            entries, args, mapping, variant_sets, progress, file_task, lock, failures
        )
    if failures:
        (SCRIPT_DIR / "portrait_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 导出 {stats['ok']}，跳过 {stats['skip']}，"
        f"失败 {stats['fail']}，实际下载 {stats['downloaded'] / 1024 ** 2:.1f} MB"
    )


def cmd_decrypt(path: str):
    root = Path(path)
    if not root.is_dir():
        console.print(f"[red]目录不存在: {root}[/red]")
        sys.exit(1)
    count = 0
    for dirpath, _, files in os.walk(root):
        for name in files:
            if name.lower().endswith(".lua"):
                decrypt_file_inplace(Path(dirpath) / name)
                count += 1
    console.print(f"[bold green]完成[/bold green] 解密 {count} 个 .lua 文件")


def main():
    if len(sys.argv) >= 2 and Path(sys.argv[1]).is_dir():
        cmd_decrypt(sys.argv[1])
        return

    parser = argparse.ArgumentParser(description="锚点降临 CDN 下载 / Lua 解密")
    sub = parser.add_subparsers(dest="command", required=True)

    p_assets = sub.add_parser("assets", help="全量下载所有资源到 Assets/")
    p_assets.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发线程数")
    p_assets.add_argument("--verify", action="store_true", help="校验已存在文件的 MD5")

    p_data = sub.add_parser("masterdata", aliases=["data", "lua"],
                            help="只下载 Lua 数据并解密到 MasterData/")
    p_data.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发线程数")
    p_data.add_argument("--force", action="store_true", help="忽略清单强制重下")

    p_portrait = sub.add_parser(
        "portrait", aliases=["painting"],
        help="只下载 herorecord 立绘，用 UnityPy 导出 Texture2D 到 Painting/",
    )
    p_portrait.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发线程数")
    p_portrait.add_argument("--force", action="store_true", help="已导出的图片也重新导出")
    p_portrait.add_argument(
        "--keep-small", action="store_true",
        help="保留 Lua 未引用的 record_pic_*_1 低清重复立绘",
    )

    p_dec = sub.add_parser("decrypt", help="对目录下的 .lua 原地解密")
    p_dec.add_argument("path", help="目录")

    sub.add_parser("list", help="打印当前版本文件统计")

    args = parser.parse_args()
    if args.command == "assets":
        cmd_assets(args)
    elif args.command in ("masterdata", "data", "lua"):
        cmd_masterdata(args)
    elif args.command in ("portrait", "painting"):
        cmd_portrait(args)
    elif args.command == "decrypt":
        cmd_decrypt(args.path)
    elif args.command == "list":
        cmd_list()


if __name__ == "__main__":
    main()
