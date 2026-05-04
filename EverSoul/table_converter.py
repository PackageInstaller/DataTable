"""
数据表转换模块
"""

import subprocess
import os
from pathlib import Path
from typing import Optional

from rich.console import Console
from rich.progress import Progress, BarColumn, TextColumn, TimeRemainingColumn

console = Console()


class TableConverter:
    """数据表转换类"""

    @staticmethod
    def convert_tables_to_json(
        schema_dir: str, table_dir: str, output_dir: str
    ) -> bool:
        """
        将数据表转换为JSON格式

        Args:
            schema_dir: FlatBuffers schema文件所在的目录路径
            table_dir: 二进制数据表文件所在的目录路径
            output_dir: 输出JSON文件的目录路径

        Returns:
            转换成功返回True，失败返回False
        """
        try:
            schema_path = Path(schema_dir)
            table_path = Path(table_dir)
            output_path = Path(output_dir)

            if not output_path.exists():
                output_path.mkdir(parents=True, exist_ok=True)

            # 统计需要转换的文件数量
            total_files = 0
            files_to_convert = []
            for fbs_file in schema_path.glob("*.fbs"):
                tbl_file = table_path / f"{fbs_file.stem}.tbl"
                if tbl_file.exists():
                    total_files += 1
                    files_to_convert.append((fbs_file, tbl_file))

            result = 0
            with Progress(
                TextColumn("[bold blue]{task.description}"),
                BarColumn(),
                TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
                TextColumn("({task.completed}/{task.total})"),
                TextColumn("{task.fields[filename]}"),
                TimeRemainingColumn(),
                console=console,
                transient=True,
            ) as progress:
                task = progress.add_task("转换进度", total=total_files, filename="")

                for fbs_file, tbl_file in files_to_convert:
                    schema_name = fbs_file.stem
                    progress.update(task, filename=f"{schema_name}.tbl")

                    command = [
                        "flatc",
                        "--json",
                        "--raw-binary",
                        "--strict-json",
                        "--natural-utf8",
                        "-o",
                        str(output_path),
                        str(fbs_file),
                        "--",
                        str(tbl_file),
                    ]

                    result = subprocess.run(
                        command, capture_output=True, text=True
                    ).returncode

                    if result != 0:
                        continue

                    progress.update(task, advance=1)

            if result == 0:
                console.print("[bold green]数据表转换完成[/bold green]")
                return True
            return False
        except Exception as e:
            console.print(f"[bold red]转换过程出错: {e}[/bold red]")
            return False

    @staticmethod
    def generate_flatbuffer_python_api(schema_dir: str, output_dir: str) -> bool:
        """
        根据FlatBuffer schema文件生成Python API

        Args:
            schema_dir: FlatBuffer schema文件所在的目录路径
            output_dir: 生成的Python API文件输出目录路径

        Returns:
            生成成功返回True，失败返回False
        """
        original_cwd = os.getcwd()

        try:
            abs_schema_dir = Path(schema_dir).resolve()

            if not abs_schema_dir.exists():
                console.print(
                    f"[bold red]Schema目录不存在: {abs_schema_dir}[/bold red]"
                )
                return False

            output_path = Path(output_dir)
            if not output_path.exists():
                output_path.mkdir(parents=True, exist_ok=True)

            # 切换到输出目录
            os.chdir(output_dir)

            # 统计.fbs文件数量
            fbs_files = list(abs_schema_dir.glob("*.fbs"))
            total_files = len(fbs_files)

            if total_files == 0:
                console.print(
                    f"[bold yellow]在Schema目录中未找到.fbs文件: {abs_schema_dir}[/bold yellow]"
                )
                return False

            generated_files = []

            with Progress(
                TextColumn("[bold blue]{task.description}"),
                BarColumn(),
                TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
                TextColumn("({task.completed}/{task.total})"),
                TextColumn("{task.fields[filename]}"),
                TimeRemainingColumn(),
                console=console,
                transient=True,
            ) as progress:
                task = progress.add_task("生成进度", total=total_files, filename="")

                for fbs_file in fbs_files:
                    schema_name = fbs_file.stem
                    progress.update(task, filename=f"{schema_name}.fbs")

                    command = ["flatc", "--python", str(fbs_file)]

                    result = subprocess.run(command, capture_output=True, text=True)

                    if result.returncode == 0:
                        generated_files.append(schema_name)
                    else:
                        console.print(
                            f"[bold yellow]生成 {schema_name} 的Python API失败[/bold yellow]"
                        )

                    progress.update(task, advance=1)

            # 为每个命名空间生成__init__.py文件
            namespace_files = {}

            for root, dirs, files in os.walk("."):
                for file in files:
                    if file.endswith(".py") and file != "__init__.py":
                        dir_name = Path(root).name
                        file_name = Path(file).stem
                        if file_name.endswith("Table"):
                            if dir_name not in namespace_files:
                                namespace_files[dir_name] = []
                            namespace_files[dir_name].append(file_name)

            for namespace_dir, files in namespace_files.items():
                init_file = Path(namespace_dir) / "__init__.py"
                with open(init_file, "w", encoding="utf-8") as f:
                    f.write("# Auto-generated FlatBuffer Python API\n")
                    f.write(
                        f"# Generated from Eversoul schema files - namespace: {namespace_dir}\n\n"
                    )

                    for file_name in files:
                        f.write(f"from . import {file_name}\n")

                    f.write("\n__all__ = [\n")
                    for i, file_name in enumerate(files):
                        comma = "," if i < len(files) - 1 else ""
                        f.write(f"    '{file_name}'{comma}\n")
                    f.write("]\n")

            if generated_files:
                console.print(
                    f"[bold green]成功生成 {len(generated_files)} 个FlatBuffer Python API文件[/bold green]"
                )
                os.chdir(original_cwd)
                return True
            else:
                os.chdir(original_cwd)
                console.print("[bold red]未能生成任何Python API文件[/bold red]")
                return False
        except Exception as e:
            try:
                os.chdir(original_cwd)
            except:
                pass

            console.print(f"[bold red]生成FlatBuffer Python API出错: {e}[/bold red]")
            return False
