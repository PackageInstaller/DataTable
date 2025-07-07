import requests
import hashlib
import base64
import UnityPy
import zlib
import json
import time
import os
from urllib.parse import urlparse
from concurrent.futures import ThreadPoolExecutor
from threading import Lock
from rich.progress import (
    Progress,
    BarColumn,
    DownloadColumn,
    TextColumn,
    TransferSpeedColumn,
    TimeRemainingColumn
)
from rich import print
from Crypto.Cipher import DES3
from Crypto.Util.Padding import unpad
from typing import Optional

class Config:
    APP_KEY = 'amvBZLfOUWwAXoVu8xxGwibrwqGsneLR'
    PLATFORM = 'webgl' # 还有 android, ios可选,这里就用网页端好点
    REGION = 'r18'
    INITIAL_MANIFEST_URL = f"https://www-r18.gc.dmmgames.com/manifest/{PLATFORM}/{REGION}"
    ASSET_JSON_FILES = ["master.json", "assetbundle.json", "advvoice.json"]
    DOWNLOAD_DIR = "downloads"
    MASTER_DATA_DIR = "MasterData"
    MAX_WORKERS = 32 # 线程
    MAX_RETRIES = 3 # 重试次数
    CHUNK_SIZE = 8192

DECRYPTION_KEY_HEX = "c53f2d9bd457d4a9985294b5e51fef04" # 由 DMM::OLG::Unity::Engine::MasterLoader字符串生成

def triple_des(encrypted_data: bytes) -> Optional[str]:
    key_bytes = bytes.fromhex(DECRYPTION_KEY_HEX)
    full_key = key_bytes + key_bytes[:8]

    encrypted_bytes = base64.b64decode(encrypted_data.strip())
    
    cipher = DES3.new(full_key, DES3.MODE_ECB)
    decrypted_padded_bytes = cipher.decrypt(encrypted_bytes)
    decrypted_bytes = unpad(decrypted_padded_bytes, DES3.block_size)

    intermediate_string = decrypted_bytes.decode('utf-8')
    compressed_bytes = base64.b64decode(intermediate_string.strip())

    decompressed_data = zlib.decompress(compressed_bytes, -zlib.MAX_WBITS)
    json_text = decompressed_data.decode('utf-8')
    
    json_data = json.loads(json_text)
    return json.dumps(json_data, ensure_ascii=False, indent=4)

def extract_and_decrypt_master_data(master_dmm_path: str):
    if os.path.exists(Config.MASTER_DATA_DIR):
        files_in_dir = [f for f in os.listdir(Config.MASTER_DATA_DIR) 
                        if os.path.isfile(os.path.join(Config.MASTER_DATA_DIR, f))]
        if files_in_dir:
            print(f"[yellow]MasterData目录已存在 {len(files_in_dir)} 个文件，跳过解密操作[/yellow]")
            return
    
    print(f"[cyan]开始解包和解密 {master_dmm_path}...[/cyan]")
    os.makedirs(Config.MASTER_DATA_DIR, exist_ok=True)

    bundle = UnityPy.load(master_dmm_path)
    
    for obj in bundle.objects:
        if obj.type.name == "TextAsset":
            data = obj.read()
            asset_name = data.m_Name
            text_content = data.m_Script

            decrypted_json = triple_des(text_content)
            
            if decrypted_json:
                output_path = os.path.join(Config.MASTER_DATA_DIR, f"{asset_name}.json")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(decrypted_json)
            else:
                print(f"解密失败: {asset_name}")

def generate_secure_link(url: str, app_key: str, timestamp: int) -> str:
    parsed_url = urlparse(url)
    url_path = parsed_url.path
    md5_input = f"{app_key}{url_path}{timestamp}"
    md5_hash = hashlib.md5(md5_input.encode('utf-8')).digest()
    s_value = base64.urlsafe_b64encode(md5_hash).decode('utf-8').rstrip('=')

    return f"{url}?s={s_value}&t={timestamp}"


class Downloader:
    def __init__(self):
        self.session = requests.Session()
        self.files_to_download = []
        self.total_download_size = 0
        self.completed_files_count = 0
        self.lock = Lock()
        self.secure_timestamp = int(time.time()) + 3600

    def _get_json(self, url: str) -> dict:
        response = self.session.get(url)
        response.raise_for_status()
        return response.json()

    def fetch_asset_lists(self):
        initial_data = self._get_json(Config.INITIAL_MANIFEST_URL)
        manifest_url = initial_data["contents"]["path"]
        manifest_data = self._get_json(manifest_url)

        self.base_resource_url = manifest_data["url"]["resource"]
        base_manifest_path = manifest_url.rsplit('/', 1)[0]

        print("[cyan]正在获取资源文件列表...[/cyan]")
        all_assets = []
        for json_file in Config.ASSET_JSON_FILES:
            asset_list_url = f"{base_manifest_path}/{json_file}"
            asset_data = self._get_json(asset_list_url)
            if asset_data and "d" in asset_data:
                print(f"{json_file} (包含 {len(asset_data['d'])} 个资源)")
                all_assets.extend(asset_data['d'])
        
        print(f"\n[cyan]准备处理 {len(all_assets)} 个总资源，开始检查本地文件...[/cyan]")
        
        for asset in all_assets:
            if 'n' not in asset or 's' not in asset:
                continue

            local_path = os.path.join(Config.DOWNLOAD_DIR, asset['n'])
            server_size = int(asset['s'])
            
            if os.path.exists(local_path) and os.path.getsize(local_path) == server_size:
                continue 
            
            self.files_to_download.append(asset)
            self.total_download_size += server_size
        
        print(f"[yellow]需要下载/更新 {len(self.files_to_download)} 个文件。总计: {self.total_download_size / 1024 / 1024:.2f} MB[/yellow]")
        return True

    def download_file(self, asset_info: dict, progress: Progress, task_id):
        file_name = asset_info['n']
        server_size = int(asset_info['s'])
        
        full_url = f"{self.base_resource_url}/{file_name}"
        secure_url = generate_secure_link(full_url, Config.APP_KEY, self.secure_timestamp)
        
        local_path = os.path.join(Config.DOWNLOAD_DIR, file_name)
        os.makedirs(os.path.dirname(local_path), exist_ok=True)

        download_successful = False
        for attempt in range(Config.MAX_RETRIES):
            try:
                headers = {}
                mode = 'wb'
                downloaded_size = 0

                if os.path.exists(local_path):
                    downloaded_size = os.path.getsize(local_path)
                    if downloaded_size < server_size:
                        headers['Range'] = f'bytes={downloaded_size}-'
                        mode = 'ab'
                        progress.update(task_id, advance=downloaded_size, refresh=True)
                    else:
                        download_successful = True
                        break

                if not download_successful:
                    with self.session.get(secure_url, headers=headers, stream=True, timeout=30) as r:
                        r.raise_for_status()
                        with open(local_path, mode) as f:
                            for chunk in r.iter_content(chunk_size=Config.CHUNK_SIZE):
                                f.write(chunk)
                                progress.update(task_id, advance=len(chunk))
                
                download_successful = True
                break
            except requests.RequestException:
                print(f"[yellow]下载 {file_name} 失败 (第 {attempt + 1} 次尝试)[/yellow]")
                time.sleep(2)
        
        if not download_successful:
            print(f"[bold red]文件 {file_name} 在 {Config.MAX_RETRIES} 次尝试后依然下载失败。[/bold red]")

        with self.lock:
            self.completed_files_count += 1
            new_description = f"下载中... ({self.completed_files_count}/{len(self.files_to_download)})"
            progress.update(task_id, description=new_description)


    def run(self):
        if not self.fetch_asset_lists() or not self.files_to_download:
            print("[green]所有文件都已是最新，无需下载。[/green]")
        else:
            with Progress(
                TextColumn("[cyan]{task.description}[/cyan]"),
                BarColumn(),
                "[progress.percentage]{task.percentage:>3.1f}%",
                "•",
                DownloadColumn(),
                "•",
                TransferSpeedColumn(),
                "•",
                TimeRemainingColumn(),
            ) as progress:
                
                initial_description = f"下载中... (0/{len(self.files_to_download)})"
                task_id = progress.add_task(description=initial_description, total=self.total_download_size)

                with ThreadPoolExecutor(max_workers=Config.MAX_WORKERS) as executor:
                    for asset in self.files_to_download:
                        executor.submit(self.download_file, asset, progress, task_id)
            
            print(f"\n[bold green]下载完成！")
        
        master_dmm_path = os.path.join(Config.DOWNLOAD_DIR, "master.dmm")
        if os.path.exists(master_dmm_path):
            extract_and_decrypt_master_data(master_dmm_path)

if __name__ == "__main__":
    
    downloader = Downloader()
    downloader.run()