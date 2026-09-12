from __future__ import annotations

import argparse
import base64
import codecs
import hashlib
import hmac
import io
import json
import os
import random
import re
import sys
import threading
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence, Tuple
from urllib.parse import quote_plus

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
MANIFEST_DIR = SCRIPT_DIR / "Manifest"


# Illusion.ProductionDomainConfig.get_DefaultGameServerFQDN @ 0x03300544
# "api-allb" + "." + "assaultlily-lb.jp";AppUrl.get_GameServerUrl @ 0x0330A800 再加 "https://"
GAME_SERVER = "https://api-allb.assaultlily-lb.jp"

# Illusion.AppUrlApi.GetUrlListUrl @ il2cpp.cs:22634
PATH_URL_LIST = "/api/appUrl/get_url_list"
# Illusion.AppAkamaiConfig.CreateTokenUrl @ 0x032FFBEC -> AppUrl.GetGameServerUrl("/api/akamai/create_token")
PATH_CREATE_TOKEN = "/api/akamai/create_token"
# Illusion.MstApi @ il2cpp.cs:352079-352082
PATH_MST_ASSET_BUNDLE = "/api/mst/get_resource_asset_bundle_mst_list"
PATH_MST_FILE = "/api/mst/get_resource_file_mst_list"
PATH_MST_MASTER_DATA = "/api/mst/get_resource_master_data_mst_list"
PATH_MST_TABLE = "/api/mst/{method}"  # MstApi.getMstList @ 0x3ecc608
# Illusion.AppCryptoConfig @ il2cpp.cs:21284（convert(): 取奇数下标字符）
HASH_KEY_SOURCE = (
    "*0h>%iZAAdrw[R5l(S+nEmzLp?|ld5QC.n(r'$l9JhqAYl#Iq+o5xK3'9m^872WbH@uIG0~6&zujCBC;zigI%o..,p2ZkQAO,"
    "iLjJjW;um1c}mrCSLPJ6$WwKS$=YX:<"
)
HASH_SALT_SOURCE = "Q?p%y):^p(N;}{5*"
CRYPTO_KEY_SOURCE = "a+Bb]NW?[,4]{fU="      # AppCryptoConfig.get_CryptoKey @ 0x03300444
# Illusion.AppMsgPackConfig.GetCryptBytes @ 0x03306E10 -> HashString("ABCDEFGHIJKLMNOP", 16)
MSGPACK_KEY_SOURCE = "ABCDEFGHIJKLMNOP"
EXPECTED_MSGPACK_KEY = b"sOJPZpoaQWXCmykt"
# ── GREE GameLib 登录（AppLoginConfig : GameLibLoginDefaultConfig） ─────────────
# AppLoginConfig.get_AppId/AppSecret -> AppServiceConfig.PaymentAppId/Secret
#   ProductionServiceConfig.get_PaymentAppId    @ 0x03309378
#   ProductionServiceConfig.get_PaymentAppSecret @ 0x033093B8。
PAYMENT_HOST = "https://gl-payment.gree-apps.net"
# Config.getId()（内部 id）= 8798589a270704f67a5020c9a4269d29；
# AppLoginConfig/ProductionServiceConfig + PaymentConfigKeys.ksrle：
PAYMENT_CONFIG_ID = "8798589a270704f67a5020c9a4269d29"
PAYMENT_CONFIG_SECRET = "c8a630f4a4c8c44f91aefccbfbdd5e26da0347f88fb1db8259a5acbdf355191f72b224426219ee1e8b2c5d24861d89e9"
PAYMENT_SCRAMBLE = "iV6csMuoI0IcKbr3"
BUNDLE_ID = "jp.co.allb"
PACKAGE_ID = "jp.co.allb"
APP_VERSION_FALLBACK = "9.4.0"
APP_VERSION = APP_VERSION_FALLBACK
VERSION_CACHE = SCRIPT_DIR / "version.json"
SESSION_PATH = SCRIPT_DIR / "session.json"

# Illusion.ResourceDefine..cctor @ 0x03362570
FILE_CRYPTO_SALT = "herensuge"       # ResourceDefine.FileCryptoSalt：本地文件 XOR 流密钥盐
HASH_FILE_NAME_SALT = "yurigaoka"    # ResourceDefine.HashFileNameSalt：文件名 md5 盐
# ResourceDefine.NonCryptFilePatternList：这些模式的资源不加密
NON_CRYPT_PATTERNS = (
    ".acb", ".awb", ".usm", ".DS_Store", ".meta",
    "/AssetBundle/", "/Image/Plot/", "/Image/WebView/",
)
# ResourceCategory / PlatformType 枚举
RESOURCE_CATEGORY_ASSET_BUNDLE = "assetbundle"
RESOURCE_CATEGORY_FILE = "file"

# A2.Http.UserAgent.GetUserAgent @ 0x02DF6DC4
def default_user_agent() -> str:
    """客户端 UA（A2.Http.UserAgent）：带上当前 app 版本。"""
    return f"UnityRequest Android {APP_VERSION} (Android)"

# 用来判断内容是否被 XOR 过
KNOWN_MAGICS: Tuple[bytes, ...] = (
    b"UnityFS", b"UnityWeb", b"UnityRaw", b"PK\x03\x04",        # AB / 压缩包
    b"\xff\xd8\xff", b"\x89PNG\r\n\x1a\n", b"GIF8", b"RIFF",    # 图片 / 音频
    b"OggS", b"CRID", b"@UTF", b"@U", b"ID3", b"FTEX",          # 音频 / CRI / 贴图
    b"\x00\x00\x00\x0c", b"{\"", b"[{", b"<?xml", b"PKM ", b"DDS ",
)

_missing: List[str] = []
try:
    import requests
except ImportError:  # pragma: no cover
    _missing.append("requests")
try:
    import msgpack
except ImportError:  # pragma: no cover
    _missing.append("msgpack")
try:
    from Crypto.Cipher import AES
    from Crypto.Util.Padding import pad, unpad
except ImportError:  # pragma: no cover
    _missing.append("pycryptodome")

try:
    from rich.console import Console
    from rich.progress import (
        BarColumn, MofNCompleteColumn, Progress, TextColumn,
        TimeRemainingColumn, TransferSpeedColumn,
    )
    console = Console()
    HAS_RICH = True
except ImportError:  # pragma: no cover
    console = None
    HAS_RICH = False

if _missing:
    print("缺少依赖: " + ", ".join(_missing))
    print("  pip install " + " ".join(_missing))
    sys.exit(1)


class MiniConsole:
    """没有 rich 时的回退实现。"""

    def print(self, *a: Any, **kw: Any) -> None:
        text = " ".join(str(x) for x in a)
        text = re.sub(r"\[/?[a-zA-Z0-9 #._]+\]", "", text)
        print(text, flush=True)


console = console or MiniConsole()
CONVERT_RESULT = "System.Char[]"


def _extract_odd_chars(source: str) -> str:
    """名字保留用于对照反汇编，实际返回值恒为 "System.Char[]"（见上面的重载陷阱说明）。"""
    return CONVERT_RESULT


HASH_KEY = _extract_odd_chars(HASH_KEY_SOURCE)
HASH_SALT = _extract_odd_chars(HASH_SALT_SOURCE)


def hash_bytes(text: str, max_length: int = 0) -> bytes:
    """A2.Crypto.Hash.HashBytes @ 0x02DF60EC。

    HMACSHA256(key = UTF8(HashKey), message = UTF8(HashSalt + text))，
    超过 max_length 时取中间一段（offset = (len - max_length) / 2）。
    """
    digest = hmac.new(HASH_KEY.encode("utf-8"), (HASH_SALT + text).encode("utf-8"), hashlib.sha256).digest()
    if max_length and len(digest) > max_length:
        offset = (len(digest) - max_length) // 2
        digest = digest[offset:offset + max_length]
    return digest


def hash_string(text: str, max_length: int = 0) -> str:
    """A2.Crypto.Hash.HashString @ 0x02E0A77C：base64 后再取中间 max_length 个字符。"""
    b64 = base64.b64encode(hash_bytes(text, max_length)).decode("ascii")
    if max_length and len(b64) > max_length:
        offset = (len(b64) - max_length) // 2
        b64 = b64[offset:offset + max_length]
    return b64


def derive_crypto_key() -> str:
    """AppCryptoConfig.get_CryptoKey @ 0x03300444（BasicCrypto 用，16 字符）。"""
    return hash_string(_extract_odd_chars(CRYPTO_KEY_SOURCE), 16)


def derive_msgpack_key() -> bytes:
    """AppMsgPackConfig.GetCryptBytes @ 0x03306E10：接口报文 AES 密钥（ASCII 16 字节）。"""
    return hash_string(MSGPACK_KEY_SOURCE, 16).encode("utf-8")


def hash_resource_name(name: str) -> str:
    """Illusion.ResourceManager.ConvertToHash @ 0x0336FDE8：md5(name + "yurigaoka") 小写十六进制。"""
    return hashlib.md5((name + HASH_FILE_NAME_SALT).encode("utf-8")).hexdigest()

def aes_cbc_decrypt(key: bytes, data: bytes) -> bytes:
    if len(data) <= len(key):
        raise ValueError("ciphertext too short")
    iv, body = data[:len(key)], data[len(key):]
    return unpad(AES.new(key, AES.MODE_CBC, iv).decrypt(body), 16)


def aes_cbc_encrypt(key: bytes, data: bytes) -> bytes:
    iv = os.urandom(len(key))
    return iv + AES.new(key, AES.MODE_CBC, iv).encrypt(pad(data, 16))

def xor_key_stream(file_name: str, salt: str = FILE_CRYPTO_SALT) -> bytes:
    return (
        hashlib.sha512((file_name + salt).encode("utf-8")).digest()
        + hashlib.sha512(file_name.encode("utf-8")).digest()
    )


def xor_cipher(data: bytes, key: bytes, position: int = 0) -> bytes:
    n = len(key)
    if n == 0:
        return data
    step = n - (position % n)
    head = bytes(b ^ k for b, k in zip(data[:step], key[position % n:]))
    if len(data) <= step:
        return head
    tail = data[step:]
    repeated = key * (len(tail) // n + 1)
    return head + bytes(b ^ k for b, k in zip(tail, repeated))


def needs_no_crypto(resource_name: str) -> bool:
    return any(pat in resource_name for pat in NON_CRYPT_PATTERNS)


def looks_known(data: bytes) -> bool:
    if len(data) < 8:
        return False
    if any(data.startswith(magic) for magic in KNOWN_MAGICS):
        return True
    sample = data[:512]
    if sample.lstrip()[:1] in (b"{", b"["):
        return True
    try:
        sample.decode("utf-8")
        return True
    except UnicodeDecodeError:
        return False


def local_decrypt(data: bytes, resource_name: str) -> Tuple[bytes, Optional[str]]:
    """解密设备上被 ResourceFileCryptoStream 加密的文件；返回 (数据, 使用的名字)。"""
    if needs_no_crypto(resource_name) or looks_known(data):
        return data, None
    candidates = [resource_name, hash_resource_name(resource_name), Path(resource_name).name]
    for name in candidates:
        try:
            out = xor_cipher(data, xor_key_stream(name))
        except Exception:
            continue
        if looks_known(out):
            return out, name
    return data, None


def _filetime_now() -> int:
    """A2.Http.Util.ActionTime.GetTime @ 0x02DFD078：DateTime.ToFileTimeUtc()（1601 起 100ns）。"""
    delta = datetime.now(timezone.utc).replace(tzinfo=None) - datetime(1601, 1, 1)
    return int(delta.total_seconds() * 10_000_000)


def empty_payload() -> Dict[str, Any]:
    """PokkeEmptyReq / PokkeReqBase：只有 unixTime。"""
    return {"unixTime": int(time.time())}


def build_container(payload: Any, *, uuid: str = "", user_id: int = 0,
                    session_id: str = "", action_token: Any = None, ctag: Any = None) -> Dict[str, Any]:
    """A2.Http.PokkeReqContainer..ctor @ 0x02DFCF1C + PokkeReqContainer<T>."""
    return {
        "uuid": uuid,
        "userId": user_id,
        "sessionId": session_id,
        "actionToken": action_token,
        "ctag": ctag,
        "actionTime": _filetime_now(),
        "payload": payload,
    }


def _to_jsonable(obj: Any) -> Any:
    """msgpack 解出来的对象转成可 json.dump 的结构。"""
    if isinstance(obj, dict):
        return {str(k): _to_jsonable(v) for k, v in obj.items()}
    if isinstance(obj, (list, tuple)):
        return [_to_jsonable(v) for v in obj]
    if isinstance(obj, msgpack.ExtType):
        return {"__ext__": obj.code, "hex": obj.data.hex()}
    if isinstance(obj, (bytes, bytearray)):
        try:
            return obj.decode("utf-8")
        except UnicodeDecodeError:
            return {"__hex__": bytes(obj).hex()}
    if isinstance(obj, float) and obj != obj:  # NaN
        return None
    return obj


def dump_json(path: Path, data: Any, *, indent: int = 2) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(path.suffix + ".tmp")
    with tmp.open("w", encoding="utf-8") as fh:
        json.dump(data, fh, ensure_ascii=False, indent=indent, sort_keys=False)
        fh.write("\n")
    tmp.replace(path)


def load_json(path: Path, default: Any = None) -> Any:
    try:
        with path.open("r", encoding="utf-8") as fh:
            return json.load(fh)
    except (OSError, ValueError):
        return default


class ApiError(RuntimeError):
    pass


class IllusionClient:
    """复刻客户端取数流程：

    AppSettings.initializeConnection @ 0x033098E8 注册了
        ICryptor        -> AesCbcCrypt
        IMsgPackConfig  -> AppMsgPackConfig
        IPokkeAPIFactory-> Illusion.Http.MsgPackAPIFactory
        ICryptoConfig   -> AppCryptoConfig
    并在每个请求上带 "X-GAME-SERVER-URL" 头；UUID 存在时才会加 "X-post-signature"。
    """

    def __init__(self, *, game_server: str = GAME_SERVER, timeout: int = 60,
                 retries: int = 3, user_agent: str = "",
                 token: str = "", verbose: bool = False, key: str = "",
                 session: str = "", uuid: str = "", action_token: str = "",
                 user_id: int = 0, private_key_pem: str = "",
                 proxy: str = "", no_proxy: bool = False) -> None:
        self.game_server = game_server.rstrip("/")
        self.timeout = timeout
        self.retries = max(1, retries)
        self.token = token or ""
        self.verbose = verbose
        self.uuid = uuid or ""
        self.session_id = session or ""
        self.action_token = action_token or ""
        self.user_id = int(user_id or 0)
        self.proxy = proxy or ""
        self.no_proxy = bool(no_proxy)
        self.private_key = None
        if private_key_pem:
            try:
                from Crypto.PublicKey import RSA
                self.private_key = RSA.import_key(private_key_pem)
            except Exception as exc:
                console.print(f"[yellow]私钥解析失败：{exc}[/yellow]")
        self.candidate_keys: List[bytes] = []
        for candidate in (key.encode() if key else None, derive_msgpack_key()):
            if candidate and candidate not in self.candidate_keys:
                self.candidate_keys.append(candidate)
        self.key = self.candidate_keys[0]
        self.revisions: Dict[str, str] = {}
        self.app_url_data: Dict[str, str] = {}
        self._token_failed = False
        self._token_lock = threading.Lock()
        self._token_refreshed_at = 0.0
        self.session = requests.Session()
        self.session.trust_env = not self.proxy and not self.no_proxy
        if self.proxy:
            self.session.proxies.update({"http": self.proxy, "https": self.proxy})
        self.session.headers.update({
            "Content-Type": "application/x-msgpack",
            "X-GAME-SERVER-URL": self.game_server,
            "User-Agent": user_agent or default_user_agent(),
            "Accept-Encoding": "gzip",
            "Connection": "Keep-Alive",
        })

    def _encode(self, payload: Any, key: Optional[bytes] = None) -> bytes:
        raw = msgpack.packb(
            build_container(payload, uuid=self.uuid, user_id=self.user_id,
                            session_id=self.session_id, action_token=self.action_token or None),
            use_bin_type=True)
        return aes_cbc_encrypt(key or self.key, raw)

    def _signature_header(self, body: bytes) -> Optional[str]:
        """A2.GameLib.APISigning.Sign：uuid 存在时对 payload 签名（base64(SHA1(data))→RSA-SHA1→base64）。"""
        if not self.private_key or not self.uuid:
            return None
        try:
            return rsa_sign(body, self.private_key)
        except Exception:
            return None

    def _decode(self, blob: bytes) -> Dict[str, Any]:
        """用候选密钥逐个尝试解密；成功后记住这把 key（服务端换 key 时自愈）。"""
        errors: List[str] = []
        ordered = [self.key] + [k for k in self.candidate_keys if k != self.key]
        for key in ordered:
            try:
                raw = aes_cbc_decrypt(key, blob)
                obj = msgpack.unpackb(raw, raw=False, strict_map_key=False)
            except Exception as exc:
                errors.append(f"{key.decode('ascii', 'replace')}: {type(exc).__name__}")
                continue
            if not isinstance(obj, dict) or ("payload" not in obj and "errors" not in obj and "status" not in obj):
                errors.append(f"{key.decode('ascii', 'replace')}: 结构不符")
                continue
            if key != self.key:
                console.print(f"[yellow]切换报文密钥[/yellow] -> {key.decode('ascii', 'replace')}")
                self.key = key
            return _to_jsonable(obj)
        raise ApiError("响应解密失败（候选密钥都不匹配：" + "; ".join(errors) + "）")

    def _remember_revisions(self, headers: Any) -> None:
        mapping = {
            "X-RESOURCE-REVISION-ASSET-BUNDLE": "assetBundle",
            "X-RESOURCE-REVISION-FILE": "file",
            "X-RESOURCE-REVISION-MASTER-DATA": "masterData",
        }
        for header, name in mapping.items():
            value = headers.get(header)
            if value:
                self.revisions[name] = value

    def _logical_error(self, container: Dict[str, Any], url: str) -> Optional[str]:
        status = container.get("status")
        errors = container.get("errors") or []
        if status not in (0, None, 200):
            return f"status={status}"
        if isinstance(errors, list) and errors:
            first = errors[0] if isinstance(errors[0], dict) else {}
            code = first.get("code")
            reason = first.get("reason") or ""
            hint = ""
            if code == 40001:
                hint = "（需要登录态：用 --session/--uuid/--action-token 传入，或先跑登录流程）"
            elif code == 40004:
                hint = "（请求体未被服务端处理：检查 UUID/sessionId 是否为空）"
            return f"code={code} {reason}{hint}"
        return None

    def post(self, url: str, payload: Any = None, *, expect_payload: bool = True,
             allow_refresh: bool = True) -> Dict[str, Any]:
        body = self._encode(empty_payload() if payload is None else payload)
        last_error: Optional[Exception] = None
        for attempt in range(self.retries):
            try:
                headers: Dict[str, str] = {}
                if self.session_id:
                    headers["Cookie"] = self.session_id
                signature = self._signature_header(body)
                if signature:
                    headers["X-post-signature"] = signature
                resp = self.session.post(url, data=body, timeout=self.timeout, headers=headers)
            except requests.RequestException as exc:
                last_error = exc
                time.sleep(1.0 + attempt)
                continue
            self._remember_revisions(resp.headers)
            if resp.status_code in (403, 401):
                if allow_refresh and attempt + 1 < self.retries and self.refresh_token():
                    console.print("[yellow]接口 403，已刷新 Akamai token 后重试[/yellow]")
                    continue
                last_error = ApiError(f"HTTP {resp.status_code} {url}(可能需要新的 Akamai token)")
                break
            if resp.status_code != 200:
                last_error = ApiError(f"HTTP {resp.status_code} {url}")
                time.sleep(1.0 + attempt)
                continue
            try:
                container = self._decode(resp.content)
            except Exception as exc: 
                last_error = ApiError(f"响应解密失败 {url}: {exc}")
                time.sleep(1.0 + attempt)
                continue
            logical = self._logical_error(container, url)
            if logical:
                raise ApiError(f"逻辑错误 {logical} @ {url}")
            for key_name in ("actionToken", "sessionId", "userId"):
                value = container.get(key_name)
                if key_name == "actionToken" and value:
                    self.action_token = value
                elif key_name == "sessionId" and value:
                    self.session_id = value
                elif key_name == "userId" and value:
                    self.user_id = int(value)
            if self.verbose:
                console.print(f"[dim]POST {url} -> ok[/dim]")
            if expect_payload and "payload" not in container:
                container["payload"] = None
            return container
        raise ApiError(f"请求失败 {url}: {last_error}")

    def fetch_url_list(self) -> Dict[str, str]:
        container = self.post(self.game_server + PATH_URL_LIST)
        data = (container.get("payload") or {}).get("appUrlData") or {}
        if not data:
            raise ApiError("get_url_list 未返回 appUrlData")
        self.app_url_data = {k: v for k, v in data.items() if isinstance(v, str)}
        return self.app_url_data

    def create_token(self) -> str:
        """A2.Akamai.ShortTimeToken.CreateToken @ 0x02E17B40 -> "/api/akamai/create_token"。

        注意 allow_refresh=False：否则 403 时会 post -> refresh_token -> create_token 自锁。
        """
        container = self.post(self.game_server + PATH_CREATE_TOKEN, allow_refresh=False)
        token = (container.get("payload") or {}).get("token") or ""
        if token:
            self.token = token
        return token

    def master_data_server(self) -> str:
        server = self.app_url_data.get("resourceMasterDataServerUrl")
        if not server:
            raise ApiError("缺少 resourceMasterDataServerUrl，请先执行 lists")
        return server.rstrip("/")

    def resource_file_server(self) -> str:
        server = self.app_url_data.get("resourceFileServerUrl")
        if not server:
            raise ApiError("缺少 resourceFileServerUrl，请先执行 lists")
        return server.rstrip("/")

    def _mst_query(self, revision: str) -> str:
        parts: List[str] = []
        if revision:
            parts.append("hash=" + revision)
        if self.token:
            parts.append(self.token)
        return "?" + "&".join(parts) if parts else ""

    def fetch_mst_list(self, path: str, revision: str = "") -> List[Dict[str, Any]]:
        url = self.master_data_server() + path + self._mst_query(revision)
        container = self.post(url)
        payload = container.get("payload") or {}
        return payload.get("mstList") or []

    def fetch_master_table(self, method: str, table_hash: str) -> List[Dict[str, Any]]:
        url = self.master_data_server() + PATH_MST_TABLE.format(method=method) + self._mst_query(table_hash)
        container = self.post(url)
        payload = container.get("payload") or {}
        return payload.get("mstList") or []

    def refresh_token(self, min_interval: float = 5.0) -> bool:
        """串行刷新 token：并发线程只允许一个真正请求，其余复用刚拿到的 token。"""
        with self._token_lock:
            if time.time() - self._token_refreshed_at < min_interval:
                return bool(self.token)
            if self._token_failed:
                return False
            try:
                ok = bool(self.create_token())
            except ApiError:
                self._token_failed = True
                return False
            self._token_refreshed_at = time.time()
            return ok

    def download(self, url_builder: Any) -> bytes:
        """FileDownloader._executeDownloadAsync @ 0x02D0B544：GET + "&{token}"，服务端内容为明文。

        url_builder(token) -> url；token 过期（403）时刷新一次再试。
        """
        last_error: Optional[Exception] = None
        for attempt in range(self.retries):
            url = url_builder(self.token)
            try:
                resp = self.session.get(url, timeout=self.timeout)
            except requests.RequestException as exc:
                last_error = exc
                time.sleep(1.0 + attempt)
                continue
            if resp.status_code == 403:
                if attempt + 1 < self.retries and self.refresh_token():
                    console.print("[yellow]token 失效，已刷新后重试[/yellow]")
                    continue
                raise ApiError(f"HTTP 403（token 过期或被 Akamai 拦截）：{url}")
            if resp.status_code != 200:
                last_error = ApiError(f"HTTP {resp.status_code} {url}")
                time.sleep(1.0 + attempt)
                continue
            return resp.content
        raise ApiError(f"下载失败 {url}: {last_error}")


def asset_bundle_base_url(file_server: str, platform: str = "android", hashed: bool = True) -> str:
    if hashed:
        return f"{file_server}/{hash_resource_name(RESOURCE_CATEGORY_ASSET_BUNDLE)}/{hash_resource_name(platform.lower())}"
    return f"{file_server}/{RESOURCE_CATEGORY_ASSET_BUNDLE}/{platform.lower()}"


def file_base_url(file_server: str, hashed: bool = True) -> str:
    if hashed:
        return f"{file_server}/{hash_resource_name(RESOURCE_CATEGORY_FILE)}"
    return f"{file_server}/{RESOURCE_CATEGORY_FILE}"


def build_download_url(base: str, name: str, file_hash: str, token: str, hashed: bool = True) -> str:
    leaf = hash_resource_name(name) if hashed else name
    query = f"?hash={file_hash}" if file_hash else "?"
    return f"{base}/{leaf}{query}" + (f"&{token}" if token else "")


def pick_platform(record: Dict[str, Any], key: str, platform: str) -> Any:
    """mst 记录里按平台取字段：androidFileHash / iosFileHash / windowsFileHash。"""
    return record.get(f"{platform}{key}") or record.get(key)


PLATFORMS = ("android", "ios", "windows")

def generate_device_id() -> str:
    """OAuth.py 同款：16 位 hex -> base64 -> 反转 -> rot13。"""
    raw = "".join(random.choice("abcdef1234567890") for _ in range(16))
    return codecs.encode(base64.b64encode(raw.encode())[::-1].decode(), "rot_13")


def generate_nonce(length: int = 19) -> int:
    return int("".join(str(random.randint(0, 9)) for _ in range(length)))


def rsa_sign(data: bytes, key: Any) -> str:
    """Payload 签名：base64(SHA1(data)) 再用 RSA 私钥 PKCS1v15-SHA1 签，返回 base64。

    与 A2.GameLib.APISigning.Sign @ 0x0330A... (SHA1 -> base64 -> Payment.sign) 同构。
    """
    from Crypto.Hash import SHA1
    from Crypto.Signature import pkcs1_15
    digest = base64.b64encode(SHA1.new(data).digest())
    return base64.b64encode(pkcs1_15.new(key).sign(SHA1.new(digest))).decode()


def _apk_version_from_local() -> str:
    """兜底：从本地 .apks/.apk 文件名里取版本（如 アサルトリリィ_9.4.0.apks）。"""
    for pattern in ("*.apks", "*.apk"):
        for path in sorted(SCRIPT_DIR.glob(pattern)):
            m = re.search(r"_(\d+(?:\.\d+)+)", path.stem)
            if m:
                return m.group(1)
    return ""


def resolve_app_version(explicit: str = "", *, ttl_hours: int = 12, quiet: bool = False) -> str:
    """动态获取 app 版本：命令行 > Play Store > 本地 APK 文件名 > 内置兜底。

    结果缓存到 version.json（默认 12 小时内复用），避免每次都请求商店。
    """
    global APP_VERSION
    if explicit:
        APP_VERSION = explicit
        if not quiet:
            console.print(f"[cyan]app 版本[/cyan] {APP_VERSION}（命令行指定）")
        return APP_VERSION

    cached = load_json(VERSION_CACHE, {}) or {}
    if cached.get("version"):
        age = time.time() - float(cached.get("fetchedAt") or 0)
        if age < ttl_hours * 3600:
            APP_VERSION = str(cached["version"])
            if not quiet:
                console.print(f"[cyan]app 版本[/cyan] {APP_VERSION}（缓存，{age / 3600:.1f}h 前获取）")
            return APP_VERSION

    version = ""
    try:
        from google_play_scraper import app as playstore_app  # type: ignore
        result = playstore_app(app_id=PACKAGE_ID, lang="en", country="jp")
        version = str(result.get("version") or "")
    except Exception as exc:
        if not quiet:
            console.print(f"[yellow]Play Store 版本获取失败：{exc}[/yellow]")

    if not version:
        version = _apk_version_from_local()
        if version and not quiet:
            console.print(f"[yellow]改用本地 APK 文件名版本：{version}[/yellow]")
    if not version:
        version = APP_VERSION_FALLBACK
        if not quiet:
            console.print(f"[yellow]版本获取失败，回退到 {version}[/yellow]")

    APP_VERSION = version
    dump_json(VERSION_CACHE, {"version": version, "fetchedAt": time.time(),
                              "source": "playstore" if version else "fallback"})
    if not quiet:
        console.print(f"[cyan]app 版本[/cyan] {APP_VERSION}")
    return APP_VERSION


def device_info_dict(device_model: str = "Samsung Galaxy Note10") -> Dict[str, Any]:
    """对应登录时提交的 DeviceInfo（dec.py 里那份字段表，现版本仍兼容）。"""
    return {
        "appVersion": APP_VERSION,
        "urlParam": None,
        "deviceModel": device_model,
        "osType": 2,
        "osVersion": "Android OS 10 / API-29",
        "storeType": 2,
        "graphicsDeviceId": 0,
        "graphicsDeviceVendorId": 0,
        "processorCount": 8,
        "processorType": "ARM64 FP ASIMD AES",
        "supportedRenderTargetCount": 8,
        "supports3DTextures": True,
        "supportsAccelerometer": True,
        "supportsComputeShaders": True,
        "supportsGyroscope": True,
        "supportsImageEffects": True,
        "supportsInstancing": True,
        "supportsLocationService": True,
        "supportsRenderTextures": True,
        "supportsRenderToCubemap": True,
        "supportsShadows": True,
        "supportsSparseTextures": True,
        "supportsStencil": 1,
        "supportsVibration": True,
        "uuid": None,
        "xuid": 0,
        "locale": "en_US",
        "numericCountryCode": 840,
    }



def rsa_generate_small(bits: int = 512, e: int = 65537) -> Any:
    """游戏用的是 512 位 RSA（GreeGameLib 支付密钥）"""
    from Crypto.Math.Numbers import Integer
    from Crypto.Math.Primality import generate_probable_prime
    from Crypto.PublicKey.RSA import RsaKey
    from Crypto import Random
    randfunc = Random.get_random_bytes
    d = n = Integer(1)
    e = Integer(e)
    p = q = Integer(3)
    while n.size_in_bits() != bits and d < (1 << (bits // 2)):
        size_q = bits // 2
        size_p = bits - size_q
        min_p = min_q = (Integer(1) << (2 * size_q - 1)).sqrt()
        if size_q != size_p:
            min_p = (Integer(1) << (2 * size_p - 1)).sqrt()
        p = generate_probable_prime(exact_bits=size_p, randfunc=randfunc,
                                    prime_filter=lambda c: c > min_p and (c - 1).gcd(e) == 1)
        min_distance = Integer(1) << (bits // 2 - 100)
        q = generate_probable_prime(exact_bits=size_q, randfunc=randfunc,
                                    prime_filter=lambda c: (c > min_q and (c - 1).gcd(e) == 1
                                                            and abs(c - p) > min_distance))
        n = p * q
        d = e.inverse((p - 1).lcm(q - 1))
    if p > q:
        p, q = q, p
    return RsaKey(n=n, e=e, d=d, p=p, q=q, u=p.inverse(q))


class GreePaymentOAuth:
    """GREE GameLib 支付 OAuth：设备注册 -> x_uid -> (可选)授权/设备校验。

    对应 OAuth.py 的 OAuthPayment，但只保留当前流程需要的部分：
      POST /v1.0/auth/initialize  (新账号用 HMAC-SHA1 签名，body 里带 RSA 公钥)
      GET  /v1.0/auth/x_uid
      POST /v1.0/auth/authorize   (老账号)
    """

    def __init__(self, *, device_model: str = "Samsung Galaxy Note10",
                 session: Optional[Any] = None, private_key_pem: str = "",
                 device_id: str = "", uuid: str = "",
                 app_id: str = "", app_secret: str = "", host: str = "") -> None:
        from Crypto.PublicKey import RSA
        self.device_model = device_model
        self.session = session or requests.Session()
        self.device_id = device_id or generate_device_id()
        derived_id, derived_secret = derive_payment_credentials()
        self.app_id = app_id or derived_id
        self.app_secret = app_secret or derived_secret
        self.host = (host or PAYMENT_HOST).rstrip("/")
        if private_key_pem:
            self.key = RSA.import_key(private_key_pem)
        else:
            self.key = rsa_generate_small(512)
        self.uuid = uuid or ""
        self.x_uid = ""

    @property
    def private_key_pem(self) -> str:
        return self.key.export_key().decode()

    def _oauth_header(self, method: str, url: str, body: bytes, uuid: Optional[str] = None,
                      new_account: bool = False, extra: Optional[Dict[str, str]] = None) -> str:
        from Crypto.Hash import SHA1
        from Crypto.Signature import pkcs1_15
        timestamp = int(time.time())
        header = {
            "oauth_body_hash": base64.b64encode(SHA1.new(body).digest()).decode(),
            "oauth_consumer_key": self.app_id,
            "oauth_nonce": str(generate_nonce()),
            "oauth_signature_method": "HMAC-SHA1" if new_account else "RSA-SHA1",
            "oauth_timestamp": str(timestamp),
            "oauth_version": "1.0",
        }
        header.update(extra or {})
        if not new_account:
            to_hash = (self.app_secret + str(timestamp)).encode()
            header["xoauth_as_hash"] = base64.b64encode(
                pkcs1_15.new(self.key).sign(SHA1.new(to_hash))).decode()
            header["xoauth_requestor_id"] = uuid or self.uuid
        auth_string = "".join(
            f"{quote_plus(k)}={quote_plus(str(v))}&" for k, v in sorted(header.items())
            if k != "oauth_signature"
        ).rstrip("&")
        string_to_hash = f"{quote_plus(method)}&{quote_plus(url)}&{quote_plus(auth_string)}"
        if new_account:
            signature = base64.b64encode(
                hmac.new(self.app_secret.encode(), string_to_hash.encode(), "SHA1").digest()).decode()
        else:
            signature = base64.b64encode(
                pkcs1_15.new(self.key).sign(SHA1.new(string_to_hash.encode()))).decode()
        header["oauth_signature"] = signature
        return "OAuth " + ",".join(f'{k}="{quote_plus(str(v))}"' for k, v in sorted(header.items()))

    def _request(self, method: str, resource: str, body: bytes = b"",
                 uuid: Optional[str] = None, extra: Optional[Dict[str, str]] = None):
        url = self.host + resource
        new_account = (uuid or self.uuid) in ("", None)
        authorization = self._oauth_header(method, url, body, uuid, new_account, extra)
        headers = {
            "Authorization": authorization,
            "X-GREE-GAMELIB": (
                "authVersion%3D1.5.17%26billing%3D3%26storeType%3Dgoogle%26appVersion%3D" + APP_VERSION +
                "%26uaType%3Dandroid-app%26carrier%3DEMOBILE%2BLimited%26compromised%3Dfalse"
                "%26countryCode%3DUS%26currencyCode%3DUSD%26model%3DAndroid-Phone"
            ),
            "User-Agent": (f"Mozilla/5.0 (Linux; Android 10; {self.device_model} AppleWebKit/537.36 "
                           "(KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.101 Mobile Safari/537.36"),
            "Content-Type": "application/json; charset=UTF-8",
            "Accept-Encoding": "gzip",
        }
        kwargs: Dict[str, Any] = {"headers": headers, "timeout": 30}
        if body:
            kwargs["data"] = body
        return self.session.request(method, url, **kwargs)

    def register(self) -> Tuple[str, str]:
        """新设备注册：返回 (uuid, x_uid)。"""
        payload = device_info_dict(self.device_model)
        payload["uuid"] = None
        payload["xuid"] = 0
        body = json.dumps({
            "device_id": self.device_id,
            "token": self.key.publickey().export_key().decode(),
            "payload": json.dumps(payload).replace(" ", ""),
        }).encode()
        resp = self._request("POST", "/v1.0/auth/initialize", body)
        if resp.status_code != 200:
            raise ApiError(f"支付网关注册失败 HTTP {resp.status_code}: {resp.text[:200]}")
        self.uuid = resp.json()["uuid"]
        x = self._request("GET", "/v1.0/auth/x_uid", b"", uuid=self.uuid)
        if x.status_code != 200:
            raise ApiError(f"获取 x_uid 失败 HTTP {x.status_code}: {x.text[:200]}")
        self.x_uid = x.json()["x_uid"]
        return self.uuid, self.x_uid

    def authorize(self) -> None:
        self._request("POST", "/v1.0/auth/authorize", b"")

    def device_verification(self) -> None:
        self._request("POST", "/v1.0/deviceverification/nonce", b"")
        payload = json.dumps({
            "device_id": self.device_id, "compromised": False, "emulator": False, "debug": False,
            "installer": "com.android.coreservice", "bundle_id": BUNDLE_ID,
            "app_version": APP_VERSION, "os_version": "10", "sf_jws": "",
        }).encode()
        self._request("POST", "/v1.0/deviceverification/verify", payload)


def _scramble_decrypt(hex_text: str, scramble: str = PAYMENT_SCRAMBLE) -> str:
    """C11750a.m25008a/m25012b + C11752b.m25030c：
    AES-128-ECB/PKCS5Padding 解密 hex 串（密钥 = scramble 的 UTF-8 字节）。"""
    if not scramble:
        raise ApiError("缺少 scramble，无法还原支付凭据")
    data = bytes.fromhex(hex_text)
    return unpad(AES.new(scramble.encode("utf-8"), AES.MODE_ECB).decrypt(data), 16).decode("utf-8")


_PAYMENT_CRED_CACHE: Optional[Tuple[str, str]] = None


def derive_payment_credentials(refresh: bool = False) -> Tuple[str, str]:
    """动态推导 (线上 app_id, 签名密钥)，与 Frida 实抓值一致。"""
    global _PAYMENT_CRED_CACHE
    if _PAYMENT_CRED_CACHE is None or refresh:
        _PAYMENT_CRED_CACHE = (
            _scramble_decrypt(PAYMENT_CONFIG_ID),
            _scramble_decrypt(PAYMENT_CONFIG_SECRET),
        )
    return _PAYMENT_CRED_CACHE


def load_session() -> Dict[str, Any]:
    data = load_json(SESSION_PATH, {}) or {}
    return data if isinstance(data, dict) else {}


def save_session(data: Dict[str, Any]) -> None:
    dump_json(SESSION_PATH, data)
    try:
        os.chmod(SESSION_PATH, 0o600)
    except OSError:
        pass


def do_login(args: argparse.Namespace, *, new: bool = False) -> Optional[Dict[str, Any]]:
    """执行登录/注册并把会话写入 session.json；失败返回 None。"""
    session = {} if new else load_session()
    oauth = GreePaymentOAuth(
        device_model=getattr(args, "device_model", "Samsung Galaxy Note10"),
        private_key_pem=session.get("privateKey", ""),
        device_id=session.get("deviceId", ""),
        uuid=session.get("uuid", ""),
        app_id=getattr(args, "payment_app_id", "") or session.get("paymentAppId", ""),
        app_secret=getattr(args, "payment_app_secret", "") or session.get("paymentAppSecret", ""),
        host=getattr(args, "payment_host", "") or "",
    )
    try:
        if oauth.uuid and oauth.device_id:
            console.print(f"[cyan]复用设备[/cyan] uuid={oauth.uuid}")
            x = oauth._request("GET", "/v1.0/auth/x_uid", b"", uuid=oauth.uuid)
            oauth.x_uid = x.json().get("x_uid", session.get("xUid", ""))
            if not oauth.x_uid:
                raise ApiError(f"x_uid 获取失败: {x.text[:200]}")
            oauth.authorize()
        else:
            console.print("[cyan]注册新设备[/cyan]（GREE 支付网关 auth/initialize）")
            oauth.register()
        console.print(f"[green]uuid[/green]={oauth.uuid} x_uid={oauth.x_uid}")
    except ApiError as exc:
        console.print(f"[red]支付网关失败：{exc}[/red]")
        return None

    client = IllusionClient(game_server=args.api, timeout=args.timeout, retries=args.retries,
                            verbose=args.verbose, key=args.key or "",
                            uuid=oauth.uuid, private_key_pem=oauth.private_key_pem)
    payload = device_info_dict(getattr(args, "device_model", "Samsung Galaxy Note10"))
    payload["uuid"] = oauth.uuid
    payload["xuid"] = int(oauth.x_uid)
    try:
        container = client.post(client.game_server + "/api/login", payload)
    except ApiError as exc:
        console.print(f"[red]登录失败：{exc}[/red]")
        return None
    data = container.get("payload") or {}
    session_id = data.get("sessionId", "")
    user_id = data.get("userId", 0)
    if not session_id:
        console.print(f"[red]登录响应缺少 sessionId：{json.dumps(container, ensure_ascii=False)[:300]}[/red]")
        return None
    client.session_id = session_id
    client.user_id = int(user_id or 0)
    saved = {
        "uuid": oauth.uuid, "xUid": oauth.x_uid, "deviceId": oauth.device_id,
        "privateKey": oauth.private_key_pem, "sessionId": session_id, "userId": client.user_id,
        "deviceModel": getattr(args, "device_model", "Samsung Galaxy Note10"), "api": client.game_server,
        "paymentAppId": oauth.app_id, "paymentAppSecret": oauth.app_secret, "paymentHost": oauth.host,
        "actionToken": data.get("actionToken", ""),
        "savedAt": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    }
    save_session(saved)
    console.print(f"[bold green]登录成功[/bold green] userId={client.user_id} -> {SESSION_PATH}")
    return saved


def ensure_logged_in(args: argparse.Namespace) -> IllusionClient:
    """没有可用会话时自动注册/登录（painting/lists/assets/masterdata 共用）。"""
    stored = load_session()
    if not (stored.get("uuid") and stored.get("sessionId")):
        console.print("[yellow]未检测到登录态，自动注册/登录…[/yellow]")
        do_login(args, new=True)
    return make_client(args)


def cmd_login(args: argparse.Namespace) -> int:
    saved = do_login(args, new=bool(getattr(args, "new", False)))
    if saved is None:
        return 1
    if args.then:
        console.print("[cyan]继续执行[/cyan] " + args.then)
        return {"lists": cmd_lists, "assets": cmd_assets, "masterdata": cmd_masterdata,
                "painting": cmd_painting, "update": cmd_update}[args.then](args)
    return 0


_unitypy_failed: Optional[str] = None


def _load_unitypy():
    global _unitypy_failed
    try:
        import UnityPy  # type: ignore
        import warnings
        warnings.filterwarnings("ignore", message=".*Unity.*version.*")
        UnityPy.config.FALLBACK_UNITY_VERSION = UnityPy.config.FALLBACK_UNITY_VERSION or "2022.3.62f1"
        return UnityPy
    except Exception as exc:  # pragma: no cover
        _unitypy_failed = str(exc)
        return None


def _safe_name(name: str) -> str:
    """文件名安全化：保留字母/数字（含日文假名、汉字等 Unicode 字母）与 . _ - /，其余替换为 _。"""
    name = name.replace("\\", "/").strip("/")
    out = []
    for ch in name:
        if ch == "/" or ch in "._-":
            out.append(ch)
        elif ch.isalnum():
            out.append(ch)
        else:
            out.append("_")
    return "".join(out) or "unnamed"


def _rel(path: Path) -> str:
    try:
        return str(path.relative_to(SCRIPT_DIR))
    except ValueError:
        return str(path)


def _object_name(obj: Any, data: Any, fallback: str) -> str:
    name = getattr(data, "m_Name", None) or getattr(data, "name", None)
    if isinstance(name, bytes):
        name = name.decode("utf-8", "ignore")
    if name:
        return str(name)
    return fallback


def _dump_monobehaviour(obj: Any, out_path: Path) -> bool:
    try:
        tree = obj.read_typetree()
    except Exception:
        return False
    dump_json(out_path.with_suffix(".json"), _to_jsonable(tree))
    return True


def extract_bundle(bundle_path: Path, out_dir: Path, *, limit: int = 0) -> Dict[str, int]:
    """把 AssetBundle 里的对象导出为可用文件（贴图/文本/音频/字体/MonoBehaviour）。"""
    UnityPy = _load_unitypy()
    stats = {"objects": 0, "files": 0, "failed": 0}
    if UnityPy is None:
        return stats
    try:
        env = UnityPy.load(str(bundle_path))
    except Exception:
        return stats

    container_map: Dict[int, str] = {}
    for container_path, obj in getattr(env, "container", {}).items():
        try:
            container_map[obj.path_id] = str(container_path)
        except Exception:
            continue
    used_names: Dict[str, int] = {}

    def target_path(type_name: str, name: str, suffix: str) -> Path:
        key = f"{type_name}/{name}{suffix}"
        used_names[key] = used_names.get(key, 0) + 1
        if used_names[key] > 1:
            name = f"{name}_{used_names[key]}"
        return out_dir / _safe_name(type_name) / (_safe_name(name) + suffix)

    for obj in env.objects:
        if limit and stats["objects"] >= limit:
            break
        stats["objects"] += 1
        try:
            type_name = obj.type.name
        except Exception:
            continue
        container = container_map.get(getattr(obj, "path_id", 0), "")
        fallback = Path(container).name if container else f"{obj.path_id}"
        try:
            if type_name in ("Texture2D", "Sprite"):
                data = obj.read()
                image = getattr(data, "image", None)
                if image is not None:
                    target = target_path(type_name, _object_name(obj, data, fallback), ".png")
                    target.parent.mkdir(parents=True, exist_ok=True)
                    image.save(target)
                    stats["files"] += 1
            elif type_name == "TextAsset":
                data = obj.read()
                raw = data.m_Script if isinstance(getattr(data, "m_Script", None), (bytes, bytearray)) else data.script
                if isinstance(raw, str):
                    raw = raw.encode("utf-8")
                raw = bytes(raw)
                try:
                    json.loads(raw.decode("utf-8"))
                    suffix = ".json"
                except Exception:
                    suffix = ".txt" if raw[:1].isascii() or raw[:1] in (b"\r", b"\n") else ".bytes"
                target = target_path(type_name, _object_name(obj, data, fallback), suffix)
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(raw)
                stats["files"] += 1
            elif type_name == "AudioClip":
                data = obj.read()
                samples = getattr(data, "samples", None)
                if samples:
                    name = next(iter(samples))
                    target = target_path(type_name, _object_name(obj, data, fallback), ".wav")
                    target.parent.mkdir(parents=True, exist_ok=True)
                    target.write_bytes(samples[name])
                    stats["files"] += 1
            elif type_name == "MonoBehaviour":
                data = obj.read()
                target = target_path(type_name, _object_name(obj, data, fallback), "")
                target.parent.mkdir(parents=True, exist_ok=True)
                if _dump_monobehaviour(obj, target):
                    stats["files"] += 1
            elif type_name in ("Font", "TextMeshProFont"):
                data = obj.read()
                raw = getattr(data, "m_FontData", None) or getattr(data, "m_Script", None)
                if isinstance(raw, (bytes, bytearray)):
                    target = target_path(type_name, _object_name(obj, data, fallback), ".bin")
                    target.parent.mkdir(parents=True, exist_ok=True)
                    target.write_bytes(bytes(raw))
                    stats["files"] += 1
        except Exception:
            stats["failed"] += 1
    return stats


def ensure_manifests(client: IllusionClient, args: argparse.Namespace, *, force: bool = False) -> Dict[str, Any]:
    """拉取 URL 列表 + Akamai token + 三份 mst 清单，落盘到 Manifest/。"""
    manifest_dir = Path(args.manifest_dir)
    manifest_dir.mkdir(parents=True, exist_ok=True)
    manifest = {
        "gameServer": client.game_server,
        "generatedAt": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    }

    url_list_path = manifest_dir / "UrlList.json"
    app_url_data = None if force else load_json(url_list_path)
    if app_url_data and app_url_data.get("appUrlData"):
        client.app_url_data = app_url_data["appUrlData"]
        client.revisions.update(app_url_data.get("revisions", {}) or {})
        console.print(f"[cyan]复用[/] {url_list_path}")
    else:
        client.fetch_url_list()
    dump_json(url_list_path, {"appUrlData": client.app_url_data,
                              "revisions": client.revisions})

    token_path = manifest_dir / "AkamaiToken.json"
    if not client.token and not force:
        cached_token = (load_json(token_path, {}) or {}).get("token", "")
        if cached_token:
            client.token = cached_token
    if not client.token or force:
        try:
            token = client.create_token()
            console.print(f"[cyan]Akamai token[/] 已获取（{token[:24]}…）")
        except ApiError as exc:
            console.print(f"[yellow]Akamai token 获取失败（继续尝试直连）：{exc}[/yellow]")
        if client.token:
            dump_json(token_path, {"token": client.token, "obtainedAt": time.time()})
    else:
        console.print(f"[cyan]复用[/] {token_path}")

    lists: Dict[str, List[Dict[str, Any]]] = {}
    targets = (
        ("assetBundle", PATH_MST_ASSET_BUNDLE, "ResourceAssetBundleMstList.json"),
        ("file", PATH_MST_FILE, "ResourceFileMstList.json"),
        ("masterData", PATH_MST_MASTER_DATA, "ResourceMasterDataMstList.json"),
    )
    for name, path, filename in targets:
        revision = "" if force else client.revisions.get(name, "")
        data = client.fetch_mst_list(path, revision)
        lists[name] = data
        dump_json(manifest_dir / filename, data)
        console.print(f"[green]{filename}[/green] {len(data)} 条")

    dump_json(manifest_dir / "revision.json", client.revisions)
    dump_json(url_list_path, {"appUrlData": client.app_url_data, "revisions": client.revisions})
    manifest["revisions"] = client.revisions
    manifest["counts"] = {k: len(v) for k, v in lists.items()}
    dump_json(manifest_dir / "index.json", manifest)
    return lists


def load_manifest_lists(client: IllusionClient, args: argparse.Namespace) -> Dict[str, List[Dict[str, Any]]]:
    """优先用本地 Manifest，缺失时联网拉取。"""
    manifest_dir = Path(args.manifest_dir)
    if args.refresh or not (manifest_dir / "ResourceAssetBundleMstList.json").exists():
        return ensure_manifests(client, args, force=args.refresh)
    url_data = load_json(manifest_dir / "UrlList.json", {}) or {}
    client.app_url_data = url_data.get("appUrlData", client.app_url_data)
    client.revisions = url_data.get("revisions", client.revisions)
    if not client.app_url_data:
        console.print("[yellow]本地 Manifest 缺少 UrlList，重新拉取清单[/yellow]")
        return ensure_manifests(client, args, force=True)
    token_data = load_json(manifest_dir / "AkamaiToken.json", {}) or {}
    if not client.token:
        client.token = token_data.get("token", "") or ""
    if not client.token:
        try:
            client.create_token()
        except ApiError:
            pass
    out: Dict[str, List[Dict[str, Any]]] = {}
    for name, filename in (
        ("assetBundle", "ResourceAssetBundleMstList.json"),
        ("file", "ResourceFileMstList.json"),
        ("masterData", "ResourceMasterDataMstList.json"),
    ):
        out[name] = load_json(manifest_dir / filename, []) or []
    return out

def make_client(args: argparse.Namespace) -> IllusionClient:
    """构造客户端；未显式传登录态时自动读取 session.json。"""
    stored = load_session()
    return IllusionClient(
        game_server=args.api, timeout=args.timeout, retries=args.retries,
        token=args.token or "", verbose=args.verbose, key=args.key or "",
        session=args.session or stored.get("sessionId", ""),
        uuid=args.uuid or stored.get("uuid", ""),
        action_token=args.action_token or stored.get("actionToken", ""),
        user_id=stored.get("userId", 0),
        private_key_pem=stored.get("privateKey", ""),
        proxy=getattr(args, "proxy", "") or "",
    )


def cmd_lists(args: argparse.Namespace) -> int:
    client = ensure_logged_in(args)
    ensure_manifests(client, args, force=True)
    console.print(f"[bold green]清单完成[/bold green] -> {MANIFEST_DIR}")
    return 0


def _download_asset_bundles(client: IllusionClient, args: argparse.Namespace,
                            records: Sequence[Dict[str, Any]]) -> Dict[str, Any]:
    file_server = client.resource_file_server()
    platform = args.platform.lower()
    base = asset_bundle_base_url(file_server, platform, hashed=not args.plain_names)
    out_dir = Path(args.assets_dir) / "AssetBundles"
    out_dir.mkdir(parents=True, exist_ok=True)
    report: Dict[str, Any] = {"count": 0, "downloaded": 0, "skipped": 0, "failed": 0, "items": []}

    def one(record: Dict[str, Any]) -> Tuple[str, str, int]:
        name = record["assetBundleName"]
        file_hash = pick_platform(record, "FileHash", platform) or ""
        size = int(pick_platform(record, "FileSize", platform) or 0)
        target = out_dir / _safe_name(name)
        if target.exists() and not args.force and (size == 0 or target.stat().st_size == size):
            return name, "skipped", target.stat().st_size
        seen: List[str] = []

        def make_url(token: str) -> str:
            url = build_download_url(base, name, file_hash, token, hashed=not args.plain_names)
            seen.append(url)
            return url

        blob = client.download(make_url)
        data, used = local_decrypt(blob, name)
        if size and len(data) != size:
            console.print(f"[yellow]大小不符[/yellow] {name}: {len(data)} != {size}")
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        report["items"].append({"name": name, "url": seen[-1], "size": len(data),
                                "decryptedWith": used, "path": _rel(target)})
        return name, "downloaded", len(data)

    if args.limit:
        records = list(records)[: args.limit]
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = {pool.submit(one, r): r for r in records}
        with progress_bar("AssetBundle") as bar:
            task = bar.add_task("AssetBundle", total=len(futures))
            for fut in as_completed(futures):
                try:
                    name, state, size = fut.result()
                    report[state] += 1
                    report["count"] += 1
                except Exception as exc:
                    record = futures[fut]
                    report["failed"] += 1
                    report["items"].append({"name": record.get("assetBundleName"), "error": str(exc)})
                    console.print(f"[red]AssetBundle 失败[/red] {record.get('assetBundleName')}: {exc}")
                bar.advance(task)
    return report


def _download_files(client: IllusionClient, args: argparse.Namespace,
                    records: Sequence[Dict[str, Any]]) -> Dict[str, Any]:
    file_server = client.resource_file_server()
    base = file_base_url(file_server, hashed=not args.plain_names)
    out_dir = Path(args.assets_dir) / "Files"
    out_dir.mkdir(parents=True, exist_ok=True)
    report: Dict[str, Any] = {"count": 0, "downloaded": 0, "skipped": 0, "failed": 0, "items": []}

    def one(record: Dict[str, Any]) -> Tuple[str, str, int]:
        name = record["fileName"]
        file_hash = record.get("hash") or ""
        size = int(record.get("fileSize") or 0)
        target = out_dir / _safe_name(name)
        if target.exists() and not args.force and (size == 0 or target.stat().st_size == size):
            return name, "skipped", target.stat().st_size
        seen: List[str] = []

        def make_url(token: str) -> str:
            url = build_download_url(base, name, file_hash, token, hashed=not args.plain_names)
            seen.append(url)
            return url

        blob = client.download(make_url)
        data, used = local_decrypt(blob, name)
        if size and len(data) != size:
            console.print(f"[yellow]大小不符[/yellow] {name}: {len(data)} != {size}")
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        report["items"].append({"name": name, "url": seen[-1], "size": len(data),
                                "decryptedWith": used, "path": _rel(target)})
        return name, "downloaded", len(data)

    if args.limit:
        records = list(records)[: args.limit]
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = {pool.submit(one, r): r for r in records}
        with progress_bar("File") as bar:
            task = bar.add_task("File", total=len(futures))
            for fut in as_completed(futures):
                try:
                    name, state, size = fut.result()
                    report[state] += 1
                    report["count"] += 1
                except Exception as exc:
                    record = futures[fut]
                    report["failed"] += 1
                    report["items"].append({"name": record.get("fileName"), "error": str(exc)})
                    console.print(f"[red]File 失败[/red] {record.get('fileName')}: {exc}")
                bar.advance(task)
    return report


def _extract_asset_bundles(args: argparse.Namespace) -> Dict[str, Any]:
    if not getattr(args, "extract", False):
        return {"skipped": True}
    src = Path(args.assets_dir) / "AssetBundles"
    dst = Path(args.assets_dir) / "Extracted"
    if not src.exists():
        return {"skipped": True}
    if _load_unitypy() is None:
        console.print(f"[yellow]未安装 UnityPy（{_unitypy_failed}），跳过 AssetBundle 解包[/yellow]")
        return {"skipped": True, "reason": _unitypy_failed}
    bundles = sorted(p for p in src.rglob("*") if p.is_file())
    if args.limit:
        bundles = bundles[: args.limit]
    total = {"objects": 0, "files": 0, "failed": 0}
    with progress_bar("Extract") as bar:
        task = bar.add_task("Extract", total=len(bundles))
        for bundle in bundles:
            logical = bundle.relative_to(src).as_posix()
            stats = extract_bundle(bundle, dst / _safe_name(logical))
            for k in total:
                total[k] += stats.get(k, 0)
            bar.advance(task)
    return total


def merge_buildin(args: argparse.Namespace, file_report: Dict[str, Any]) -> Dict[str, Any]:
    """热更资产 + 包内初始资源整合还原。

    以包内 assetpack（Assets/BuildIn/）为底，热更文件覆盖同名资源；
    默认只产出索引（Assets/_merged_index.json），加 --merge-buildin 才真正落盘到 Assets/Merged/。
    """
    assets_dir = Path(args.assets_dir)
    buildin = assets_dir / "BuildIn"
    hot_files = assets_dir / "Files"
    index: Dict[str, Any] = {"generatedAt": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                             "sources": [], "entries": {}, "hotOverrides": 0}
    names: Dict[str, str] = {}
    if buildin.exists():
        index["sources"].append("BuildIn")
        for path in buildin.rglob("*"):
            if path.is_file():
                names[path.relative_to(buildin).as_posix()] = "buildin"
    if hot_files.exists():
        index["sources"].append("Files")
        for path in hot_files.rglob("*"):
            if not path.is_file():
                continue
            rel = path.relative_to(hot_files).as_posix()
            if names.get(rel) == "buildin":
                index["hotOverrides"] += 1
            names[rel] = "hot"
    index["entries"] = names

    if args.merge_buildin and buildin.exists():
        merged = assets_dir / "Merged"
        for src_root, tag in ((buildin, "buildin"), (hot_files, "hot")):
            if not src_root.exists():
                continue
            for path in src_root.rglob("*"):
                if not path.is_file():
                    continue
                rel = path.relative_to(src_root).as_posix()
                if names.get(rel) != tag:
                    continue
                target = merged / _safe_name(rel)
                target.parent.mkdir(parents=True, exist_ok=True)
                if not target.exists() or target.stat().st_size != path.stat().st_size:
                    target.write_bytes(path.read_bytes())
        index["mergedDir"] = _rel(merged)
    dump_json(assets_dir / "_merged_index.json", index)
    return {"files": len(names), "hotOverrides": index["hotOverrides"], "merged": bool(args.merge_buildin)}


def cmd_assets(args: argparse.Namespace) -> int:
    client = ensure_logged_in(args)
    lists = load_manifest_lists(client, args)
    Path(args.assets_dir).mkdir(parents=True, exist_ok=True)
    console.print(f"[bold]热更资产[/bold] assetBundle={len(lists['assetBundle'])} file={len(lists['file'])}")
    ab_report = _download_asset_bundles(client, args, lists["assetBundle"])
    file_report = _download_files(client, args, lists["file"])
    extract_report = _extract_asset_bundles(args) if args.extract else {"skipped": True, "reason": "默认不提取"}
    merge_report = merge_buildin(args, file_report)
    dump_json(Path(args.assets_dir) / "_manifest.json", {
        "generatedAt": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "revisions": client.revisions,
        "assetBundle": {k: v for k, v in ab_report.items() if k != "items"},
        "file": {k: v for k, v in file_report.items() if k != "items"},
        "extract": extract_report,
        "merge": merge_report,
        "items": ab_report.get("items", []) + file_report.get("items", []),
    })
    console.print(
        f"[bold green]资产完成[/bold green] AB 下载={ab_report['downloaded']} 跳过={ab_report['skipped']} "
        f"失败={ab_report['failed']}｜File 下载={file_report['downloaded']} 跳过={file_report['skipped']} "
        f"失败={file_report['failed']}｜整合 {merge_report['files']} 个（热更覆盖 {merge_report['hotOverrides']}）"
        f" -> {args.assets_dir}"
    )
    return 0 if not (ab_report["failed"] or file_report["failed"]) else 1



def _painting_tables() -> Tuple[Dict[int, str], Dict[int, str]]:
    """返回 (jobId -> "角色/变体"), (characterMstId -> 角色全名)。"""
    jobs = load_json(Path(MASTER_DIR) / "CharacterJob.json", []) or []
    chars = load_json(Path(MASTER_DIR) / "Character.json", []) or []
    job_map: Dict[int, str] = {}
    for row in jobs:
        if isinstance(row, dict) and isinstance(row.get("characterJobMstId"), int):
            job_map[row["characterJobMstId"]] = str(row.get("name") or "")
    char_map: Dict[int, str] = {}
    for row in chars:
        if isinstance(row, dict) and isinstance(row.get("characterMstId"), int):
            char_map[row["characterMstId"]] = str(row.get("name") or "")
    return job_map, char_map


def _painting_mapping() -> Dict[int, Dict[str, Any]]:
    """CharacterJobResourceMapping：部分未收录立绘能从这里拿到 characterMstId / styleType。"""
    rows = load_json(Path(MASTER_DIR) / "CharacterJobResourceMapping.json", []) or []
    out: Dict[int, Dict[str, Any]] = {}
    for row in rows:
        if isinstance(row, dict) and isinstance(row.get("characterJobMstId"), int):
            out[int(row["characterJobMstId"])] = row
    return out


def _painting_style_names() -> Dict[int, str]:
    """styleType -> 服装名：同一 styleType 的已收录行提供（如 132 -> 極光の聖装）。"""
    rows = load_json(Path(MASTER_DIR) / "CharacterJob.json", []) or []
    out: Dict[int, str] = {}
    for row in rows:
        if not isinstance(row, dict):
            continue
        style = row.get("styleType")
        name = str(row.get("name") or "")
        if isinstance(style, int) and "/" in name:
            variant = name.split("/", 1)[1]
            if "(" in variant:
                variant = variant.split("(", 1)[0]
            out.setdefault(style, variant)
    return out


def _painting_overrides() -> Dict[str, Any]:
    """人工/维基覆写：Painting/_names.json，形如
       {"134046": "森本結爾/宿星の凶装", "121001": {"character":"一柳梨璃","variant":"リリィウィッチ"}}"""
    data = load_json(Path(MASTER_DIR).parent / "Painting" / "_names.json", {})
    return data if isinstance(data, dict) else {}


def _painting_identical_map(job_map: Dict[int, str]) -> Dict[int, int]:
    """未收录立绘若与某张已收录立绘字节完全相同 -> 映射到那张的 id（用于沿用名字）。"""
    import hashlib as _hashlib
    root = Path(MASTER_DIR).parent / "Assets" / "Files" / "Image" / "CharacterJob"
    digests: Dict[str, List[int]] = {}
    for path in root.glob("CharacterJob*.png"):
        m = re.search(r"(\d+)$", path.stem)
        if not m:
            continue
        jid = int(m.group(1))
        try:
            digests.setdefault(_hashlib.md5(path.read_bytes()).hexdigest(), []).append(jid)
        except OSError:
            continue
    out: Dict[int, int] = {}
    for ids in digests.values():
        known = sorted(i for i in ids if i in job_map)
        if not known:
            continue
        for i in ids:
            if i not in job_map:
                out[i] = known[0]
    return out


def _painting_similar_names(unresolved: List[int], job_map: Dict[int, str]) -> Dict[int, Tuple[int, str, int]]:
    """对数据表里没有名字的立绘，用图像相似度找最接近的"有名字的立绘"，借用它的服装名。

    返回 {id: (最相似 id, 服装名, 距离)}；需要 Pillow，缺失时返回空表。
    """
    try:
        from PIL import Image
    except ImportError:
        console.print("[yellow]未装 Pillow，跳过相似度推断[/yellow]")
        return {}
    root = Path(MASTER_DIR).parent / "Assets" / "Files" / "Image" / "CharacterJob"
    sigs: Dict[int, List[float]] = {}
    named: Dict[int, str] = {}
    for path in root.glob("CharacterJob*.png"):
        m = re.search(r"(\d+)$", path.stem)
        if not m:
            continue
        jid = int(m.group(1))
        try:
            im = Image.open(path).convert("L").resize((24, 24))
            px = list(im.getdata())
            avg = sum(px) / len(px)
            sigs[jid] = [p - avg for p in px]
        except Exception:
            continue
        raw = job_map.get(jid)
        if raw:
            variant = raw.split("/", 1)[1] if "/" in raw else raw
            named[jid] = variant.split("(", 1)[0]

    out: Dict[int, Tuple[int, str, int]] = {}
    for jid in unresolved:
        target = sigs.get(jid)
        if not target:
            continue
        best = None
        for other, sig in sigs.items():
            if other == jid or other not in named:
                continue
            d = sum((a - b) ** 2 for a, b in zip(target, sig)) / len(sig)
            if best is None or d < best[0]:
                best = (d, other)
        if best and best[0] < 800:      # 阈值：视为同一套服装
            out[jid] = (best[1], named[best[1]], int(best[0]))
    return out


def ensure_painting_tables(client: IllusionClient, args: argparse.Namespace,
                           lists: Dict[str, List[Dict[str, Any]]]) -> None:
    """缺 CharacterJob/Character 表时按需下载（不跑全量 masterdata）。"""
    out_dir = Path(args.master_dir)
    need = {"getCharacterJobMstList": "CharacterJob.json", "getCharacterMstList": "Character.json"}
    missing = {m: f for m, f in need.items() if not (out_dir / f).exists()}
    if not missing:
        return
    out_dir.mkdir(parents=True, exist_ok=True)
    index = {str(r.get("method")): r for r in lists["masterData"]}
    for method, filename in missing.items():
        record = index.get(method)
        if not record:
            console.print(f"[yellow]清单里没有 {method}，跳过[/yellow]")
            continue
        rows = client.fetch_master_table(method, str(record.get("hash") or ""))
        dump_json(out_dir / filename, _to_jsonable(rows), indent=2)
        console.print(f"[green]{filename}[/green] {len(rows)} 条（立绘命名用）")


def build_painting_name(job_id: int, job_map: Dict[int, str], char_map: Dict[int, str],
                        char_mst_id: Optional[int],
                        mapping: Optional[Dict[int, Dict[str, Any]]] = None,
                        style_names: Optional[Dict[int, str]] = None,
                        overrides: Optional[Dict[str, Any]] = None,
                        identical: Optional[Dict[int, int]] = None) -> Tuple[str, str]:
    """突击莉莉_角色名_皮肤/变体名_其他备注.png

    来源优先级：override(人工/维基) > table(CharacterJob) > style(同风格名+角色表) > 未收录
    """
    def compose(char: str, variant: str, notes: List[str]) -> str:
        parts = ["突击莉莉", char, variant] + notes
        return "_".join(_safe_name(x) for x in parts if x) + ".png"

    ov = (overrides or {}).get(str(job_id))
    if ov:
        if isinstance(ov, str):
            char, _, variant = ov.partition("/")
            return compose(char or str(job_id), variant or "未命名", []), "override"
        if isinstance(ov, dict):
            return compose(str(ov.get("character") or job_id), str(ov.get("variant") or "未命名"),
                           [str(x) for x in (ov.get("notes") or [])]), "override"

    raw = job_map.get(job_id, "")
    if raw:
        short, _, variant = raw.partition("/")
        char_name = char_map.get(char_mst_id or -1) or short or str(job_id)
        notes: List[str] = []
        if "(" in variant and variant.endswith(")"):
            variant, _, tail = variant.partition("(")
            notes = [x for x in tail[:-1].split("/") if x.strip()]
        return compose(char_name, variant or short or str(job_id), notes), "table"

    twin = (identical or {}).get(job_id)
    if twin is not None:
        twin_raw = job_map.get(twin, "")
        if twin_raw:
            _, _, tv = twin_raw.partition("/")
            if "(" in tv and tv.endswith(")"):
                tv = tv.split("(", 1)[0]
            return compose(char_map.get(0, "") or twin_raw.split("/", 1)[0], tv, [f"同{twin}"]), "identical"

    row = (mapping or {}).get(job_id) or {}
    m_char = row.get("characterMstId")
    m_style = row.get("styleType")
    if isinstance(m_char, int):
        char_name = char_map.get(m_char) or f"角色{m_char}"
        variant = (style_names or {}).get(m_style) or (f"style{m_style}" if isinstance(m_style, int) else "资源表")
        return compose(char_name, variant, ["资源表"]), "mapping"

    style, char_id = divmod(job_id, 1000)
    char_name = char_map.get(char_id)
    variant = (style_names or {}).get(style)
    if char_name and variant:
        return compose(char_name, variant, []), "style"
    if char_name:
        return compose(char_name, f"未收录风格{style}", []), "style"

    return compose("未收录", str(job_id), []), "missing"


def cmd_painting(args: argparse.Namespace) -> int:
    """立绘模式：自动登录 -> 需要时补数据表 -> 下载 Image/CharacterJob -> 按主数据命名到 Painting/。"""
    client = ensure_logged_in(args)
    lists = load_manifest_lists(client, args)
    ensure_painting_tables(client, args, lists)

    prefix = args.prefix
    rows = [r for r in lists["file"] if str(r.get("fileName", "")).startswith(prefix)]
    if args.limit:
        rows = rows[: args.limit]

    raw_dir = Path(args.out) if args.out else Path(args.assets_dir) / "Files" / prefix.rstrip("/")
    raw_dir.mkdir(parents=True, exist_ok=True)
    painting_dir = Path(args.painting_dir)
    painting_dir.mkdir(parents=True, exist_ok=True)

    job_map, char_map = _painting_tables()
    mapping = _painting_mapping()
    style_names = _painting_style_names()
    overrides = _painting_overrides()
    identical = _painting_identical_map(job_map)
    job_by_id = {int(r["characterJobMstId"]): r for r in (load_json(Path(MASTER_DIR) / "CharacterJob.json", []) or [])
                 if isinstance(r, dict) and isinstance(r.get("characterJobMstId"), int)}
    console.print(f"[bold]立绘[/bold] 匹配 {len(rows)} 个 -> 原图 {raw_dir}"
                  + (f"，命名 {painting_dir}" if args.named else ""))

    file_server = client.resource_file_server()
    base = file_base_url(file_server, hashed=not args.plain_names)
    done = {"ok": 0, "named": 0, "fail": 0, "table": 0, "mapping": 0, "style": 0,
            "override": 0, "identical": 0, "similar": 0}
    missing_ids: List[int] = []

    similar: Dict[int, Tuple[int, str, int]] = {}
    if getattr(args, "similar", False):
        unresolved: List[int] = []
        for record in rows:
            m = re.search(r"(\d+)$", Path(record["fileName"]).stem)
            if not m:
                continue
            jid = int(m.group(1))
            if jid in job_map or jid in similar:
                continue
            if jid not in mapping:
                style, cid = divmod(jid, 1000)
                if not style_names.get(style):
                    unresolved.append(jid)
        if unresolved:
            console.print(f"[cyan]相似度推断[/cyan] {len(unresolved)} 张未收录立绘的服装名…")
            similar = _painting_similar_names(unresolved, job_map)
            for jid, (src, variant, dist) in sorted(similar.items()):
                console.print(f"  {jid} -> 借鉴 {src} ({variant}, 距离 {dist})")

    planned: Dict[str, str] = {}
    taken: Dict[str, int] = {}
    id_source: Dict[int, str] = {}
    for record in rows:
        name = record["fileName"]
        m = re.search(r"(\d+)$", Path(name).stem)
        job_id = int(m.group(1)) if m else -1
        job = job_by_id.get(job_id, {})
        fname, source = build_painting_name(job_id, job_map, char_map, job.get("characterMstId"),
                                            mapping, style_names, overrides, identical)
        if source in ("style", "missing") and job_id in similar:
            style, cid = divmod(job_id, 1000)
            char_name = char_map.get(cid) or "未收录"
            _, variant, dist = similar[job_id]
            fname = "_".join(_safe_name(x) for x in
                             ["突击莉莉", char_name, variant, f"风格{style}"]) + ".png"
            source = "similar"
        if fname in taken and taken[fname] != job_id:
            stem, ext = fname.rsplit(".", 1)
            fname = f"{stem}_{job_id}.{ext}"
        taken[fname] = job_id
        planned[name] = fname
        id_source[job_id] = source
    produced = set(planned.values())

    def one(record: Dict[str, Any]) -> str:
        name = record["fileName"]
        target = raw_dir / _safe_name(Path(name).name)
        if not (target.exists() and not args.force
                and target.stat().st_size == int(record.get("fileSize") or 0)):
            blob = client.download(lambda token: build_download_url(
                base, name, record.get("hash") or "", token, hashed=not args.plain_names))
            data, _ = local_decrypt(blob, name)
            target.write_bytes(data)
        if not args.named:
            return "ok"
        m = re.search(r"(\d+)$", Path(name).stem)
        job_id = int(m.group(1)) if m else -1
        fname = planned[name]
        source = id_source.get(job_id, "missing")
        named_path = painting_dir / fname
        if not named_path.exists() or args.force:
            named_path.write_bytes(target.read_bytes())
        if source == "missing":
            missing_ids.append(job_id)
        return source

    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures = [pool.submit(one, r) for r in rows]
        with progress_bar("Painting") as bar:
            task = bar.add_task("Painting", total=len(futures))
            for fut in as_completed(futures):
                try:
                    result = fut.result()
                    done["ok"] += 1
                    if result in ("table", "mapping", "style", "override", "identical", "similar", "missing"):
                        done["named"] += 1
                        if result != "missing":
                            done[result] += 1
                except Exception as exc:
                    done["fail"] += 1
                    console.print(f"[red]立绘失败[/red] {exc}")
                bar.advance(task)
    if args.named:
        if missing_ids:
            report = painting_dir / "_unmatched.txt"
            lines = []
            for i in sorted(set(missing_ids)):
                style, cid = divmod(i, 1000)
                lines.append(f"{i}\tstyle={style}\tchar={cid}\t{char_map.get(cid, '角色未知')}")
            report.write_text("\n".join(lines) + "\n", encoding="utf-8")
        if getattr(args, "prune", False):
            removed = 0
            for path in painting_dir.glob("*.png"):
                if path.name not in produced:
                    path.unlink()
                    removed += 1
            if removed:
                console.print(f"[yellow]清理旧命名文件[/yellow] {removed} 个")
        console.print(f"  命名来源：数据表 {done['table']}，资源映射表 {done['mapping']}，风格推断 {done['style']}，"
                      f"同图沿用 {done['identical']}，相似借用 {done['similar']}，人工覆写 {done['override']}，"
                      f"未收录 {len(set(missing_ids))}"
                      + (f"（清单 {painting_dir / '_unmatched.txt'}）" if missing_ids else ""))
    console.print(f"[bold green]立绘完成[/bold green] 下载 {done['ok']} 张（命名 {done['named']}，失败 {done['fail']}）"
                  + (f" -> {painting_dir.resolve()}" if args.named else ""))
    return 0 if not done["fail"] else 1


def table_name_from_method(method: str) -> str:
    """getCharacterMstList -> Character；getCardMstList -> Card。"""
    name = method
    if name.startswith("get"):
        name = name[3:]
    for suffix in ("MstList", "List"):
        if name.endswith(suffix):
            name = name[: -len(suffix)]
            break
    return name[:1].upper() + name[1:] if name else method


def cmd_masterdata(args: argparse.Namespace) -> int:
    client = ensure_logged_in(args)
    lists = load_manifest_lists(client, args)
    tables = lists["masterData"]
    if args.limit:
        tables = tables[: args.limit]
    out_dir = Path(args.master_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    console.print(f"[bold]数据表[/bold] {len(tables)} 张")
    index: List[Dict[str, Any]] = []
    failed = 0
    with progress_bar("MasterData") as bar:
        task = bar.add_task("MasterData", total=len(tables))
        for record in tables:
            method = record.get("method") or ""
            table_hash = record.get("hash") or ""
            name = table_name_from_method(method)
            try:
                rows = client.fetch_master_table(method, table_hash)
            except Exception as exc:
                failed += 1
                index.append({"method": method, "name": name, "error": str(exc)})
                console.print(f"[red]数据表失败[/red] {method}: {exc}")
                bar.advance(task)
                continue
            dump_json(out_dir / f"{name}.json", _to_jsonable(rows), indent=2)
            if rows and isinstance(rows[0], (list, tuple)):
                shape = "array"
                console.print(f"[yellow]提示[/yellow] {method} 的字段是数组编码（MsgpackTypemap asArray）")
            elif rows and isinstance(rows[0], dict):
                shape = "map"
            else:
                shape = "scalar"
            index.append({
                "method": method,
                "name": name,
                "file": f"{name}.json",
                "hash": table_hash,
                "size": record.get("size"),
                "count": len(rows) if isinstance(rows, list) else 1,
                "shape": shape,
            })
            bar.advance(task)
    dump_json(out_dir / "_index.json", {
        "generatedAt": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "revision": client.revisions.get("masterData", ""),
        "tables": index,
    })
    console.print(f"[bold green]数据表完成[/bold green] {len(index)} 张（失败 {failed}）-> {out_dir}")
    return 0 if not failed else 1


def cmd_update(args: argparse.Namespace) -> int:
    rc1 = cmd_assets(args)
    rc2 = cmd_masterdata(args)
    return 0 if rc1 == 0 and rc2 == 0 else 1


def cmd_installed(args: argparse.Namespace) -> int:
    """从 .apks / .apk 里抽取包内初始 assetpack（Play Asset Delivery install-time）。"""
    apk = Path(args.apk) if args.apk else find_apk(SCRIPT_DIR)
    if not apk or not apk.exists():
        console.print("[red]未找到 .apks/.apk，请用 --apk 指定[/red]")
        return 2
    out_dir = Path(args.assets_dir) / "BuildIn"
    out_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    sources: List[zipfile.ZipFile] = []
    try:
        outer = zipfile.ZipFile(apk)
        if apk.suffix.lower() == ".apks":
            for entry in outer.namelist():
                if entry.endswith(".apk"):
                    inner = zipfile.ZipFile(io.BytesIO(outer.read(entry)))
                    sources.append(inner)
        else:
            sources.append(outer)
        for source in sources:
            for info in source.infolist():
                if not info.filename.startswith("assets/assetpack/"):
                    continue
                rel = info.filename[len("assets/assetpack/"):]
                if not rel or rel.endswith("/"):
                    continue
                target = out_dir / _safe_name(rel)
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(source.read(info))
                count += 1
    finally:
        for source in sources:
            try:
                source.close()
            except Exception:
                pass
    console.print(f"[bold green]包内资源[/bold green] {count} 个 -> {out_dir}")
    return 0


def cmd_decrypt_local(args: argparse.Namespace) -> int:
    src = Path(args.input).resolve()
    dst = Path(args.output).resolve()
    if not src.exists():
        console.print(f"[red]目录不存在：{src}[/red]")
        return 2
    dst.mkdir(parents=True, exist_ok=True)
    decrypted = unchanged = suspicious = 0
    for path in sorted(p for p in src.rglob("*") if p.is_file()):
        rel = path.relative_to(src).as_posix()
        blob = path.read_bytes()
        target = dst / _safe_name(rel)
        target.parent.mkdir(parents=True, exist_ok=True)
        if needs_no_crypto("/" + rel) or looks_known(blob):
            target.write_bytes(blob)
            unchanged += 1
            continue
        data, used = local_decrypt(blob, rel)
        target.write_bytes(data)
        if used:
            decrypted += 1
        else:
            suspicious += 1
    console.print(
        f"[bold green]解密完成[/bold green] 共 {decrypted + unchanged + suspicious} 个："
        f"解密 {decrypted}，原样 {unchanged}，未识别 {suspicious} -> {dst}"
    )
    return 0


def cmd_status(args: argparse.Namespace) -> int:
    rows = []
    for label, path in (("Assets", Path(args.assets_dir)), ("MasterData", Path(args.master_dir)),
                        ("Manifest", Path(args.manifest_dir))):
        if path.exists():
            files = [p for p in path.rglob("*") if p.is_file()]
            size = sum(p.stat().st_size for p in files)
            rows.append((label, len(files), size / 1048576.0))
        else:
            rows.append((label, 0, 0.0))
    console.print("[bold]目录统计[/bold]")
    for label, count, mib in rows:
        console.print(f"  {label:<12} 文件 {count:>7}  {mib:>10.1f} MiB")
    revision = load_json(Path(args.manifest_dir) / "revision.json", {}) or {}
    if revision:
        console.print(f"  revision: {json.dumps(revision, ensure_ascii=False)}")
    return 0


def cmd_selftest(args: argparse.Namespace) -> int:
    """离线自检：不联网，验证从反汇编复刻的算法能自洽。"""
    ok = True

    def check(label: str, actual: Any, expected: Any) -> None:
        nonlocal ok
        if actual == expected:
            console.print(f"[green]ok[/green]   {label} = {actual}")
        else:
            ok = False
            console.print(f"[red]FAIL[/red] {label} = {actual!r}（期望 {expected!r}）")

    check("convert() 结果", HASH_KEY, CONVERT_RESULT)
    check("HashSalt 同源", HASH_SALT, CONVERT_RESULT)
    check("CryptoKey(HashString)", derive_crypto_key(), "FmUJWtP5KIZBBeHX")
    check("MsgPackKey(HashString)", derive_msgpack_key().decode(), "sOJPZpoaQWXCmykt")
    check("推导 == 线上实测", derive_msgpack_key(), EXPECTED_MSGPACK_KEY)
    cred_id, cred_secret = derive_payment_credentials()
    check("支付 app_id(动态推导)", cred_id, "551439557786070")
    check("支付签名密钥(动态推导)", cred_secret, "d13df06039a768a18bb9b120ca544cc0")
    check("md5(assetbundle+yurigaoka)", hash_resource_name("assetbundle"),
          "3d3cd05aab4be5ee3a71b2bef99b3b0b")
    check("md5(file+yurigaoka)", hash_resource_name("file"),
          "775b74a5870f2b9af3c5cbf8c847a434")
    check("md5(android+yurigaoka)", hash_resource_name("android"),
          "e52f8d80435419d7ec5e8e3a1f482265")

    key = derive_msgpack_key()
    payload = {"payload": {"method": "getCharacterMstList"}, "status": 0}
    ok_round = True
    for candidate in (derive_msgpack_key(), key):
        blob = aes_cbc_encrypt(candidate, msgpack.packb(payload, use_bin_type=True))
        round_tripped = msgpack.unpackb(aes_cbc_decrypt(candidate, blob), raw=False, strict_map_key=False)
        ok_round = ok_round and round_tripped == payload
    check("AES-CBC 往返（两套 key）", ok_round, True)

    name = "asset_bundle/character_job_spine/1001"
    sample = b"UnityFS\x00\x00\x00\x08" + os.urandom(64)
    scrambled = xor_cipher(sample, xor_key_stream(name))
    restored, used = local_decrypt(scrambled, name)
    check("本地 XOR 解密", restored == sample and used == name, True)
    check("非加密模式(.acb)不处理", needs_no_crypto("Sound/Common/xxx.acb"), True)
    check("资源名哈希长度", len(hash_resource_name("Image/Card/Card020000001.jpg")), 32)

    console.print("[bold green]自检通过[/bold green]" if ok else "[bold red]自检失败[/bold red]")
    return 0 if ok else 1


class _NullProgress:
    def __enter__(self) -> "_NullProgress":
        return self

    def __exit__(self, *exc: Any) -> None:
        return None

    def add_task(self, *a: Any, **kw: Any) -> int:
        return 0

    def advance(self, *a: Any, **kw: Any) -> None:
        return None


def progress_bar(label: str):
    if HAS_RICH:
        return Progress(
            TextColumn("[bold]{task.description}"),
            BarColumn(),
            MofNCompleteColumn(),
            TransferSpeedColumn(),
            TimeRemainingColumn(),
            console=console,
        )
    return _NullProgress()


def find_apk(root: Path) -> Optional[Path]:
    candidates = sorted(list(root.glob("*.apks")) + list(root.glob("*.apk")))
    return candidates[-1] if candidates else None


def add_common_args(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--api", default=GAME_SERVER, help=f"游戏服务器（默认 {GAME_SERVER}）")
    parser.add_argument("--token", default="", help="手动指定 Akamai token（形如 __gda__=st=...）")
    parser.add_argument("--key", default="", help="手动指定 16 字节报文密钥（默认自动协商）")
    parser.add_argument("--app-version", default="", help="手动指定 app 版本（默认从 Play Store 动态获取并缓存）")
    parser.add_argument("--proxy", default="", help="显式代理，如 http://127.0.0.1:7897（默认直连，忽略系统代理）")
    parser.add_argument("--refresh-version", action="store_true", help="忽略版本缓存，重新获取 app 版本")
    parser.add_argument("--session", default="", help="登录会话（Cookie/sessionId），部分接口需要")
    parser.add_argument("--uuid", default="", help="设备 UUID（PokkeUserInfo.uuid）")
    parser.add_argument("--action-token", default="", help="actionToken（PokkeUserInfo.actionToken）")
    parser.add_argument("-j", "--jobs", type=int, default=8, help="并发下载线程数（默认 8）")
    parser.add_argument("--retries", type=int, default=3, help="单个请求重试次数（默认 3）")
    parser.add_argument("--timeout", type=int, default=60, help="单请求超时秒数（默认 60）")
    parser.add_argument("--platform", default="android", choices=("android", "ios", "windows"),
                        help="资源平台（默认 android）")
    parser.add_argument("--limit", type=int, default=0, help="只处理前 N 条（调试用，0=全部）")
    parser.add_argument("--force", action="store_true", help="忽略已有文件，强制重新下载")
    parser.add_argument("--refresh", action="store_true", help="忽略本地 Manifest，重新拉清单")
    parser.add_argument("--plain-names", action="store_true",
                        help="CDN 不开文件名哈希（EnableResourceHashForAppUrl=false）时使用")
    parser.add_argument("--assets-dir", default=str(ASSETS_DIR), help="资产输出目录（默认 Assets/）")
    parser.add_argument("--master-dir", default=str(MASTER_DIR), help="数据表输出目录（默认 MasterData/）")
    parser.add_argument("--manifest-dir", default=str(MANIFEST_DIR), help="清单目录（默认 Manifest/）")
    parser.add_argument("--extract", action="store_true",
                        help="下载后用 UnityPy 解包到 Assets/Extracted/（默认不提取，玩家自行处理）")
    parser.add_argument("--merge-buildin", action="store_true",
                        help="把热更文件覆盖到 Assets/Merged/（以 Assets/BuildIn/ 为底，占用额外磁盘）")
    parser.add_argument("-v", "--verbose", action="store_true", help="打印每个请求")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="AssaultLilyLastBullet.py",
        description="《アサルトリリィ Last Bullet》热更资源还原 / 数据表导出（算法全部来自 il2cpp 反汇编）",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "示例：\n"
            "  python3 AssaultLilyLastBullet.py update\n"
            "  python3 AssaultLilyLastBullet.py assets --jobs 16\n"
            "  python3 AssaultLilyLastBullet.py masterdata --refresh\n"
            "  python3 AssaultLilyLastBullet.py installed --apk アサルトリリィ_9.4.0.apks\n"
            "  python3 AssaultLilyLastBullet.py selftest\n"
        ),
    )
    sub = parser.add_subparsers(dest="command", metavar="<子命令>")

    p_login = sub.add_parser("login", help="GREE 支付网关注册/登录设备账号 -> session.json")
    add_common_args(p_login)
    p_login.add_argument("--new", action="store_true", help="忽略已有 session.json，重新注册设备账号")
    p_login.add_argument("--device-model", default="Samsung Galaxy Note10", help="伪装机型")
    p_login.add_argument("--payment-host", default="", help=f"支付网关（默认 {PAYMENT_HOST}）")
    p_login.add_argument("--payment-app-id", default="", help="支付 app id（默认由 APK 配置动态推导）")
    p_login.add_argument("--payment-app-secret", default="", help="支付签名密钥（默认由 APK 配置动态推导）")
    p_login.add_argument("--then", default="", choices=("", "lists", "assets", "masterdata", "update"),
                         help="登录成功后接着执行的子命令")

    p_all = sub.add_parser("update", help="全量：清单 + 热更资产 + 数据表")
    add_common_args(p_all)

    p_assets = sub.add_parser("assets", help="热更资产下载/解密/解包 -> Assets/")
    add_common_args(p_assets)

    p_master = sub.add_parser("masterdata", help="数据表导出 indent=2 JSON -> MasterData/")
    add_common_args(p_master)

    p_pt = sub.add_parser("painting", help="立绘模式：只下 Image/CharacterJob/*.png，可命名到 Painting/")
    add_common_args(p_pt)
    p_pt.add_argument("--prefix", default="Image/CharacterJob/", help="清单前缀过滤（默认 Image/CharacterJob/）")
    p_pt.add_argument("--out", default="", help="原图输出目录（默认 Assets/Files/<前缀>）")
    p_pt.add_argument("--named", action="store_true", default=True,
                      help="按主数据命名复制到 Painting/（默认开）")
    p_pt.add_argument("--no-named", dest="named", action="store_false")
    p_pt.add_argument("--prune", action="store_true", help="删除 Painting/ 里不再生成的旧命名文件")
    p_pt.add_argument("--similar", action="store_true",
                      help="对数据表无名的立绘用相似度借用服装名（需 Pillow，慢约 20s）")
    p_pt.add_argument("--painting-dir", default=str(SCRIPT_DIR / "Painting"),
                      help="命名立绘输出目录（默认脚本目录下的 Painting/，与 Assets/ 同级）")

    p_lists = sub.add_parser("lists", help="只拉 URL 列表 / token / 三份 mst 清单 -> Manifest/")
    add_common_args(p_lists)

    p_inst = sub.add_parser("installed", help="从 .apks 抽取包内初始 assetpack -> Assets/BuildIn/")
    p_inst.add_argument("--apk", default=None, help=".apks/.apk 路径（默认取脚本目录下最新）")
    p_inst.add_argument("--assets-dir", default=str(ASSETS_DIR), help="资产输出目录")

    p_dec = sub.add_parser("decrypt-local", help="解密设备本地文件（XOR 流）")
    p_dec.add_argument("input", help="输入目录（例如从 Android/data 拉回来的目录）")
    p_dec.add_argument("-o", "--output", default=str(ASSETS_DIR / "Decrypted"), help="输出目录")

    p_st = sub.add_parser("status", help="目录统计")
    p_st.add_argument("--assets-dir", default=str(ASSETS_DIR))
    p_st.add_argument("--master-dir", default=str(MASTER_DIR))
    p_st.add_argument("--manifest-dir", default=str(MANIFEST_DIR))

    sub.add_parser("selftest", help="离线自检（密钥/加解密/命名哈希）")
    return parser


COMMANDS = {
    "login": cmd_login,
    "update": cmd_update,
    "assets": cmd_assets,
    "masterdata": cmd_masterdata,
    "lists": cmd_lists,
    "painting": cmd_painting,
    "installed": cmd_installed,
    "decrypt-local": cmd_decrypt_local,
    "status": cmd_status,
    "selftest": cmd_selftest,
}


def main(argv: Optional[Sequence[str]] = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    if not args.command:
        args = parser.parse_args(["update"])
    if getattr(args, "refresh_version", False):
        try:
            VERSION_CACHE.unlink()
        except OSError:
            pass
    resolve_app_version(getattr(args, "app_version", "") or "", quiet=args.command == "selftest")
    return COMMANDS[args.command](args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        raise SystemExit(130)
    except ApiError as exc:
        console.print(f"[red]接口错误：{exc}[/red]")
        raise SystemExit(1)
