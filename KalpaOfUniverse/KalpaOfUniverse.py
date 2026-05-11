from __future__ import annotations

import functools
import json
import os
import re
import shutil
import struct
import subprocess
import tempfile
import time
import warnings
from typing import Any, Dict, List, Optional, Tuple

import requests
import UnityPy
import UnityPy.config
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

warnings.filterwarnings("ignore", category=UserWarning, module="UnityPy")

console = Console()

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
MASTER_DIR = os.path.join(ROOT_DIR, "MasterData")
SCHEMA_DIR = os.path.join(ROOT_DIR, "schema")
LEGACY_SCHEMA_DIR = os.path.join(ROOT_DIR, "output")
DLL_DIR = os.path.join(ROOT_DIR, "dll")
SCHEMA_GENERATOR_EXE = os.path.join(
    ROOT_DIR, "SchemaGenerate", "bin", "Debug", "net8.0", "DNFBDmp"
)
SCHEMA_GENERATOR_DLL = os.path.join(
    ROOT_DIR, "SchemaGenerate", "bin", "Debug", "net8.0", "DNFBDmp.dll"
)

SETTING_URL = (
    "http://tdjclient.zlongame.com/TDJ/android_ob65/android_bilibili_serversetting.txt"
)
UNITYCN_KEY_HEX = "426C61636B4A61636B54444A50726F6A"
TARGET_BUNDLE_NAME = "configdata_abs.b"
MANIFEST_BUNDLE_NAME = "assets_gameproject_runtimeassets_bundledataandroid_asset.b"
MERGED_PROTO_NAME = "BlackJack.ConfigData_inferred_merged.proto"

os.makedirs(MASTER_DIR, exist_ok=True)

decrypt_key = bytes.fromhex(UNITYCN_KEY_HEX)
try:
    UnityPy.set_assetbundle_decrypt_key(decrypt_key)
except AttributeError:
    pass
try:
    UnityPy.config.UNITYCN_KEY = decrypt_key
except AttributeError:
    pass


def schema_dir() -> str:
    if os.path.isdir(SCHEMA_DIR):
        return SCHEMA_DIR
    if os.path.isdir(LEGACY_SCHEMA_DIR):
        return LEGACY_SCHEMA_DIR
    return SCHEMA_DIR


def get_base_url() -> str:
    console.print(f"正在请求 ServerSetting: {SETTING_URL}")
    r = requests.get(SETTING_URL, timeout=20)
    r.raise_for_status()
    text = r.text.strip()

    raw_urls = re.findall(r"https?://[^\s\"'<>]+", text)
    urls: List[str] = []
    for raw in raw_urls:
        for part in raw.split(","):
            part = part.strip()
            if part:
                urls.append(part)
    if not urls:
        raise RuntimeError("未能从 ServerSetting 中解析基础下载路径")

    preferred = None
    for keyword in ("UpdateClientData", "ClientPath", "tdjupdate.zlongame.com"):
        for url in urls:
            if keyword.lower() in url.lower():
                preferred = url
                break
        if preferred:
            break
    if preferred is None:
        non_login_urls = [u for u in urls if "login" not in u.lower()]
        preferred = max(non_login_urls or urls, key=len)

    base = preferred.rstrip("/")
    console.print(f"[bold green]✔ 获取到基础下载路径: {base}[/]")
    return base


def download_bytes(
    url: str, expected_size: Optional[int] = None, retries: int = 3
) -> Optional[bytes]:
    for attempt in range(1, retries + 1):
        try:
            chunks: List[bytes] = []
            with requests.get(url, stream=True, timeout=30) as r:
                r.raise_for_status()
                total = int(r.headers.get("Content-Length", "0")) or expected_size or 0
                with Progress(
                    TextColumn("Downloading {task.description}"),
                    BarColumn(),
                    DownloadColumn(),
                    TransferSpeedColumn(),
                    TimeRemainingColumn(),
                    console=console,
                ) as progress:
                    task = progress.add_task(
                        url.rsplit("/", 1)[-1], total=total if total > 0 else None
                    )
                    for chunk in r.iter_content(chunk_size=1024 * 256):
                        if not chunk:
                            continue
                        chunks.append(chunk)
                        progress.update(task, advance=len(chunk))
            blob = b"".join(chunks)
            if expected_size is not None and len(blob) != expected_size:
                raise RuntimeError(f"文件大小不匹配: {len(blob)} != {expected_size}")
            console.print(f"[bold green]✔ 下载完成: {url.rsplit('/', 1)[-1]}[/]")
            return blob
        except Exception as e:
            console.print(f"[yellow]⚠ 下载失败 (尝试 {attempt}/{retries}): {e}[/]")
            time.sleep(1)
    return None


def _str_to_script_bytes(s: str) -> bytes:
    return s.encode("utf-8", errors="surrogateescape") if s else b""


def get_textasset_bytes(obj, data) -> bytes:
    try:
        tt = obj.read_typetree()
        if isinstance(tt, dict):
            for key in ("m_Script", "script", "Script", "m_ScriptData"):
                v = tt.get(key)
                if isinstance(v, memoryview):
                    b = v.tobytes()
                    if b:
                        return b
                if isinstance(v, (bytes, bytearray)) and v:
                    return bytes(v)
                if isinstance(v, str) and v:
                    return _str_to_script_bytes(v)
    except Exception:
        pass

    for attr in ("script", "m_Script", "m_ScriptData", "bytes", "raw_data"):
        v = getattr(data, attr, None)
        if isinstance(v, memoryview):
            b = v.tobytes()
            if b:
                return b
        if isinstance(v, (bytes, bytearray)) and v:
            return bytes(v)
        if isinstance(v, str) and v:
            return _str_to_script_bytes(v)
    return b""


def _safe_name(name: str) -> str:
    return re.sub(r'[<>:"/\\\\|?*]+', "_", name).strip() or "unnamed"


def extract_bundle_manifest_from_bytes(bundle_data: bytes) -> Dict[str, Any]:
    env = UnityPy.load(bundle_data)
    for obj in env.objects:
        if obj.type.name not in ("MonoBehaviour", "AssetBundleManifest", "TextAsset"):
            continue
        try:
            tt = obj.read_typetree()
        except Exception:
            continue
        if not isinstance(tt, dict):
            continue
        for key in ("m_bundleList", "bundleList"):
            if isinstance(tt.get(key), list):
                console.print(
                    "[bold green]✔ 成功解析出目标清单 (Name: BundleDataAndroid)[/]"
                )
                return tt
    raise RuntimeError("未找到可用的 BundleDataAndroid 清单对象")


def collect_configdata_assets_from_bytes(bundle_data: bytes) -> Dict[str, bytes]:
    env = UnityPy.load(bundle_data)
    files: Dict[str, bytes] = {}
    total_entries = 0
    text_asset_count = 0

    with Progress(
        TextColumn("Extracting"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total} Files"),
        console=console,
    ) as progress:
        task = progress.add_task("extract", total=len(env.container))
        for path, obj in env.container.items():
            total_entries += 1
            progress.advance(task)
            try:
                if obj.type.name != "TextAsset":
                    continue
                norm = path.replace("\\", "/").lower()
                if "/configdata00/" not in norm:
                    continue
                data = obj.read()
                blob = get_textasset_bytes(obj, data)
                base_name = _safe_name(
                    os.path.basename(path) or getattr(data, "name", "unnamed")
                )
                if not os.path.splitext(base_name)[1]:
                    base_name += ".bytes"
                files[base_name] = blob
                text_asset_count += 1
            except Exception:
                continue
    return files


def _generator_command() -> Optional[List[str]]:
    if os.path.isfile(SCHEMA_GENERATOR_EXE) and os.access(
        SCHEMA_GENERATOR_EXE, os.X_OK
    ):
        return [SCHEMA_GENERATOR_EXE]
    if os.path.isfile(SCHEMA_GENERATOR_DLL):
        return ["dotnet", SCHEMA_GENERATOR_DLL]
    return None


def _generator_stamp_mtime() -> float:
    cmd = _generator_command()
    if not cmd:
        return 0.0
    stamp = cmd[0] if len(cmd) == 1 else cmd[1]
    return os.path.getmtime(stamp) if os.path.isfile(stamp) else 0.0


def _dll_dir_max_mtime() -> float:
    if not os.path.isdir(DLL_DIR):
        return 0.0
    mtimes = [
        os.path.getmtime(os.path.join(DLL_DIR, name))
        for name in os.listdir(DLL_DIR)
        if name.lower().endswith(".dll")
    ]
    return max(mtimes, default=0.0)


@functools.lru_cache(maxsize=8)
def _load_merged_pool_and_index_cached(dll_mtime: float, gen_mtime: float):
    from google.protobuf.descriptor_pb2 import FileDescriptorSet
    from google.protobuf.descriptor_pool import DescriptorPool
    from google.protobuf.message_factory import GetMessageClass

    protoc = shutil.which("protoc")
    if not protoc:
        raise EnvironmentError("未找到 protoc，请先安装 protobuf-compiler")
    gen_cmd = _generator_command()
    if not gen_cmd:
        raise FileNotFoundError("未找到 SchemaGenerate 生成器，请先构建 DNFBDmp")

    with tempfile.TemporaryDirectory(prefix="tdj_schema_", dir=ROOT_DIR) as temp_dir:
        merged_proto_path = os.path.join(temp_dir, MERGED_PROTO_NAME)
        merged_fdset_path = os.path.join(temp_dir, "merged.pb")

        console.print(f"正在生成 merged proto：{MERGED_PROTO_NAME}")
        r = subprocess.run(
            [*gen_cmd, DLL_DIR, temp_dir, "--merge-infer"],
            capture_output=True,
            text=True,
            timeout=600,
        )
        if r.returncode != 0 or not os.path.isfile(merged_proto_path):
            raise RuntimeError(
                f"生成 merged proto 失败：{(r.stderr or r.stdout).strip()}"
            )

        r = subprocess.run(
            [
                protoc,
                "-I",
                temp_dir,
                "--include_imports",
                f"--descriptor_set_out={merged_fdset_path}",
                merged_proto_path,
            ],
            capture_output=True,
            text=True,
            timeout=600,
        )
        if r.returncode != 0:
            raise RuntimeError(
                f"编译 merged proto 失败：{(r.stderr or r.stdout).strip()}"
            )
        fdset_bytes = open(merged_fdset_path, "rb").read()

    fds = FileDescriptorSet.FromString(fdset_bytes)
    pool = DescriptorPool()
    for fd in fds.file:
        try:
            pool.Add(fd)
        except Exception:
            pool.AddSerializedFile(fd.SerializeToString())

    simple_index: Dict[str, List[str]] = {}

    def add_index(key: str, full_name: str):
        low = key.lower()
        bucket = simple_index.setdefault(low, [])
        if full_name not in bucket:
            bucket.append(full_name)

    def walk(pkg: str, prefix: str, messages):
        for msg in messages:
            full_name = ".".join(part for part in (pkg, prefix, msg.name) if part)
            simple = full_name.split(".")[-1]
            add_index(simple, full_name)
            if simple.lower().endswith("info"):
                add_index(simple[:-4], full_name)
            walk(
                pkg,
                ".".join(part for part in (prefix, msg.name) if part),
                msg.nested_type,
            )

    for fd in fds.file:
        walk(fd.package, "", fd.message_type)

    def make_message(full_name: str):
        desc = pool.FindMessageTypeByName(full_name)
        cls = GetMessageClass(desc)
        return cls()

    return pool, make_message, simple_index


def load_merged_pool_and_index():
    return _load_merged_pool_and_index_cached(
        _dll_dir_max_mtime(), _generator_stamp_mtime()
    )


def build_schema_index() -> Dict[str, str]:
    index: Dict[str, str] = {}
    sdir = schema_dir()
    if not os.path.isdir(sdir):
        return index
    for name in os.listdir(sdir):
        if not name.lower().endswith(".proto"):
            continue
        stem = os.path.splitext(name)[0]
        index[stem.lower()] = stem
        if stem.lower().endswith("info"):
            index[stem[:-4].lower()] = stem
    return index


def _iter_file_lookup_keys(stem: str):
    seen = set()

    def add(v: str):
        v = v.lower()
        if v and v not in seen:
            seen.add(v)
            yield v

    low = stem.lower()
    base = re.sub(r"_\d+$", "", low)
    for item in add(low):
        yield item
    if base != low:
        for item in add(base):
            yield item
    for candidate in (low, base):
        if candidate.endswith("info"):
            for item in add(candidate[:-4]):
                yield item
        else:
            for item in add(candidate + "info"):
                yield item


SPECIAL_STEM_ALIASES = {
    "configdatamozicontentbossfeature": "configdatamozicontentbossfeatureinfo",
}


def resolve_message_candidates(
    stem: str,
    schema_index: Dict[str, str],
    merged_index: Dict[str, List[str]],
) -> Tuple[Optional[str], List[str]]:
    candidates: List[str] = []
    seen_full = set()
    canonical_schema = None

    def add_full(full_name: str):
        if full_name not in seen_full:
            seen_full.add(full_name)
            candidates.append(full_name)

    keys = list(_iter_file_lookup_keys(stem))
    for key in list(keys):
        alias = SPECIAL_STEM_ALIASES.get(key)
        if alias and alias not in keys:
            keys.append(alias)

    for key in keys:
        schema_stem = schema_index.get(key)
        if schema_stem and canonical_schema is None:
            canonical_schema = schema_stem
        if schema_stem:
            for full_name in merged_index.get(schema_stem.lower(), []):
                add_full(full_name)
        for full_name in merged_index.get(key, []):
            add_full(full_name)

    if canonical_schema is None and candidates:
        canonical_schema = candidates[0].split(".")[-1]
    return canonical_schema, candidates


def parse_configdata_messages(
    raw: bytes, make_message, full_type: str
) -> Optional[List[Any]]:
    if not raw:
        return None
    if len(raw) == 4 and raw == b"\x00\x00\x00\x00":
        return []

    def _one(blob: bytes) -> Any:
        msg = make_message(full_type)
        msg.ParseFromString(blob)
        return msg

    if len(raw) >= 8:
        count, first_len = struct.unpack(">II", raw[:8])
        if count > 0 and first_len > 0:
            pos = 8
            msgs: List[Any] = []
            msg_len = first_len
            ok = True
            for i in range(count):
                if msg_len <= 0 or pos + msg_len > len(raw):
                    ok = False
                    break
                try:
                    msgs.append(_one(raw[pos : pos + msg_len]))
                except Exception:
                    ok = False
                    break
                pos += msg_len
                if i < count - 1:
                    if pos == len(raw) and msgs:
                        return msgs
                    if pos + 4 > len(raw):
                        ok = False
                        break
                    msg_len = struct.unpack(">I", raw[pos : pos + 4])[0]
                    pos += 4
            if ok and pos == len(raw) and msgs:
                return msgs

    if len(raw) > 8:
        c1, _ = struct.unpack(">II", raw[:8])
        if c1 == 1:
            try:
                return [_one(raw[8:])]
            except Exception:
                pass

    if len(raw) >= 12:
        _c, zero, body_len = struct.unpack(">III", raw[:12])
        if zero == 0 and body_len > 0 and 12 + body_len == len(raw):
            try:
                return [_one(raw[12:])]
            except Exception:
                pass

    if len(raw) >= 12:
        count, zero, first_len = struct.unpack(">III", raw[:12])
        if count > 0 and zero == 0 and first_len > 0:
            pos = 12
            msgs = []
            msg_len = first_len
            ok = True
            for i in range(count):
                if msg_len <= 0 or pos + msg_len > len(raw):
                    ok = False
                    break
                try:
                    msgs.append(_one(raw[pos : pos + msg_len]))
                except Exception:
                    ok = False
                    break
                pos += msg_len
                if i < count - 1:
                    if pos == len(raw) and msgs:
                        return msgs
                    if pos + 4 > len(raw):
                        ok = False
                        break
                    msg_len = struct.unpack(">I", raw[pos : pos + 4])[0]
                    pos += 4
            if ok and pos == len(raw) and msgs:
                return msgs

    if len(raw) >= 12:
        _c, second = struct.unpack(">II", raw[:8])
        if second == 0:
            pos = 12
            short_msgs: List[Any] = []
            while pos + 2 <= len(raw):
                if pos + 4 <= len(raw) and raw[pos : pos + 4] == b"\x00\x00\x00\x02":
                    pos += 4
                if pos + 2 <= len(raw) and raw[pos] == 0x10:
                    try:
                        short_msgs.append(_one(raw[pos : pos + 2]))
                    except Exception:
                        short_msgs.clear()
                        break
                    pos += 2
                else:
                    break
            if short_msgs:
                return short_msgs

    try:
        return [_one(raw)]
    except Exception:
        return None


def _read_varint(buf: bytes, pos: int) -> Tuple[int, int]:
    value = 0
    shift = 0
    while True:
        if pos >= len(buf):
            raise EOFError("unexpected eof while reading varint")
        b = buf[pos]
        pos += 1
        value |= (b & 0x7F) << shift
        if b < 0x80:
            return value, pos
        shift += 7
        if shift > 64:
            raise ValueError("varint too long")


def _parse_wire_fields(blob: bytes) -> List[Tuple[int, int, bytes]]:
    pos = 0
    out: List[Tuple[int, int, bytes]] = []
    while pos < len(blob):
        tag, pos = _read_varint(blob, pos)
        field_number = tag >> 3
        wire_type = tag & 0x07
        if wire_type == 0:
            start = pos
            _, pos = _read_varint(blob, pos)
            out.append((field_number, wire_type, blob[start:pos]))
        elif wire_type == 1:
            out.append((field_number, wire_type, blob[pos : pos + 8]))
            pos += 8
        elif wire_type == 2:
            size, pos = _read_varint(blob, pos)
            out.append((field_number, wire_type, blob[pos : pos + size]))
            pos += size
        elif wire_type == 5:
            out.append((field_number, wire_type, blob[pos : pos + 4]))
            pos += 4
        else:
            raise ValueError(f"unsupported wire type: {wire_type}")
    return out


def _decode_packed_ints(blob: bytes) -> List[int]:
    pos = 0
    values: List[int] = []
    while pos < len(blob):
        value, pos = _read_varint(blob, pos)
        values.append(value)
    return values


def _decode_nested_message_dict(
    blob: bytes, make_message, full_type: str
) -> Dict[str, Any]:
    from google.protobuf.json_format import MessageToDict

    msg = make_message(full_type)
    msg.ParseFromString(blob)
    return MessageToDict(msg, preserving_proto_field_name=True)


def parse_story_sum_item_info_custom(
    raw: bytes, make_message
) -> Optional[List[Dict[str, Any]]]:
    if len(raw) < 8:
        return None
    count, first_len = struct.unpack(">II", raw[:8])
    if count <= 0 or first_len <= 0:
        return None

    pos = 8
    msg_len = first_len
    rows: List[Dict[str, Any]] = []
    for i in range(count):
        if msg_len <= 0 or pos + msg_len > len(raw):
            return None
        blob = raw[pos : pos + msg_len]
        pos += msg_len
        if i < count - 1:
            if pos + 4 > len(raw):
                return None
            next_len = struct.unpack(">I", raw[pos : pos + 4])[0]
            pos += 4
        else:
            next_len = 0

        row: Dict[str, Any] = {}
        try:
            for field_number, wire_type, value in _parse_wire_fields(blob):
                if field_number == 2 and wire_type == 0:
                    row["ID"], _ = _read_varint(value, 0)
                elif field_number == 3 and wire_type == 0:
                    row["GameFunType"], _ = _read_varint(value, 0)
                elif field_number == 4 and wire_type == 2:
                    row.setdefault("JumpGameFunType", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.StoryJumpInfo"
                        )
                    )
                elif field_number == 5 and wire_type == 2:
                    row.setdefault("OpenCondition", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.ConditionInfo"
                        )
                    )
                elif field_number == 6 and wire_type == 2:
                    row.setdefault("FunParam", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.SSItemParam"
                        )
                    )
                elif field_number == 7 and wire_type == 2:
                    row["ExcludeDropIds"] = _decode_packed_ints(value)
                elif field_number == 8 and wire_type == 2:
                    row["ItemIds"] = _decode_packed_ints(value)
                elif field_number == 9 and wire_type == 2:
                    try:
                        row["UnknownField9"] = _decode_packed_ints(value)
                    except Exception:
                        row["UnknownField9"] = value.hex()
                elif field_number == 10 and wire_type == 2:
                    row["BGImage"] = value.decode("utf-8")
                elif field_number == 11 and wire_type == 2:
                    row["SubSmallBGImage"] = value.decode("utf-8")
                elif field_number == 12 and wire_type == 2:
                    row["SubBorderTag"] = value.decode("utf-8")
                elif field_number == 13 and wire_type == 2:
                    row.setdefault("AdjustPos", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.OffsetScale"
                        )
                    )
                elif field_number == 14 and wire_type == 2:
                    row["TitleStrKey"] = value.decode("utf-8")
                elif field_number == 15 and wire_type == 2:
                    row["TitleTagStrKey"] = value.decode("utf-8")
                elif field_number == 16 and wire_type == 2:
                    row["SubTitleStrKey"] = value.decode("utf-8")
                elif field_number == 17 and wire_type == 2:
                    row["DescStrKey"] = value.decode("utf-8")
                elif field_number == 18 and wire_type == 2:
                    row["SubBottomTagStrKey"] = value.decode("utf-8")
        except Exception:
            return None

        rows.append(row)
        msg_len = next_len

    return rows if pos == len(raw) else None


def export_json_from_memory(
    schema_index: Dict[str, str], files: Dict[str, bytes], master_root: str
) -> Tuple[int, int]:
    from google.protobuf.json_format import MessageToDict

    ok, fail, empty_tables = 0, 0, 0
    stat_no_schema = 0
    stat_parse = 0
    stat_empty_raw = 0
    stat_dict = 0
    failure_details: List[Dict[str, str]] = []
    master_root = os.path.abspath(master_root)

    def record_failure(file_name: str, reason: str, detail: str = ""):
        item = {"file": file_name, "reason": reason}
        if detail:
            item["detail"] = detail
        failure_details.append(item)

    all_files = sorted(
        name
        for name in files
        if os.path.splitext(name)[1].lower() in (".bytes", ".bin")
    )
    _, make_message, merged_index = load_merged_pool_and_index()
    console.print(
        f"仅处理 configdata00 目录中的 {len(all_files)} 个数据文件，并平铺导出到 {master_root}"
    )

    for base_name in all_files:
        stem, _ = os.path.splitext(base_name)
        resolved_schema, candidates = resolve_message_candidates(
            stem, schema_index, merged_index
        )
        if not candidates:
            stat_no_schema += 1
            fail += 1
            record_failure(base_name, "无可用消息类型匹配")
            continue

        raw = files[base_name]
        if len(raw) == 0:
            stat_empty_raw += 1
            fail += 1
            record_failure(base_name, "空文件")
            continue

        msgs = None
        custom_rows = None
        for full_type in candidates:
            try:
                msgs = parse_configdata_messages(raw, make_message, full_type)
                if msgs is not None:
                    break
            except Exception:
                msgs = None
        if msgs is None and stem.lower() == "configdatastorysumiteminfo":
            custom_rows = parse_story_sum_item_info_custom(raw, make_message)
        if msgs is None and custom_rows is None:
            stat_parse += 1
            fail += 1
            record_failure(
                base_name, "二进制与 proto 解析不匹配", ", ".join(candidates[:5])
            )
            continue

        try:
            if custom_rows is not None:
                d = custom_rows
            elif len(msgs) == 0:
                d = []
                empty_tables += 1
            elif len(msgs) == 1:
                d = MessageToDict(msgs[0], preserving_proto_field_name=True)
            else:
                d = [MessageToDict(m, preserving_proto_field_name=True) for m in msgs]
        except Exception:
            stat_dict += 1
            fail += 1
            record_failure(base_name, "转 JSON 异常")
            continue

        out_name = stem if re.search(r"_\d+$", stem) else (resolved_schema or stem)
        with open(
            os.path.join(master_root, f"{out_name}.json"), "w", encoding="utf-8"
        ) as jf:
            json.dump(d, jf, ensure_ascii=False, indent=2)
        ok += 1

    if empty_tables:
        console.print(
            f"[gray]其中空表（仅写入 []）{empty_tables} 个，多为 4 字节全 0 占位。[/]"
        )
    console.print(
        "[dim]失败原因统计："
        f"无可用消息类型匹配：{stat_no_schema}；"
        f"二进制与 proto 解析不匹配：{stat_parse}；"
        f"空文件：{stat_empty_raw}；"
        f"转 JSON 异常：{stat_dict}。[/]"
    )
    return ok, fail


def main():
    try:
        base_url = get_base_url()
        android_base_url = f"{base_url}/Android"

        manifest_blob = download_bytes(f"{android_base_url}/{MANIFEST_BUNDLE_NAME}")
        if manifest_blob is None:
            return

        manifest_data = extract_bundle_manifest_from_bytes(manifest_blob)
        bundle_list = manifest_data.get("m_bundleList", []) or manifest_data.get(
            "bundleList", []
        )
        target_info = next(
            (b for b in bundle_list if b.get("m_bundleName") == TARGET_BUNDLE_NAME),
            None,
        )
        if not target_info:
            raise RuntimeError(f"在清单中未找到目标文件: {TARGET_BUNDLE_NAME}")
        target_version = target_info.get("m_version")
        target_size = target_info.get("m_size")
        console.print(
            f"[bold green]✔ 找到 {TARGET_BUNDLE_NAME} | Version: {target_version} | Size: {target_size} bytes[/]"
        )

        config_blob = download_bytes(
            f"{android_base_url}/{TARGET_BUNDLE_NAME}", expected_size=target_size
        )
        if config_blob is None:
            return
        config_files = collect_configdata_assets_from_bytes(config_blob)
        schema_index = build_schema_index()
        good, bad = export_json_from_memory(schema_index, config_files, MASTER_DIR)
        console.print(f"[bold green]JSON 导出完成：成功 {good}，跳过/失败 {bad}[/]")
        console.print(f"[gray]MasterData 目录: {MASTER_DIR}[/]")
    except Exception as e:
        console.print(f"[bold red]❌ 执行过程中发生严重错误: {e}[/]")


if __name__ == "__main__":
    main()
