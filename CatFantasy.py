from __future__ import annotations

import argparse
import base64
import gzip
import hashlib
import hmac
import json
import os
import random
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import time
import warnings
import zipfile
import zlib
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable

import requests
from Crypto.Cipher import AES
from Crypto.Hash import SHA1
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Util.Padding import pad, unpad
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


LUA_PASSWORD = "BaBaVf7258Whw759"
# AESUtils.cctor
LUA_PBKDF_SALT = bytes.fromhex("e6dcff74adad7aeec5fe50af4d082d3c")
LUA_PBKDF_ITERS = 64

# GetApiSalt()
API_SIGN_SALT = "1eeba33bbdff3287f53af9b7bc209b5d"
# HttpModule.cctor
HTTP_AES_KEY = b"f53af9b7bc209b5d"

# 资源 AesPasswordE
UNITYCN_KEY_HEX = "43614461566637323538576877363433"
UNITYCN_KEY = bytes.fromhex(UNITYCN_KEY_HEX)

GAME_ID = "704269f6d5e648f95c20247e03102737"
BUNDLE_ID = "com.funtoygame.cater.android"
NOTICE_URL = "http://notice-cat-cn-v2.fantanggame.com"
NOTICE_HOST = "cat-cn-v2.fantanggame.com"
UNITY_VERSION = "2021.3.33f1c1"
DEFAULT_LANG = "zh_CN"
DEFAULT_APP_VERSION = "2.14.0"
DEFAULT_RES_VERSION = "2.14.0.1"

APK_EXTRACT_GLOBS = (
    "assets/Bundles/*",
    "assets/Lua/*",
    "assets/Setting/*",
    "assets/Behavior/*",
)

HTTP_HEADERS = {
    "Accept": "application/json;charset=UTF-8",
    "User-Agent": "U:nil,P:0",
    "Content-Type": "application/json",
    "X-Unity-Version": UNITY_VERSION,
}

RETRY_COUNT = 4
CHUNK_SIZE = 1 << 20
DEFAULT_JOBS = 8
BUNDLE_JOBS = 16
LUA_MAGIC = b"\x1bLua"
CUSTOM_LUA_MAGIC = b"\x1bXX"
UNITY_MAGICS = (b"UnityFS", b"UnityWeb", b"UnityRaw", b"UnityArchive")
SETTING_HDR = bytes.fromhex("abee0803")

console = Console()
ROOT = Path(__file__).resolve().parent
ASSETS_DIR = ROOT / "Assets"
MASTER_DIR = ROOT / "MasterData"
CACHE_DIR = ROOT / "Cache"
PAINTING_DIR = ROOT / "Painting"
ROLE_ART_DIR = ASSETS_DIR / "Bundles" / "Android" / "arts" / "role"
CARD_SKIN_TABLE = MASTER_DIR / "Setting" / "Data" / "Card" / "CardSkin.txt"
CARD_TABLE = MASTER_DIR / "Setting" / "Data" / "Card" / "Card.txt"
ROLES_TABLE = MASTER_DIR / "Setting" / "Data" / "Card" / "Roles.txt"
UNLUAC = shutil.which("unluac") or "/usr/bin/unluac"
GAME_TITLE = "猫之城"
_CARD_IMG_RE = re.compile(r"^card_img_(\d+)(?:_l|_1)?(?:_hexie)?$", re.I)
_DRAWING_FIELDS = ("hdCardDrawing", "bigCardDrawing", "cardDrawing")
_DRAWING_HEXIE_FIELDS = (
    "hdCardDrawing_hexie",
    "bigCardDrawing_hexie",
    "cardDrawing_hexie",
)

_lua_keyiv: bytes | None = None
_tls = threading.local()


def format_size(n: int) -> str:
    size = float(n)
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if size < 1024 or unit == "TB":
            return f"{size:.2f} {unit}"
        size /= 1024
    return f"{n} B"


def md5_file(path: Path, chunk_size: int = CHUNK_SIZE) -> str:
    h = hashlib.md5()
    with path.open("rb") as fh:
        while True:
            block = fh.read(chunk_size)
            if not block:
                break
            h.update(block)
    return h.hexdigest()


def find_apk(explicit: str | None = None) -> Path:
    if explicit:
        p = Path(explicit)
        if not p.is_file():
            raise FileNotFoundError(p)
        return p
    apks = sorted(ROOT.glob("*.apk"), key=lambda x: x.stat().st_size, reverse=True)
    if not apks:
        raise FileNotFoundError("工作区里没有 .apk")
    return apks[0]


def read_apk_channel(apk: Path) -> str:
    try:
        data = subprocess.check_output(["unzip", "-p", str(apk), "assets/channel.txt"])
        return data.decode("utf-8", "replace").strip() or "5047"
    except Exception:
        return "5047"


def read_apk_version(apk: Path) -> str:
    try:
        out = subprocess.check_output(
            ["aapt", "dump", "badging", str(apk)], text=True, errors="replace"
        )
        for token in out.split():
            if token.startswith("versionName="):
                return token.split("=", 1)[1].strip("'\"")
    except Exception:
        pass
    return DEFAULT_APP_VERSION


def session() -> requests.Session:
    s = getattr(_tls, "session", None)
    if s is None:
        s = requests.Session()
        s.headers.update(HTTP_HEADERS)
        _tls.session = s
    return s



def _sign_fields(fields: dict[str, Any]) -> str:
    items = sorted(
        (k, "" if v is None else str(v)) for k, v in fields.items() if k != "sign"
    )
    joined = "".join(v for _, v in items)
    return hashlib.md5((joined + API_SIGN_SALT).encode("utf-8")).hexdigest()


def encrypt_http_body(fields: dict[str, Any]) -> bytes:
    body: dict[str, Any] = {}
    for k, v in fields.items():
        if k == "sign":
            continue
        if v is None or v == "":
            body[k] = None
        else:
            body[k] = str(v)
    sign_src = {k: ("" if v is None else v) for k, v in body.items()}
    ordered = {k: body[k] for k in sorted(body)}
    ordered["sign"] = _sign_fields(sign_src)
    plaintext = json.dumps(ordered, ensure_ascii=False, separators=(",", ":"))
    iv = HTTP_AES_KEY
    ct = AES.new(HTTP_AES_KEY, AES.MODE_CBC, iv).encrypt(
        pad(plaintext.encode("utf-8"), 16)
    )
    value = base64.b64encode(ct).decode("ascii")
    iv_b64 = base64.b64encode(iv).decode("ascii")
    mac = hmac.new(iv, (iv_b64 + value).encode("utf-8"), hashlib.sha256).hexdigest()
    payload = json.dumps(
        {"iv": iv_b64, "mac": mac, "value": value}, separators=(",", ":")
    )
    return zlib.compress(base64.b64encode(payload.encode("utf-8")), 9)


def decrypt_http_response(text: str) -> dict[str, Any]:
    raw = text.strip()
    blob = base64.b64decode(raw)
    try:
        blob = gzip.decompress(blob)
    except Exception:
        try:
            blob = zlib.decompress(blob)
        except Exception:
            pass
    if blob[:1] != b"{":
        blob = base64.b64decode(blob)
    obj = json.loads(blob)
    iv = base64.b64decode(obj["iv"])
    ct = base64.b64decode(obj["value"])
    pt = unpad(AES.new(HTTP_AES_KEY, AES.MODE_CBC, iv).decrypt(ct), 16)
    return json.loads(pt.decode("utf-8"))


def default_request_fields(
    app_version: str,
    res_version: str,
    channel_id: str,
    extra: dict[str, Any] | None = None,
) -> dict[str, Any]:
    sid = str(random.randrange(10**14, 10**15))
    fields = {
        "androidId": "0000000000000000",
        "appVersion": app_version,
        "bundleId": BUNDLE_ID,
        "channelId": channel_id,
        "device": "Android",
        "deviceName": "Android",
        "deviceType": "Handheld",
        "dpi": "480",
        "emulatorName": None,
        "gameId": GAME_ID,
        "graphicsMemory": "4096",
        "graphicsName": "Adreno",
        "graphicsVersion": "OpenGL ES 3.2",
        "height": "1080",
        "idfa": None,
        "lang": DEFAULT_LANG,
        "memorySize": "8192",
        "os": "Android OS 15",
        "osVer": "Android OS 15",
        "playerId": "",
        "processorCount": "8",
        "processorFrequency": "2000",
        "processorType": "ARM64",
        "serializeId": sid,
        "serializeId1": str(int(sid) - 1),
        "serverId": "",
        "sessionId": "",
        "subChannelId": None,
        "timezone": "UTC",
        "ts": str(int(time.time())),
        "udid": "0000000000000000",
        "userId": "",
        "version": res_version,
        "width": "1920",
    }
    if extra:
        fields.update(extra)
    return fields


def api_post(path: str, fields: dict[str, Any], timeout: int = 30) -> dict[str, Any]:
    url = NOTICE_URL.rstrip("/") + "/" + path.lstrip("/")
    last_err: Exception | None = None
    for attempt in range(1, RETRY_COUNT + 1):
        try:
            resp = session().post(
                url,
                data=encrypt_http_body(fields),
                headers={**HTTP_HEADERS, "Host": NOTICE_HOST},
                timeout=timeout,
            )
            resp.raise_for_status()
            data = decrypt_http_response(resp.text)
            if int(data.get("errCode") or 0) != 0:
                raise RuntimeError(
                    f"{path} errCode={data.get('errCode')} {data.get('errMsg')}"
                )
            return data
        except Exception as exc:
            last_err = exc
            time.sleep(min(2 * attempt, 8))
    raise RuntimeError(f"{path} 请求失败: {last_err}") from last_err


def fetch_user_update(app_version: str, res_version: str, channel_id: str) -> dict[str, Any]:
    data = api_post(
        "User/update",
        default_request_fields(app_version, res_version, channel_id),
    )
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    (CACHE_DIR / "user_update.json").write_text(
        json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    return data


def fetch_download_before(
    app_version: str, res_version: str, channel_id: str
) -> dict[str, Any]:
    data = api_post(
        "User/downloadBefore",
        default_request_fields(
            app_version, res_version, channel_id, extra={"preVersion": app_version}
        ),
    )
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    (CACHE_DIR / "download_before.json").write_text(
        json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    return data


def pick_local_res_version(patches: dict[str, Any], app_version: str, prefer: str) -> str:
    if prefer in patches:
        return prefer
    fallback = f"{app_version}.1"
    if fallback in patches:
        return fallback
    same = [k for k in patches if k.startswith(app_version + ".")]
    if same:
        return max(same, key=lambda k: int(patches[k].get("size") or 0))
    if patches:
        return max(patches, key=lambda k: int(patches[k].get("size") or 0))
    raise RuntimeError("远端 patches 为空")


# ---------------------------------------------------------------------------
# 下载 / 解压
# ---------------------------------------------------------------------------

def download_file(
    urls: Iterable[str],
    dest: Path,
    expected_md5: str | None = None,
    expected_size: int | None = None,
    force: bool = False,
    progress: Progress | None = None,
    task_id: int | None = None,
) -> str:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file() and not force:
        if expected_size and dest.stat().st_size != expected_size:
            pass
        elif expected_md5 and md5_file(dest) == expected_md5.lower():
            if progress is not None and task_id is not None:
                progress.update(task_id, completed=expected_size or dest.stat().st_size)
            return "skip"
        elif not expected_md5:
            if progress is not None and task_id is not None:
                progress.update(task_id, completed=dest.stat().st_size)
            return "skip"

    part = dest.with_suffix(dest.suffix + ".part")
    last_err: Exception | None = None
    url_list = [u for u in urls if u]
    for url in url_list:
        for attempt in range(1, RETRY_COUNT + 1):
            try:
                headers = {"User-Agent": HTTP_HEADERS["User-Agent"]}
                existing = part.stat().st_size if part.is_file() else 0
                if existing:
                    headers["Range"] = f"bytes={existing}-"
                with session().get(url, headers=headers, stream=True, timeout=60) as resp:
                    if resp.status_code == 416:
                        part.unlink(missing_ok=True)
                        existing = 0
                        continue
                    if existing and resp.status_code == 200:
                        existing = 0
                        part.unlink(missing_ok=True)
                    resp.raise_for_status()
                    total = expected_size
                    if total is None:
                        cl = resp.headers.get("Content-Length")
                        if cl:
                            total = existing + int(cl)
                    if progress is not None and task_id is not None and total:
                        progress.update(task_id, total=total, completed=existing)
                    mode = "ab" if existing and resp.status_code == 206 else "wb"
                    with part.open(mode) as fh:
                        for chunk in resp.iter_content(CHUNK_SIZE):
                            if not chunk:
                                continue
                            fh.write(chunk)
                            if progress is not None and task_id is not None:
                                progress.advance(task_id, len(chunk))
                if expected_md5:
                    got = md5_file(part)
                    if got != expected_md5.lower():
                        part.unlink(missing_ok=True)
                        raise RuntimeError(f"MD5 不符 {got} != {expected_md5}")
                part.replace(dest)
                return "ok"
            except Exception as exc:
                last_err = exc
                time.sleep(min(2 * attempt, 8))
    raise RuntimeError(f"下载失败 {dest.name}: {last_err}") from last_err


def zip_member_name(name: str) -> str | None:
    name = name.replace("\\", "/")
    if name.endswith("/") or ".." in Path(name).parts:
        return None
    prefixes = ("assets/", "Assets/", "./")
    for pfx in prefixes:
        if name.startswith(pfx):
            name = name[len(pfx) :]
            break
    return name or None


def extract_zip(zip_path: Path, dest: Path, progress: Progress | None = None) -> int:
    dest.mkdir(parents=True, exist_ok=True)
    count = 0
    with zipfile.ZipFile(zip_path) as zf:
        infos = [i for i in zf.infolist() if zip_member_name(i.filename)]
        task = None
        if progress is not None:
            task = progress.add_task(f"[cyan]解压 {zip_path.name}", total=len(infos))
        for info in infos:
            rel = zip_member_name(info.filename)
            if rel is None:
                continue
            target = dest / rel
            if info.is_dir():
                target.mkdir(parents=True, exist_ok=True)
                if task is not None:
                    progress.advance(task)
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(info) as src, target.open("wb") as out:
                shutil.copyfileobj(src, out, CHUNK_SIZE)
            count += 1
            if task is not None:
                progress.advance(task)
    return count


def merge_tree(src: Path, dest: Path) -> None:
    dest.mkdir(parents=True, exist_ok=True)
    for item in src.iterdir():
        target = dest / item.name
        if item.is_dir():
            if target.exists():
                merge_tree(item, target)
            else:
                shutil.move(str(item), str(target))
        else:
            target.parent.mkdir(parents=True, exist_ok=True)
            if target.exists():
                target.unlink()
            shutil.move(str(item), str(target))


def apply_deleted_list(dest: Path) -> int:
    listing = dest / ".deleted"
    if not listing.is_file():
        return 0
    n = 0
    for line in listing.read_text(encoding="utf-8", errors="replace").splitlines():
        rel = line.strip().replace("\\", "/")
        if not rel or ".." in Path(rel).parts:
            continue
        target = dest / rel
        if target.is_file():
            target.unlink()
            n += 1
    if n:
        console.print(f"[cyan]按 .deleted 移除[/cyan] {n} 个过期文件")
    return n


def extract_apk(apk: Path, dest: Path, force: bool = False) -> None:
    stamp = dest / ".apk_extracted"
    if stamp.is_file() and not force:
        console.print(f"[yellow]已提取过 APK，跳过[/yellow]（--force 可重提）")
        return
    tmp = CACHE_DIR / "apk_extract"
    if tmp.exists():
        shutil.rmtree(tmp)
    tmp.mkdir(parents=True, exist_ok=True)
    console.print(f"[cyan]从 APK 提取 Bundles/Lua/Setting/Behavior ...[/cyan]")
    cmd = ["unzip", "-qo", str(apk), *APK_EXTRACT_GLOBS, "-d", str(tmp)]
    proc = subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE)
    if proc.returncode not in (0, 11):  # 11 = 部分文件未匹配
        err = proc.stderr.decode("utf-8", "replace")
        raise RuntimeError(f"unzip APK 失败: {err}")
    assets = tmp / "assets"
    if not assets.is_dir():
        raise RuntimeError("APK 中没有 assets/")
    dest.mkdir(parents=True, exist_ok=True)
    merge_tree(assets, dest)
    shutil.rmtree(tmp, ignore_errors=True)
    stamp.write_text(str(apk) + "\n", encoding="utf-8")
    console.print(f"[green]APK 已提取到[/green] {dest}")


# ---------------------------------------------------------------------------
# Setting / Lua
# ---------------------------------------------------------------------------

def lua_keyiv() -> bytes:
    global _lua_keyiv
    if _lua_keyiv is None:
        _lua_keyiv = PBKDF2(
            LUA_PASSWORD,
            LUA_PBKDF_SALT,
            dkLen=48,
            count=LUA_PBKDF_ITERS,
            hmac_hash_module=SHA1,
        )
    return _lua_keyiv


def decrypt_lua_bytes(data: bytes) -> bytes:
    keyiv = lua_keyiv()
    pt = unpad(AES.new(keyiv[:32], AES.MODE_CBC, keyiv[32:]).decrypt(data), 16)
    for fn in (zlib.decompress, gzip.decompress, lambda x: zlib.decompress(x, -15)):
        try:
            return fn(pt)
        except Exception:
            continue
    return pt


def decrypt_setting_bytes(data: bytes) -> bytes:
    payload = data[4:] if data.startswith(SETTING_HDR) or len(data) > 4 else data
    if payload[:2] == b"\x1f\x8b":
        return gzip.decompress(payload)
    return zlib.decompress(payload)


def looks_like_lua_source(data: bytes) -> bool:
    head = data.lstrip()[:80]
    if head.startswith(LUA_MAGIC) or head.startswith(CUSTOM_LUA_MAGIC):
        return False
    try:
        text = head.decode("utf-8")
    except Exception:
        return False
    return text.startswith(("---", "--", "local ", "return ", "function ", "---@"))


def looks_like_json(data: bytes) -> bool:
    head = data.lstrip()[:1]
    return head in (b"{", b"[")


def looks_like_setting_text(data: bytes) -> bool:
    if data.startswith(SETTING_HDR) or data[:2] in (b"x\x01", b"x\x9c", b"x\xda", b"\x1f\x8b"):
        return False
    try:
        data[:64].decode("utf-8")
        return True
    except Exception:
        return False


def is_zlib_wrapped(data: bytes) -> bool:
    if data.startswith(SETTING_HDR):
        return True
    return len(data) > 2 and data[:2] in (b"x\x01", b"x\x9c", b"x\xda", b"\x1f\x8b")


def decrypt_zlib_inplace(src: Path) -> str:
    data = src.read_bytes()
    if looks_like_json(data) or looks_like_setting_text(data):
        return "skip"
    if not is_zlib_wrapped(data):
        return "skip"
    plain = decrypt_setting_bytes(data)
    tmp = src.with_name(src.name + ".dec.tmp")
    tmp.write_bytes(plain)
    tmp.replace(src)
    return "ok"


def run_unluac(src: Path, dest: Path) -> bool:
    if not Path(UNLUAC).exists():
        return False
    dest.parent.mkdir(parents=True, exist_ok=True)
    try:
        subprocess.run(
            [UNLUAC, "--rawstring", "--output", str(dest), str(src)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return dest.is_file() and dest.stat().st_size > 0
    except Exception:
        return False


def process_lua_file(src: Path, dest: Path) -> str:
    data = src.read_bytes()
    if looks_like_lua_source(data):
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
        return "source"
    try:
        plain = decrypt_lua_bytes(data)
    except Exception:
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
        return "copy"
    if looks_like_lua_source(plain) or (
        not plain.startswith(LUA_MAGIC) and not plain.startswith(CUSTOM_LUA_MAGIC)
    ):
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(plain)
        return "decrypt"
    with tempfile.NamedTemporaryFile(suffix=".luac", delete=False) as tmp:
        tmp.write(plain)
        tmp_path = Path(tmp.name)
    try:
        if run_unluac(tmp_path, dest):
            return "unluac"
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.with_suffix(".luac").write_bytes(plain)
        return "bytecode"
    finally:
        tmp_path.unlink(missing_ok=True)


def process_setting_file(src: Path, dest: Path) -> str:
    data = src.read_bytes()
    dest.parent.mkdir(parents=True, exist_ok=True)
    if looks_like_setting_text(data):
        dest.write_bytes(data)
        return "source"
    try:
        dest.write_bytes(decrypt_setting_bytes(data))
        return "decrypt"
    except Exception:
        dest.write_bytes(data)
        return "copy"


def walk_files(root: Path, suffixes: tuple[str, ...]) -> list[Path]:
    out: list[Path] = []
    if not root.is_dir():
        return out
    for dirpath, _, files in os.walk(root):
        for name in files:
            if name.lower().endswith(suffixes):
                out.append(Path(dirpath) / name)
    return out


def lua_dest_name(src: Path, src_root: Path, dest_root: Path) -> Path:
    rel = src.relative_to(src_root)
    name = rel.name
    if name.endswith(".lua.bytes"):
        name = name[: -len(".bytes")]
    elif name.endswith(".bytes"):
        name = name[: -len(".bytes")] + ".lua"
    elif not name.endswith(".lua"):
        name = name + ".lua"
    return dest_root / rel.with_name(name)


def setting_dest_name(src: Path, src_root: Path, dest_root: Path) -> Path:
    rel = src.relative_to(src_root)
    name = rel.name
    if name.endswith(".bytes"):
        name = name[: -len(".bytes")] + ".txt"
    return dest_root / rel.with_name(name)


# ---------------------------------------------------------------------------
# UnityCN
# ---------------------------------------------------------------------------

def is_unity_bundle(path: Path) -> bool:
    try:
        with path.open("rb") as fh:
            magic = fh.read(16)
    except Exception:
        return False
    return magic.startswith(UNITY_MAGICS)


def decrypt_unity_bundle(src: Path) -> str:
    if not is_unity_bundle(src):
        return "skip"
    import UnityPy

    UnityPy.set_assetbundle_decrypt_key(UNITYCN_KEY)
    env = UnityPy.load(str(src))
    data = env.file.save()
    tmp = src.with_name(src.name + ".dec.tmp")
    tmp.write_bytes(data)
    tmp.replace(src)
    return "ok"


# ---------------------------------------------------------------------------
# 立绘
# CardConfMgr:GetRolesVoByCatId → Card.characterId → Roles.name
# CardSkin.name = 皮肤/变体名；CardSkin.desc 为角色名兜底
# ---------------------------------------------------------------------------

def read_tsv(path: Path) -> list[dict[str, str]]:
    if not path.is_file():
        return []
    lines = path.read_text(encoding="utf-8").splitlines()
    if len(lines) < 3:
        return []
    header = lines[0].split("\t")
    rows: list[dict[str, str]] = []
    for line in lines[2:]:
        if not line.strip():
            continue
        cols = line.split("\t")
        if len(cols) < len(header):
            cols.extend([""] * (len(header) - len(cols)))
        rows.append(dict(zip(header, cols)))
    return rows


def drawing_asset_key(val: str) -> str:
    text = (val or "").strip()
    if ":" in text:
        text = text.split(":", 1)[1]
    return text.strip()


def bundle_asset_stem(path: Path) -> str:
    name = path.name
    for ext in (".png.bytes", ".bytes", ".png"):
        if name.endswith(ext):
            return name[: -len(ext)]
    return path.stem


def parse_card_img_id(stem: str) -> str:
    match = _CARD_IMG_RE.match(stem)
    return match.group(1) if match else ""


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
    out = text.translate(table).strip()
    return out or "未知"


def painting_notes_from_stem(stem: str) -> list[str]:
    notes: list[str] = []
    if "_hexie" in stem.lower():
        notes.append("和谐")
    return notes


def painting_filename(
    cha: str,
    skin: str,
    used: set[str],
    notes: Iterable[str] | None = None,
) -> str:
    """游戏名_角色名_皮肤/变体名[_备注1_备注2...].png，备注可无限追加。"""
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(skin)]
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
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


def _index_rows(rows: list[dict[str, str]], key: str) -> dict[str, dict[str, str]]:
    out: dict[str, dict[str, str]] = {}
    for row in rows:
        kid = (row.get(key) or "").strip()
        if kid:
            out[kid] = row
    return out


def _group_rows(rows: list[dict[str, str]], key: str) -> dict[str, list[dict[str, str]]]:
    out: dict[str, list[dict[str, str]]] = {}
    for row in rows:
        kid = (row.get(key) or "").strip()
        if kid:
            out.setdefault(kid, []).append(row)
    return out


def load_painting_tables() -> tuple[
    list[dict[str, str]],
    dict[str, dict[str, str]],
    dict[str, dict[str, str]],
]:
    skins = read_tsv(CARD_SKIN_TABLE)
    cards = _index_rows(read_tsv(CARD_TABLE), "roleId")
    roles = _index_rows(read_tsv(ROLES_TABLE), "roleId")
    return skins, cards, roles


def character_name(
    skin: dict[str, str],
    cards: dict[str, dict[str, str]],
    roles: dict[str, dict[str, str]],
) -> str:
    card = cards.get((skin.get("roleId") or "").strip())
    if card:
        role = roles.get((card.get("characterId") or "").strip())
        name = (role.get("name") or "").strip() if role else ""
        if name:
            return name
    desc = (skin.get("desc") or "").strip()
    if desc:
        return desc
    return "未知"


def _skin_score(row: dict[str, str], asset_id: str, asset_stem: str) -> int:
    score = 0
    skin_id = (row.get("skinId") or "").strip()
    role_id = (row.get("roleId") or "").strip()
    if skin_id and skin_id == asset_id:
        score += 200
    if role_id and role_id == asset_id:
        score += 80
    if drawing_asset_key(row.get("hdCardDrawing") or "") == asset_stem:
        score += 40
    if drawing_asset_key(row.get("bigCardDrawing") or "") == asset_stem:
        score += 20
    if row.get("inHandBook") == "1":
        score += 10
    if row.get("isMonster") == "0":
        score += 5
    tag = (row.get("tag") or "1").strip()
    if asset_id.endswith("99") and tag == "2":
        score += 30
    elif len(asset_id) > 6 and not asset_id.endswith("01") and tag in {"3", "4", "5"}:
        score += 20
    elif len(asset_id) == 6 and tag == "1":
        score += 15
    return score


def build_painting_index(
    skins: list[dict[str, str]],
) -> tuple[dict[str, list[dict[str, str]]], dict[str, list[dict[str, str]]]]:
    by_asset: dict[str, list[dict[str, str]]] = {}
    by_hexie: dict[str, list[dict[str, str]]] = {}
    for row in skins:
        for field in _DRAWING_FIELDS:
            key = drawing_asset_key(row.get(field) or "")
            if key.startswith("card_img_"):
                by_asset.setdefault(key, []).append(row)
        for field in _DRAWING_HEXIE_FIELDS:
            key = drawing_asset_key(row.get(field) or "")
            if key.startswith("card_img_"):
                by_hexie.setdefault(key, []).append(row)
    return by_asset, by_hexie


def resolve_painting_name(
    stem: str,
    by_asset: dict[str, list[dict[str, str]]],
    by_hexie: dict[str, list[dict[str, str]]],
    by_skin_id: dict[str, dict[str, str]],
    by_role_id: dict[str, list[dict[str, str]]],
    cards: dict[str, dict[str, str]],
    roles: dict[str, dict[str, str]],
) -> tuple[str, str, list[str], bool]:
    notes = painting_notes_from_stem(stem)
    hexie = "_hexie" in stem
    core = stem.replace("_hexie", "")
    asset_id = parse_card_img_id(core) or parse_card_img_id(stem)
    candidates = by_hexie.get(stem, []) if hexie else []
    if not candidates:
        candidates = by_asset.get(core, [])
    if not candidates and asset_id:
        row = by_skin_id.get(asset_id)
        if row:
            candidates = [row]
        elif asset_id in by_role_id:
            candidates = by_role_id[asset_id]
    if candidates:
        row = max(candidates, key=lambda r: _skin_score(r, asset_id, core))
        cha = character_name(row, cards, roles)
        skin = (row.get("name") or "").strip() or asset_id or core
        return cha, skin, notes, True
    if asset_id:
        parent = asset_id[:6] if len(asset_id) >= 8 else asset_id
        if parent in by_role_id:
            row = max(
                by_role_id[parent],
                key=lambda r: _skin_score(r, parent, f"card_img_{parent}_l"),
            )
            cha = character_name(row, cards, roles)
            base = (row.get("name") or "").strip() or parent
            extra = asset_id[len(parent) :]
            if extra == "99":
                skin = base if "炫彩" in base else f"{base}·炫彩"
            elif extra and extra != "01":
                skin = f"{base}·{extra}"
            else:
                skin = base
            return cha, skin, notes, True
    cha = "未知"
    if asset_id and len(asset_id) >= 6 and asset_id[:3] in roles:
        cha = (roles[asset_id[:3]].get("name") or "").strip() or cha
    skin = asset_id or core
    return cha, skin, notes, False


def iter_card_img_files(root: Path) -> list[Path]:
    if not root.is_dir():
        return []
    out: list[Path] = []
    for path in sorted(root.rglob("*")):
        if not path.is_file():
            continue
        stem = bundle_asset_stem(path)
        if stem.startswith("card_img_"):
            out.append(path)
    return out


def _export_role_texture(bundle: Path, dest: Path, want_name: str = "") -> str:
    import UnityPy

    UnityPy.set_assetbundle_decrypt_key(UNITYCN_KEY)
    env = UnityPy.load(str(bundle))
    textures: list[tuple[str, Any]] = []
    for obj in env.objects:
        if getattr(obj.type, "name", None) != "Texture2D":
            continue
        data = obj.read()
        image = data.image
        if image is not None:
            textures.append((str(data.m_Name or ""), image))
    if not textures:
        return "skip"
    want = want_name.lower()
    picked = None
    if want:
        for name, image in textures:
            if name.lower() == want:
                picked = image
                break
    if picked is None:
        picked = max(textures, key=lambda item: item[1].width * item[1].height)[1]
    dest.parent.mkdir(parents=True, exist_ok=True)
    picked.save(dest, "PNG")
    return "ok"


def cmd_painting(args) -> None:
    warnings.filterwarnings("ignore", message="No valid Unity version found")
    root = Path(getattr(args, "path", None) or ROLE_ART_DIR)
    force = bool(getattr(args, "force", False))
    limit = int(getattr(args, "limit", 0) or 0)
    jobs = max(1, int(getattr(args, "jobs", None) or DEFAULT_JOBS))

    if not CARD_SKIN_TABLE.is_file():
        console.print(f"[red]缺表[/red] {CARD_SKIN_TABLE}，先跑 masterdata")
        return
    if not root.is_dir():
        console.print(f"[red]缺立绘目录[/red] {root}，先跑 assets")
        return

    skins, cards, roles = load_painting_tables()
    by_asset, by_hexie = build_painting_index(skins)
    by_skin_id = _index_rows(skins, "skinId")
    by_role_id = _group_rows(skins, "roleId")
    files = iter_card_img_files(root)
    if limit > 0:
        files = files[:limit]
        console.print(f"[yellow]--limit {limit}[/yellow] 立绘")

    used: set[str] = set()
    jobs_list: list[tuple[Path, str, Path, bool]] = []
    named = 0
    for bundle in files:
        stem = bundle_asset_stem(bundle)
        cha, skin, notes, hit = resolve_painting_name(
            stem, by_asset, by_hexie, by_skin_id, by_role_id, cards, roles
        )
        if hit:
            named += 1
        fname = painting_filename(cha, skin, used, notes)
        jobs_list.append((bundle, stem, PAINTING_DIR / fname, hit))

    console.print(
        f"[cyan]立绘名称[/cyan] CardSkin/Roles 命中 {named}/{len(jobs_list)}  "
        f"表 {len(skins)} 皮肤 / {len(roles)} 角色 → {PAINTING_DIR}"
    )
    if not jobs_list:
        console.print("[yellow]没有 card_img_* 可导出[/yellow]")
        return

    written = skipped = fail = 0
    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("导出立绘", total=len(jobs_list))

        def work(item: tuple[Path, str, Path, bool]) -> tuple[str, str, str | None]:
            bundle, stem, dest, _hit = item
            if dest.is_file() and not force:
                return "skip", stem, None
            try:
                status = _export_role_texture(bundle, dest, want_name=stem)
                return status, stem, None
            except Exception as exc:  # noqa: BLE001
                dest.unlink(missing_ok=True)
                return "fail", stem, str(exc)

        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(work, item) for item in jobs_list]
            for fut in as_completed(futs):
                status, stem, err = fut.result()
                if status == "ok":
                    written += 1
                elif status == "skip":
                    skipped += 1
                else:
                    fail += 1
                    if err:
                        console.print(f"[red]立绘失败[/red] {stem}: {err}")
                progress.advance(task)

    console.print(
        f"[bold green]Painting[/bold green] 写出 {written}  跳过 {skipped}  失败 {fail} → {PAINTING_DIR}"
    )


# ---------------------------------------------------------------------------
# 命令
# ---------------------------------------------------------------------------

def make_progress(*extra):
    cols = [
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        *extra,
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
    ]
    return Progress(*cols, console=console)


def cmd_version(args) -> dict[str, Any]:
    apk = find_apk(args.apk)
    app_version = args.app_version or read_apk_version(apk)
    channel = args.channel or read_apk_channel(apk)
    res_version = args.local_version or DEFAULT_RES_VERSION
    console.print(
        f"[cyan]拉取 User/update[/cyan] app={app_version} res={res_version} channel={channel}"
    )
    data = fetch_user_update(app_version, res_version, channel)
    info = data.get("data") or {}
    patches = info.get("patches") or {}
    local = pick_local_res_version(patches, app_version, res_version)
    table = Table(title=f"远端 {info.get('version')}  / 本地补丁键 {local}")
    table.add_column("字段")
    table.add_column("值")
    for key in ("appVersion", "version", "updateUrl", "backupUrl", "isForceUpdate", "isMaintain"):
        table.add_row(key, str(info.get(key, "")))
    table.add_row("channel", channel)
    table.add_row("patches", str(len(patches)))
    if local in patches:
        table.add_row("patch size", format_size(int(patches[local]["size"])))
        table.add_row("patch md5", patches[local]["md5"])
    console.print(table)
    return data


def _cdn_urls(info: dict[str, Any], rel: str) -> list[str]:
    bases = [
        info.get("updateUrl"),
        info.get("backupUrl"),
        info.get("backupUrl2"),
    ]
    out = []
    for base in bases:
        if not base:
            continue
        url = base.rstrip("/") + "/" + rel.lstrip("/")
        if url not in out:
            out.append(url)
    return out


def cmd_assets(args) -> None:
    apk = find_apk(args.apk)
    app_version = args.app_version or read_apk_version(apk)
    channel = args.channel or read_apk_channel(apk)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)

    if not args.skip_apk:
        extract_apk(apk, ASSETS_DIR, force=args.force)

    console.print("[cyan]拉取版本清单 / 分包清单 ...[/cyan]")
    update = fetch_user_update(
        app_version, args.local_version or DEFAULT_RES_VERSION, channel
    )
    info = update.get("data") or {}
    patches = info.get("patches") or {}
    local = pick_local_res_version(
        patches, app_version, args.local_version or DEFAULT_RES_VERSION
    )
    remote = info.get("version")
    console.print(
        f"[cyan]远端资源[/cyan] {remote}  [cyan]本地键[/cyan] {local}  "
        f"[cyan]channel[/cyan] {channel}"
    )

    jobs: list[dict[str, Any]] = []
    if not args.skip_subpackage:
        before = fetch_download_before(app_version, local, channel)
        packages = before.get("data") or []
        if isinstance(packages, dict):
            packages = [packages]
        for pkg in packages:
            splits = pkg.get("split") or []
            if splits:
                for sp in splits:
                    jobs.append(
                        {
                            "name": Path(sp["url"]).name,
                            "urls": [sp["url"]],
                            "md5": sp.get("md5"),
                            "size": int(sp.get("size") or 0),
                            "kind": "sub",
                        }
                    )
            elif pkg.get("url"):
                jobs.append(
                    {
                        "name": Path(pkg["url"]).name,
                        "urls": [pkg["url"]],
                        "md5": pkg.get("md5"),
                        "size": int(pkg.get("size") or 0),
                        "kind": "sub",
                    }
                )

    if local in patches:
        patch = patches[local]
        rel = f"{remote}/{local}.zip"
        jobs.append(
            {
                "name": f"{local}.zip",
                "urls": _cdn_urls(info, rel),
                "md5": patch.get("md5"),
                "size": int(patch.get("size") or 0),
                "kind": "patch",
            }
        )

    total = sum(j["size"] for j in jobs)
    console.print(
        f"[cyan]开始下载 {len(jobs)} 个 zip / {format_size(total)}[/cyan]"
    )

    with make_progress(DownloadColumn(), TransferSpeedColumn()) as progress:
        for job in jobs:
            dest = CACHE_DIR / job["name"]
            task = progress.add_task(job["name"], total=job["size"] or None)
            state = download_file(
                job["urls"],
                dest,
                expected_md5=job.get("md5"),
                expected_size=job["size"] or None,
                force=args.force,
                progress=progress,
                task_id=task,
            )
            job["dest"] = dest
            job["state"] = state
            if state == "skip":
                progress.update(task, completed=job["size"] or dest.stat().st_size)

    # 先分包后补丁，新文件覆盖旧文件
    ordered = [j for j in jobs if j["kind"] == "sub"] + [
        j for j in jobs if j["kind"] == "patch"
    ]
    with make_progress(MofNCompleteColumn()) as progress:
        for job in ordered:
            dest = job.get("dest")
            if not dest or not dest.is_file():
                continue
            console.print(f"[cyan]解压 overlay[/cyan] {dest.name}")
            n = extract_zip(dest, ASSETS_DIR, progress=progress)
            console.print(f"  -> {n} 个文件")

    apply_deleted_list(ASSETS_DIR)
    console.print(f"[bold green]Assets 完成[/bold green] {ASSETS_DIR}")


def cmd_masterdata(args) -> None:
    lua_root = ASSETS_DIR / "Lua"
    setting_root = ASSETS_DIR / "Setting"
    if not lua_root.is_dir() or not setting_root.is_dir():
        apk = find_apk(getattr(args, "apk", None))
        console.print("[yellow]Assets 中没有 Lua/Setting，先从 APK 提取[/yellow]")
        extract_apk(apk, ASSETS_DIR, force=False)

    lua_files = walk_files(ASSETS_DIR / "Lua", (".lua", ".bytes", ".lua.bytes"))
    setting_files = walk_files(ASSETS_DIR / "Setting", (".bytes", ".txt", ".tsv"))
    console.print(
        f"[cyan]解密 Lua {len(lua_files)} + Setting {len(setting_files)} -> MasterData/[/cyan]"
    )

    stats = {"lua": 0, "setting": 0, "unluac": 0, "fail": 0}
    lock = threading.Lock()
    lua_dest_root = MASTER_DIR / "Lua"
    setting_dest_root = MASTER_DIR / "Setting"

    def do_lua(src: Path) -> None:
        dest = lua_dest_name(src, ASSETS_DIR / "Lua", lua_dest_root)
        try:
            kind = process_lua_file(src, dest)
            with lock:
                stats["lua"] += 1
                if kind == "unluac":
                    stats["unluac"] += 1
        except Exception as exc:
            with lock:
                stats["fail"] += 1
            console.print(f"[red]Lua 失败[/red] {src}: {exc}")

    def do_setting(src: Path) -> None:
        dest = setting_dest_name(src, ASSETS_DIR / "Setting", setting_dest_root)
        try:
            process_setting_file(src, dest)
            with lock:
                stats["setting"] += 1
        except Exception as exc:
            with lock:
                stats["fail"] += 1
            console.print(f"[red]Setting 失败[/red] {src}: {exc}")

    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("MasterData", total=len(lua_files) + len(setting_files))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = [pool.submit(do_lua, p) for p in lua_files]
            futs += [pool.submit(do_setting, p) for p in setting_files]
            for fut in as_completed(futs):
                fut.result()
                progress.advance(task)

    MASTER_DIR.mkdir(parents=True, exist_ok=True)
    (MASTER_DIR / ".version.json").write_text(
        json.dumps(
            {
                "lua": stats["lua"],
                "setting": stats["setting"],
                "unluac": stats["unluac"],
                "fail": stats["fail"],
            },
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    console.print(
        f"[bold green]MasterData 完成[/bold green] Lua {stats['lua']} "
        f"(unluac {stats['unluac']})  Setting {stats['setting']}  失败 {stats['fail']}"
    )


def cmd_behavior(args) -> None:
    root = Path(getattr(args, "path", None) or ASSETS_DIR / "Behavior")
    if not root.is_dir():
        console.print(f"[yellow]没有 Behavior 目录[/yellow] {root}")
        return
    files = [p for p in root.rglob("*") if p.is_file()]
    console.print(f"[cyan]Behavior 原地解密 {len(files)} 个文件 -> {root}[/cyan]")
    ok = skip = fail = 0
    for path in files:
        try:
            kind = decrypt_zlib_inplace(path)
            if kind == "ok":
                ok += 1
            else:
                skip += 1
        except Exception as exc:
            fail += 1
            console.print(f"[red]失败[/red] {path}: {exc}")
    console.print(
        f"[bold green]Behavior 完成[/bold green] 解密 {ok} 跳过 {skip} 失败 {fail}"
    )


def cmd_bundles(args) -> None:
    root = Path(args.path) if getattr(args, "path", None) else ASSETS_DIR / "Bundles"
    if not root.is_dir():
        console.print(f"[red]目录不存在[/red] {root}")
        sys.exit(1)
    files = [p for p in root.rglob("*") if p.is_file() and is_unity_bundle(p)]
    console.print(f"[cyan]UnityCN 解密 {len(files)} 个 Bundle -> {root}[/cyan]")
    ok = skip = fail = 0
    lock = threading.Lock()

    def work(path: Path) -> None:
        nonlocal ok, skip, fail
        try:
            kind = decrypt_unity_bundle(path)
            with lock:
                if kind == "ok":
                    ok += 1
                else:
                    skip += 1
        except Exception as exc:
            with lock:
                fail += 1
            console.print(f"[red]失败[/red] {path}: {exc}")

    with make_progress(MofNCompleteColumn()) as progress:
        task = progress.add_task("UnityCN", total=len(files))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = [pool.submit(work, p) for p in files]
            for fut in as_completed(futs):
                fut.result()
                progress.advance(task)
    console.print(
        f"[bold green]Bundles 完成[/bold green] 解密 {ok} 跳过 {skip} 失败 {fail}"
    )


def cmd_decrypt(args) -> None:
    root = Path(args.path)
    if not root.is_dir():
        console.print(f"[red]目录不存在[/red] {root}")
        sys.exit(1)
    lua_n = setting_n = bundle_n = 0
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        name = path.name.lower()
        if name.endswith((".lua", ".lua.bytes", ".bytes")) and "setting" not in str(
            path
        ).replace("\\", "/").lower():
            if "lua" in str(path).replace("\\", "/").lower() or name.endswith(".lua"):
                try:
                    data = path.read_bytes()
                    if looks_like_lua_source(data):
                        continue
                    plain = decrypt_lua_bytes(data)
                    if looks_like_lua_source(plain):
                        out = path.with_name(path.name.replace(".bytes", ""))
                        if not str(out).endswith(".lua"):
                            out = out.with_suffix(".lua")
                        out.write_bytes(plain)
                        lua_n += 1
                    elif plain.startswith(LUA_MAGIC):
                        with tempfile.NamedTemporaryFile(suffix=".luac", delete=False) as tmp:
                            tmp.write(plain)
                            tmp_path = Path(tmp.name)
                        try:
                            out = path.with_suffix(".lua")
                            if run_unluac(tmp_path, out):
                                lua_n += 1
                        finally:
                            tmp_path.unlink(missing_ok=True)
                except Exception:
                    pass
        if "setting" in str(path).replace("\\", "/").lower() and name.endswith(".bytes"):
            try:
                plain = decrypt_setting_bytes(path.read_bytes())
                path.with_suffix(".txt").write_bytes(plain)
                setting_n += 1
            except Exception:
                pass
        if "behavior" in str(path).replace("\\", "/").lower() and name.endswith(".bytes"):
            try:
                if decrypt_zlib_inplace(path) == "ok":
                    setting_n += 1
            except Exception:
                pass
        if is_unity_bundle(path):
            try:
                decrypt_unity_bundle(path)
                bundle_n += 1
            except Exception:
                pass
    console.print(
        f"[bold green]完成[/bold green] Lua {lua_n}  Setting {setting_n}  Bundle {bundle_n}"
    )


def cmd_all(args) -> None:
    paint_jobs = getattr(args, "jobs", None) or DEFAULT_JOBS
    cmd_assets(args)
    cmd_behavior(args)
    cmd_masterdata(args)
    if not getattr(args, "skip_bundles", False):
        args.path = None
        args.jobs = getattr(args, "bundle_jobs", None) or BUNDLE_JOBS
        cmd_bundles(args)
    if not getattr(args, "skip_painting", False):
        args.path = None
        args.jobs = paint_jobs
        cmd_painting(args)


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", help="APK 路径")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发线程数")
    shared.add_argument("--channel", help="渠道 ID，默认读 APK assets/channel.txt")
    shared.add_argument("--app-version", dest="app_version", help="应用版本，默认读 APK")
    shared.add_argument(
        "--local-version", help=f"本地资源版本，默认 {DEFAULT_RES_VERSION}"
    )
    shared.add_argument("--force", action="store_true", help="忽略已有文件强制重做")

    p = argparse.ArgumentParser(
        description="猫之城 CDN 下载 / Setting+Lua+UnityCN+Behavior 解密 / 立绘导出。"
        "不带子命令时执行全流程。",
        parents=[shared],
    )
    p.add_argument("--skip-apk", action="store_true", help="不从 APK 提取")
    p.add_argument("--skip-subpackage", action="store_true", help="不下分包")
    p.add_argument("--skip-bundles", action="store_true", help="跳过 UnityCN")
    p.add_argument("--skip-painting", action="store_true", help="跳过立绘导出")
    p.add_argument("--bundle-jobs", type=int, default=BUNDLE_JOBS, help="Bundle 解密线程数")
    sub = p.add_subparsers(dest="command", required=False)

    sub.add_parser("version", aliases=["list"], parents=[shared], help="打印远端版本与补丁清单")

    p_assets = sub.add_parser(
        "assets", parents=[shared], help="APK 提取 + 分包 + 热更补丁到 Assets/"
    )
    p_assets.add_argument("--skip-apk", action="store_true", help="不从 APK 提取")
    p_assets.add_argument("--skip-subpackage", action="store_true", help="不下分包")

    sub.add_parser(
        "masterdata",
        aliases=["data", "lua", "setting"],
        parents=[shared],
        help="Setting/Lua 解密到 MasterData/",
    )

    p_bun = sub.add_parser("bundles", help="UnityCN 解密 Assets/Bundles")
    p_bun.add_argument("--jobs", type=int, default=BUNDLE_JOBS)
    p_bun.add_argument("--path", help="Bundle 目录，默认 Assets/Bundles")

    p_beh = sub.add_parser("behavior", help="Behavior 行为树原地解密")
    p_beh.add_argument("--path", help="Behavior 目录，默认 Assets/Behavior")

    p_paint = sub.add_parser("painting", parents=[shared], help="导出立绘到 Painting/")
    p_paint.add_argument("--path", help="立绘 bundle 目录，默认 Assets/Bundles/Android/arts/role")
    p_paint.add_argument("--limit", type=int, default=0, help="只导出前 N 张，调试用")

    p_dec = sub.add_parser("decrypt", help="对已有目录原地解密")
    p_dec.add_argument("path", help="目录")
    return p


def main() -> None:
    if len(sys.argv) >= 2 and Path(sys.argv[1]).is_dir() and sys.argv[1] not in {
        "assets",
        "masterdata",
        "data",
        "lua",
        "setting",
        "bundles",
        "behavior",
        "painting",
        "decrypt",
        "version",
        "list",
    }:
        ns = argparse.Namespace(path=sys.argv[1])
        cmd_decrypt(ns)
        return

    parser = build_parser()
    args = parser.parse_args()
    if not hasattr(args, "jobs") or args.jobs is None:
        args.jobs = DEFAULT_JOBS
    if not args.command:
        cmd_all(args)
    elif args.command in ("version", "list"):
        cmd_version(args)
    elif args.command == "assets":
        cmd_assets(args)
    elif args.command in ("masterdata", "data", "lua", "setting"):
        cmd_masterdata(args)
    elif args.command == "bundles":
        cmd_bundles(args)
    elif args.command == "behavior":
        cmd_behavior(args)
    elif args.command == "painting":
        cmd_painting(args)
    elif args.command == "decrypt":
        cmd_decrypt(args)


if __name__ == "__main__":
    main()
