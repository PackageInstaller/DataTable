import hashlib
import json
import os
import requests
import UnityPy
from pathlib import Path
from typing import Dict, List, Tuple
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
import concurrent.futures
import time
from rich.console import Console
from rich.progress import (
    Progress, 
    BarColumn, 
    TextColumn, 
    TaskID,
    MofNCompleteColumn
)

CONFIG_URL = "https://kr1-config.lost-sword.com/KR1CDN.config"
SECRET_KEY = "1020whaoCnf#$rkqqlek!%(vldrj=="
HEADER_SECRET_KEY = "dk12kff$&kq2d!Rhf$haqldk&*(--="
HEADER_BODY = "동해!물과@백두산이마르고닳도록하느님이보우하사!우리나라만세@#무궁화%^삼천리()화려-=강산`1"
FILTER_PATTERNS = [
    "texture/"
]

class MasterTableUpdater:
    def __init__(self, master_table_dir: str = "MasterData", max_workers: int = 4, max_retries: int = 3):
        self.master_table_dir = Path(master_table_dir)
        self.master_table_dir.mkdir(exist_ok=True)
        self.local_patch_list_path = self.master_table_dir / "patchList.json"
        self.max_workers = max_workers
        self.max_retries = max_retries
        self.console = Console()
        
    def should_skip_file(self, bundle_name: str) -> bool:
        bundle_name_lower = bundle_name.lower()
        for pattern in FILTER_PATTERNS:
            if pattern in bundle_name_lower:
                return True
        return False
    
    def get_config_info(self) -> Dict:
        try:
            response = requests.get(CONFIG_URL, timeout=30)
            response.raise_for_status()
            return response.json()
        except Exception as e:
            self.console.print(f"[red]获取配置失败: {e}[/red]")
            raise
    
    def get_asset_version_and_url(self, config: Dict) -> Tuple[str, str]:
        aos_info = config.get("Info", {}).get("AOS", {})
        asset_bundle_urls = aos_info.get("AssetBundleUrl", {})
        
        if not asset_bundle_urls:
            raise ValueError("找不到AssetBundleUrl")
        
        latest_version = max(asset_bundle_urls.keys(), key=int)
        base_url = asset_bundle_urls[latest_version]
        
        return latest_version, base_url
    
    def get_patch_list(self, base_url: str) -> List[Dict]:
        patch_list_url = f"{base_url}/patchList.json"

        try:
            response = requests.get(patch_list_url, timeout=30)
            response.raise_for_status()
            return response.json()
        except Exception as e:
            self.console.print(f"[red]获取资产列表失败: {e}[/red]")
            raise
    
    def load_local_patch_list(self) -> Dict:
        if not self.local_patch_list_path.exists():
            return {}
        
        try:
            with open(self.local_patch_list_path, 'r', encoding='utf-8') as f:
                patch_list = json.load(f)
                return {item["BundleName"]: item for item in patch_list}
        except Exception as e:
            self.console.print(f"[red]读取本地资产列表失败: {e}[/red]")
            return {}
    
    def save_patch_list(self, patch_list: List[Dict]):
        try:
            with open(self.local_patch_list_path, 'w', encoding='utf-8') as f:
                json.dump(patch_list, f, ensure_ascii=False, indent=2)
        except Exception as e:
            self.console.print(f"[red]保存资产列表失败: {e}[/red]")
    
    def check_updates_needed(self, remote_patch_list: List[Dict]) -> List[Dict]:
        local_patch_dict = self.load_local_patch_list()
        updates_needed = []
        skipped_count = 0
        up_to_date_count = 0
        
        for item in remote_patch_list:
            bundle_name = item["BundleName"]

            if self.should_skip_file(bundle_name):
                skipped_count += 1
                continue
                
            remote_size = item["Size"]
            local_item = local_patch_dict.get(bundle_name)
            
            bundle_path = Path(bundle_name)
            bundle_stem = bundle_path.stem
            
            possible_json_names = [
                f"{bundle_stem}.json",  
                f"{bundle_stem.replace('data', 'Data')}.json",
                f"{bundle_stem.title().replace('Data', 'Data')}.json",
                f"{''.join(word.capitalize() for word in bundle_stem.split('_'))}.json",
                f"{''.join(word.capitalize() for word in bundle_stem.split('-'))}.json",
            ]
            
            json_exists = False
            json_dir = self.master_table_dir / bundle_path.parent
            if json_dir.exists():
                existing_files = {f.name.lower(): f.name for f in json_dir.iterdir() if f.suffix.lower() == '.json'}
                for json_name in possible_json_names:
                    if json_name.lower() in existing_files:
                        json_exists = True
                        break
            
            need_update = False
            
            if not local_item:
                need_update = True
            elif local_item.get("Size") != remote_size:
                need_update = True
            elif not json_exists:
                need_update = True
            else:
                up_to_date_count += 1
            
            if need_update:
                updates_needed.append(item)
        
        self.console.print(f"[blue]跳过了 {skipped_count} 个非数据文件[/blue]")
        self.console.print(f"[green]{up_to_date_count} 个文件已是最新版本[/green]")
        return updates_needed
    
    def download_file_with_retry(self, base_url: str, bundle_name: str, target_path: Path, progress: Progress, task_id: TaskID) -> bool:
        download_url = f"{base_url}/{bundle_name}"
        
        for attempt in range(self.max_retries):
            try:
                target_path.parent.mkdir(parents=True, exist_ok=True)
                
                response = requests.get(download_url, timeout=60, stream=True)
                response.raise_for_status()
                
                total_size = int(response.headers.get('content-length', 0))
                progress.update(task_id, total=total_size)
                
                with open(target_path, 'wb') as f:
                    downloaded = 0
                    for chunk in response.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)
                            downloaded += len(chunk)
                            progress.update(task_id, advance=len(chunk))
                
                return True
                
            except Exception as e:
                if attempt < self.max_retries - 1:
                    time.sleep(1)
                    progress.reset(task_id)
                else:
                    return False
        
        return False
    
    def export_textassets(self, data: bytes) -> Tuple[bytes, str]:
        try:
            env = UnityPy.load(data)
            for obj in env.objects:
                if obj.type.name == "TextAsset":
                    ta = obj.read()
                    script_data = getattr(ta, "m_Script", None)
                    if script_data is not None:
                        asset_name = getattr(ta, "m_Name", "")
                        
                        if isinstance(script_data, str):
                            return script_data.encode("utf-8", "surrogateescape"), asset_name
                        return script_data, asset_name
        except Exception:
            pass
        return data, ""
    
    def calculate_header_length(self):
        header_body_bytes = HEADER_BODY.encode("UTF-8")
        padded_length = ((len(header_body_bytes) + 15) // 16) * 16
        total_header_length = 16 + padded_length
        return total_header_length
    
    def decrypt_and_export_bundle(self, bundle_path: Path) -> bool:
        try:
            with open(bundle_path, 'rb') as f:
                bundle_data = f.read()
            
            extracted_data, asset_name = self.export_textassets(bundle_data)
            
            if not extracted_data:
                return False
            
            header_length = self.calculate_header_length()
            if len(extracted_data) <= header_length:
                return False
            
            encrypted_content = extracted_data[header_length:]
            decrypt_key = hashlib.md5(SECRET_KEY.encode('UTF-8')).digest()
            cipher = AES.new(decrypt_key, AES.MODE_ECB)
            
            decrypted_padded_data = cipher.decrypt(encrypted_content)
            decrypted_data = unpad(decrypted_padded_data, AES.block_size)
            
            json_text = decrypted_data.decode('UTF-8')
            formatted_json = json.dumps(json.loads(json_text), ensure_ascii=False, indent=4)
            
            if asset_name:
                output_name = f"{asset_name}.json"
            else:
                output_name = bundle_path.stem + ".json"
            
            output_path = bundle_path.parent / output_name
            with open(output_path, 'w', encoding='UTF-8') as f:
                f.write(formatted_json)
            
            try:
                bundle_path.unlink()
            except Exception as e:
                pass
            
            return True
            
        except Exception as e:
            return False
    
    def download_and_process_file(self, base_url: str, item: Dict) -> Tuple[bool, str]:
        bundle_name = item["BundleName"]
        local_path = self.master_table_dir / bundle_name.replace("/", os.sep)
        
        try:
            if self.download_file_simple(base_url, bundle_name, local_path):
                if self.decrypt_and_export_bundle(local_path):
                    return True, bundle_name
                else:
                    return False, bundle_name
            else:
                return False, bundle_name
                
        except Exception as e:
            return False, bundle_name
    
    def download_file_simple(self, base_url: str, bundle_name: str, target_path: Path) -> bool:
        download_url = f"{base_url}/{bundle_name}"
        
        for attempt in range(self.max_retries):
            try:
                target_path.parent.mkdir(parents=True, exist_ok=True)
                
                response = requests.get(download_url, timeout=60, stream=True)
                response.raise_for_status()
                
                with open(target_path, 'wb') as f:
                    for chunk in response.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)
                
                return True
                
            except Exception as e:
                if attempt < self.max_retries - 1:
                    time.sleep(1)
                else:
                    return False
        
        return False
    
    def update_master_tables(self):
        try:
            config = self.get_config_info()
            _, base_url = self.get_asset_version_and_url(config)
            
            remote_patch_list = self.get_patch_list(base_url)
            
            updates_needed = self.check_updates_needed(remote_patch_list)
            
            if not updates_needed:
                self.console.print("[green]所有文件都是最新的，无需更新[/green]")
                return
            
            self.console.print(f"[yellow]需要更新 {len(updates_needed)} 个文件[/yellow]")
            
            with Progress(
                TextColumn("下载进度: "),
                BarColumn(),
                MofNCompleteColumn(),
                TextColumn("| 当前: [cyan]{task.description}[/cyan]"),
                console=self.console
            ) as progress:
                
                main_task = progress.add_task(description="准备中...", total=len(updates_needed))
                
                success_count = 0
                failed_files = []
                
                with concurrent.futures.ThreadPoolExecutor(max_workers=self.max_workers) as executor:
                    future_to_item = {
                        executor.submit(self.download_and_process_file, base_url, item): item
                        for item in updates_needed
                    }
                    
                    for future in concurrent.futures.as_completed(future_to_item):
                        item = future_to_item[future]
                        try:
                            success, filename = future.result()
                            short_name = Path(filename).name
                            if success:
                                success_count += 1
                                progress.update(main_task, advance=1, description=f"{short_name}")
                            else:
                                failed_files.append(filename)
                                progress.update(main_task, advance=1, description=f"{short_name}")
                        except Exception as e:
                            failed_files.append(item["BundleName"])
                            progress.update(main_task, advance=1, description=f"{Path(item['BundleName']).name}")
                
                progress.update(main_task, description="完成")
            
            if success_count > 0:
                self.save_patch_list(remote_patch_list)
                self.console.print(f"[green]更新完成！成功处理 {success_count}/{len(updates_needed)} 个文件[/green]")
                
                if failed_files:
                    self.console.print(f"[yellow]失败的文件 ({len(failed_files)}个):[/yellow]")
                    for failed_file in failed_files[:10]:
                        self.console.print(f"[red]- {failed_file}[/red]")
                    if len(failed_files) > 10:
                        self.console.print(f"[yellow]... 还有 {len(failed_files) - 10} 个文件失败[/yellow]")
            else:
                self.console.print("[red]更新失败，没有文件被成功处理[/red]")
                
        except Exception as e:
            self.console.print(f"[red]更新过程中发生错误: {e}[/red]")

if __name__ == "__main__":
    updater = MasterTableUpdater(max_workers=4, max_retries=3)
    updater.update_master_tables()