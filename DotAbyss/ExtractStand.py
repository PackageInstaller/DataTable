import os
import sys
import json
from pathlib import Path
from typing import Optional
from PIL import Image
import UnityPy
from UnityPy.enums import ClassIDType


class SpriteAtlasExtractor:
    def __init__(self, bundle_dir: str):
        self.bundle_dir = Path(bundle_dir).resolve()
        self.script_dir = Path(os.path.dirname(os.path.abspath(__file__)))
        self.output_dir = self.script_dir / "Output"
        self.assets_json_path = self.script_dir / "assets.json"

        if not self.assets_json_path.exists():
            raise FileNotFoundError(
                f"未找到 assets.json，路径：{self.assets_json_path}"
            )

        with open(self.assets_json_path, "r", encoding="utf-8") as f:
            self.assets_json = json.load(f)

        self.id_to_primary = {}
        self._build_lookups()
        self.stats = {
            "atlas_processed": 0,
            "expression_exported": 0,
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

            # 获取当前 Bundle 的 Container Path
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

            # SpriteAtlas索引
            all_sprites = {}
            for obj in env.objects:
                if obj.type == ClassIDType.Sprite:
                    try:
                        sprite = obj.read()
                        all_sprites[obj.path_id] = sprite
                    except:
                        pass

            # 从 Prefab 的 RectTransform 层级提取 FaceContent 的位置信息
            face_info = self._extract_face_layout(env)

            # 读取 SpriteAtlas, 提取里面的信息
            for obj in env.objects:
                if obj.type == ClassIDType.SpriteAtlas:
                    self._process_sprite_atlas(
                        obj, env, all_sprites, best_primary_key, face_info
                    )

        print(f"\n导出全部完成！")
        print(f"导出目录总数: {len(self.stats['exported_dirs'])}")
        print(f"处理图集数量: {self.stats['atlas_processed']}")
        print(f"导出表情拼图: {self.stats['expression_exported']}")

    def _extract_face_layout(self, env):
        """从 Prefab 的 RectTransform 层级中提取 FaceContent 相对于 Body 的坐标和尺寸。

        层级结构一般为:
          Body (m_AnchoredPosition, m_SizeDelta)
            └── FaceContent (m_AnchoredPosition, m_SizeDelta)
                  ├── Normal (stretch fill)
                  ├── Anger (stretch fill) ...

        Returns:
            dict: {
                "face_anchor_x": float,  # FaceContent 相对 Body 中心的 X 偏移
                "face_anchor_y": float,  # FaceContent 相对 Body 中心的 Y 偏移
                "face_w": float,         # FaceContent 尺寸宽
                "face_h": float,         # FaceContent 尺寸高
                "body_w": float,         # Body RectTransform 宽
                "body_h": float,         # Body RectTransform 高
            } 或 None
        """
        # 收集所有对象按 path_id 索引
        objects_by_id = {}
        for obj in env.objects:
            objects_by_id[obj.path_id] = obj

        # 收集 GameObject name -> path_id 映射
        go_names = {}
        for obj in env.objects:
            if obj.type == ClassIDType.GameObject:
                try:
                    go = obj.read()
                    go_names[obj.path_id] = getattr(go, "m_Name", "")
                except:
                    pass

        # 遍历所有 RectTransform，找到 FaceContent 和 Body
        rt_data = {}  # go_name -> {go_id, anchored_pos, size_delta, parent_go_name}
        for obj in env.objects:
            type_id = obj.type.value if hasattr(obj.type, "value") else obj.type
            if obj.type == ClassIDType.RectTransform or type_id == 224:
                try:
                    rt = obj.read()
                    go_ref = getattr(rt, "m_GameObject", None)
                    go_id = None
                    if hasattr(go_ref, "m_PathID"):
                        go_id = go_ref.m_PathID
                    elif isinstance(go_ref, dict):
                        go_id = go_ref.get("m_PathID", 0)

                    go_name = go_names.get(go_id, "")
                    if not go_name:
                        continue

                    anchored_pos = getattr(rt, "m_AnchoredPosition", None)
                    size_delta = getattr(rt, "m_SizeDelta", None)

                    ax = (
                        anchored_pos.x
                        if anchored_pos and hasattr(anchored_pos, "x")
                        else 0
                    )
                    ay = (
                        anchored_pos.y
                        if anchored_pos and hasattr(anchored_pos, "y")
                        else 0
                    )
                    sw = size_delta.x if size_delta and hasattr(size_delta, "x") else 0
                    sh = size_delta.y if size_delta and hasattr(size_delta, "y") else 0

                    # 获取父节点名称
                    parent_name = ""
                    father = getattr(rt, "m_Father", None)
                    if father:
                        father_id = None
                        if hasattr(father, "m_PathID"):
                            father_id = father.m_PathID
                        elif isinstance(father, dict):
                            father_id = father.get("m_PathID")
                        if father_id and father_id in objects_by_id:
                            try:
                                father_rt = objects_by_id[father_id].read()
                                father_go_ref = getattr(father_rt, "m_GameObject", None)
                                father_go_id = None
                                if hasattr(father_go_ref, "m_PathID"):
                                    father_go_id = father_go_ref.m_PathID
                                elif isinstance(father_go_ref, dict):
                                    father_go_id = father_go_ref.get("m_PathID")
                                parent_name = go_names.get(father_go_id, "")
                            except:
                                pass

                    rt_data[go_name] = {
                        "ax": ax,
                        "ay": ay,
                        "sw": sw,
                        "sh": sh,
                        "parent": parent_name,
                    }
                except:
                    pass

        # 提取关键信息：找 FaceContent（父节点是 Body）
        face = rt_data.get("FaceContent")
        body = rt_data.get("Body")

        if face and body and face["parent"] == "Body":
            result = {
                "face_anchor_x": face["ax"],
                "face_anchor_y": face["ay"],
                "face_w": face["sw"],
                "face_h": face["sh"],
                "body_w": body["sw"],
                "body_h": body["sh"],
            }
            return result

        return None

    def _process_sprite_atlas(self, obj, env, all_sprites, best_primary_key, face_info):
        try:
            atlas = obj.read()
            atlas_name = getattr(atlas, "m_Name", "UnknownAtlas")

            # 还原 Container Path
            primary_key = None
            container = getattr(atlas, "container", getattr(atlas, "m_Container", ""))
            if container:
                primary_key = self._find_primary_key(container)
            if not primary_key:
                primary_key = best_primary_key

            export_rel_dir = (
                self._path_to_dir(primary_key) if primary_key else "Uncategorized"
            )
            output_path = self.output_dir / export_rel_dir
            output_path.mkdir(parents=True, exist_ok=True)
            self.stats["exported_dirs"].add(str(export_rel_dir))

            # 收集该图集下包含的所有精灵图
            sprites_in_atlas = []
            if hasattr(atlas, "m_PackedSprites"):
                for pptr in atlas.m_PackedSprites:
                    if pptr.m_PathID != 0:
                        if pptr.m_PathID in all_sprites:
                            sprites_in_atlas.append(all_sprites[pptr.m_PathID])
                        else:
                            resolved = pptr.resolve()
                            if resolved:
                                sprites_in_atlas.append(resolved.read())

            if not sprites_in_atlas:
                return

            print(f"处理图集: {atlas_name} -> {export_rel_dir}")

            # 解析所有 Sprite 信息
            sprite_map = {}  # name -> {sprite data}
            for sprite in sprites_in_atlas:
                name = getattr(sprite, "m_Name", "unknown")
                if name == "_stand1":
                    continue  # 跳过通用底标

                if not hasattr(sprite, "image") or sprite.image is None:
                    continue

                # 获取 Sprite 原始 Rect 尺寸（未裁剪）
                m_rect = getattr(sprite, "m_Rect", None)
                rect_w = int(m_rect.width) if m_rect and hasattr(m_rect, "width") else 0
                rect_h = (
                    int(m_rect.height) if m_rect and hasattr(m_rect, "height") else 0
                )

                # m_RD.textureRectOffset = 裁剪图在原始 Rect 中的偏移
                tro_x, tro_y = 0.0, 0.0
                if hasattr(sprite, "m_RD"):
                    rd = sprite.m_RD
                    if hasattr(rd, "textureRectOffset"):
                        tro_x = rd.textureRectOffset.x
                        tro_y = rd.textureRectOffset.y

                img = sprite.image

                sprite_map[name] = {
                    "name": name,
                    "img": img,
                    "img_w": img.size[0],
                    "img_h": img.size[1],
                    "rect_w": rect_w,
                    "rect_h": rect_h,
                    "tro_x": tro_x,
                    "tro_y": tro_y,
                }

            if not sprite_map:
                return

            # 分离 Body 和 Expression 表情
            body_data = None
            expression_list = []

            for name, data in sprite_map.items():
                name_lower = name.lower()
                if "body" in name_lower or "base" in name_lower:
                    if not body_data or (
                        data["img_w"] * data["img_h"]
                        > body_data["img_w"] * body_data["img_h"]
                    ):
                        if body_data:
                            expression_list.append(body_data)
                        body_data = data
                    else:
                        expression_list.append(data)
                else:
                    expression_list.append(data)

            if not body_data:
                print(f"未找到 Body 图层，跳过")
                return

            # Body 图像就是画布底图
            body_img = body_data["img"]
            canvas_w, canvas_h = body_img.size

            print(f"Body 图像尺寸: {canvas_w}x{canvas_h}")

            if not expression_list:
                print(f"未找到任何表情图层")
                return

            # 计算表情在 Body 画布上的粘贴坐标
            #
            # 数据来源：Prefab 中 FaceContent 的 RectTransform
            #   面部区域锚点 (face_anchor_x, face_anchor_y) 是相对于 Body 的中心坐标 (Unity 坐标系)
            #   面部区域尺寸 (face_w, face_h)
            #   Body 的 RectTransform 尺寸 (body_w, body_h)
            #
            # 需要将 Unity 的锚点坐标转换为 PIL 的像素坐标（左上角为原点）

            if face_info:
                face_ax = face_info["face_anchor_x"]
                face_ay = face_info["face_anchor_y"]
                face_w = (
                    face_info["face_w"]
                    if face_info["face_w"] > 0
                    else expression_list[0]["rect_w"]
                )
                face_h = (
                    face_info["face_h"]
                    if face_info["face_h"] > 0
                    else expression_list[0]["rect_h"]
                )
                body_rt_w = face_info["body_w"]
                body_rt_h = face_info["body_h"]

                # RectTransform -> 像素坐标的缩放比例
                # Body RT 尺寸与实际 Body 图像尺寸的比率
                scale_x = canvas_w / body_rt_w if body_rt_w > 0 else 1.0
                scale_y = canvas_h / body_rt_h if body_rt_h > 0 else 1.0

                # 将 FaceContent 的锚点从 Unity 坐标（中心为原点，Y 朝上）转为像素坐标（左上为原点）
                # 在 Unity 中, Body 中心是 (0,0), FaceContent 在 (face_ax, face_ay)
                # FaceContent 的 pivot 是 (0.5, 0.5), 所以其中心在锚点位置
                # 转像素坐标:
                #   pixel_center_x = canvas_w/2 + face_ax * scale_x
                #   pixel_center_y = canvas_h/2 - face_ay * scale_y   (Y 轴翻转)
                # FaceContent 左上角:
                #   pixel_x = pixel_center_x - (face_w * scale_x) / 2
                #   pixel_y = pixel_center_y - (face_h * scale_y) / 2

                face_pixel_w = face_w * scale_x
                face_pixel_h = face_h * scale_y

                face_center_px = canvas_w / 2 + face_ax * scale_x
                face_center_py = canvas_h / 2 - face_ay * scale_y

                face_left = face_center_px - face_pixel_w / 2
                face_top = face_center_py - face_pixel_h / 2

                print(
                    f"FaceContent 锚点: ({face_ax}, {face_ay}), 尺寸: {face_w}x{face_h}"
                )
                print(f"缩放: ({scale_x:.4f}, {scale_y:.4f})")
                print(
                    f"FaceContent 像素位置: 左上({face_left:.1f}, {face_top:.1f}), 尺寸({face_pixel_w:.1f}x{face_pixel_h:.1f})"
                )
            else:
                print(f"未找到 FaceContent 布局信息，直接使用 textureRectOffset")
                # 直接使用 textureRectOffset
                face_left = 0
                face_top = 0
                face_pixel_w = canvas_w
                face_pixel_h = canvas_h
                face_w = canvas_w
                face_h = canvas_h

            # 遍历并导出每个表情的完整合成图
            for expr_data in expression_list:
                # 复制 Body 画布
                canvas = body_img.copy()

                # 将表情裁剪图还原到其原始 Rect 尺寸（含透明边距）
                expr_rect_w = (
                    expr_data["rect_w"]
                    if expr_data["rect_w"] > 0
                    else expr_data["img_w"]
                )
                expr_rect_h = (
                    expr_data["rect_h"]
                    if expr_data["rect_h"] > 0
                    else expr_data["img_h"]
                )

                # 创建原始 Rect 大小的透明画布
                expr_full = Image.new("RGBA", (expr_rect_w, expr_rect_h), (0, 0, 0, 0))
                tro_x = int(round(expr_data["tro_x"]))
                # textureRectOffset 的 Y 是 Unity 坐标（bottom-up），需翻转
                tro_y_flipped = (
                    expr_rect_h - int(round(expr_data["tro_y"])) - expr_data["img_h"]
                )
                tro_y_flipped = max(0, tro_y_flipped)
                tro_x = max(0, tro_x)

                expr_full.alpha_composite(expr_data["img"], dest=(tro_x, tro_y_flipped))

                # 将还原后的表情缩放到 FaceContent 在画布上的实际像素尺寸
                target_fw = int(round(face_pixel_w))
                target_fh = int(round(face_pixel_h))
                if target_fw > 0 and target_fh > 0:
                    expr_resized = expr_full.resize(
                        (target_fw, target_fh), Image.LANCZOS
                    )
                else:
                    expr_resized = expr_full

                # 计算粘贴到 Body 画布上的 FaceContent 位置
                paste_x = int(round(face_left))
                paste_y = int(round(face_top))

                # 越界保护
                paste_x = max(0, min(paste_x, canvas_w - expr_resized.size[0]))
                paste_y = max(0, min(paste_y, canvas_h - expr_resized.size[1]))

                # 将 expr_resized 直接以 Alpha 混合模式贴到 canvas 的 (paste_x, paste_y) 处
                canvas.alpha_composite(expr_resized, dest=(paste_x, paste_y))

                # 命名格式: SpriteAtlas名字_表情名.png
                expr_save_name = f"{atlas_name}_{expr_data['name']}.png"
                canvas.save(output_path / expr_save_name)
                self.stats["expression_exported"] += 1
                print(f"  └─ [表情合成] {expr_save_name}")

            self.stats["atlas_processed"] += 1

        except Exception as e:
            import traceback

            print(f"处理 SpriteAtlas 失败: {e}")
            traceback.print_exc()


def main():
    if len(sys.argv) < 2:
        print("用法: python script.py <Bundle文件夹路径>")
        sys.exit(1)

    bundle_dir = sys.argv[1]

    if not os.path.isdir(bundle_dir):
        print(f"错误: 未找到目录: {bundle_dir}")
        sys.exit(1)

    try:
        extractor = SpriteAtlasExtractor(bundle_dir)
        extractor.export_assets()
    except Exception as e:
        print(f"运行错误: {e}")
        import traceback

        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
