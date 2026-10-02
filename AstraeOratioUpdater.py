"""NCSOFT TinyUpdater 协议客户端（TCP protobuf + HTTP 仓库）。"""

from __future__ import annotations

import hashlib
import lzma
import socket
import struct
import time
from typing import Any, Dict, List, Optional, Tuple

import requests

# api.purpleworks.plaync.com/config/v2/init -> platform.address_for_updater / game_id_for_updater
CONFIG_URL = "https://api.purpleworks.plaync.com/config/v2/init"
CONFIG_BASIC = "MmJmYTE0ZmMtMDNhYy00MzVmLWFmMWMtYzcyOGNkZDAzM2FjOg=="
DEFAULT_UPDATER_PORT = 27500  # InitTU 里的默认端口
GAME_ID_FALLBACK = "A0MMZP9O3XDSHVNPXZ_LIVE_LIVE_01"
UPDATER_ADDR_FALLBACK = "live-3rd-purple.ncupdate.com"

TIMEOUT = 30

# 请求 id（libNCTinyUpdater.so CJob_GetUpdateInfo::Get*）
REQ_VERSION_RELEASE = 6
REQ_VERSION_FORWARD = 7
REQ_SERVICE_DISPLAY = 5
REQ_GAME_UPDATE = 3


def fetch_platform_config(session: Optional[requests.Session] = None) -> Dict[str, Any]:
    """拉取 Purpleworks 平台配置，取 updater 地址与 game id。"""
    s = session or requests.Session()
    headers = {
        "Authorization": f"Basic {CONFIG_BASIC}",
        "X-Purpleworks-Channel": "live",
        "X-Purpleworks-App": "a-0mmzp9o3xdshvnpxz",
        "X-Purpleworks-Appversion": "0.7.0",
        "Accept": "application/json",
        "Content-Type": "application/json; charset=utf-8",
        "Accept-Language": "en-US",
        "Client-Context": 'os="Android OS 15 / API-35", os-legacy="Android", lang="en-US", device="ONEPLUS A5010"',
        "Client-Game-Context": 'sdk-v="0.4.4", game-appid="", game-v="0.7.0", game-engine="unity"',
    }
    r = s.get(CONFIG_URL, headers=headers, timeout=TIMEOUT)
    r.raise_for_status()
    return r.json().get("platform", {})


class UpdateServer:
    """更新服务器 TCP protobuf 协议。

    请求帧: [u16 总长][u16 req_id] + protobuf
    应答帧: [u16 总长][u16 ack_id][i32 result] + protobuf
    """

    def __init__(self, host: str, port: int = DEFAULT_UPDATER_PORT, timeout: int = TIMEOUT):
        self.host = host
        self.port = port
        self.timeout = timeout
        self.sock: Optional[socket.socket] = None

    def connect(self) -> None:
        self.sock = socket.create_connection((self.host, self.port), timeout=self.timeout)

    def close(self) -> None:
        if self.sock:
            try:
                self.sock.close()
            except OSError:
                pass
            self.sock = None

    def __enter__(self) -> "UpdateServer":
        self.connect()
        return self

    def __exit__(self, *exc) -> None:
        self.close()

    def _recv_exact(self, n: int) -> bytes:
        buf = b""
        while len(buf) < n:
            chunk = self.sock.recv(n - len(buf))
            if not chunk:
                raise ConnectionError("update server closed connection")
            buf += chunk
        return buf

    def request(self, req_id: int, body: bytes, ack_id: int) -> bytes:
        pkt = struct.pack("<HH", 4 + len(body), req_id) + body
        self.sock.sendall(pkt)
        hdr = self._recv_exact(8)
        total, rid, result = struct.unpack("<HHi", hdr)
        if result != 0:
            raise RuntimeError(f"update server result={result} (req_id={req_id})")
        if rid != ack_id:
            raise RuntimeError(f"update server ack id mismatch: {rid} != {ack_id}")
        return self._recv_exact(total - 8) if total > 8 else b""


def _pb_bytes(field: int, value: str) -> bytes:
    b = value.encode()
    return bytes([field << 3 | 2, len(b)]) + b


def _parse_pb(data: bytes) -> Dict[int, Any]:
    out: Dict[int, Any] = {}
    i = 0
    while i < len(data):
        tag = data[i]
        i += 1
        field, wire = tag >> 3, tag & 7
        if wire == 2:
            ln, shift = 0, 0
            while True:
                b = data[i]
                i += 1
                ln |= (b & 0x7F) << shift
                if not b & 0x80:
                    break
                shift += 7
            out[field] = data[i:i + ln]
            i += ln
        elif wire == 0:
            v, shift = 0, 0
            while True:
                b = data[i]
                i += 1
                v |= (b & 0x7F) << shift
                if not b & 0x80:
                    break
                shift += 7
            out[field] = v
        else:
            raise ValueError(f"unsupported wire type {wire}")
    return out


class UpdateInfo:
    """VersionInfo_ReleaseAck + GameInfo_UpdateAck 的合集。"""

    def __init__(self, global_version: int, file_info_hash: str, repo_address: str,
                 updater_addr: str, game_id: str):
        self.global_version = global_version
        self.file_info_hash = file_info_hash
        self.repo_address = repo_address
        self.updater_addr = updater_addr
        self.game_id = game_id

    @property
    def patch_base(self) -> str:
        return f"http://{self.repo_address}/{self.game_id}/{self.global_version}/Patch"

    def files_info_url(self) -> str:
        """files_info.json.zip（本作 flag 开启时为 sha256 命名）。"""
        digest = hashlib.sha256(f"{self.global_version} {self.game_id}Patch".encode()).hexdigest()
        return f"{self.patch_base}/{digest}"


def fetch_update_info(game_id: str = GAME_ID_FALLBACK,
                      updater_addr: str = UPDATER_ADDR_FALLBACK,
                      port: int = DEFAULT_UPDATER_PORT) -> UpdateInfo:
    body = _pb_bytes(1, game_id)
    with UpdateServer(updater_addr, port) as srv:
        release = _parse_pb(srv.request(REQ_VERSION_RELEASE, body, REQ_VERSION_RELEASE))
        update = _parse_pb(srv.request(REQ_GAME_UPDATE, body, REQ_GAME_UPDATE))
    repo = update.get(2, b"").decode()
    if not repo:
        raise RuntimeError("empty repository server address")
    return UpdateInfo(
        global_version=release.get(4, 0),
        file_info_hash=release.get(10, b"").decode(),
        repo_address=repo,
        updater_addr=updater_addr,
        game_id=game_id,
    )


def fetch_file_list(info: UpdateInfo, session: Optional[requests.Session] = None) -> List[Dict[str, Any]]:
    """下载并解压 files_info.json，返回 files 列表。"""
    s = session or requests.Session()
    r = s.get(info.files_info_url(), timeout=TIMEOUT)
    r.raise_for_status()
    raw = lzma.LZMADecompressor(format=lzma.FORMAT_ALONE).decompress(r.content)
    import json
    doc = json.loads(raw)
    files = doc.get("files") or []
    for f in files:
        f["_size"] = int(f.get("size") or 0)
    return files


def download_file(info: UpdateInfo, entry: Dict[str, Any], session: requests.Session,
                  timeout: int = 600) -> bytes:
    """按 encodedInfo.path 下载单个热更文件（原始字节，sha1 校验）。"""
    path = entry["encodedInfo"]["path"]
    url = f"http://{info.repo_address}/{path}"
    r = session.get(url, timeout=timeout)
    r.raise_for_status()
    return r.content


def retry_download(info: UpdateInfo, entry: Dict[str, Any], session: requests.Session,
                   retries: int = 5, timeout: int = 600) -> bytes:
    last: Optional[Exception] = None
    for attempt in range(retries):
        try:
            data = download_file(info, entry, session, timeout)
            expect = entry.get("hash") or ""
            if expect and hashlib.sha1(data).hexdigest() != expect:
                raise RuntimeError(f"sha1 mismatch: {entry['path']}")
            return data
        except Exception as e:  # noqa: BLE001
            last = e
            time.sleep(min(1.5 * (attempt + 1), 8))
    raise RuntimeError(f"download failed {entry['path']}: {last}")
