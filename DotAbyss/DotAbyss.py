import os
import sys
import time
import json
import base64
import hmac
import hashlib
import urllib.parse
import threading
from queue import Queue
from typing import Dict, List, Any, Optional, Tuple
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

from UnityCatalogReader import UnityCatalogReader


APP_KEY_B64 = "b5RHgCQ66Glhlru9WV5Koc5SulPDiWZ44K0+dCeVTn0="
APP_KEY_BYTES = base64.b64decode(APP_KEY_B64)
VERSION_URL = "https://preregist.abyss-prod-r18.dotabyss.dmmgames.com/uuid"
SECURE_LINK_KEY = "ulTn7l2O7kctUTYkI0qsM9YuEnrj6isy"
MASTER_BASE_URL = "https://preregist.abyss-prod-r18.dotabyss.dmmgames.com/data/preregist/"
MAX_THREADS = 16
RETRY_COUNT = 5

console = Console()

class AbyssDecryptor:
    @staticmethod
    def decrypt_laravel_session(encrypted_str: str) -> Optional[str]:
        try:
            decoded_json = base64.b64decode(urllib.parse.unquote(encrypted_str))
            payload = json.loads(decoded_json)
            iv = base64.b64decode(payload['iv'])
            value = base64.b64decode(payload['value'])
            cipher = AES.new(APP_KEY_BYTES, AES.MODE_CBC, iv)
            decrypted = unpad(cipher.decrypt(value), AES.block_size)
            res_str = decrypted.decode('utf-8')
            if ':"' in res_str:
                return res_str.split(':"')[1].split('"')[0]
            return res_str
        except Exception as e:
            console.print(f"[red][-] Session 解密失败: {e}[/red]")
            return None

    @staticmethod
    def decrypt_api_body(binary_body: bytes, session_id: str) -> Optional[bytes]:
        try:
            derived_key = hmac.new(APP_KEY_BYTES, session_id.encode('utf-8'), hashlib.sha256).digest()
            iv = binary_body[:16]
            ciphertext = binary_body[16:]
            cipher = AES.new(derived_key, AES.MODE_CBC, iv)
            return unpad(cipher.decrypt(ciphertext), AES.block_size)
        except Exception as e:
            console.print(f"[red][-] Body 解密失败: {e}[/red]")
            return None

    @staticmethod
    def decrypt_master_data(data: bytes, decrypt_key_str: str = "abyss") -> Optional[bytes]:
        """解密数据表逻辑"""
        try:
            actual_key = hmac.new(APP_KEY_BYTES, decrypt_key_str.encode('utf-8'), hashlib.sha256).digest()
            
            iv = data[:16]
            ciphertext = data[16:]
            cipher = AES.new(actual_key, AES.MODE_CBC, iv)
            decrypted = unpad(cipher.decrypt(ciphertext), AES.block_size)
            return decrypted
        except Exception as e:
            console.print(f"[red][-] 数据表解密失败: {e}[/red]")
            return None

def create_secure_url(base_url: str, path: str, secret: str, expire_seconds: int = 600) -> str:
    """Absf::Api::SecureLinkUtil::CreateSecureUrl"""
    t = int(time.time()) + expire_seconds
    raw_str = f"{secret}{path}{t}"
    md5_hash = hashlib.md5(raw_str.encode('utf-8')).digest()
    s = base64.b64encode(md5_hash).decode('utf-8')
    s = s.replace('+', '-').replace('/', '_').replace('=', '')
    parsed_domain = urllib.parse.urlparse(base_url).netloc
    return f"https://{parsed_domain}{path}?s={s}&t={t}"

class AbyssDownloader:
    def __init__(self, threads: int = MAX_THREADS):
        self.session = requests.Session()
        self.session.headers.update({
            "User-Agent": "UnityPlayer/6000.0.43f1 (UnityWebRequest/1.0, libcurl/7.84.0-DEV)",
            "X-Unity-Version": "6000.0.43f1"
        })
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

    def get_version_info(self) -> Optional[Dict[str, Any]]:
        """获取并解密版本信息"""
        console.print(f"[*] 正在请求版本 URL: {VERSION_URL}")
        try:
            resp = self.session.get(VERSION_URL, timeout=15)
            resp.raise_for_status()
            
            enc_session = resp.headers.get('X-Olg-Session')
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
                
            return json.loads(decrypted_body.decode('utf-8'))
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
                    raise ValueError(f"文件大小校验失败: {os.path.getsize(dest_path)} != {expected_size}")
                
                return True
            except Exception as e:
                if attempt == RETRY_COUNT - 1:
                    console.print(f"[red]下载失败 ({url}): {e}[/red]")
                else:
                    time.sleep(1)
        return False

    def handle_master_data(self):
        """处理数据表下载、解密与解析"""
        path = f"/data/preregist/{self.master_ver}"
        secure_url = create_secure_url(MASTER_BASE_URL, path, SECURE_LINK_KEY)
        
        console.print(f"[*] 正在获取 Master Data: {secure_url}")
        try:
            resp = self.session.get(secure_url, timeout=30)
            resp.raise_for_status()
            
            enc_data = resp.content
            dec_data = AbyssDecryptor.decrypt_master_data(enc_data, "abyss")
            if not dec_data:
                return False
                
            master_obj = msgpack.unpackb(dec_data)
            output_file = "MasterData.json"
            with open(output_file, "w", encoding="utf-8") as f:
                json.dump(master_obj, f, ensure_ascii=False, indent=2)
            
            console.print(f"[green][+] Master Data 已保存至 {output_file}[/green]")
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
                
            dest_path = os.path.join("Assets", primary_key)
            
            ok = self.download_file(url, dest_path, expected_size=size)
            if ok:
                self.progress.advance(task_id)
            else:
                # console.print(f"[yellow][!] 跳过文件: {primary_key}[/yellow]")
                self.progress.advance(task_id)
                
            self.download_queue.task_done()

    def run(self):
        info = self.get_version_info()
        if not info:
            return
            
        versions = info.get("versions", {})
        self.asset_ver = versions.get("AssetVersionAndroidDmmR18Preregist")
        self.master_ver = versions.get("resourcePreregist", "4")
        client_ver = versions.get("ClientVersionAndroidDmmR18Preregist", "1.0.0")
        self.client_ver_prefix = client_ver.split('.')[0]
        
        if not self.asset_ver:
            console.print("[red][-] 未能在响应中找到 AssetVersionAndroidDmmR18Preregist[/red]")
            return
            
        console.print(f"[blue][*] 资产版本: {self.asset_ver}, 数据表版本: {self.master_ver}, 客户端前缀: {self.client_ver_prefix}[/blue]")
        if not self.handle_master_data():
            console.print("[yellow][!] Master Data 处理失败，将跳过数据表任务。[/yellow]")

        self.base_url = f"https://preregist.abyss-prod-r18.dotabyss.dmmgames.com/resources/android_preregist/r18/aas/{self.asset_ver}/aa"
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
        updated = True
        if os.path.exists(hash_file):
            with open(hash_file, "r") as f:
                old_hash = f.read().strip()
                if old_hash == current_hash:
                    console.print("[yellow][*] Catalog 已经是最新，跳过。[/yellow]")
                    updated = False
        
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
        except Exception as e:
            console.print(f"[red][-] 解析 Catalog 失败: {e}[/red]")
            return

        for asset in assets:
            self.download_queue.put((asset['internal_id'], asset['primary_key'], asset['bundle_size']))
            
        total_assets = len(assets)
        with self.progress:
            task_id = self.progress.add_task("[cyan]正在同步资源...[/cyan]", total=total_assets)
            
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
