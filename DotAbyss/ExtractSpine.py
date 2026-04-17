import os
import sys
import json
import re
from pathlib import Path
from typing import List, Optional
import UnityPy
import UnityPy.config
from UnityPy.enums import ClassIDType


class SpineAssetExtractor:
    def __init__(self, bundle_dir: str):
        self.bundle_dir = Path(bundle_dir).resolve()
        self.script_dir = Path(os.path.dirname(os.path.abspath(__file__)))
        self.output_dir = self.script_dir / "Output"
        self.assets_json_path = self.script_dir / "assets.json"
        self.image_pattern = re.compile(r"([^#\r\n]+)\.png")
        self.size_pattern = re.compile(r"size:\s*(\d+),\s*(\d+)")

        if not self.assets_json_path.exists():
            raise FileNotFoundError(
                f"未找到 assets.json，路径：{self.assets_json_path}"
            )
        with open(self.assets_json_path, "r", encoding="utf-8") as f:
            self.assets_json = json.load(f)

        self.id_to_primary = {}
        self._build_lookups()
        self.stats = {
            "atlas": 0,
            "skel": 0,
            "json": 0,
            "texture": 0,
            "exported_dirs": set(),
        }

    def _normalize_id(self, internal_id: str) -> str:
        if "}" in internal_id:
            return internal_id.split("}", 1)[1].lstrip("/")
        return internal_id.lstrip("/")

    def _build_lookups(self):
        assets = self.assets_json.get("assets", [])
        print(f"正在为 {len(assets)} 个资产构建索引表...")
        for asset in assets:
            if not isinstance(asset, dict):
                continue

            internal_id = asset.get("internal_id", "")
            primary_key = asset.get("primary_key", "")

            if internal_id:
                norm_id = self._normalize_id(internal_id)
                self.id_to_primary[norm_id] = primary_key
            if primary_key:
                norm_key = self._normalize_id(primary_key)
                self.id_to_primary[norm_key] = primary_key

    def _path_to_dir(self, path: str) -> str:
        if "." in path:
            return path.split(".")[0]
        return path

    def _find_primary_key(self, container: str) -> Optional[str]:
        if not container:
            return None

        norm_container = container.lstrip("/")
        if norm_container in self.id_to_primary:
            return self.id_to_primary[norm_container]

        norm_container_lower = norm_container.lower()
        for norm_id, primary in self.id_to_primary.items():
            if norm_id.lower() == norm_container_lower:
                return primary

        for norm_id, primary in self.id_to_primary.items():
            if norm_id.endswith(norm_container) or norm_container.endswith(norm_id):
                return primary

        return None

    def _extract_atlas_images(self, atlas_text: str) -> List[str]:
        return list(dict.fromkeys(self.image_pattern.findall(atlas_text)))

    def export_assets(self):
        self.output_dir.mkdir(exist_ok=True)
        bundles = []
        for path in self.bundle_dir.rglob("*"):
            if path.is_file():
                try:
                    with open(path, "rb") as f:
                        header = f.read(7)
                        if header == b"UnityFS":
                            bundles.append(path)
                except:
                    continue

        print(f"找到 {len(bundles)} 个 Bundle\n")

        for bundle_path in bundles:
            try:
                env = UnityPy.load(str(bundle_path))
            except Exception as e:
                print(f"加载 Bundle 失败 {bundle_path.name}: {e}")
                continue

            potential_containers = set()
            potential_containers.add(bundle_path.name)

            for obj in env.objects:
                if obj.type == ClassIDType.AssetBundle:
                    try:
                        data = obj.read()
                        if hasattr(data, "m_Container"):
                            container_data = data.m_Container
                            it = (
                                container_data.items()
                                if hasattr(container_data, "items")
                                else container_data
                            )
                            for key, _ in it:
                                if isinstance(key, str):
                                    potential_containers.add(key)
                    except:
                        pass
            best_primary_key = None
            for container in potential_containers:
                pk = self._find_primary_key(container)
                if pk:
                    best_primary_key = pk
                    break

            assets_in_bundle = {}
            for obj in env.objects:
                if obj.type in [ClassIDType.TextAsset, ClassIDType.Texture2D]:
                    try:
                        data = obj.read()
                        name = getattr(data, "m_Name", "")
                        if name:
                            assets_in_bundle[name] = obj
                    except:
                        continue

            for name, obj in assets_in_bundle.items():
                if obj.type != ClassIDType.TextAsset:
                    continue

                if not name.endswith(".atlas"):
                    continue

                primary_key = None
                container = getattr(obj, "container", "")
                if container:
                    primary_key = self._find_primary_key(container)

                if not primary_key:
                    primary_key = best_primary_key

                if not primary_key:
                    continue

                export_rel_dir = self._path_to_dir(primary_key)
                output_path = self.output_dir / export_rel_dir
                output_path.mkdir(parents=True, exist_ok=True)

                self.stats["exported_dirs"].add(str(export_rel_dir))

                try:
                    data = obj.read()
                    raw_script = getattr(data, "m_Script", b"")

                    if isinstance(raw_script, str):
                        script_bytes = raw_script.encode("utf-8", "surrogateescape")
                        atlas_text = raw_script
                    else:
                        script_bytes = raw_script
                        atlas_text = raw_script.decode("utf-8", "ignore")

                    with open(output_path / name, "wb") as f:
                        f.write(script_bytes)

                    self.stats["atlas"] += 1
                    print(f"{export_rel_dir}/{name}")
                    base_name = name.rsplit(".atlas", 1)[0]
                    for ext in [".json", ".skel"]:
                        linked_name = base_name + ext
                        if linked_name in assets_in_bundle:
                            try:
                                linked_obj = assets_in_bundle[linked_name]
                                linked_data = linked_obj.read()
                                l_raw_script = getattr(linked_data, "m_Script", b"")

                                if isinstance(l_raw_script, str):
                                    l_script_bytes = l_raw_script.encode(
                                        "utf-8", "surrogateescape"
                                    )
                                else:
                                    l_script_bytes = l_raw_script

                                with open(output_path / linked_name, "wb") as f:
                                    f.write(l_script_bytes)

                                if ext == ".json":
                                    self.stats["json"] += 1
                                else:
                                    self.stats["skel"] += 1
                                print(f"└─ 关联导出: {linked_name}")
                            except Exception as e:
                                print(f"关联导出失败 {linked_name}: {e}")
                    img_names = self._extract_atlas_images(atlas_text)
                    for img_name in img_names:
                        img_base = img_name
                        texture_obj = assets_in_bundle.get(
                            img_base
                        ) or assets_in_bundle.get(img_base + ".png")
                        if texture_obj and texture_obj.type == ClassIDType.Texture2D:
                            try:
                                texture_data = texture_obj.read()
                                save_name = (
                                    img_base
                                    if img_base.endswith(".png")
                                    else img_base + ".png"
                                )
                                texture_data.image.save(output_path / save_name)
                                self.stats["texture"] += 1
                                print(f"└─ 贴图导出: {save_name}")
                            except Exception as e:
                                print(f"贴图保存失败 {img_base}: {e}")
                except Exception as e:
                    print(f"处理失败 {name}: {e}")

        print(f"导出目录总数: {len(self.stats['exported_dirs'])}")
        print(f"Atlas 文件: {self.stats['atlas']}")
        print(f"Skel 文件: {self.stats['skel']}")
        print(f"JSON 文件: {self.stats['json']}")
        print(f"贴图数量: {self.stats['texture']}")


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    bundle_dir = sys.argv[1]

    if not os.path.isdir(bundle_dir):
        print(f"错误: 未找到目录: {bundle_dir}")
        sys.exit(1)

    try:
        extractor = SpineAssetExtractor(bundle_dir)
        extractor.export_assets()
    except Exception as e:
        print(f"运行错误: {e}")
        import traceback

        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
