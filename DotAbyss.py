import os
import time
import json
import base64
import hmac
import hashlib
import urllib.parse
import threading
from queue import Queue
from typing import Dict, Any, Optional
import requests
import msgpack
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from rich.console import Console
from rich.progress import (
    Progress,
    SpinnerColumn,
    BarColumn,
    TextColumn,
    MofNCompleteColumn,
    TimeRemainingColumn,
)
from AbyssSchema import DATABASE_SCHEMA
from UnityCatalogReader import UnityCatalogReader

APP_KEY_B64 = "b5RHgCQ66Glhlru9WV5Koc5SulPDiWZ44K0+dCeVTn0="
APP_KEY_BYTES = base64.b64decode(APP_KEY_B64)
VERSION_URL = "https://api.abyss-prod-r18.dotabyss.dmmgames.com/version"
SECURE_LINK_KEY = "ulTn7l2O7kctUTYkI0qsM9YuEnrj6isy"
MASTER_BASE_URL = (
    "https://api.abyss-prod-r18.dotabyss.dmmgames.com/data/"
)
MAX_THREADS = 16
RETRY_COUNT = 5

console = Console()


class AbyssDecryptor:
    @staticmethod
    def decrypt_laravel_session(encrypted_str: str) -> Optional[str]:
        try:
            decoded_json = base64.b64decode(urllib.parse.unquote(encrypted_str))
            payload = json.loads(decoded_json)
            iv = base64.b64decode(payload["iv"])
            value = base64.b64decode(payload["value"])
            cipher = AES.new(APP_KEY_BYTES, AES.MODE_CBC, iv)
            decrypted = unpad(cipher.decrypt(value), AES.block_size)
            res_str = decrypted.decode("utf-8")
            if ':"' in res_str:
                return res_str.split(':"')[1].split('"')[0]
            return res_str
        except Exception as e:
            console.print(f"[red][-] Session 解密失败: {e}[/red]")
            return None

    @staticmethod
    def decrypt_api_body(binary_body: bytes, session_id: str) -> Optional[bytes]:
        try:
            derived_key = hmac.new(
                APP_KEY_BYTES, session_id.encode("utf-8"), hashlib.sha256
            ).digest()
            iv = binary_body[:16]
            ciphertext = binary_body[16:]
            cipher = AES.new(derived_key, AES.MODE_CBC, iv)
            return unpad(cipher.decrypt(ciphertext), AES.block_size)
        except Exception as e:
            console.print(f"[red][-] Body 解密失败: {e}[/red]")
            return None

    @staticmethod
    def decrypt_master_data(
        data: bytes, decrypt_key_str: str = "abyss"
    ) -> Optional[bytes]:
        """解密数据表逻辑"""
        try:
            actual_key = hmac.new(
                APP_KEY_BYTES, decrypt_key_str.encode("utf-8"), hashlib.sha256
            ).digest()

            iv = data[:16]
            ciphertext = data[16:]
            cipher = AES.new(actual_key, AES.MODE_CBC, iv)
            return unpad(cipher.decrypt(ciphertext), AES.block_size)
        except Exception as e:
            console.print(f"[red][-] 数据表解密失败: {e}[/red]")
            return None


def create_secure_url(
    base_url: str, path: str, secret: str, expire_seconds: int = 600
) -> str:
    """Absf::Api::SecureLinkUtil::CreateSecureUrl"""
    t = int(time.time()) + expire_seconds
    
    parsed = urllib.parse.urlparse(base_url)
    host = parsed.netloc
    base_path = parsed.path.rstrip('/')
    if not path.startswith('/'):
        path = '/' + path
    full_path = (base_path + path).replace('//', '/')

    raw_str = f"{secret}{full_path}{t}"
    md5_hash = hashlib.md5(raw_str.encode("utf-8")).digest()
    s = base64.b64encode(md5_hash).decode("utf-8")
    s = s.replace("+", "-").replace("/", "_").replace("=", "")

    return f"https://{host}{full_path}?s={s}&t={t}"


class AbyssDownloader:
    def __init__(self, threads: int = MAX_THREADS):
        self.session = requests.Session()
        self.session.headers.update(
            {
                "User-Agent": "UnityPlayer/6000.0.43f1 (UnityWebRequest/1.0, libcurl/7.84.0-DEV)",
                "X-Unity-Version": "6000.0.43f1",
            }
        )
        self.threads = threads
        self.base_url = ""
        self.asset_ver = ""
        self.master_ver = ""
        self.client_ver_prefix = ""
        self.download_queue: Queue = Queue()
        self.progress = Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            MofNCompleteColumn(),
            TimeRemainingColumn(),
            console=console,
            transient=False,
        )

    def _pick_version(
        self, versions: Dict[str, Any], *keys: str, default: Optional[Any] = None
    ) -> Optional[str]:
        """从可能的键中选取第一个非空版本值，支持列表值和带/不带方括号的键名。"""
        for key in keys:
            for candidate in (key, f"[{key}]"):
                if candidate in versions:
                    val = versions[candidate]
                    if isinstance(val, list):
                        if len(val) > 0:
                            return str(val[0])
                        else:
                            continue
                    if val is None:
                        continue
                    return str(val)
        return default
    

    def get_version_info(self) -> Optional[Dict[str, Any]]:
        """获取并解密版本信息"""
        console.print(f"[*] 正在请求版本 URL: {VERSION_URL}")
        try:
            resp = self.session.get(VERSION_URL, timeout=15)
            resp.raise_for_status()

            enc_session = resp.headers.get("X-Olg-Session")

            
            if not enc_session:
                console.print("[red][-] 未能获取 X-Olg-Session[/red]")
                return None

            session_id = AbyssDecryptor.decrypt_laravel_session(enc_session)
            if not session_id:
                return None

            console.print(f"[green][+] 成功获取 SessionID: {session_id}[/green]")
            decrypted_body = AbyssDecryptor.decrypt_api_body(resp.content, session_id)
            if not decrypted_body:
                return None

            return json.loads(decrypted_body.decode("utf-8"))
        except Exception as e:
            console.print(f"[red][-] 获取版本信息失败: {e}[/red]")
            return None

    def download_file(self, url: str, dest_path: str, expected_size: int = 0) -> bool:
        dir_name = os.path.dirname(dest_path)
        if dir_name:
            os.makedirs(dir_name, exist_ok=True)

        for attempt in range(RETRY_COUNT):
            try:
                headers = {}
                initial_pos = 0
                if os.path.exists(dest_path) and expected_size > 0:
                    initial_pos = os.path.getsize(dest_path)
                    if initial_pos >= expected_size:
                        if initial_pos == expected_size:
                            return True
                        else:
                            os.remove(dest_path)
                            initial_pos = 0

                    if initial_pos > 0:
                        headers["Range"] = f"bytes={initial_pos}-"
                else:
                    initial_pos = 0

                resp = self.session.get(url, headers=headers, stream=True, timeout=20)

                if resp.status_code == 206:
                    mode = "ab"
                elif resp.status_code == 200:
                    mode = "wb"
                    initial_pos = 0
                else:
                    resp.raise_for_status()
                    return False

                with open(dest_path, mode) as f:
                    for chunk in resp.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)

                if expected_size > 0 and os.path.getsize(dest_path) != expected_size:
                    raise ValueError(
                        f"文件大小校验失败: {os.path.getsize(dest_path)} != {expected_size}"
                    )

                return True
            except Exception as e:
                if attempt == RETRY_COUNT - 1:
                    console.print(f"[red]下载失败 ({url}): {e}[/red]")
                else:
                    time.sleep(1)
        return False

    
    def _apply_database_schema(self, raw_db: Dict[str, Any]) -> Dict[str, Any]:
        """将原始无键数组数据库数据重新还原为带有完整字段名的字典结构"""
        if not DATABASE_SCHEMA:
            return raw_db

        restored_db = {}
        for table_name, raw_table in raw_db.items():
            if table_name in DATABASE_SCHEMA:
                fields = DATABASE_SCHEMA[table_name]
                items = raw_table
                
                if isinstance(items, dict) and "elements" in items:
                    items = items["elements"]
                elif isinstance(items, list) and len(items) == 1 and isinstance(items[0], list):
                    if all(isinstance(sub, list) for sub in items[0]):
                        items = items[0]
                
                restored_table = []
                for item in items:
                    if isinstance(item, list):
                        record = {}
                        for idx, field_name in enumerate(fields):
                            if idx < len(item):
                                record[field_name] = item[idx]
                        restored_table.append(record)
                    else:
                        restored_table.append(item)
                restored_db[table_name] = restored_table
            else:
                restored_db[table_name] = raw_table
        return restored_db

    def handle_master_data(self):
        """处理数据表下载与反序列化字段填充"""
        secure_url = create_secure_url(MASTER_BASE_URL, f"/{self.master_ver}", SECURE_LINK_KEY)

        console.print(f"[*] 正在获取 Master Data: {secure_url}")
        try:
            resp = self.session.get(secure_url, timeout=30)
            resp.raise_for_status()

            raw_data = resp.content
            console.print(f"[blue][*] 成功下载数据表，大小: {len(raw_data)} 字节，正在解析并补全字段名...[/blue]")

            master_raw_obj = msgpack.unpackb(raw_data)
            
            master_json_obj = self._apply_database_schema(master_raw_obj)
            
            output_file = "MasterData.json"
            with open(output_file, "w", encoding="utf-8") as f:
                json.dump(master_json_obj, f, ensure_ascii=False, indent=2)

            console.print(f"[green][+] 字段补全成功！Master Data 已保存至 {output_file}[/green]")
            return True
        except Exception as e:
            console.print(f"[red][-] 处理 Master Data 时发生错误: {e}[/red]")
            return False

    def worker(self, task_id):
        while True:
            item = self.download_queue.get()
            if item is None:
                break

            internal_id, primary_key, size = item

            remote_path_key = "{Absf.Asset.AddressableAssets.AddressablesProfileDefine.RemoteLoadPath}"
            if remote_path_key in internal_id:
                url = internal_id.replace(remote_path_key, self.base_url)
            elif internal_id.startswith("http"):
                url = internal_id
            else:
                self.progress.advance(task_id)
                self.download_queue.task_done()
                continue

            file_name = primary_key
            for ext in [".usm", ".awb"]:
                if ext in file_name:
                    file_name = file_name.split(ext)[0] + ext
                    break
            dest_path = os.path.join("downloads", file_name)

            try:
                ok = self.download_file(url, dest_path, expected_size=size)
                if ok:
                    self.progress.advance(task_id)
                else:
                    # console.print(f"[yellow][!] 跳过文件: {primary_key}[/yellow]")
                    self.progress.advance(task_id)
            except Exception as e:
                console.print(f"[red][!] 下载失败 ({primary_key}): {e}[/red]")
                self.progress.advance(task_id)

            self.download_queue.task_done()

    def run(self):
        info = self.get_version_info()
        if not info:
            return

        versions = info.get("versions", {})
        print(versions)
        self.asset_ver = self._pick_version(
            versions,
            "AssetVersionWebDmmR18",
            default=None,
        )
        self.master_ver = self._pick_version(
            versions, "resource", "resource", default="4"
        )
        client_ver = self._pick_version(
            versions,
            "ClientVersionWebDmmR18",
            default="1.0.0",
        )
        if client_ver is None:
            client_ver = "1.0.0"
        self.client_ver_prefix = str(client_ver).split(".")[0] if client_ver else "1"
        console.print(
            f"[blue][*] 资产版本: {self.asset_ver}, 数据表版本: {self.master_ver}, 客户端前缀: {self.client_ver_prefix}[/blue]"
        )
        if not self.handle_master_data():
            console.print(
                "[yellow][!] Master Data 处理失败，将跳过数据表任务。[/yellow]"
            )

        self.base_url = f"https://api.abyss-prod-r18.dotabyss.dmmgames.com/resources/webgl/r18/aas/{self.asset_ver}/aa"
        hash_url = f"{self.base_url}/catalog_{self.client_ver_prefix}.hash"
        bin_url = f"{self.base_url}/catalog_{self.client_ver_prefix}.bin"

        console.print(f"[*] 检查 Catalog Hash: {hash_url}")
        resp = self.session.get(hash_url)
        if resp.status_code != 200:
            console.print(f"[red][-] 获取 Hash 失败: {resp.status_code}[/red]")
            return
        current_hash = resp.text.strip()
        console.print(f"[green][+] 当前 Hash: {current_hash}[/green]")

        hash_file = "catalog.hash"
        catalog_json_path = "catalog.json"
        updated = True
        if os.path.exists(hash_file):
            with open(hash_file, "r") as f:
                old_hash = f.read().strip()
                if old_hash == current_hash:
                    updated = False
                    if os.path.exists(catalog_json_path):
                        console.print("[yellow][*] Catalog 已经是最新，跳过。[/yellow]")
                        return
                    console.print(
                        "[yellow][*] Catalog 已是最新，但缺少 catalog.json，将重新解析导出...[/yellow]"
                    )

        bin_path = f"catalog_{self.client_ver_prefix}.bin"
        if not os.path.exists(bin_path) or updated:
            console.print(f"[*] 正在下载 Catalog Bin: {bin_url}")
            if self.download_file(bin_url, bin_path):
                with open(hash_file, "w") as f:
                    f.write(current_hash)
            else:
                return

        console.print(f"[*] 正在解析 {bin_path}...")
        try:
            reader = UnityCatalogReader(bin_path)
            assets = reader.get_asset_list()
            console.print(f"[green][+] 找到 {len(assets)} 个资产项目[/green]")
            reader.export_to_json(catalog_json_path)
            console.print(f"[green][+] 已导出解析后的 {catalog_json_path}[/green]")
        except Exception as e:
            console.print(f"[red][-] 解析 Catalog 失败: {e}[/red]")
            return

        download_tasks = []
        seen_dest_paths = set()

        for asset in assets:
            internal_id = asset["internal_id"]
            primary_key = asset["primary_key"]
            size = asset["bundle_size"]

            # 提前计算目标路径用于去重
            file_name = primary_key
            for ext in [".usm", ".awb"]:
                if ext in file_name:
                    file_name = file_name.split(ext)[0] + ext
                    break
            dest_path = os.path.join("downloads", file_name)

            if dest_path not in seen_dest_paths:
                seen_dest_paths.add(dest_path)
                download_tasks.append((internal_id, primary_key, size))

        total_tasks = len(download_tasks)
        for task in download_tasks:
            self.download_queue.put(task)

        with self.progress:
            task_id = self.progress.add_task(
                "[cyan]正在同步资源...[/cyan]", total=total_tasks
            )

            threads = []
            for _ in range(self.threads):
                t = threading.Thread(target=self.worker, args=(task_id,), daemon=True)
                t.start()
                threads.append(t)

            self.download_queue.join()

            for _ in range(self.threads):
                self.download_queue.put(None)
            for t in threads:
                t.join()

        console.print("[bold green][✓] 所有任务处理完成！[/bold green]")


if __name__ == "__main__":
    downloader = AbyssDownloader()
    downloader.run()
