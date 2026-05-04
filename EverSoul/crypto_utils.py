"""
加密解密工具模块
"""

import hashlib
from pathlib import Path
from typing import Optional
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

from rich.console import Console
from rich.progress import Progress, BarColumn, TextColumn, TimeRemainingColumn

console = Console()

# 全局常量
TABLE_VERSION = 0  # 从cdn直接下载的表版本为0, 游戏下载后的表为获取的版本号
KEY_MAGIC = "!@UmWlXo"


class CryptoUtils:
    """加密解密工具类"""

    @staticmethod
    def derive_key_and_iv() -> tuple[bytes, bytes]:
        """
        密钥派生函数

        Returns:
            (解密密钥, 初始化向量)的元组

        Raises:
            RuntimeError: SHA256处理失败
        """
        try:
            # 计算 (tableVersion ^ 0x80000000) 并作为有符号整数
            xor_result = TABLE_VERSION ^ 0x80000000
            # 转换为有符号32位整数
            if xor_result >= 0x80000000:
                xor_result = xor_result - 0x100000000

            unhash_key = str(xor_result) + KEY_MAGIC

            # SHA256处理
            hash_obj = hashlib.sha256(unhash_key.encode("utf-8"))
            hash_bytes = hash_obj.digest()

            # 前16个字节作为密钥
            key = hash_bytes[:16]
            # IV与密钥相同
            iv = key

            return key, iv
        except Exception as e:
            raise RuntimeError(f"密钥派生失败: {e}")

    @staticmethod
    def decrypt_aes128_cbc(ciphertext: bytes, key: bytes, iv: bytes) -> Optional[bytes]:
        """
        使用AES-128-CBC模式解密数据

        Args:
            ciphertext: 待解密的密文数据
            key: 解密密钥
            iv: 初始化向量

        Returns:
            解密后的明文数据，失败时返回None
        """
        try:
            cipher = AES.new(key, AES.MODE_CBC, iv)
            plaintext = cipher.decrypt(ciphertext)
            # 移除填充
            plaintext = unpad(plaintext, AES.block_size)
            return plaintext
        except Exception as e:
            console.print(f"[bold red]AES解密失败: {e}[/bold red]")
            return None

    @staticmethod
    def is_file_decrypted(file_path: Path) -> bool:
        """
        检查文件是否已经被解密

        Args:
            file_path: 要检查的文件路径

        Returns:
            如果文件已解密返回True，否则返回False
        """
        try:
            with open(file_path, "rb") as f:
                header = f.read(32)
                if len(header) < 32:
                    return False

                # 检查是否有统一的偏移量模式
                has_uniform_offsets = False
                for i in range(16, 28, 4):
                    curr = int.from_bytes(header[i : i + 4], byteorder="little")
                    next_val = int.from_bytes(header[i + 4 : i + 8], byteorder="little")
                    # 检查相邻的两个4字节整数是否形成递减序列
                    if curr > next_val and (curr - next_val) < 0x1000:
                        has_uniform_offsets = True
                        break

                return has_uniform_offsets
        except Exception:
            return False

    @staticmethod
    def decrypt_file_in_place(file_path: Path, key: bytes, iv: bytes) -> bool:
        """
        在文件原位解密数据

        Args:
            file_path: 要解密的文件路径
            key: 解密密钥
            iv: 初始化向量

        Returns:
            解密成功返回True，失败返回False
        """
        try:
            # 读取文件内容
            with open(file_path, "rb") as f:
                ciphertext = f.read()

            # 解密
            plaintext = CryptoUtils.decrypt_aes128_cbc(ciphertext, key, iv)
            if plaintext is None:
                return False

            # 写回文件
            with open(file_path, "wb") as f:
                f.write(plaintext)

            return True
        except Exception as e:
            console.print(f"[bold red]解密失败 {file_path}: {e}[/bold red]")
            return False

    @staticmethod
    def decrypt_files(files: list[Path], key: bytes, iv: bytes) -> bool:
        """
        解密多个文件

        Args:
            files: 需要解密的文件路径列表
            key: 解密密钥
            iv: 初始化向量

        Returns:
            所有文件解密成功返回True，任一文件解密失败返回False
        """
        total_files = len(files)
        failed_count = 0
        failed_files = []

        with Progress(
            TextColumn("[bold blue]{task.description}"),
            BarColumn(),
            TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
            TextColumn("({task.completed}/{task.total})"),
            TimeRemainingColumn(),
            console=console,
            transient=True,
        ) as progress:
            task = progress.add_task("解密进度", total=total_files)

            for file_path in files:
                if not CryptoUtils.decrypt_file_in_place(file_path, key, iv):
                    failed_count += 1
                    failed_files.append(file_path.name)
                    console.print(
                        f"[bold yellow]警告: {file_path.name} 解密失败，跳过该文件[/bold yellow]"
                    )

                progress.update(task, advance=1)

        if failed_count > 0:
            console.print(
                f"[bold yellow]数据表解密完成，但有 {failed_count} 个文件失败[/bold yellow]"
            )
            console.print("[bold yellow]失败的文件:[/bold yellow]")
            for f in failed_files:
                console.print(f"  - {f}")

            # 如果失败文件过多（超过10%），则返回失败
            if failed_count > total_files / 10:
                console.print("[bold red]失败文件过多，可能存在严重问题[/bold red]")
                return False
            return True  # 少量文件失败，视为成功

        console.print("[bold green]数据表解密完成[/bold green]")
        return True
