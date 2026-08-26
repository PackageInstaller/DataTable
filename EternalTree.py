from __future__ import annotations

import argparse
import base64
import hashlib
import json
import struct
import threading
import time
import warnings
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable

import requests
from Crypto.Cipher import AES
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
from rich.table import Table

# HybridDllLoader 常量（cctor: StringToBytes 截断长度）
ENCRYPTION_KEY = "SlVSbJGPv4FryAq9ODRmNFcbRKzQPUNyWfUIqFAeeoFcqqT2YRiDbVg0rQz9aRlh"
ENCRYPTION_IV = "Y2qI1JeNO8bXkVfSpzCRYbxnSaw8MQaz"
XOR_KEY = "sSh0WZ1UakiaHTObbr1aebmYJcJZnc6wL7tsjkrCpYsGXIX3FKlFcMtgQp9PUmfW"
AES_KEY = ENCRYPTION_KEY.encode("utf-8")[:32]
AES_IV = ENCRYPTION_IV.encode("utf-8")[:16]
XOR_BYTES = XOR_KEY.encode("utf-8")[:32]

# HybridDllLoader.HotAssemblyFiles（CDN 文件名为 UTF-8 MD5 大写）
HOT_ASSEMBLY_FILES = [
    "Unity.Postprocessing.Runtime.dll",
    "OrleshRenderer.dll",
    "DynamicImage.dll",
    "UIContainer.dll",
    "YJZSRuntime.dll",
]
HOT_ASSEMBLY_BY_HASH = {
    hashlib.md5(name.encode("utf-8")).hexdigest().upper(): name
    for name in HOT_ASSEMBLY_FILES
}

DEFAULT_CHANNEL = "and4.3.101"
PLATFORM = "Android"
VERSIONS_URLS = [
    f"https://l{n}-prod-static.yjzs.orlesh.com/versions.json" for n in (1, 2, 3)
]
HTTP_HEADERS = {
    "User-Agent": "UnityPlayer/2022.3.62f2 (UnityWebRequest/1.0, libcurl/8.5.0-DEV)",
    "Accept": "*/*",
    "X-Unity-Version": "2022.3.62f2",
}
RETRY_COUNT = 4
CHUNK_SIZE = 1 << 20

console = Console()
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
HOTDLL_DIR = ROOT / "HotDlls"
MASTER_DIR = ROOT / "MasterData"
PAINTING_DIR = ROOT / "Painting"
STATE_PATH = ROOT / "version.json"
CONFIG_DLL_NAME = "YJZSRuntime.dll"
DESCRIPTOR_CACHE = HOTDLL_DIR / "Config.FileDescriptorProto"
JSONDATA_NEEDLE = "/foldersplitbundle/config/jsondata/"
LANGUAGE_NEEDLE = "/foldersplitbundle/config/language/"
SHD_NEEDLE = "/foldersplitbundle/shd/"
GAME_TITLE = "悠久之树"
PAINTING_NAME_TABLES = ("Character", "Skin", "ChaDes", "SkinDes", "ProSkin")
_tls = threading.local()

# protobuf FieldDescriptorProto.type / label
_PB_TYPE_DOUBLE, _PB_TYPE_FLOAT = 1, 2
_PB_TYPE_INT64, _PB_TYPE_UINT64, _PB_TYPE_INT32 = 3, 4, 5
_PB_TYPE_FIXED64, _PB_TYPE_FIXED32, _PB_TYPE_BOOL = 6, 7, 8
_PB_TYPE_STRING, _PB_TYPE_MESSAGE, _PB_TYPE_BYTES = 9, 11, 12
_PB_TYPE_UINT32, _PB_TYPE_ENUM = 13, 14
_PB_TYPE_SFIXED32, _PB_TYPE_SFIXED64 = 15, 16
_PB_TYPE_SINT32, _PB_TYPE_SINT64 = 17, 18
_PB_LABEL_REPEATED = 3
_PB_VARINT_TYPES = {
    _PB_TYPE_INT64,
    _PB_TYPE_UINT64,
    _PB_TYPE_INT32,
    _PB_TYPE_BOOL,
    _PB_TYPE_UINT32,
    _PB_TYPE_ENUM,
    _PB_TYPE_SINT32,
    _PB_TYPE_SINT64,
}


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def md5_upper(text: str) -> str:
    return hashlib.md5(text.encode("utf-8")).hexdigest().upper()


def md5_file(path: Path, chunk_size: int = CHUNK_SIZE) -> str:
    h = hashlib.md5()
    with path.open("rb") as fh:
        while True:
            block = fh.read(chunk_size)
            if not block:
                break
            h.update(block)
    return h.hexdigest()


def xor_data(data: bytes, key: bytes = XOR_BYTES) -> bytes:
    klen = len(key)
    return bytes(b ^ key[i % klen] for i, b in enumerate(data))


def decrypt_hybrid_dll(data: bytes) -> bytes:
    """HybridDllLoader.Decrypt：先 XOR，再 AES-256-CBC PKCS7。"""
    xored = xor_data(data)
    cipher = AES.new(AES_KEY, AES.MODE_CBC, AES_IV)
    return unpad(cipher.decrypt(xored), AES.block_size)


def looks_like_pe(data: bytes) -> bool:
    return data[:2] == b"MZ"


def get_session() -> requests.Session:
    session = getattr(_tls, "session", None)
    if session is None:
        session = requests.Session()
        session.headers.update(HTTP_HEADERS)
        _tls.session = session
    return session


def http_get(url: str, timeout: int = 60, stream: bool = False) -> requests.Response:
    resp = get_session().get(url, timeout=timeout, stream=stream)
    resp.raise_for_status()
    return resp


def fetch_json(urls: Iterable[str]) -> Any:
    last_err: Exception | None = None
    for url in urls:
        try:
            return http_get(url, timeout=30).json()
        except Exception as exc:  # noqa: BLE001
            last_err = exc
            console.print(f"[yellow]versions.json 失败[/] {url}: {exc}")
    assert last_err is not None
    raise last_err


def load_state() -> dict[str, Any]:
    if STATE_PATH.exists():
        return json.loads(STATE_PATH.read_text(encoding="utf-8"))
    return {}


def save_state(state: dict[str, Any]) -> None:
    STATE_PATH.write_text(json.dumps(state, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def ends_with_seg(base: str, seg: str) -> bool:
    return base.rstrip("/").lower().endswith("/" + seg.lower())


def with_platform(cdn: str, platform: str) -> str:
    base = cdn.rstrip("/")
    if not ends_with_seg(base, platform):
        base = f"{base}/{platform}"
    return base


def resource_url(cdn: str, platform: str, patch_ver: int, file_name: str) -> str:
    """DownloadService.BuildPatchFileUrls。"""
    base = with_platform(cdn, platform)
    if not ends_with_seg(base, "Patches"):
        base = f"{base}/Patches"
    return f"{base}/{patch_ver}/{file_name}"


def manifest_url(cdn: str, platform: str, resv: int) -> str:
    return resource_url(cdn, platform, resv, "patch_assets_Manifest.yaml")


def reflection_url(cdn: str, platform: str, resv: int) -> str:
    return resource_url(cdn, platform, resv, "reflection_manifest.yaml")


class AssetItem:
    __slots__ = ("name", "length", "hash", "patch_ver", "group")

    def __init__(self, name: str, length: int, digest: str, patch_ver: int, group: str) -> None:
        self.name = name
        self.length = length
        self.hash = digest.lower()
        self.patch_ver = patch_ver
        self.group = group


def parse_patch_manifest(text: str) -> tuple[str, int, list[AssetItem]]:
    """按客户端 DownloadService.ParseManifest 的字段，区分 Assets / ExtraAssets。"""
    version = ""
    patch_ver = 0
    items: list[AssetItem] = []
    current: dict[str, Any] | None = None
    group = "Assets"

    def flush() -> None:
        nonlocal current
        if not current or not current.get("name"):
            current = None
            return
        items.append(
            AssetItem(
                name=str(current["name"]),
                length=int(current.get("length") or 0),
                digest=str(current.get("hash") or ""),
                patch_ver=int(current.get("patchVer") or 0),
                group=str(current.get("group") or "Assets"),
            )
        )
        current = None

    extra_lang = ""
    for raw in text.splitlines():
        if not raw.strip():
            continue
        if raw.startswith("Version:"):
            version = raw.split(":", 1)[1].strip()
            continue
        if raw.startswith("PatchVer:"):
            try:
                patch_ver = int(raw.split(":", 1)[1].strip())
            except ValueError:
                patch_ver = 0
            continue
        if raw.startswith("Assets:"):
            flush()
            group = "Assets"
            extra_lang = ""
            continue
        if raw.startswith("ExtraAssets:"):
            flush()
            group = "ExtraAssets"
            extra_lang = ""
            continue
        stripped = raw.strip()
        if group.startswith("Extra") and raw.startswith("  ") and not raw.startswith("    ") and not stripped.startswith("- "):
            extra_lang = stripped.rstrip(":")
            continue
        if stripped.startswith("- name:"):
            flush()
            g = f"Extra/{extra_lang}" if extra_lang else group
            current = {"name": stripped[7:].strip(), "group": g}
            continue
        if current is None:
            continue
        for key in ("length", "hash", "patchVer", "crc"):
            prefix = f"{key}:"
            if stripped.startswith(prefix):
                current[key] = stripped[len(prefix) :].strip()
                break
    flush()
    return version, patch_ver, items


def parse_reflection_manifest(text: str) -> dict[str, list[str]]:
    """reflection_manifest.yaml：逻辑资源路径 → AB 包名。不用于落盘。"""
    mapping: dict[str, list[str]] = {}
    for raw in text.splitlines():
        stripped = raw.strip()
        if not stripped or ": " not in stripped:
            continue
        path, digest = stripped.rsplit(":", 1)
        path = path.strip()
        digest = digest.strip().lower()
        if len(digest) != 32 or any(c not in "0123456789abcdef" for c in digest):
            continue
        if not path or path.endswith(":"):
            continue
        mapping.setdefault(digest, []).append(path)
    return mapping


def channel_info(versions: dict[str, Any], channel: str) -> dict[str, Any]:
    info = versions.get(channel)
    if not isinstance(info, dict):
        raise KeyError(f"versions.json 没有渠道 {channel}，可选: {', '.join(sorted(versions))}")
    return info


def print_channel(channel: str, info: dict[str, Any]) -> None:
    table = Table(title=f"YJZS {channel}")
    table.add_column("项")
    table.add_column("值")
    table.add_row("appver", str(info.get("appver")))
    table.add_row("resv", str(info.get("resv")))
    table.add_row("zipVersion", str(info.get("zipVersion")))
    cdns = info.get("cdn") or []
    for i, cdn in enumerate(cdns):
        table.add_row(f"cdn[{i}]", str(cdn))
    table.add_row("sdkUrl", str(info.get("sdkUrl")))
    console.print(table)


def local_path_for(item: AssetItem) -> Path:
    """与 HighSpeedBackgroundDownloader 一致：{persistent}/bundles/{name}。"""
    return ASSETS_DIR / "bundles" / item.name


def maybe_migrate_legacy(item: AssetItem, dest: Path) -> None:
    """把旧版摊在 Assets/ 根目录或 extra/ 下的同名文件挪到 bundles/。"""
    if dest.exists():
        return
    candidates = [ASSETS_DIR / item.name]
    if item.group.startswith("Extra/"):
        lang = item.group.split("/", 1)[1]
        candidates.append(ASSETS_DIR / "extra" / lang / item.name)
    dest_res = dest.resolve()
    for cand in candidates:
        if not cand.is_file():
            continue
        try:
            if cand.resolve() == dest_res:
                continue
        except OSError:
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        cand.replace(dest)
        return


def file_is_current(path: Path, item: AssetItem) -> bool:
    if not path.is_file():
        return False
    if item.length and path.stat().st_size != item.length:
        return False
    if item.hash and md5_file(path) != item.hash:
        return False
    return True


def download_file(urls: list[str], dest: Path, item: AssetItem, retries: int, force: bool) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    maybe_migrate_legacy(item, dest)
    if not force and file_is_current(dest, item):
        return "skip"
    last_err: Exception | None = None
    for attempt in range(1, retries + 1):
        for url in urls:
            try:
                resp = http_get(url, timeout=120, stream=True)
                tmp = dest.with_suffix(dest.suffix + ".part")
                written = 0
                with tmp.open("wb") as fh:
                    for chunk in resp.iter_content(CHUNK_SIZE):
                        if chunk:
                            fh.write(chunk)
                            written += len(chunk)
                if item.length and written != item.length:
                    raise ValueError(f"size {written} != {item.length}")
                digest = md5_file(tmp)
                if item.hash and digest != item.hash:
                    raise ValueError(f"md5 {digest} != {item.hash}")
                tmp.replace(dest)
                return "ok"
            except Exception as exc:  # noqa: BLE001
                last_err = exc
        time.sleep(min(8, attempt))
    raise RuntimeError(str(last_err) if last_err else "download failed")


def maybe_decrypt_hot_dll(item: AssetItem, dest: Path) -> None:
    name = HOT_ASSEMBLY_BY_HASH.get(item.name.upper())
    if not name or not dest.is_file():
        return
    raw = dest.read_bytes()
    if looks_like_pe(raw):
        plain = raw
    else:
        try:
            plain = decrypt_hybrid_dll(raw)
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]热更 DLL 解密失败[/] {name}: {exc}")
            return
    HOTDLL_DIR.mkdir(parents=True, exist_ok=True)
    out = HOTDLL_DIR / name
    out.write_bytes(plain)
    console.print(f"[cyan]热更 DLL[/] {item.name} → {out.name} ({format_size(len(plain))})")


def pull_text(cdns: list[str], platform: str, resv: int, kind: str) -> tuple[str, str]:
    last_err: Exception | None = None
    builder = manifest_url if kind == "patch" else reflection_url
    versions = [resv] if kind == "patch" else [resv, resv - 1]
    for ver in versions:
        if ver <= 0:
            continue
        for cdn in cdns:
            url = builder(cdn, platform, ver)
            try:
                text = http_get(url, timeout=120).text
                return text, url
            except Exception as exc:  # noqa: BLE001
                last_err = exc
    raise RuntimeError(f"{kind} 清单拉取失败: {last_err}")


def _pb_decode_varint(buf: bytes, i: int) -> tuple[int, int]:
    x = 0
    shift = 0
    while True:
        if i >= len(buf):
            raise ValueError("truncated varint")
        b = buf[i]
        i += 1
        x |= (b & 0x7F) << shift
        if b < 0x80:
            return x, i
        shift += 7
        if shift > 63:
            raise ValueError("varint too long")


def _pb_zigzag(n: int) -> int:
    return (n >> 1) ^ -(n & 1)


def _pb_decode_wt(buf: bytes, i: int, wt: int) -> tuple[Any, int]:
    if wt == 0:
        return _pb_decode_varint(buf, i)
    if wt == 1:
        if i + 8 > len(buf):
            raise ValueError("truncated fixed64")
        return buf[i : i + 8], i + 8
    if wt == 2:
        ln, i = _pb_decode_varint(buf, i)
        if i + ln > len(buf):
            raise ValueError("truncated length-delimited")
        return buf[i : i + ln], i + ln
    if wt == 5:
        if i + 4 > len(buf):
            raise ValueError("truncated fixed32")
        return buf[i : i + 4], i + 4
    raise ValueError(f"bad wire type {wt}")


def _pb_coerce_varint(value: int, ftype: int | None) -> Any:
    if ftype == _PB_TYPE_BOOL:
        return bool(value)
    if ftype in (_PB_TYPE_SINT32, _PB_TYPE_SINT64):
        return _pb_zigzag(value)
    if ftype == _PB_TYPE_INT32 and value >= 0x80000000:
        return value - 0x100000000
    if ftype == _PB_TYPE_INT64 and value >= (1 << 63):
        return value - (1 << 64)
    return value


def _pb_unpack_packed(buf: bytes, ftype: int) -> list[Any] | None:
    i = 0
    out: list[Any] = []
    if ftype in _PB_VARINT_TYPES:
        while i < len(buf):
            v, i = _pb_decode_varint(buf, i)
            out.append(_pb_coerce_varint(v, ftype))
        return out
    if ftype in (_PB_TYPE_FIXED32, _PB_TYPE_FLOAT, _PB_TYPE_SFIXED32):
        fmt = {_PB_TYPE_FLOAT: "<f", _PB_TYPE_SFIXED32: "<i"}.get(ftype, "<I")
        while i + 4 <= len(buf):
            out.append(struct.unpack_from(fmt, buf, i)[0])
            i += 4
        return out
    if ftype in (_PB_TYPE_FIXED64, _PB_TYPE_DOUBLE, _PB_TYPE_SFIXED64):
        fmt = {_PB_TYPE_DOUBLE: "<d", _PB_TYPE_SFIXED64: "<q"}.get(ftype, "<Q")
        while i + 8 <= len(buf):
            out.append(struct.unpack_from(fmt, buf, i)[0])
            i += 8
        return out
    return None


class _ProtoSchema:
    def __init__(self, fdp: Any) -> None:
        self.messages: dict[str, Any] = {}
        pkg = f".{fdp.package}" if fdp.package else ""

        def add(prefix: str, msg: Any) -> None:
            fq = f"{prefix}.{msg.name}"
            self.messages[fq] = msg
            self.messages[msg.name] = msg
            for nested in msg.nested_type:
                add(fq, nested)

        for msg in fdp.message_type:
            add(pkg, msg)

    def resolve(self, type_name: str) -> Any | None:
        if type_name in self.messages:
            return self.messages[type_name]
        if type_name.startswith(".") and type_name[1:] in self.messages:
            return self.messages[type_name[1:]]
        return self.messages.get(type_name.rsplit(".", 1)[-1])

    def find_table(self, asset_name: str) -> Any | None:
        for suffix in ("TypeMap", "RootType"):
            key = asset_name + suffix
            msg = self.resolve(f".Config.{key}") or self.resolve(key)
            if msg is not None:
                return msg
        want = {f"{asset_name.lower()}typemap", f"{asset_name.lower()}roottype"}
        for name, msg in self.messages.items():
            short = name.rsplit(".", 1)[-1]
            if short.lower() in want:
                return msg
        return None


def _pb_decode_message(buf: bytes, msg: Any, schema: _ProtoSchema) -> dict[str, Any]:
    fields = {f.number: f for f in msg.field}
    out: dict[str, Any] = {}
    i = 0
    n = len(buf)
    while i < n:
        tag, i = _pb_decode_varint(buf, i)
        fn, wt = tag >> 3, tag & 7
        payload, i = _pb_decode_wt(buf, i, wt)
        field = fields.get(fn)
        if field is None:
            name = str(fn)
            repeated = False
            ftype = None
            type_name = ""
            is_map = False
        else:
            name = field.name
            repeated = field.label == _PB_LABEL_REPEATED
            ftype = field.type
            type_name = field.type_name
            nested = schema.resolve(type_name) if ftype == _PB_TYPE_MESSAGE else None
            is_map = bool(nested is not None and nested.options.map_entry)
        if is_map and wt == 2:
            entry = schema.resolve(type_name)
            decoded = _pb_decode_message(payload, entry, schema)
            bucket = out.setdefault(name, {})
            bucket[str(decoded.get("key"))] = decoded.get("value")
            continue
        if wt == 2 and ftype == _PB_TYPE_MESSAGE:
            nested = schema.resolve(type_name)
            if nested is not None:
                try:
                    val: Any = _pb_decode_message(payload, nested, schema)
                except Exception:  # noqa: BLE001
                    val = payload.hex()
            else:
                val = payload.hex()
        elif wt == 2 and ftype == _PB_TYPE_STRING:
            val = payload.decode("utf-8", "replace")
        elif wt == 2 and ftype == _PB_TYPE_BYTES:
            val = payload.hex()
        elif (
            wt == 2
            and ftype is not None
            and ftype not in (_PB_TYPE_MESSAGE, _PB_TYPE_STRING, _PB_TYPE_BYTES)
        ):
            packed = _pb_unpack_packed(payload, ftype)
            val = packed if packed is not None else payload.hex()
            if repeated and isinstance(val, list):
                out.setdefault(name, []).extend(val)
                continue
        elif wt == 2:
            try:
                val = payload.decode("utf-8")
            except Exception:  # noqa: BLE001
                val = payload.hex()
        elif wt == 0:
            val = _pb_coerce_varint(payload, ftype or _PB_TYPE_UINT32)
        elif wt == 5:
            fmt = {_PB_TYPE_FLOAT: "<f", _PB_TYPE_SFIXED32: "<i"}.get(ftype, "<I")
            val = struct.unpack(fmt, payload)[0]
        elif wt == 1:
            fmt = {_PB_TYPE_DOUBLE: "<d", _PB_TYPE_SFIXED64: "<q"}.get(ftype, "<Q")
            val = struct.unpack(fmt, payload)[0]
        else:
            val = payload.hex() if isinstance(payload, (bytes, bytearray)) else payload
        if repeated:
            out.setdefault(name, []).append(val)
        else:
            out[name] = val
    return out


def _pb_rows(decoded: dict[str, Any]) -> Any:
    if len(decoded) != 1:
        return decoded
    only = next(iter(decoded.values()))
    if isinstance(only, dict) and only and all(isinstance(v, dict) for v in only.values()):
        def keyfn(k: str) -> tuple[int, Any]:
            try:
                return (0, int(k))
            except ValueError:
                return (1, k)

        return [only[k] for k in sorted(only, key=keyfn)]
    if isinstance(only, list):
        return only
    return decoded


def _extract_descriptor_blob(dll: Path) -> bytes:
    import dnfile  # noqa: PLC0415

    pe = dnfile.dnPE(str(dll))
    rva = None
    for typedef in pe.net.mdtables.TypeDef.rows:
        ns = typedef.TypeNamespace.value if typedef.TypeNamespace else ""
        name = typedef.TypeName.value if typedef.TypeName else ""
        if ns != "Config" or name != "ConfigReflection":
            continue
        for mi in typedef.MethodList:
            method = pe.net.mdtables.MethodDef.rows[mi.row_index - 1]
            if method.Name.value == ".cctor":
                rva = method.Rva
        break
    if not rva:
        raise RuntimeError("YJZSRuntime.dll 里没有 Config.ConfigReflection..cctor")
    hdr = pe.get_data(rva, 12)
    flags, _maxstack, codesize, _locals = struct.unpack_from("<HHII", hdr, 0)
    header_size = (flags >> 12) * 4
    body = pe.get_data(rva + header_size, codesize)
    if not body or body[0] != 0x20:
        raise RuntimeError("ConfigReflection.cctor 不是预期的 string[] 描述符")
    count = struct.unpack_from("<I", body, 1)[0]
    i = 10
    us = pe.net.user_strings
    parts: list[str] = []
    for _ in range(count):
        if i >= len(body) or body[i] != 0x25:
            raise RuntimeError("ConfigReflection.cctor 描述符数组被截断")
        i += 1
        op = body[i]
        if op == 0x20:
            i += 5
        elif op == 0x1F:
            i += 2
        elif 0x16 <= op <= 0x1E:
            i += 1
        else:
            raise RuntimeError(f"ConfigReflection.cctor 未知 ldc {op:#x}")
        if body[i] != 0x72:
            raise RuntimeError("ConfigReflection.cctor 期望 ldstr")
        token = struct.unpack_from("<I", body, i + 1)[0]
        i += 5
        item = us.get(token & 0xFFFFFF)
        parts.append(item.value if hasattr(item, "value") else str(item))
        if body[i] != 0xA2:
            raise RuntimeError("ConfigReflection.cctor 期望 stelem.ref")
        i += 1
    blob = base64.b64decode("".join(parts))
    if not blob.startswith(b"\n\x0cConfig.proto"):
        raise RuntimeError("抽出的描述符不是 Config.proto")
    return blob


def load_config_schema() -> _ProtoSchema:
    from google.protobuf.descriptor_pb2 import FileDescriptorProto  # noqa: PLC0415

    dll = HOTDLL_DIR / CONFIG_DLL_NAME
    blob: bytes | None = None
    if (
        DESCRIPTOR_CACHE.is_file()
        and (not dll.is_file() or DESCRIPTOR_CACHE.stat().st_mtime >= dll.stat().st_mtime)
    ):
        blob = DESCRIPTOR_CACHE.read_bytes()
    elif dll.is_file():
        console.print(f"[cyan]解析 protobuf 描述符[/] {dll.name}")
        blob = _extract_descriptor_blob(dll)
        DESCRIPTOR_CACHE.parent.mkdir(parents=True, exist_ok=True)
        DESCRIPTOR_CACHE.write_bytes(blob)
    if not blob:
        raise RuntimeError(f"需要 {dll}（先 download --dll 或 --masterdata）才能解析数据表")
    fdp = FileDescriptorProto()
    fdp.ParseFromString(blob)
    return _ProtoSchema(fdp)


def _textasset_script(obj: Any) -> tuple[str, bytes]:
    raw = obj.get_raw_data()
    nlen = struct.unpack_from("<I", raw, 0)[0]
    name = raw[4 : 4 + nlen].decode("utf-8", "replace")
    i = (4 + nlen + 3) & ~3
    slen = struct.unpack_from("<i", raw, i)[0]
    if slen < 0 or i + 4 + slen > len(raw):
        raise ValueError(f"TextAsset {name} script 长度异常: {slen}")
    return name, raw[i + 4 : i + 4 + slen]


def classify_table_item(item: AssetItem, paths: list[str]) -> str | None:
    """数据表 AB 返回导出子目录：''=基线 MasterData/，否则为语言名；非表返回 None。"""
    matched: list[str] = []
    for path in paths:
        low = path.replace("\\", "/").lower()
        if JSONDATA_NEEDLE in low or LANGUAGE_NEEDLE in low:
            matched.append(low)
    if not matched:
        return None
    sample = matched[0]
    if "/localization/" in sample:
        if item.group.startswith("Extra/"):
            return item.group.split("/", 1)[1]
        return sample.split("/localization/", 1)[1].split("/", 1)[0]
    return ""


def iter_table_items(
    items: list[AssetItem],
    hash_to_paths: dict[str, list[str]],
    extra_set: set[str],
    want_all_extra: bool,
) -> list[tuple[AssetItem, str]]:
    out: list[tuple[AssetItem, str]] = []
    seen: set[str] = set()
    for item in items:
        key = item.name.lower()
        if key in seen:
            continue
        paths = hash_to_paths.get(key) or []
        sub = classify_table_item(item, paths)
        if sub is None:
            continue
        if sub and not want_all_extra and sub.lower() not in extra_set:
            continue
        seen.add(key)
        out.append((item, sub))
    return out


def config_dll_item(items: list[AssetItem]) -> AssetItem | None:
    digest = md5_upper(CONFIG_DLL_NAME)
    for item in items:
        if item.name.upper() == digest:
            return item
    return None


def need_config_dll() -> bool:
    dll = HOTDLL_DIR / CONFIG_DLL_NAME
    if dll.is_file():
        with dll.open("rb") as fh:
            return fh.read(2) != b"MZ"
    return not DESCRIPTOR_CACHE.is_file()


def export_masterdata(targets: list[tuple[AssetItem, str]]) -> int:
    """从已下载的表 AB 导出 JSON 到 MasterData/。返回失败表数量。"""
    import UnityPy  # noqa: PLC0415

    warnings.filterwarnings("ignore", message="No valid Unity version found")
    schema = load_config_schema()
    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    fail = 0
    written = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出 MasterData", total=max(len(targets), 1))
        for item, sub in targets:
            dest_dir = MASTER_DIR / sub if sub else MASTER_DIR
            dest_dir.mkdir(parents=True, exist_ok=True)
            bundle = local_path_for(item)
            progress.update(task, description=f"导出 {item.name[:12]}…")
            if not bundle.is_file():
                console.print(f"[yellow]缺表 AB[/] {item.name}")
                fail += 1
                progress.advance(task)
                continue
            try:
                env = UnityPy.load(str(bundle))
                for obj in env.objects:
                    if getattr(obj.type, "name", None) != "TextAsset":
                        continue
                    name, script = _textasset_script(obj)
                    msg = schema.find_table(name)
                    if msg is None:
                        console.print(f"[yellow]无 schema[/] {name}")
                        fail += 1
                        continue
                    rows = _pb_rows(_pb_decode_message(script, msg, schema))
                    out = dest_dir / f"{name}.json"
                    out.write_text(
                        json.dumps(rows, ensure_ascii=False, indent=2) + "\n",
                        encoding="utf-8",
                    )
                    written += 1
            except Exception as exc:  # noqa: BLE001
                console.print(f"[red]解析失败[/] {item.name}: {exc}")
                fail += 1
            progress.advance(task)
    console.print(f"[cyan]MasterData[/] 写出 {written} 张表 → {MASTER_DIR}  失败 {fail}")
    return fail


def shd_folder_id(paths: list[str]) -> str | None:
    """FolderSplitBundle/SHD/{id}/shd.prefab → 立绘目录 id。"""
    for path in paths:
        low = path.replace("\\", "/").lower()
        if SHD_NEEDLE not in low or "/localization/" in low:
            continue
        parts = low.split("/")
        try:
            idx = parts.index("shd")
        except ValueError:
            continue
        if idx + 1 >= len(parts):
            continue
        fid = parts[idx + 1]
        if fid and fid != "shd.prefab":
            return fid
    return None


def iter_shd_items(
    items: list[AssetItem],
    hash_to_paths: dict[str, list[str]],
) -> list[tuple[AssetItem, str]]:
    out: list[tuple[AssetItem, str]] = []
    seen: set[str] = set()
    for item in items:
        if item.group.startswith("Extra/"):
            continue
        key = item.name.lower()
        if key in seen:
            continue
        fid = shd_folder_id(hash_to_paths.get(key) or [])
        if fid is None:
            continue
        seen.add(key)
        out.append((item, fid))
    return out


def _localized_content(entries: Any, prefer: str = "ChineseSimplified") -> str:
    if not entries:
        return ""
    if isinstance(entries, str):
        return entries.strip()
    picked = ""
    if not isinstance(entries, list):
        return ""
    for entry in entries:
        if not isinstance(entry, dict):
            continue
        content = str(entry.get("Content") or "").strip()
        if not content:
            continue
        if entry.get("Type") == prefer:
            return content
        if not picked:
            picked = content
    return picked


def _safe_fs_name(text: str) -> str:
    table = str.maketrans(
        {
            "/": "／",
            "\\": "＼",
            ":": "：",
            "*": "＊",
            "?": "？",
            '"': "'",
            "<": "＜",
            ">": "＞",
            "|": "｜",
            "\n": "",
            "\r": "",
            "\t": " ",
        }
    )
    text = text.translate(table).strip()
    return text or "未知"


def _load_named_tables(
    targets: list[tuple[AssetItem, str]],
    names: Iterable[str],
) -> dict[str, Any]:
    import UnityPy  # noqa: PLC0415

    warnings.filterwarnings("ignore", message="No valid Unity version found")
    schema = load_config_schema()
    want = set(names)
    out: dict[str, Any] = {}
    for item, _sub in targets:
        bundle = local_path_for(item)
        if not bundle.is_file():
            continue
        env = UnityPy.load(str(bundle))
        for obj in env.objects:
            if getattr(obj.type, "name", None) != "TextAsset":
                continue
            name, script = _textasset_script(obj)
            if name not in want:
                continue
            msg = schema.find_table(name)
            if msg is None:
                continue
            out[name] = _pb_rows(_pb_decode_message(script, msg, schema))
            if len(out) == len(want):
                return out
    return out


def build_painting_names(tables: dict[str, Any]) -> dict[str, tuple[str, str]]:
    """SHD 目录 id → (角色名, 皮肤/变体名)。"""
    chades = {
        int(row["Id"]): _localized_content(row.get("Name"))
        for row in (tables.get("ChaDes") or [])
        if row.get("Id")
    }
    skindes = {
        int(row["Id"]): _localized_content(row.get("Name"))
        for row in (tables.get("SkinDes") or [])
        if row.get("Id")
    }
    skins = {int(row["Id"]): row for row in (tables.get("Skin") or []) if row.get("Id")}
    skin_to_char: dict[int, int] = {}
    for row in tables.get("Character") or []:
        lst = [int(x) for x in (row.get("CharacterSkinList") or [])]
        if not lst:
            continue
        cid = lst[0]
        for sid in lst:
            skin_to_char[sid] = cid
    live2d_to_skin: dict[int, dict[str, Any]] = {}
    for skin in skins.values():
        lid = skin.get("CharacterLive2D")
        if lid:
            live2d_to_skin.setdefault(int(lid), skin)

    names: dict[str, tuple[str, str]] = {}

    def put(fid: int, cha: str, skin: str) -> None:
        names[str(fid)] = (cha, skin)

    for sid, skin in skins.items():
        cid = skin.get("Character") or skin_to_char.get(sid)
        if not cid:
            sc = skin.get("SkinCorrelation")
            if sc in chades:
                cid = sc
        cha = chades.get(int(cid), "") if cid else ""
        skn = skindes.get(sid, "")
        if not cha:
            continue
        if not skn:
            skn = "默认" if cid and int(cid) == sid else str(sid)
        put(sid, cha, skn)
        lid = skin.get("CharacterLive2D")
        if lid and int(lid) != sid:
            put(int(lid), cha, skn)

    for sid, cid in skin_to_char.items():
        if str(sid) in names:
            continue
        cha = chades.get(cid, "")
        if not cha:
            continue
        put(sid, cha, skindes.get(sid, "") or "默认")

    for cid, cha in chades.items():
        if str(cid) not in names:
            put(cid, cha, skindes.get(cid, "") or "默认")

    for row in tables.get("ProSkin") or []:
        title = str(row.get("Name") or "").strip() or "主角"
        for key, suffix in (("MaleSkin", "男"), ("FemaleSkin", "女")):
            pid = row.get(key)
            if not pid or str(pid) in names:
                continue
            put(int(pid), f"{title}{suffix}", title)
    return names


def resolve_painting_name(fid: str, names: dict[str, tuple[str, str]]) -> tuple[str, str]:
    if fid in names:
        return names[fid]
    try:
        alt = str(int(fid))
    except ValueError:
        return fid, fid
    if alt in names:
        return names[alt]
    return fid, fid


def painting_filename(cha: str, skin: str, used: set[str]) -> str:
    base = f"{GAME_TITLE}_{_safe_fs_name(cha)}_{_safe_fs_name(skin)}.png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while True:
        name = f"{GAME_TITLE}_{_safe_fs_name(cha)}_{_safe_fs_name(skin)}_{n}.png"
        if name not in used:
            used.add(name)
            return name
        n += 1


def _parse_spine_atlas(text: str) -> list[dict[str, str]]:
    """解析 Spine/libgdx atlas：缩进键属于 region，未缩进 size: 属于 page。"""
    regions: list[dict[str, str]] = []
    lines = text.splitlines()
    i = 0

    def indented(raw: str) -> bool:
        return raw.startswith(" ") or raw.startswith("\t")

    while i < len(lines):
        raw = lines[i]
        line = raw.rstrip()
        i += 1
        if not line.strip() or indented(raw):
            continue
        nxt = None
        j = i
        while j < len(lines) and not lines[j].strip():
            j += 1
        if j < len(lines):
            nxt = lines[j]
        if nxt is None:
            continue
        if not indented(nxt) and nxt.strip().startswith("size:"):
            while i < len(lines) and lines[i].strip() and not indented(lines[i]) and ":" in lines[i]:
                i += 1
            continue
        region = {"name": line.strip()}
        while i < len(lines) and indented(lines[i]) and ":" in lines[i]:
            key, val = lines[i].strip().split(":", 1)
            region[key.strip()] = val.strip()
            i += 1
        regions.append(region)
    return regions


def _parse_int_pair(text: str) -> tuple[int, int]:
    left, right = text.split(",", 1)
    return int(float(left.strip())), int(float(right.strip()))


def _atlas_name_key(name: str) -> str:
    return name.lower().rsplit(".", 1)[0]


def _pick_atlas_region(
    regions: list[dict[str, str]],
    fid: str,
    tex_name: str,
) -> dict[str, str] | None:
    keys = {_atlas_name_key(fid)}
    try:
        keys.add(str(int(fid)))
    except ValueError:
        pass
    if tex_name:
        keys.add(_atlas_name_key(tex_name))
    matched = [reg for reg in regions if _atlas_name_key(reg.get("name") or "") in keys]
    if len(matched) == 1:
        return matched[0]
    if len(matched) > 1:
        return max(
            matched,
            key=lambda r: (lambda wh: wh[0] * wh[1])(_parse_int_pair(r.get("size") or "0,0")),
        )
    if len(regions) == 1:
        return regions[0]
    return None


def _crop_atlas_region(image: Any, region: dict[str, str]) -> Any:
    x, y = _parse_int_pair(region.get("xy") or "0,0")
    width, height = _parse_int_pair(region.get("size") or f"{image.width},{image.height}")
    rotate = (region.get("rotate") or "false").strip().lower()
    packed_w, packed_h = (height, width) if rotate in ("true", "90") else (width, height)
    packed_w = max(1, min(packed_w, image.width - x))
    packed_h = max(1, min(packed_h, image.height - y))
    cropped = image.crop((x, y, x + packed_w, y + packed_h))
    if rotate in ("true", "90"):
        cropped = cropped.rotate(90, expand=True)
    elif rotate == "180":
        cropped = cropped.rotate(180, expand=True)
    elif rotate == "270":
        cropped = cropped.rotate(270, expand=True)
    return cropped


def _export_shd_texture(bundle: Path, dest: Path, fid: str = "") -> str:
    """导出立绘。优先同名 Sprite，其次 Spine atlas 单区域裁切；分件图集跳过。

    返回 ok / skip / fail。
    """
    import UnityPy  # noqa: PLC0415

    env = UnityPy.load(str(bundle))
    textures: list[tuple[str, Any]] = []
    sprites: list[Any] = []
    atlas_text = ""
    for obj in env.objects:
        kind = getattr(obj.type, "name", None)
        if kind == "Texture2D":
            data = obj.read()
            image = data.image
            if image is not None:
                textures.append((str(data.m_Name or ""), image))
        elif kind == "Sprite":
            sprites.append(obj.read())
        elif kind == "TextAsset":
            name, script = _textasset_script(obj)
            try:
                text = script.decode("utf-8")
            except Exception:  # noqa: BLE001
                continue
            if "xy:" in text and "size:" in text:
                atlas_text = text

    if not textures:
        return "skip"

    tex_name, image = max(textures, key=lambda item: item[1].width * item[1].height)
    want = {_atlas_name_key(tex_name), _atlas_name_key(fid)} if fid else {_atlas_name_key(tex_name)}

    for sprite in sprites:
        sname = _atlas_name_key(str(getattr(sprite, "m_Name", "") or ""))
        if sname in want or (not fid and sname):
            cropped = sprite.image
            if cropped is not None:
                dest.parent.mkdir(parents=True, exist_ok=True)
                cropped.save(dest, "PNG")
                return "ok"

    if atlas_text:
        regions = _parse_spine_atlas(atlas_text)
        region = _pick_atlas_region(regions, fid, tex_name)
        if region is None:
            return "skip"
        image = _crop_atlas_region(image, region)

    dest.parent.mkdir(parents=True, exist_ok=True)
    image.save(dest, "PNG")
    return "ok"


def export_paintings(
    shd_targets: list[tuple[AssetItem, str]],
    table_targets: list[tuple[AssetItem, str]],
) -> int:
    """导出 SHD 立绘 PNG 到 Painting/悠久之树_角色名_皮肤名.png。返回失败数。"""
    warnings.filterwarnings("ignore", message="No valid Unity version found")
    tables = _load_named_tables(table_targets, PAINTING_NAME_TABLES)
    names = build_painting_names(tables)
    PAINTING_DIR.mkdir(parents=True, exist_ok=True)
    for name, rows in tables.items():
        (PAINTING_DIR / f"{name}.json").write_text(
            json.dumps(rows, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
    named = sum(1 for _item, fid in shd_targets if resolve_painting_name(fid, names)[0] != fid)
    console.print(
        f"[cyan]立绘名称[/] Skin/ChaDes 命中 {named}/{len(shd_targets)}  "
        f"表 {', '.join(k for k in PAINTING_NAME_TABLES if k in tables)}"
    )
    for old in PAINTING_DIR.glob("*.png"):
        old.unlink()
    used: set[str] = set()
    fail = 0
    written = 0
    skipped = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=max(len(shd_targets), 1))
        for item, fid in shd_targets:
            cha, skin = resolve_painting_name(fid, names)
            filename = painting_filename(cha, skin, used)
            dest = PAINTING_DIR / filename
            progress.update(task, description=f"导出 {cha or fid}")
            bundle = local_path_for(item)
            if not bundle.is_file():
                console.print(f"[yellow]缺立绘 AB[/] {fid} {item.name}")
                fail += 1
                used.discard(filename)
                progress.advance(task)
                continue
            try:
                status = _export_shd_texture(bundle, dest, fid=fid)
                if status == "ok":
                    written += 1
                elif status == "skip":
                    skipped += 1
                    used.discard(filename)
                    dest.unlink(missing_ok=True)
                else:
                    fail += 1
                    used.discard(filename)
                    dest.unlink(missing_ok=True)
            except Exception as exc:  # noqa: BLE001
                console.print(f"[red]立绘失败[/] {fid}: {exc}")
                fail += 1
                used.discard(filename)
                dest.unlink(missing_ok=True)
            progress.advance(task)
    console.print(
        f"[cyan]Painting[/] 写出 {written} 张 → {PAINTING_DIR}  "
        f"跳过分件 Spine {skipped}  失败 {fail}"
    )
    return fail


def cmd_status(channel: str) -> int:
    versions = fetch_json(VERSIONS_URLS)
    info = channel_info(versions, channel)
    print_channel(channel, info)
    cdns = [str(c) for c in (info.get("cdn") or [])]
    resv = int(info.get("resv") or 0)
    if not cdns or not resv:
        return 1
    url = manifest_url(cdns[0], PLATFORM, resv)
    console.print(f"清单: {url}")
    text, used = pull_text(cdns, PLATFORM, resv, "patch")
    ver, pver, items = parse_patch_manifest(text)
    assets = [i for i in items if not i.group.startswith("Extra/")]
    extras = [i for i in items if i.group.startswith("Extra/")]
    langs = sorted({i.group.split("/", 1)[1] for i in extras})
    total = sum(i.length for i in assets)
    console.print(f"清单来源: {used}")
    console.print(f"Version={ver} PatchVer={pver}  Assets={len(assets)} ({format_size(total)})  Extra={len(extras)} {langs}")
    state = load_state()
    console.print(f"本地 resv: {state.get('resv', '(无)')}")
    if state.get("resv") == resv:
        console.print("[green]resv 未变化，下载会跳过已校验文件[/]")
    else:
        console.print("[cyan]resv 有更新[/]")
    return 0


def cmd_list_channels() -> int:
    versions = fetch_json(VERSIONS_URLS)
    table = Table(title="versions.json 渠道")
    table.add_column("渠道")
    table.add_column("appver")
    table.add_column("resv", justify="right")
    table.add_column("cdn")
    for key in sorted(versions):
        info = versions[key]
        if not isinstance(info, dict):
            continue
        cdns = info.get("cdn") or []
        table.add_row(key, str(info.get("appver")), str(info.get("resv")), cdns[0] if cdns else "")
    console.print(table)
    return 0


def cmd_download(
    channel: str,
    workers: int,
    retries: int,
    force: bool,
    extras: list[str],
    dll: bool,
    masterdata: bool,
    painting: bool,
    limit: int | None,
) -> int:
    if sum(bool(x) for x in (dll, masterdata, painting)) > 1:
        console.print("[red]--dll / --masterdata / --painting 不能同时使用[/]")
        return 1
    versions = fetch_json(VERSIONS_URLS)
    info = channel_info(versions, channel)
    print_channel(channel, info)
    cdns = [str(c) for c in (info.get("cdn") or [])]
    resv = int(info.get("resv") or 0)
    if not cdns or not resv:
        console.print("[red]渠道缺少 cdn / resv[/]")
        return 1

    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    console.print(f"拉取清单 resv={resv} …")
    text, used = pull_text(cdns, PLATFORM, resv, "patch")
    man_path = ASSETS_DIR / "_manifest" / f"patch_assets_Manifest_{resv}.yaml"
    man_path.parent.mkdir(parents=True, exist_ok=True)
    man_path.write_text(text, encoding="utf-8")
    ver, pver, items = parse_patch_manifest(text)
    console.print(f"[cyan]清单[/] {used}")
    console.print(f"Version={ver} PatchVer={pver} 条目 {len(items)}")

    hash_to_paths: dict[str, list[str]] = {}
    if not dll:
        try:
            refl, refl_url = pull_text(cdns, PLATFORM, resv, "reflection")
            refl_path = ASSETS_DIR / "_manifest" / f"reflection_manifest_{resv}.yaml"
            refl_path.write_text(refl, encoding="utf-8")
            hash_to_paths = parse_reflection_manifest(refl)
            mapped = sum(1 for i in items if i.name.lower() in hash_to_paths)
            console.print(
                f"[cyan]reflection[/] {refl_url}  "
                f"{len(hash_to_paths)} 个 CDN 文件 / {sum(len(v) for v in hash_to_paths.values())} 条逻辑路径  "
                f"命中清单 {mapped}/{len(items)}"
            )
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow]reflection_manifest 跳过:[/] {exc}")

    extra_set = {x.lower() for x in extras}
    want_all_extra = "all" in extra_set
    table_targets: list[tuple[AssetItem, str]] = []
    shd_targets: list[tuple[AssetItem, str]] = []
    if not dll:
        if not hash_to_paths:
            msg = "没有 reflection_manifest，无法定位数据表 / 立绘 AB"
            if masterdata or painting:
                console.print(f"[red]{msg}[/]")
                return 1
            console.print(f"[yellow]{msg}，跳过 MasterData[/]")
        else:
            table_targets = iter_table_items(items, hash_to_paths, extra_set, want_all_extra)
            if painting:
                table_targets = [(item, sub) for item, sub in table_targets if not sub]
            if (masterdata or painting) and not table_targets:
                console.print("[red]reflection 里没有 JsonData / Language 数据表[/]")
                return 1

    selected: list[AssetItem] = []
    if dll:
        selected = [item for item in items if item.name.upper() in HOT_ASSEMBLY_BY_HASH]
        found = {item.name.upper() for item in selected}
        missing = [name for digest, name in HOT_ASSEMBLY_BY_HASH.items() if digest not in found]
        if missing:
            console.print(f"[red]远端清单缺少热更 DLL:[/] {', '.join(missing)}")
            return 1
        console.print(f"热更 DLL {len(selected)} 个 → {HOTDLL_DIR}")
    elif masterdata:
        seen: set[str] = set()
        for item, _sub in table_targets:
            if item.name.lower() not in seen:
                selected.append(item)
                seen.add(item.name.lower())
        dll_item = config_dll_item(items)
        if need_config_dll():
            if dll_item is None:
                console.print(f"[red]远端清单缺少 {CONFIG_DLL_NAME}，无法解析数据表[/]")
                return 1
            if dll_item.name.lower() not in seen:
                selected.append(dll_item)
        n_base = sum(1 for _i, sub in table_targets if not sub)
        n_loc = len(table_targets) - n_base
        console.print(
            f"数据表 AB {len(table_targets)} 个（基线 {n_base} / 语言包 {n_loc}）→ {MASTER_DIR}"
        )
    elif painting:
        shd_targets = iter_shd_items(items, hash_to_paths)
        if not shd_targets:
            console.print("[red]reflection 里没有 FolderSplitBundle/SHD 立绘[/]")
            return 1
        if limit is not None:
            shd_targets = shd_targets[:limit]
            console.print(f"[yellow]--limit {limit} 立绘[/]")
            limit = None
        seen: set[str] = set()
        for item, _sub in table_targets:
            if item.name.lower() not in seen:
                selected.append(item)
                seen.add(item.name.lower())
        for item, _fid in shd_targets:
            if item.name.lower() not in seen:
                selected.append(item)
                seen.add(item.name.lower())
        dll_item = config_dll_item(items)
        if need_config_dll():
            if dll_item is None:
                console.print(f"[red]远端清单缺少 {CONFIG_DLL_NAME}，无法还原立绘名称[/]")
                return 1
            if dll_item.name.lower() not in seen:
                selected.append(dll_item)
        console.print(
            f"立绘 SHD {len(shd_targets)} 个 + 名称表 {len(table_targets)} 个 → {PAINTING_DIR}"
        )
    else:
        for item in items:
            if item.group.startswith("Extra/"):
                lang = item.group.split("/", 1)[1].lower()
                if want_all_extra or lang in extra_set:
                    selected.append(item)
                continue
            selected.append(item)
    if limit is not None:
        selected = selected[:limit]
        console.print(f"[yellow]--limit {limit}[/]")

    total_bytes = sum(i.length for i in selected)
    console.print(f"待处理 {len(selected)} 个文件 / {format_size(total_bytes)}")

    stats = {"ok": 0, "skip": 0, "fail": 0}
    errors: list[str] = []
    done_bytes = 0
    bytes_lock = threading.Lock()

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("下载资源", total=max(total_bytes, 1))

        def work(item: AssetItem) -> tuple[str, AssetItem]:
            dest = local_path_for(item)
            urls = [resource_url(cdn, PLATFORM, item.patch_ver, item.name) for cdn in cdns]
            status = download_file(urls, dest, item, retries=retries, force=force)
            maybe_decrypt_hot_dll(item, dest)
            return status, item

        with ThreadPoolExecutor(max_workers=max(1, workers)) as pool:
            futures = {pool.submit(work, item): item for item in selected}
            for fut in as_completed(futures):
                item = futures[fut]
                try:
                    status, item = fut.result()
                    stats[status] = stats.get(status, 0) + 1
                except Exception as exc:  # noqa: BLE001
                    stats["fail"] += 1
                    errors.append(f"{item.group}/{item.name}: {exc}")
                    console.print(f"[red]FAIL[/] {item.name}: {exc}")
                with bytes_lock:
                    done_bytes += item.length
                    progress.update(task, completed=min(done_bytes, total_bytes))

    save_state(
        {
            "channel": channel,
            "appver": info.get("appver"),
            "resv": resv,
            "version": ver,
            "patch_ver": pver,
            "cdn": cdns,
            "files": len(selected),
            "dll": dll,
            "masterdata": masterdata,
            "painting": painting,
        }
    )
    console.print()
    console.print(
        f"[bold]完成[/] 下载 {stats['ok']}  跳过 {stats['skip']}  失败 {stats['fail']}"
    )
    rc = 1 if errors else 0
    if errors:
        err_log = ROOT / "download_errors.log"
        err_log.write_text("\n".join(errors) + "\n", encoding="utf-8")
        console.print(f"[yellow]错误写入 {err_log} ({len(errors)})[/]")
    if painting:
        if export_paintings(shd_targets, table_targets):
            rc = 1
    elif not dll and table_targets:
        if export_masterdata(table_targets):
            rc = 1
    return rc


def main() -> int:
    parser = argparse.ArgumentParser(description="悠久之树 资产下载更新 / 数据表导出 / 远端热更 DLL 解密")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_st = sub.add_parser("status", help="查看远端 versions.json / 清单")
    p_st.add_argument("--channel", default=DEFAULT_CHANNEL)

    sub.add_parser("list-channels", help="列出 versions.json 全部渠道")

    p_dl = sub.add_parser(
        "download",
        help="按 patch_assets_Manifest.yaml 下载/更新资产；完成后解析数据表到 MasterData/",
    )
    p_dl.add_argument("--channel", default=DEFAULT_CHANNEL, help="versions.json 键，默认 and4.3.101")
    p_dl.add_argument("--workers", type=int, default=8)
    p_dl.add_argument("--retries", type=int, default=RETRY_COUNT)
    p_dl.add_argument("--force", action="store_true")
    p_dl.add_argument(
        "--extra",
        action="append",
        default=[],
        help="额外语言包：ChineseSimplified / Japanese / ChineseTraditional / all，可重复",
    )
    p_dl.add_argument(
        "--dll",
        action="store_true",
        help="只从 CDN 下载 HybridDllLoader.HotAssemblyFiles 并解密到 HotDlls/",
    )
    p_dl.add_argument(
        "--masterdata",
        action="store_true",
        help="只下载 JsonData/Language 数据表 AB，解析导出到 MasterData/",
    )
    p_dl.add_argument(
        "--painting",
        action="store_true",
        help="只下载 SHD 立绘和名称表，导出到 Painting/悠久之树_角色名_皮肤名.png",
    )
    p_dl.add_argument("--limit", type=int, default=None)

    args = parser.parse_args()
    if args.cmd == "status":
        return cmd_status(args.channel)
    if args.cmd == "list-channels":
        return cmd_list_channels()
    if args.cmd == "download":
        return cmd_download(
            channel=args.channel,
            workers=args.workers,
            retries=args.retries,
            force=args.force,
            extras=args.extra,
            dll=args.dll,
            masterdata=args.masterdata,
            painting=args.painting,
            limit=args.limit,
        )
    parser.error("unknown command")
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
