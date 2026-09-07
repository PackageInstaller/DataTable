import os
import sys
import re
import base64
import hmac
import time
import hashlib
import urllib.parse
import json
import struct
import threading
import requests
import msgpack
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from typing import Any, Dict, List, Optional, Tuple, Union
from PIL import Image
from enum import IntEnum
from queue import Queue
from dataclasses import dataclass
import UnityPy
from AbyssSchema import DATABASE_SCHEMA
from UnityPy.enums import ClassIDType
from rich.console import Console
from rich.progress import (
    Progress,
    SpinnerColumn,
    BarColumn,
    TextColumn,
    MofNCompleteColumn,
    TimeRemainingColumn,
)

VERSION_URL = "https://api.abyss-prod-r18.dotabyss.dmmgames.com/version"
APP_KEY_B64 = "b5RHgCQ66Glhlru9WV5Koc5SulPDiWZ44K0+dCeVTn0="
APP_KEY_BYTES = base64.b64decode(APP_KEY_B64)
ASSET_PREFIX = "r18-only-charastand_assets"
REMOTE_PATH_KEY = (
    "{Absf.Asset.AddressableAssets.AddressablesProfileDefine.RemoteLoadPath}"
)
SECURE_LINK_KEY = "ulTn7l2O7kctUTYkI0qsM9YuEnrj6isy"
MASTER_BASE_URL = (
    "https://api.abyss-prod-r18.dotabyss.dmmgames.com/data/"
)
MANIFEST_NAME = ".export_manifest.json"
MANIFEST_VERSION = 5
MAX_THREADS = 16
RETRY_COUNT = 5
ATLAS_PREFIX = "NovelCharaStand"
_INVALID_FS = re.compile(r'[<>:"/\\|?*\x00-\x1f]')
_LAYER_BACK = re.compile(r"^(backcontent|backeffect)", re.I)
_LAYER_FRONT = re.compile(r"^(frontcontent|glasses)", re.I)
console = Console()


class CatalogFileType(IntEnum):
    """Catalog文件类型枚举"""

    NONE = 0
    JSON = 1
    BINARY = 2


class ObjectType(IntEnum):
    """序列化对象类型枚举（JSON格式）"""

    AsciiString = 0
    UnicodeString = 1
    UInt16 = 2
    UInt32 = 3
    Int32 = 4
    Hash128 = 5
    Type = 6
    JsonObject = 7


@dataclass
class SerializedType:
    """序列化类型"""

    assembly_name: str = ""
    class_name: str = ""

    def to_dict(self) -> Dict[str, str]:
        return {"assembly_name": self.assembly_name, "class_name": self.class_name}

    def get_assembly_short_name(self) -> str:
        """获取程序集短名称（逗号前的部分）"""
        if "," not in self.assembly_name:
            return self.assembly_name
        return self.assembly_name.split(",", 1)[0]

    def get_match_name(self) -> str:
        """获取匹配名称（用于类型判断）"""
        return f"{self.get_assembly_short_name()}; {self.class_name}"


@dataclass
class ObjectInitializationData:
    """对象初始化数据"""

    id: str = ""
    object_type: Optional[SerializedType] = None
    data: str = ""

    def to_dict(self) -> Dict[str, Any]:
        return {
            "id": self.id,
            "data": self.data,
            "object_type": self.object_type.to_dict() if self.object_type else None,
        }


@dataclass
class CommonInfo:
    """AssetBundleRequestOptions的通用信息"""

    timeout: int = 0
    redirect_limit: int = 0
    retry_count: int = 0
    asset_load_mode: int = (
        0  # 0=RequestedAssetAndDependencies, 1=AllPackedAssetsAndDependencies
    )
    chunked_transfer: bool = False
    use_crc_for_cached_bundle: bool = False
    use_unity_web_request_for_local_bundles: bool = False
    clear_other_cached_versions_when_loaded: bool = False
    version: int = 3  # 用于判断写入时包含哪些字段

    def to_dict(self) -> Dict[str, Any]:
        return {
            "timeout": self.timeout,
            "redirect_limit": self.redirect_limit,
            "retry_count": self.retry_count,
            "asset_load_mode": self.asset_load_mode,
            "chunked_transfer": self.chunked_transfer,
            "use_crc_for_cached_bundle": self.use_crc_for_cached_bundle,
            "use_unity_web_request_for_local_bundles": self.use_unity_web_request_for_local_bundles,
            "clear_other_cached_versions_when_loaded": self.clear_other_cached_versions_when_loaded,
            "version": self.version,
        }


@dataclass
class AssetInfo:
    """资产信息（ResourceLocation）"""

    internal_id: str
    provider_id: str
    primary_key: str  # 唯一标识
    dependency_hash_code: int = 0
    dependency_key: Any = None  # 可以是任意类型：字符串、数字等
    dependencies: Optional[List["AssetInfo"]] = None
    bundle_name: str = ""
    bundle_size: int = 0
    crc: str = ""
    hash: str = ""
    resource_type: Optional[SerializedType] = None
    data: Optional[Dict[str, Any]] = None
    hash_code: int = 0
    common_info: Optional[CommonInfo] = None  # AssetBundleRequestOptions的CommonInfo


class BinaryReader:
    """二进制读取器"""

    def __init__(self, data: bytes):
        self.data = data
        self.position = 0
        self.version = 1
        self.string_cache: Dict[int, str] = {}
        self.offset_cache: Dict[int, List[int]] = {}
        self.resource_cache: Dict[int, str] = {}

    @property
    def pos(self) -> int:
        return self.position

    @pos.setter
    def pos(self, value: int):
        self.position = value

    def read(self, length: int) -> bytes:
        """读取指定长度的字节"""
        result = self.data[self.position : self.position + length]
        self.position += length
        return result

    @property
    def u8(self) -> int:
        """读取无符号8位整数"""
        return self.read(1)[0]

    @property
    def u16(self) -> int:
        """读取无符号16位整数"""
        return struct.unpack("<H", self.read(2))[0]

    @property
    def u32(self) -> int:
        """读取无符号32位整数"""
        return struct.unpack("<I", self.read(4))[0]

    @property
    def i32(self) -> int:
        """读取有符号32位整数"""
        return struct.unpack("<i", self.read(4))[0]

    @property
    def i64(self) -> int:
        """读取有符号64位整数"""
        return struct.unpack("<q", self.read(8))[0]

    @property
    def bool_val(self) -> bool:
        """读取布尔值"""
        return self.u8 != 0

    def str(self, length: int, encoding: str = "utf-8") -> str:
        """读取指定长度的字符串"""
        return self.read(length).decode(encoding, errors="ignore")

    def read_basic_string(self, offset: int, unicode: bool) -> str:
        """读取基本字符串"""
        self.pos = offset - 4
        length = self.i32
        data = self.read(length)
        return data.decode("utf-16le" if unicode else "ascii", errors="ignore")

    def read_dynamic_string(self, offset: int, unicode: bool, sep: str) -> str:
        """读取动态字符串"""
        self.pos = offset
        parts = []

        while True:
            part_string_offset = self.u32
            next_part_offset = self.u32
            parts.append(self.read_encoded_string(part_string_offset))

            if next_part_offset == 0xFFFFFFFF:
                break
            self.pos = next_part_offset

        if len(parts) == 1:
            return parts[0]

        return sep.join(parts if self.version <= 1 else reversed(parts))

    def read_encoded_string(
        self, encoded_offset: int, sep: str = "\0"
    ) -> Optional[str]:
        """读取编码字符串"""
        if encoded_offset == 0xFFFFFFFF or encoded_offset == 0xFFFFFFFE:
            return None

        if encoded_offset in self.string_cache:
            return self.string_cache[encoded_offset]

        unicode = (encoded_offset & 0x80000000) != 0
        dynamic_string = (encoded_offset & 0x40000000) != 0 and sep != "\0"
        offset = encoded_offset & 0x3FFFFFFF

        if dynamic_string:
            result = self.read_dynamic_string(offset, unicode, sep)
        else:
            result = self.read_basic_string(offset, unicode)

        self.string_cache[encoded_offset] = result
        return result

    def read_offset_array(self, offset: int) -> List[int]:
        """读取偏移数组"""
        if offset == 0xFFFFFFFF:
            return []

        if offset in self.offset_cache:
            return self.offset_cache[offset]

        self.pos = offset - 4
        byte_size = self.i32

        if byte_size % 4 != 0:
            raise ValueError("数组大小必须是4的倍数")

        elem_count = byte_size // 4
        result = [self.u32 for _ in range(elem_count)]

        self.offset_cache[offset] = result
        return result

    def read_serialized_type(self, offset: int) -> SerializedType | None:
        """读取序列化类型"""
        if offset == 0xFFFFFFFF:
            return None

        self.pos = offset
        assembly_name_offset = self.u32
        class_name_offset = self.u32

        return SerializedType(
            assembly_name=self.read_encoded_string(assembly_name_offset, ".") or "",
            class_name=self.read_encoded_string(class_name_offset, ".") or "",
        )

    def read_object_initialization_data(self, offset: int) -> ObjectInitializationData:
        """读取对象初始化数据"""
        if offset == 0xFFFFFFFF:
            return ObjectInitializationData()

        self.pos = offset
        id_offset = self.u32
        object_type_offset = self.u32
        data_offset = self.u32

        return ObjectInitializationData(
            id=self.read_encoded_string(id_offset) or "",
            data=self.read_encoded_string(data_offset) or "",
            object_type=self.read_serialized_type(object_type_offset),
        )

    def read_hash128(self, offset: int) -> str:
        """读取Hash128，返回hex字符串
        使用小端序打包 4 个 uint32
        """
        if offset == 0 or offset == 0xFFFFFFFF:
            return ""

        self.pos = offset
        v0 = self.u32
        v1 = self.u32
        v2 = self.u32
        v3 = self.u32

        return struct.pack("<IIII", v0, v1, v2, v3).hex()

    def read_common_info(self, offset: int) -> Optional[CommonInfo]:
        """读取CommonInfo"""
        if offset == 0 or offset == 0xFFFFFFFF:
            return None

        self.pos = offset
        timeout = struct.unpack("<h", self.read(2))[0]
        redirect_limit = self.u8
        retry_count = self.u8
        flags = self.i32

        return CommonInfo(
            timeout=timeout,
            redirect_limit=redirect_limit,
            retry_count=retry_count,
            asset_load_mode=flags & 1,
            chunked_transfer=(flags & 2) != 0,
            use_crc_for_cached_bundle=(flags & 4) != 0,
            use_unity_web_request_for_local_bundles=(flags & 8) != 0,
            clear_other_cached_versions_when_loaded=(flags & 16) != 0,
            version=3,
        )

    def read_asset_bundle_request_options(self, offset: int) -> Dict[str, Any]:
        """读取AssetBundleRequestOptions"""
        self.pos = offset
        hash_offset = self.u32
        bundle_name_offset = self.u32
        crc = self.u32
        bundle_size = self.u32
        common_info_offset = self.u32
        hash_value = self.read_hash128(hash_offset)
        common_info = self.read_common_info(common_info_offset)

        return {
            "bundle_name": self.read_encoded_string(bundle_name_offset, "_") or "",
            "bundle_size": bundle_size,
            "crc": f"0x{crc:08x}",
            "hash": hash_value,
            "common_info": common_info,
        }

    def decode_object(self, offset: int) -> Any:
        """解码对象（V2格式）"""
        if offset == 0xFFFFFFFF:
            return None

        self.pos = offset
        type_name_offset = self.u32
        object_offset = self.u32

        is_default_object = object_offset == 0xFFFFFFFF

        if type_name_offset == 0:
            return None

        serialized_type = self.read_serialized_type(type_name_offset)
        if not serialized_type:
            return None

        match_name = serialized_type.get_match_name()

        if match_name == "mscorlib; System.Int32":
            if is_default_object:
                return 0
            self.pos = object_offset
            return self.i32

        elif match_name == "mscorlib; System.Int64":
            if is_default_object:
                return 0
            self.pos = object_offset
            return self.i64

        elif match_name == "mscorlib; System.Boolean":
            if is_default_object:
                return False
            self.pos = object_offset
            return self.bool_val

        elif match_name == "mscorlib; System.String":
            if is_default_object:
                return ""
            self.pos = object_offset
            string_offset = self.u32
            sep = self.str(2, "utf-16le")
            return self.read_encoded_string(string_offset, sep)

        elif match_name == "UnityEngine.CoreModule; UnityEngine.Hash128":
            if is_default_object:
                return None
            return self.read_hash128(object_offset)

        elif (
            match_name
            == "Unity.ResourceManager; UnityEngine.ResourceManagement.ResourceProviders.AssetBundleRequestOptions"
        ):
            if is_default_object:
                return None
            return self.read_asset_bundle_request_options(object_offset)

        else:
            return None


class UnityCatalogReader:
    """Unity Addressables Catalog读取器"""

    def __init__(self, catalog_data: Union[str, bytes]):
        """
        初始化catalog读取器

        Args:
            catalog_data: catalog文件路径（str）或字节流数据（bytes），支持JSON和二进制格式
        """
        self.catalog_path = catalog_data if isinstance(catalog_data, str) else None
        self.catalog_bytes = catalog_data if isinstance(catalog_data, bytes) else None
        self.locator_id = ""
        self.build_result_hash = ""
        self.version = 1
        self.instance_provider_data: Optional[ObjectInitializationData] = None
        self.scene_provider_data: Optional[ObjectInitializationData] = None
        self.resource_provider_data: List[ObjectInitializationData] = []
        self.resources: Dict[Any, List[AssetInfo]] = {}

        file_type = self._detect_file_type()

        if file_type == CatalogFileType.JSON:
            print("json格式catalog文件")
            self._load_json_catalog()
        elif file_type == CatalogFileType.BINARY:
            print("二进制格式catalog文件")
            self._load_binary_catalog()
        else:
            raise ValueError(f"不支持的catalog文件类型")

    def _detect_file_type(self) -> CatalogFileType:
        """检测catalog文件类型"""
        try:
            if self.catalog_bytes:
                if len(self.catalog_bytes) < 4:
                    return CatalogFileType.NONE
                magic = struct.unpack("<I", self.catalog_bytes[:4])[0]
                if magic == 0x0DE38942 or magic == 0x4289E30D:
                    return CatalogFileType.BINARY
                else:
                    return CatalogFileType.JSON
            else:
                with open(self.catalog_path, "rb") as f:
                    data = f.read(4)
                    magic = struct.unpack("<I", data)[0]
                    if magic == 0x0DE38942 or magic == 0x4289E30D:
                        return CatalogFileType.BINARY
                    else:
                        return CatalogFileType.JSON

        except Exception:
            return CatalogFileType.NONE

    def _load_json_catalog(self):
        """加载JSON格式的catalog文件"""
        if self.catalog_bytes:
            json_str = self.catalog_bytes.decode("utf-8")
            catalog_data = json.loads(json_str)
        else:
            with open(self.catalog_path, "r", encoding="utf-8") as f:
                catalog_data = json.load(f)

        self.locator_id = catalog_data.get("m_LocatorId", "")
        self.build_result_hash = catalog_data.get("m_BuildResultHash", "")
        self.version = 0

        print(f"Catalog版本: {self.version}")
        print(f"定位器ID: {self.locator_id}")

        self._parse_json_provider_data(catalog_data)
        self._parse_json_resources(catalog_data)

    def _parse_json_provider_data(self, catalog_data: Dict[str, Any]):
        """解析JSON格式的Provider数据"""
        instance_data = catalog_data.get("m_InstanceProviderData", {})
        if instance_data:
            obj_type_data = instance_data.get("m_ObjectType", {})
            self.instance_provider_data = ObjectInitializationData(
                id=instance_data.get("m_Id", ""),
                object_type=(
                    SerializedType(
                        assembly_name=obj_type_data.get("m_AssemblyName", ""),
                        class_name=obj_type_data.get("m_ClassName", ""),
                    )
                    if obj_type_data
                    else None
                ),
                data=instance_data.get("m_Data", ""),
            )
        scene_data = catalog_data.get("m_SceneProviderData", {})
        if scene_data:
            obj_type_data = scene_data.get("m_ObjectType", {})
            self.scene_provider_data = ObjectInitializationData(
                id=scene_data.get("m_Id", ""),
                object_type=(
                    SerializedType(
                        assembly_name=obj_type_data.get("m_AssemblyName", ""),
                        class_name=obj_type_data.get("m_ClassName", ""),
                    )
                    if obj_type_data
                    else None
                ),
                data=scene_data.get("m_Data", ""),
            )

        resource_providers = catalog_data.get("m_ResourceProviderData", [])
        for provider_data in resource_providers:
            obj_type_data = provider_data.get("m_ObjectType", {})
            self.resource_provider_data.append(
                ObjectInitializationData(
                    id=provider_data.get("m_Id", ""),
                    object_type=(
                        SerializedType(
                            assembly_name=obj_type_data.get("m_AssemblyName", ""),
                            class_name=obj_type_data.get("m_ClassName", ""),
                        )
                        if obj_type_data
                        else None
                    ),
                    data=provider_data.get("m_Data", ""),
                )
            )

    def _parse_json_resources(self, catalog_data: Dict[str, Any]):
        """解析JSON格式的资源数据"""
        key_data = base64.b64decode(catalog_data["m_KeyDataString"])
        entry_data = base64.b64decode(catalog_data["m_EntryDataString"])
        extra_data = base64.b64decode(catalog_data["m_ExtraDataString"])
        bucket_data = base64.b64decode(catalog_data["m_BucketDataString"])

        kds = BinaryReader(key_data)
        eds = BinaryReader(entry_data)
        xds = BinaryReader(extra_data)
        bds = BinaryReader(bucket_data)

        bucket_count = bds.u32
        buckets = []
        for _ in range(bucket_count):
            offset = bds.i32
            entry_count = bds.i32
            entries = [bds.i32 for _ in range(entry_count)]
            buckets.append({"offset": offset, "entries": entries})

        key_count = kds.u32
        keys = []
        for i in range(key_count):
            if i < len(buckets):
                kds.pos = buckets[i]["offset"]

            obj_type = kds.u8
            if obj_type == 0:  # ASCII string
                keys.append(kds.str(kds.u32))
            elif obj_type == 1:  # Unicode string
                keys.append(kds.str(kds.u32, "utf-16le"))
            elif obj_type in (2, 3, 4):  # 数字类型
                keys.append(str(kds.u32 if obj_type in (2, 3) else kds.i32))
            else:
                keys.append(f"key_{len(keys)}")

        internal_ids = catalog_data["m_InternalIds"]
        internal_id_prefixes = catalog_data.get("m_InternalIdPrefixes", [])
        provider_ids = catalog_data["m_ProviderIds"]

        resource_types = []
        for rt_data in catalog_data.get("m_resourceTypes", []):
            resource_types.append(
                SerializedType(
                    assembly_name=rt_data.get("m_AssemblyName", ""),
                    class_name=rt_data.get("m_ClassName", ""),
                )
            )

        legacy_keys = catalog_data.get("m_Keys", None)

        entry_count = eds.u32
        print(f"找到 {entry_count} 个资源组")

        locations = []
        for i in range(entry_count):
            ii = eds.i32  # internal_id index
            pi = eds.i32  # provider_id index
            dki = eds.i32  # dependency_key index
            dh = eds.i32  # dependency hash
            di = eds.i32  # data index
            pk = eds.i32  # primary_key index
            rt = eds.i32  # resource_type index

            obj_data = None
            if di >= 0:
                xds.pos = di
                obj_type = xds.u8
                if obj_type == 7:  # JSON object
                    assembly_name = xds.str(xds.u8)
                    class_name = xds.str(xds.u8)
                    json_str = xds.str(xds.i32, "utf-16le")
                    try:
                        obj_data = json.loads(json_str)
                    except:
                        obj_data = {}
            internal_id = internal_ids[ii] if ii < len(internal_ids) else ""
            if internal_id_prefixes and "#" in internal_id:
                split_idx = internal_id.index("#")
                try:
                    prefix_idx = int(internal_id[:split_idx])
                    if prefix_idx < len(internal_id_prefixes):
                        internal_id = (
                            internal_id_prefixes[prefix_idx]
                            + internal_id[split_idx + 1 :]
                        )
                except:
                    pass

            provider_id = provider_ids[pi] if pi < len(provider_ids) else ""
            if legacy_keys:
                primary_key = legacy_keys[pk] if pk < len(legacy_keys) else f"key_{i}"
            else:
                primary_key = keys[pk] if pk < len(keys) else f"key_{i}"

            dependency_key = keys[dki] if dki >= 0 and dki < len(keys) else None
            resource_type = (
                resource_types[rt] if rt >= 0 and rt < len(resource_types) else None
            )

            hash_code = hash(internal_id) * 31 + hash(provider_id)

            asset = AssetInfo(
                internal_id=internal_id,
                provider_id=provider_id,
                primary_key=primary_key,
                dependency_hash_code=dh,
                dependency_key=dependency_key,
                resource_type=resource_type,
                hash_code=hash_code,
            )
            if obj_data and isinstance(obj_data, dict):
                asset.bundle_name = obj_data.get("m_BundleName", "")
                asset.bundle_size = obj_data.get("m_BundleSize", 0)
                asset.crc = f"0x{obj_data.get('m_Crc', 0):08x}"
                asset.hash = obj_data.get("m_Hash", "")
                asset.data = obj_data
                # CommonInfo version 判断逻辑
                if obj_data.get("m_ChunkedTransfer") is None:
                    common_info_version = 1
                elif (
                    obj_data.get("m_AssetLoadMode") is None
                    and obj_data.get("m_UseCrcForCachedBundles") is None
                    and obj_data.get("m_UseUWRForLocalBundles") is None
                    and obj_data.get("m_ClearOtherCachedVersionsWhenLoaded") is None
                ):
                    common_info_version = 2
                else:
                    common_info_version = 3
                asset.common_info = CommonInfo(
                    timeout=obj_data.get("m_Timeout", 0),
                    redirect_limit=obj_data.get("m_RedirectLimit", 0),
                    retry_count=obj_data.get("m_RetryCount", 0),
                    asset_load_mode=obj_data.get("m_AssetLoadMode", 0),
                    chunked_transfer=obj_data.get("m_ChunkedTransfer", False),
                    use_crc_for_cached_bundle=obj_data.get(
                        "m_UseCrcForCachedBundles", False
                    ),
                    use_unity_web_request_for_local_bundles=obj_data.get(
                        "m_UseUWRForLocalBundles", False
                    ),
                    clear_other_cached_versions_when_loaded=obj_data.get(
                        "m_ClearOtherCachedVersionsWhenLoaded", False
                    ),
                    version=common_info_version,
                )

            locations.append(asset)

        self.resources = {}
        for i, bucket in enumerate(buckets):
            if i < len(keys):
                bucket_key = keys[i]
                bucket_locations = []
                for entry_idx in bucket["entries"]:
                    if entry_idx < len(locations):
                        bucket_locations.append(locations[entry_idx])
                if bucket_locations:
                    self.resources[bucket_key] = bucket_locations

        total_locations = sum(len(locs) for locs in self.resources.values())
        print(
            f"解析完成，共 {len(self.resources)} 个资源键，{total_locations} 个资源位置"
        )

    def _load_binary_catalog(self):
        """加载二进制格式的catalog文件"""
        if self.catalog_bytes:
            binary_data = self.catalog_bytes
        else:

            with open(self.catalog_path, "rb") as f:
                binary_data = f.read()

        reader = BinaryReader(binary_data)

        signature = reader.read(4)
        version = reader.u32

        if version not in (1, 2):
            raise ValueError(f"不支持的二进制版本: {version}")

        reader.version = version

        keys_offset = reader.u32
        id_offset = reader.u32
        instance_provider_offset = reader.u32
        scene_provider_offset = reader.u32
        init_objects_array_offset = reader.u32

        # 版本1的某些子版本没有BuildResultHashOffset
        if version == 1 and keys_offset == 32:
            build_result_hash_offset = 0xFFFFFFFF
        else:
            build_result_hash_offset = reader.u32

        self.locator_id = reader.read_encoded_string(id_offset) or ""
        self.build_result_hash = (
            reader.read_encoded_string(build_result_hash_offset) or ""
        )
        self.version = version

        print(f"Catalog版本: {version}")
        print(f"定位器ID: {self.locator_id}")

        self.instance_provider_data = reader.read_object_initialization_data(
            instance_provider_offset
        )
        self.scene_provider_data = reader.read_object_initialization_data(
            scene_provider_offset
        )

        resource_provider_offsets = reader.read_offset_array(init_objects_array_offset)
        self.resource_provider_data = []
        for rp_offset in resource_provider_offsets:
            self.resource_provider_data.append(
                reader.read_object_initialization_data(rp_offset)
            )

        self._parse_binary_resources(reader, keys_offset)

    def _decode_binary_object_v2(self, reader: BinaryReader, offset: int) -> Any:
        """解码二进制对象（V2格式），用于解码key等"""
        return reader.decode_object(offset)

    def _parse_binary_resources(self, reader: BinaryReader, keys_offset: int):
        key_location_offsets = reader.read_offset_array(keys_offset)
        total_groups = len(key_location_offsets) // 2
        print(f"找到 {total_groups} 个资源组")

        self.resources = {}
        total_locations = 0

        for i in range(0, len(key_location_offsets), 2):
            group_index = i // 2

            try:
                key_offset = key_location_offsets[i]
                location_list_offset = key_location_offsets[i + 1]

                key = self._decode_binary_object_v2(reader, key_offset)
                if key is None:
                    key = f"key_{group_index}"

                location_offsets = reader.read_offset_array(location_list_offset)
                locations = []

                for location_offset in location_offsets:
                    try:
                        location = self._read_binary_resource_location(
                            reader, location_offset
                        )
                        if location:
                            locations.append(location)
                    except Exception as e:
                        continue

                if locations:
                    self.resources[key] = locations
                    total_locations += len(locations)

            except Exception as e:
                print(f"处理资源组 {group_index} 失败: {e}")
                continue

        print(
            f"解析完成，共 {len(self.resources)} 个资源键，{total_locations} 个资源位置"
        )

    def _read_binary_resource_location(
        self, reader: BinaryReader, offset: int
    ) -> Optional[AssetInfo]:
        """读取二进制格式的资源位置，返回AssetInfo对象"""
        if offset in reader.resource_cache:
            return reader.resource_cache[offset]

        reader.pos = offset

        primary_key_offset = reader.u32
        internal_id_offset = reader.u32
        provider_id_offset = reader.u32
        dependencies_offset = reader.u32
        dependency_hash_code = reader.i32
        data_offset = reader.u32
        type_offset = reader.u32

        primary_key = (
            reader.read_encoded_string(primary_key_offset, "/") or f"res_{offset}"
        )
        internal_id = reader.read_encoded_string(internal_id_offset, "/") or ""
        provider_id = reader.read_encoded_string(provider_id_offset, ".") or ""
        resource_type = reader.read_serialized_type(type_offset)
        data = reader.decode_object(data_offset)
        hash_code = hash(internal_id) * 31 + hash(provider_id)

        asset = AssetInfo(
            internal_id=internal_id,
            provider_id=provider_id,
            primary_key=primary_key,
            dependency_hash_code=dependency_hash_code,
            resource_type=resource_type,
            hash_code=hash_code,
        )

        if data and isinstance(data, dict):
            asset.bundle_name = data.get("bundle_name", "")
            asset.bundle_size = data.get("bundle_size", 0)
            asset.crc = data.get("crc", "")
            asset.hash = data.get("hash", "")
            asset.common_info = data.get("common_info")
            asset.data = data

        if dependencies_offset != 0xFFFFFFFF:
            try:
                dependency_offsets = reader.read_offset_array(dependencies_offset)
                dependencies = []

                for dep_offset in dependency_offsets:
                    dep_asset = self._read_binary_resource_location(reader, dep_offset)
                    if dep_asset:
                        dependencies.append(dep_asset)

                asset.dependencies = dependencies if dependencies else None
                asset.dependency_key = None
            except Exception as e:
                pass

        reader.resource_cache[offset] = asset
        return asset

    def get_all_locations(self) -> List[AssetInfo]:
        """获取所有资源位置的扁平列表"""
        all_locations = []
        for locations in self.resources.values():
            all_locations.extend(locations)
        return all_locations

    def get_asset_list(self) -> List[Dict[str, Any]]:
        """获取详细的资产列表（扁平化）"""
        asset_list = []
        all_locations = self.get_all_locations()

        for asset in all_locations:
            data_dict = None
            if asset.data and isinstance(asset.data, dict):
                data_dict = asset.data.copy()
                if "common_info" in data_dict and isinstance(
                    data_dict["common_info"], CommonInfo
                ):
                    data_dict["common_info"] = data_dict["common_info"].to_dict()

            asset_info = {
                "internal_id": asset.internal_id,
                "provider_id": asset.provider_id,
                "primary_key": asset.primary_key,
                "dependency_hash_code": asset.dependency_hash_code,
                "dependency_key": (
                    str(asset.dependency_key)
                    if asset.dependency_key is not None
                    else None
                ),
                "bundle_name": asset.bundle_name,
                "bundle_size": asset.bundle_size,
                "crc": asset.crc,
                "hash": asset.hash,
                "hash_code": asset.hash_code,
                "resource_type": (
                    asset.resource_type.to_dict() if asset.resource_type else None
                ),
                "common_info": (
                    asset.common_info.to_dict() if asset.common_info else None
                ),
                "data": data_dict,
            }
            if asset.dependencies:
                asset_info["dependencies"] = [
                    {
                        "internal_id": dep.internal_id,
                        "provider_id": dep.provider_id,
                        "primary_key": dep.primary_key,
                    }
                    for dep in asset.dependencies
                ]

            asset_list.append(asset_info)

        return asset_list

    def get_resources_dict(self) -> Dict[str, List[Dict[str, Any]]]:
        """获取资源字典（保持key->locations结构）"""
        result = {}
        for key, locations in self.resources.items():
            key_str = str(key)
            result[key_str] = []

            for asset in locations:
                data_dict = None
                if asset.data and isinstance(asset.data, dict):
                    data_dict = asset.data.copy()
                    if "common_info" in data_dict and isinstance(
                        data_dict["common_info"], CommonInfo
                    ):
                        data_dict["common_info"] = data_dict["common_info"].to_dict()

                asset_info = {
                    "internal_id": asset.internal_id,
                    "provider_id": asset.provider_id,
                    "primary_key": asset.primary_key,
                    "dependency_hash_code": asset.dependency_hash_code,
                    "dependency_key": (
                        str(asset.dependency_key)
                        if asset.dependency_key is not None
                        else None
                    ),
                    "bundle_name": asset.bundle_name,
                    "bundle_size": asset.bundle_size,
                    "crc": asset.crc,
                    "hash": asset.hash,
                    "hash_code": asset.hash_code,
                    "resource_type": (
                        asset.resource_type.to_dict() if asset.resource_type else None
                    ),
                    "common_info": (
                        asset.common_info.to_dict() if asset.common_info else None
                    ),
                    "data": data_dict,
                }
                if asset.dependencies:
                    asset_info["dependencies"] = [
                        {
                            "internal_id": dep.internal_id,
                            "provider_id": dep.provider_id,
                            "primary_key": dep.primary_key,
                        }
                        for dep in asset.dependencies
                    ]

                result[key_str].append(asset_info)

        return result

    def export_to_json(
        self, output_path: str = "assets.json", flat_structure: bool = True
    ):
        """
        导出所有资产信息到JSON文件

        Args:
            output_path: 输出文件路径
            flat_structure: True=扁平化资产列表, False=保持key->locations结构
        """
        if flat_structure:
            all_assets = self.get_asset_list()
            assets_data = all_assets
        else:
            assets_data = self.get_resources_dict()
            all_assets = self.get_asset_list()

        provider_stats = {}
        for asset in all_assets:
            provider_type = (
                asset["provider_id"].split(".")[-1]
                if "." in asset["provider_id"]
                else asset["provider_id"]
            )
            provider_stats[provider_type] = provider_stats.get(provider_type, 0) + 1

        export_data = {
            "catalog_info": {
                "version": self.version,
                "locator_id": self.locator_id,
                "build_result_hash": self.build_result_hash,
                "total_resource_keys": len(self.resources),
                "total_locations": len(all_assets),
                "export_timestamp": __import__("datetime").datetime.now().isoformat(),
                "structure_type": "flat" if flat_structure else "grouped",
            },
            "provider_data": {
                "instance_provider": (
                    self.instance_provider_data.to_dict()
                    if self.instance_provider_data
                    else None
                ),
                "scene_provider": (
                    self.scene_provider_data.to_dict()
                    if self.scene_provider_data
                    else None
                ),
                "resource_providers": (
                    [rp.to_dict() for rp in self.resource_provider_data]
                    if self.resource_provider_data
                    else []
                ),
            },
            "statistics": {"provider_types": provider_stats},
            "assets" if flat_structure else "resources": assets_data,
        }
        with open(output_path, "w", encoding="utf-8") as f:
            json.dump(export_data, f, ensure_ascii=False, indent=2)

        print(f"已保存到{output_path}")
        return output_path

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

class SpriteAtlasExtractor:
    def __init__(self, bundle_dir: Optional[str] = None, threads: int = MAX_THREADS):
        self.script_dir = Path(os.path.dirname(os.path.abspath(__file__)))
        self.bundle_dir = Path(bundle_dir).resolve() if bundle_dir else self.script_dir / "downloads"
        self.output_dir = self.script_dir / "Painting"
        self.assets_json_path = self.script_dir / "catalog.json"
        self.master_data_path = self.script_dir / "MasterData.json"
        self.hash_file = self.script_dir / "catalog.hash"
        self.manifest_path = self.output_dir / MANIFEST_NAME
        self.threads = threads
        self._lock = threading.Lock()
        self.downloader = AbyssDownloader(threads=threads)
        self.catalog_hash = ""
        self.bg_to_meta: Dict[str, Dict[str, Any]] = {}
        self._char_g_codes: Dict[str, List[str]] = {}

        self.ensure_catalog()
        self.ensure_master_data()
        with open(self.assets_json_path, "r", encoding="utf-8") as f:
            self.assets_json = json.load(f)

        self.id_to_primary = {}
        self._build_lookups()
        self._build_char_name_lookup()
        self.manifest = self._load_manifest()
        self.stats = {
            "atlas_processed": 0,
            "expression_exported": 0,
            "exported_dirs": set(),
            "bundles_skipped": 0,
            "bundles_exported": 0,
        }

    def _resolve_base_url(self) -> str:
        if self.downloader.base_url:
            return self.downloader.base_url
        info = self.downloader.get_version_info()
        if not info:
            raise RuntimeError("获取版本信息失败")
        versions = info.get("versions", {})
        asset_ver = self.downloader._pick_version(
            versions, "AssetVersionWebDmmR18", default=None
        )
        client_ver = self.downloader._pick_version(
            versions, "ClientVersionWebDmmR18", default="1.0.0"
        ) or "1.0.0"
        if not asset_ver:
            raise RuntimeError("未能解析 AssetVersionWebDmmR18")
        self.client_ver_prefix = str(client_ver).split(".")[0]
        self.downloader.base_url = (
            "https://api.abyss-prod-r18.dotabyss.dmmgames.com/"
            f"resources/webgl/r18/aas/{asset_ver}/aa"
        )
        self.downloader.asset_ver = asset_ver
        return self.downloader.base_url

    def _parse_catalog_bin(self, bin_path: Path):
        console.print(f"[*] 正在解析 {bin_path.name} ...")
        reader = UnityCatalogReader(str(bin_path))
        reader.export_to_json(str(self.assets_json_path))
        console.print(f"[green][+] 已导出 {self.assets_json_path.name}[/green]")

    def ensure_catalog(self):
        """检测远程 catalog.hash，有变化则重下 bin 并重建 catalog.json。"""
        try:
            base_url = self._resolve_base_url()
            prefix = getattr(self, "client_ver_prefix", None)
            if not prefix:
                info = self.downloader.get_version_info()
                versions = (info or {}).get("versions", {})
                client_ver = self.downloader._pick_version(
                    versions, "ClientVersionWebDmmR18", default="1.0.0"
                ) or "1.0.0"
                prefix = str(client_ver).split(".")[0]
                self.client_ver_prefix = prefix

            hash_url = f"{base_url}/catalog_{prefix}.hash"
            console.print(f"[*] 检查 Catalog Hash: {hash_url}")
            resp = self.downloader.session.get(hash_url, timeout=15)
            resp.raise_for_status()
            current_hash = resp.text.strip()
            self.catalog_hash = current_hash
            console.print(f"[green][+] 当前 Hash: {current_hash}[/green]")

            old_hash = ""
            if self.hash_file.exists():
                old_hash = self.hash_file.read_text(encoding="utf-8").strip()

            bin_path = self.script_dir / f"catalog_{prefix}.bin"
            need_bin = not bin_path.exists() or old_hash != current_hash
            need_json = not self.assets_json_path.exists() or old_hash != current_hash

            if not need_bin and not need_json:
                console.print("[yellow][*] Catalog 已经是最新，跳过更新。[/yellow]")
                return

            if need_bin:
                bin_url = f"{base_url}/catalog_{prefix}.bin"
                console.print(f"[*] 下载 Catalog Bin: {bin_url}")
                if not self.downloader.download_file(bin_url, str(bin_path)):
                    raise RuntimeError("Catalog Bin 下载失败")

            if need_json:
                self._parse_catalog_bin(bin_path)

            self.hash_file.write_text(current_hash, encoding="utf-8")
        except Exception as e:
            if self.assets_json_path.exists():
                console.print(
                    f"[yellow][!] Catalog 在线检查失败 ({e})，使用本地 catalog.json[/yellow]"
                )
                if self.hash_file.exists():
                    self.catalog_hash = self.hash_file.read_text(encoding="utf-8").strip()
                return
            bins = sorted(self.script_dir.glob("catalog_*.bin"))
            if bins:
                console.print(f"[yellow][!] 在线失败，从本地 {bins[-1].name} 解析[/yellow]")
                self._parse_catalog_bin(bins[-1])
                return
            raise RuntimeError(f"无法获取 catalog: {e}") from e

    def ensure_master_data(self):
        """MasterData.json 不存在则按 DotAbyss 方式下载。"""
        if self.master_data_path.exists():
            return

        console.print("[*] MasterData.json 不存在，正在下载...")
        info = self.downloader.get_version_info()
        if not info:
            raise RuntimeError("获取版本信息失败，无法下载 MasterData")
        versions = info.get("versions", {})
        self.downloader.master_ver = self.downloader._pick_version(
            versions, "resource", "resource", default="4"
        )
        if not self.downloader.handle_master_data():
            raise RuntimeError("MasterData 下载失败")

        cwd_file = Path("MasterData.json")
        if cwd_file.resolve() != self.master_data_path.resolve():
            if not cwd_file.exists():
                raise RuntimeError("MasterData 下载后未找到文件")
            self.master_data_path.write_text(
                cwd_file.read_text(encoding="utf-8"), encoding="utf-8"
            )
        console.print(f"[green][+] MasterData 已保存至 {self.master_data_path}[/green]")

    def _safe_fs_name(self, name: str) -> str:
        name = _INVALID_FS.sub("_", (name or "").strip())
        name = name.rstrip(" .")
        return name or "Unknown"

    def _atlas_asset_code(self, atlas_name: str) -> str:
        if atlas_name.startswith(ATLAS_PREFIX):
            return atlas_name[len(ATLAS_PREFIX) :]
        return atlas_name

    def _build_char_name_lookup(self):
        with open(self.master_data_path, "r", encoding="utf-8") as f:
            md = json.load(f)
        chars = {
            c["id"]: c.get("name", "")
            for c in md.get("m_characters", [])
            if isinstance(c, dict) and "id" in c
        }
        self.bg_to_meta = {}
        self._char_g_codes = {}
        for skin in md.get("m_character_skins", []):
            if not isinstance(skin, dict):
                continue
            bg = str(skin.get("bg_asset_id") or "").strip()
            if not bg:
                continue
            char_name = chars.get(skin.get("m_character_id"), "") or bg
            meta = {
                "char_name": char_name,
                "type": skin.get("type"),
                "is_default": skin.get("is_default"),
                "skin_name": skin.get("name") or "",
            }
            self.bg_to_meta[bg] = meta
            if bg.endswith("G"):
                self._char_g_codes.setdefault(char_name, []).append(bg)

        console.print(
            f"[blue][*] 角色立绘映射: {len(self.bg_to_meta)} 条 bg_asset_id[/blue]"
        )

    def _lookup_skin_meta(self, asset_code: str) -> Optional[Dict[str, Any]]:
        if asset_code in self.bg_to_meta:
            return self.bg_to_meta[asset_code]
        # atlas 有时缺末尾 G
        if asset_code and asset_code[-1].isdigit():
            return self.bg_to_meta.get(asset_code + "G")
        return None

    def _preferred_g_code(self, char_name: str, g_codes: List[str]) -> str:
        for c in g_codes:
            m = self.bg_to_meta.get(c) or {}
            if m.get("is_default") == 1 and c.endswith("000G"):
                return c
        for c in g_codes:
            if c.endswith("000G"):
                return c
        return sorted(g_codes)[0]

    def _display_asset_code(self, code: str) -> str:
        """展示用 asset code：去掉末尾 G/X。"""
        if code and code[-1] in "GXgx":
            return code[:-1]
        return code

    def _skin_label(self, meta: Dict[str, Any], code: str) -> str:
        """非默认皮肤的文件名标签：优先数据表皮肤名，空缺时退回 asset code。"""
        skin_name = (meta.get("skin_name") or "").strip()
        if skin_name:
            return self._safe_fs_name(skin_name)
        return self._display_asset_code(code)

    def _resolve_stand_names(self, atlas_name: str) -> Tuple[str, str]:
        """返回 (导出目录名, 文件名前缀)。默认G→角色名；X→角色名_工作装；非默认皮肤→角色名_皮肤名；表外 NPC→NPC/<code>。"""
        code = self._atlas_asset_code(atlas_name)
        meta = self._lookup_skin_meta(code)
        if not meta:
            code_safe = self._safe_fs_name(self._display_asset_code(code) or atlas_name)
            return f"NPC/{code_safe}", code_safe

        char = self._safe_fs_name(meta["char_name"])
        skin_type = meta.get("type")
        if skin_type == 2 or code.endswith("X"):
            if meta.get("is_default") == 1:
                return char, f"{char}_工作装"
            # 非默认工作装皮肤（如 キューティデビル）用皮肤名，避免与默认工作装互相覆盖
            return char, f"{char}_{self._skin_label(meta, code)}"

        if skin_type == 1 or code.endswith("G"):
            g_codes = self._char_g_codes.get(meta["char_name"], [])
            if len(g_codes) <= 1:
                return char, char
            preferred = self._preferred_g_code(meta["char_name"], g_codes)
            if code == preferred:
                return char, char
            return char, f"{char}_{self._skin_label(meta, code)}"

        return char, f"{char}_{self._skin_label(meta, code)}"

    def _load_manifest(self) -> Dict[str, Any]:
        empty = {"version": MANIFEST_VERSION, "catalog_hash": "", "bundles": {}}
        if not self.manifest_path.exists():
            return empty
        try:
            with open(self.manifest_path, "r", encoding="utf-8") as f:
                data = json.load(f)
            if not isinstance(data, dict):
                return empty
            if int(data.get("version") or 0) < MANIFEST_VERSION:
                console.print(
                    "[yellow][*] 导出命名规则已更新，清理旧文件后按新规则重新导出[/yellow]"
                )
                self._clear_exported_pngs()
                return empty
            data.setdefault("version", MANIFEST_VERSION)
            data.setdefault("catalog_hash", "")
            data.setdefault("bundles", {})
            return data
        except Exception:
            return empty

    def _clear_exported_pngs(self):
        """命名规则变更时清理旧导出 PNG，避免新旧文件名并存。"""
        if not self.output_dir.exists():
            return
        removed = 0
        for png in self.output_dir.rglob("*.png"):
            try:
                png.unlink()
                removed += 1
            except OSError:
                pass
        if removed:
            console.print(f"[yellow][*] 已清理旧 PNG: {removed} 个[/yellow]")

    def _save_manifest(self):
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.manifest["version"] = MANIFEST_VERSION
        self.manifest["catalog_hash"] = self.catalog_hash
        with open(self.manifest_path, "w", encoding="utf-8") as f:
            json.dump(self.manifest, f, ensure_ascii=False, indent=2)

    def _atlas_dir_ok(self, atlas_name: str) -> bool:
        d = self.output_dir / atlas_name
        return d.is_dir() and any(d.glob("*.png"))

    def _is_already_exported(self, primary_key: str, asset_hash: str, size: int) -> bool:
        entry = self.manifest.get("bundles", {}).get(primary_key)
        if not entry:
            return False
        if str(entry.get("hash", "")) != str(asset_hash):
            return False
        if int(entry.get("size") or 0) != int(size or 0):
            return False
        atlases = entry.get("atlases") or []
        if not atlases:
            return False
        return all(self._atlas_dir_ok(name) for name in atlases)

    def _record_export(self, primary_key: str, asset_hash: str, size: int, atlases: List[str]):
        with self._lock:
            self.manifest.setdefault("bundles", {})[primary_key] = {
                "hash": asset_hash,
                "size": int(size or 0),
                "atlases": sorted(set(atlases)),
            }

    def _normalize_id(self, internal_id: str) -> str:
        if "}" in internal_id:
            return internal_id.split("}", 1)[1].lstrip("/")
        return internal_id.lstrip("/")

    def _build_lookups(self):
        assets = self.assets_json.get("assets", [])
        console.print(f"[*] 正在为 {len(assets)} 个资产构建索引表...")
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

    def _charastand_assets(self) -> List[Dict[str, Any]]:
        result = []
        seen = set()
        for asset in self.assets_json.get("assets", []):
            if not isinstance(asset, dict):
                continue
            primary_key = asset.get("primary_key", "")
            if not primary_key.startswith(ASSET_PREFIX):
                continue
            if primary_key in seen:
                continue
            seen.add(primary_key)
            result.append(asset)
        return result

    def ensure_assets(self) -> Path:
        """按 catalog 同步 r18-only-charastand_assets*：缺失或 size/hash 不一致则重下。"""
        self.bundle_dir.mkdir(parents=True, exist_ok=True)
        assets = self._charastand_assets()
        if not assets:
            raise RuntimeError(
                f"catalog.json 中未找到以 {ASSET_PREFIX} 开头的资产"
            )

        missing = []
        for asset in assets:
            primary_key = asset["primary_key"]
            dest = self.bundle_dir / primary_key
            expected = int(asset.get("bundle_size") or 0)
            asset_hash = str(asset.get("hash") or "")
            if dest.exists():
                size_ok = expected <= 0 or dest.stat().st_size == expected
                # primary_key 内嵌内容 hash；文件名对且大小对即视为未变
                name_hash_ok = (not asset_hash) or asset_hash in primary_key
                if size_ok and name_hash_ok:
                    continue
                try:
                    dest.unlink()
                except OSError:
                    pass
            missing.append(asset)

        console.print(
            f"[blue][*] charastand 资产: {len(assets)}，本地已有: "
            f"{len(assets) - len(missing)}，待下载: {len(missing)}[/blue]"
        )
        if not missing:
            return self.bundle_dir

        base_url = self._resolve_base_url()
        console.print(f"[blue][*] 资源基址: {base_url}[/blue]")

        progress = Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            MofNCompleteColumn(),
            TimeRemainingColumn(),
            console=console,
            transient=False,
        )

        def _download_one(asset: Dict[str, Any]) -> bool:
            primary_key = asset["primary_key"]
            internal_id = asset.get("internal_id", "")
            size = int(asset.get("bundle_size") or 0)
            if REMOTE_PATH_KEY in internal_id:
                url = internal_id.replace(REMOTE_PATH_KEY, base_url)
            elif internal_id.startswith("http"):
                url = internal_id
            else:
                url = f"{base_url}/{primary_key}"
            dest = str(self.bundle_dir / primary_key)
            return self.downloader.download_file(url, dest, expected_size=size)

        with progress:
            task_id = progress.add_task(
                "[cyan]下载 charastand 资产...[/cyan]", total=len(missing)
            )
            with ThreadPoolExecutor(max_workers=self.threads) as pool:
                futures = {pool.submit(_download_one, a): a for a in missing}
                for fut in as_completed(futures):
                    asset = futures[fut]
                    try:
                        ok = fut.result()
                        if not ok:
                            console.print(
                                f"[yellow][!] 下载失败: {asset['primary_key']}[/yellow]"
                            )
                    except Exception as e:
                        console.print(
                            f"[red][!] 下载异常 ({asset['primary_key']}): {e}[/red]"
                        )
                    progress.advance(task_id)

        return self.bundle_dir

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

    def _is_sub_prefab(self, primary_key: Optional[str]) -> bool:
        """判断是否是 sub 图层"""
        if not primary_key:
            return False
        normalized = primary_key.lower().replace("\\", "/")
        return "prefabs/sub/" in normalized or "prefabs_sub" in normalized

    def _collect_rt_layout(self, env) -> Dict[str, Dict[str, Any]]:
        objects_by_id = {obj.path_id: obj for obj in env.objects}
        go_names: Dict[int, str] = {}
        for obj in env.objects:
            if obj.type == ClassIDType.GameObject:
                try:
                    go = obj.read()
                    go_names[obj.path_id] = getattr(go, "m_Name", "")
                except Exception:
                    pass

        rt_data: Dict[str, Dict[str, Any]] = {}
        for obj in env.objects:
            type_id = obj.type.value if hasattr(obj.type, "value") else obj.type
            if obj.type != ClassIDType.RectTransform and type_id != 224:
                continue
            try:
                rt = obj.read()
                go_ref = getattr(rt, "m_GameObject", None)
                go_id = None
                if hasattr(go_ref, "m_PathID"):
                    go_id = go_ref.m_PathID  # type: ignore
                elif isinstance(go_ref, dict):
                    go_id = go_ref.get("m_PathID", 0)

                go_name = go_names.get(go_id, "")
                if not go_name:
                    continue

                anchored_pos = getattr(rt, "m_AnchoredPosition", None)
                size_delta = getattr(rt, "m_SizeDelta", None)
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
                                father_go_id = father_go_ref.m_PathID  # type: ignore
                            elif isinstance(father_go_ref, dict):
                                father_go_id = father_go_ref.get("m_PathID")
                            parent_name = go_names.get(father_go_id, "")
                        except Exception:
                            pass

                rt_data[go_name] = {
                    "ax": (
                        anchored_pos.x
                        if anchored_pos and hasattr(anchored_pos, "x")
                        else 0
                    ),
                    "ay": (
                        anchored_pos.y
                        if anchored_pos and hasattr(anchored_pos, "y")
                        else 0
                    ),
                    "sw": (
                        size_delta.x if size_delta and hasattr(size_delta, "x") else 0
                    ),
                    "sh": (
                        size_delta.y if size_delta and hasattr(size_delta, "y") else 0
                    ),
                    "parent": parent_name,
                }
            except Exception:
                pass
        return rt_data

    def _extract_sub_layout(self, env) -> Optional[Dict[str, Any]]:
        rt_data = self._collect_rt_layout(env)
        face = rt_data.get("FaceContent")
        body = rt_data.get("Body")
        front = rt_data.get("FrontContent")

        if not face or not body or face.get("parent") != "Body":
            return None

        result: Dict[str, Any] = {
            "face_anchor_x": face["ax"],
            "face_anchor_y": face["ay"],
            "face_w": face["sw"],
            "face_h": face["sh"],
            "body_w": body["sw"],
            "body_h": body["sh"],
            "body_pose_x": body["ax"],
            "body_pose_y": body["ay"],
        }

        if front and front.get("parent") == "Pose":
            result["front_anchor_x"] = front["ax"]
            result["front_anchor_y"] = front["ay"]
            result["front_w"] = front["sw"]
            result["front_h"] = front["sh"]

        return result

    def _compute_content_slot(
        self,
        anchor_x: float,
        anchor_y: float,
        slot_w: float,
        slot_h: float,
        canvas_w: int,
        canvas_h: int,
        body_rt_w: float,
        body_rt_h: float,
    ) -> Tuple[float, float, float, float]:
        scale_x = canvas_w / body_rt_w if body_rt_w > 0 else 1.0
        scale_y = canvas_h / body_rt_h if body_rt_h > 0 else 1.0

        face_pixel_w = slot_w * scale_x
        face_pixel_h = slot_h * scale_y
        face_center_px = canvas_w / 2 + anchor_x * scale_x
        face_center_py = canvas_h / 2 - anchor_y * scale_y
        face_left = face_center_px - face_pixel_w / 2
        face_top = face_center_py - face_pixel_h / 2
        return face_left, face_top, face_pixel_w, face_pixel_h

    def _prepare_sprite_layer(
        self, expr_data: Dict[str, Any], target_w: int, target_h: int
    ) -> Image.Image:
        expr_rect_w = (
            expr_data["rect_w"] if expr_data["rect_w"] > 0 else expr_data["img_w"]
        )
        expr_rect_h = (
            expr_data["rect_h"] if expr_data["rect_h"] > 0 else expr_data["img_h"]
        )

        expr_full = Image.new("RGBA", (expr_rect_w, expr_rect_h), (0, 0, 0, 0))
        tro_x = int(round(expr_data["tro_x"]))
        tro_y_flipped = (
            expr_rect_h - int(round(expr_data["tro_y"])) - expr_data["img_h"]
        )
        tro_y_flipped = max(0, tro_y_flipped)
        tro_x = max(0, tro_x)
        expr_full.alpha_composite(expr_data["img"], dest=(tro_x, tro_y_flipped))

        if target_w > 0 and target_h > 0:
            return expr_full.resize((target_w, target_h), Image.Resampling.LANCZOS)
        return expr_full

    def _composite_with_overflow(
        self,
        body_img: Image.Image,
        overlays: List[Tuple[Image.Image, int, int]],
    ) -> Image.Image:
        return self._composite_stack(body_img, [], overlays)

    def _composite_stack(
        self,
        body_img: Image.Image,
        below: List[Tuple[Image.Image, int, int]],
        above: List[Tuple[Image.Image, int, int]],
    ) -> Image.Image:
        """below 在 Body 下（BackContent），above 在 Body 上（脸/前景）。坐标相对 Body 左上角。"""
        canvas_w, canvas_h = body_img.size
        items: List[Tuple[Image.Image, int, int]] = (
            list(below) + [(body_img, 0, 0)] + list(above)
        )
        min_x = 0
        min_y = 0
        max_x = canvas_w
        max_y = canvas_h
        for overlay, paste_x, paste_y in items:
            min_x = min(min_x, paste_x)
            min_y = min(min_y, paste_y)
            max_x = max(max_x, paste_x + overlay.size[0])
            max_y = max(max_y, paste_y + overlay.size[1])

        offset_x = -min_x if min_x < 0 else 0
        offset_y = -min_y if min_y < 0 else 0
        canvas = Image.new("RGBA", (max_x - min_x, max_y - min_y), (0, 0, 0, 0))
        for overlay, paste_x, paste_y in items:
            canvas.alpha_composite(
                overlay, dest=(paste_x + offset_x, paste_y + offset_y)
            )
        return canvas

    def _sprite_layer_kind(self, name: str) -> str:
        name_lower = name.lower()
        if "body" in name_lower or name_lower == "base":
            return "body"
        if _LAYER_BACK.match(name_lower):
            return "back"
        if _LAYER_FRONT.match(name_lower):
            return "front"
        return "face"

    def _is_front_overlay_sprite(self, name: str) -> bool:
        return self._sprite_layer_kind(name) == "front"

    def _anchor_under_pose(self, rt_data: Dict[str, Dict[str, Any]], name: str) -> Tuple[float, float]:
        ax = ay = 0.0
        cur = name
        seen = set()
        while cur and cur in rt_data and cur not in seen:
            seen.add(cur)
            if cur == "Pose":
                break
            node = rt_data[cur]
            ax += float(node.get("ax") or 0)
            ay += float(node.get("ay") or 0)
            cur = node.get("parent") or ""
        return ax, ay

    def _rt_candidates_for_sprite(self, sprite_name: str) -> List[str]:
        """BackContent1 → BackContent01 / BackContent1 / BackContent"""
        raw = sprite_name
        m = re.match(r"^(BackContent|FrontContent|BackEffect)(\d+)$", sprite_name, re.I)
        names = []
        if m:
            kind, num = m.group(1), m.group(2)
            names.append(f"{kind}{int(num):02d}")  # BackContent01
            names.append(f"{kind}{num}")
            names.append(kind)
            names.append(f"{kind}0{num}" if len(num) == 1 else None)
        else:
            names.append(sprite_name)
            if sprite_name.lower().startswith("glasses"):
                names.extend(["FrontContent", "FrontContent01"])
        return [n for n in names if n]

    def _slot_for_pose_layer(
        self,
        rt_data: Dict[str, Dict[str, Any]],
        sprite_name: str,
        sprite_data: Dict[str, Any],
        body: Dict[str, Any],
        canvas_w: int,
        canvas_h: int,
    ) -> Optional[Tuple[float, float, float, float]]:
        """计算 Pose 层级图层相对 Body 画布的像素槽位。"""
        slot = None
        slot_name = None
        for cand in self._rt_candidates_for_sprite(sprite_name):
            if cand in rt_data:
                slot = rt_data[cand]
                slot_name = cand
                break
        if not slot:
            return None

        body_ax, body_ay = self._anchor_under_pose(rt_data, "Body")
        layer_ax, layer_ay = self._anchor_under_pose(rt_data, slot_name)
        rel_x = layer_ax - body_ax
        rel_y = layer_ay - body_ay

        slot_w = float(slot.get("sw") or 0)
        slot_h = float(slot.get("sh") or 0)
        if slot_w <= 0 or slot_h <= 0:
            slot_w = float(sprite_data.get("rect_w") or sprite_data["img_w"])
            slot_h = float(sprite_data.get("rect_h") or sprite_data["img_h"])

        body_rt_w = float(body.get("sw") or 0)
        body_rt_h = float(body.get("sh") or 0)
        return self._compute_content_slot(
            rel_x,
            rel_y,
            slot_w,
            slot_h,
            canvas_w,
            canvas_h,
            body_rt_w,
            body_rt_h,
        )

    def _build_pose_overlays(
        self,
        rt_data: Dict[str, Dict[str, Any]],
        layers: List[Dict[str, Any]],
        body_rt: Dict[str, Any],
        canvas_w: int,
        canvas_h: int,
    ) -> List[Tuple[Image.Image, int, int]]:
        result = []
        for data in layers:
            slot = self._slot_for_pose_layer(
                rt_data, data["name"], data, body_rt, canvas_w, canvas_h
            )
            if not slot:
                continue
            left, top, pw, ph = slot
            layer = self._prepare_sprite_layer(data, int(round(pw)), int(round(ph)))
            result.append((layer, int(round(left)), int(round(top))))
        return result

    def export_assets(self):
        self.output_dir.mkdir(exist_ok=True)
        assets = self._charastand_assets()
        pending: List[Tuple[Path, Dict[str, Any]]] = []

        for asset in assets:
            primary_key = asset["primary_key"]
            asset_hash = str(asset.get("hash") or "")
            size = int(asset.get("bundle_size") or 0)
            bundle_path = self.bundle_dir / primary_key
            if not bundle_path.exists():
                console.print(f"[yellow][!] 缺少 bundle，跳过: {primary_key}[/yellow]")
                continue
            if self._is_already_exported(primary_key, asset_hash, size):
                with self._lock:
                    self.stats["bundles_skipped"] += 1
                continue
            pending.append((bundle_path, asset))

        console.print(
            f"[green][+] catalog 中 {len(assets)} 个，"
            f"跳过已导出 {self.stats['bundles_skipped']}，"
            f"待导出 {len(pending)}[/green]"
        )
        if not pending:
            self._save_manifest()
            console.print("[bold green][✓] 无需导出，全部已是最新。[/bold green]")
            return

        progress = Progress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            "[progress.percentage]{task.percentage:>3.0f}%",
            MofNCompleteColumn(),
            TimeRemainingColumn(),
            console=console,
            transient=False,
        )

        with progress:
            task_id = progress.add_task(
                "[cyan]导出立绘...[/cyan]", total=len(pending)
            )
            with ThreadPoolExecutor(max_workers=self.threads) as pool:
                futures = {
                    pool.submit(self._process_bundle, path, asset): asset
                    for path, asset in pending
                }
                for fut in as_completed(futures):
                    asset = futures[fut]
                    try:
                        atlases = fut.result() or []
                        if atlases:
                            self._record_export(
                                asset["primary_key"],
                                str(asset.get("hash") or ""),
                                int(asset.get("bundle_size") or 0),
                                atlases,
                            )
                            with self._lock:
                                self.stats["bundles_exported"] += 1
                    except Exception as e:
                        console.print(
                            f"[red][!] Bundle 处理异常 ({asset['primary_key']}): {e}[/red]"
                        )
                    progress.advance(task_id)

        with self._lock:
            self._save_manifest()

        console.print("[bold green][✓] 导出全部完成！[/bold green]")
        console.print(f"跳过已导出: {self.stats['bundles_skipped']}")
        console.print(f"本次导出 bundle: {self.stats['bundles_exported']}")
        console.print(f"导出目录总数: {len(self.stats['exported_dirs'])}")
        console.print(f"处理图集数量: {self.stats['atlas_processed']}")
        console.print(f"导出表情拼图: {self.stats['expression_exported']}")

    def _process_bundle(self, bundle_path: Path, asset: Optional[Dict[str, Any]] = None) -> List[str]:
        try:
            env = UnityPy.load(str(bundle_path))
        except Exception as e:
            console.print(f"[red]加载 Bundle 失败 {bundle_path.name}: {e}[/red]")
            return []

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
                except Exception:
                    pass

        best_primary_key = (asset or {}).get("primary_key")
        if not best_primary_key:
            for container in potential_containers:
                pk = self._find_primary_key(container)
                if pk:
                    best_primary_key = pk
                    break

        all_sprites = {}
        for obj in env.objects:
            if obj.type == ClassIDType.Sprite:
                try:
                    sprite = obj.read()
                    all_sprites[obj.path_id] = sprite
                except Exception:
                    pass

        face_info = self._extract_face_layout(env)
        sub_layout = self._extract_sub_layout(env)

        atlases: List[str] = []
        for obj in env.objects:
            if obj.type == ClassIDType.SpriteAtlas:
                name = self._process_sprite_atlas(
                    obj,
                    env,
                    all_sprites,
                    best_primary_key,
                    face_info,
                    sub_layout,
                )
                if name:
                    atlases.append(name)
        return atlases

    def _extract_face_layout(self, env):
        """从 Prefab 的 RectTransform 层级中提取 FaceContent 相对于 Body 的坐标和尺寸"""
        rt_data = self._collect_rt_layout(env)
        face = rt_data.get("FaceContent")
        body = rt_data.get("Body")

        if face and body and face["parent"] == "Body":
            return {
                "face_anchor_x": face["ax"],
                "face_anchor_y": face["ay"],
                "face_w": face["sw"],
                "face_h": face["sh"],
                "body_w": body["sw"],
                "body_h": body["sh"],
            }

        return None

    def _process_sprite_atlas(
        self, obj, env, all_sprites, best_primary_key, face_info, sub_layout
    ):
        try:
            atlas = obj.read()
            atlas_name = getattr(atlas, "m_Name", "UnknownAtlas")
            folder_name, file_prefix = self._resolve_stand_names(atlas_name)

            primary_key = None
            container = getattr(atlas, "container", getattr(atlas, "m_Container", ""))
            if container:
                primary_key = self._find_primary_key(container)
            if not primary_key:
                primary_key = best_primary_key

            output_path = self.output_dir / folder_name
            output_path.mkdir(parents=True, exist_ok=True)
            with self._lock:
                self.stats["exported_dirs"].add(folder_name)

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
                return None

            sprite_map = {}
            for sprite in sprites_in_atlas:
                name = getattr(sprite, "m_Name", "unknown")
                if name == "_stand1":
                    continue

                if not hasattr(sprite, "image") or sprite.image is None:
                    continue

                m_rect = getattr(sprite, "m_Rect", None)
                rect_w = int(m_rect.width) if m_rect and hasattr(m_rect, "width") else 0
                rect_h = (
                    int(m_rect.height) if m_rect and hasattr(m_rect, "height") else 0
                )

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
                return None

            body_data = None
            face_list: List[Dict[str, Any]] = []
            back_list: List[Dict[str, Any]] = []
            front_list: List[Dict[str, Any]] = []

            for name, data in sprite_map.items():
                kind = self._sprite_layer_kind(name)
                if kind == "body":
                    if not body_data or (
                        data["img_w"] * data["img_h"]
                        > body_data["img_w"] * body_data["img_h"]
                    ):
                        if body_data:
                            face_list.append(body_data)
                        body_data = data
                    else:
                        face_list.append(data)
                elif kind == "back":
                    back_list.append(data)
                elif kind == "front":
                    front_list.append(data)
                else:
                    face_list.append(data)

            if not body_data:
                return None

            rt_data = self._collect_rt_layout(env)

            if self._is_sub_prefab(primary_key) and sub_layout:
                self._export_sub_stand(
                    file_prefix,
                    output_path,
                    body_data,
                    sprite_map,
                    sub_layout,
                    rt_data,
                )
                return folder_name

            body_img = body_data["img"]
            canvas_w, canvas_h = body_img.size
            body_rt = rt_data.get("Body") or {
                "ax": 0,
                "ay": 0,
                "sw": canvas_w,
                "sh": canvas_h,
            }

            if not face_list and not back_list and not front_list:
                return None

            if face_info:
                face_ax = face_info["face_anchor_x"]
                face_ay = face_info["face_anchor_y"]
                face_w = (
                    face_info["face_w"]
                    if face_info["face_w"] > 0
                    else (face_list[0]["rect_w"] if face_list else 0)
                )
                face_h = (
                    face_info["face_h"]
                    if face_info["face_h"] > 0
                    else (face_list[0]["rect_h"] if face_list else 0)
                )
                body_rt_w = face_info["body_w"]
                body_rt_h = face_info["body_h"]

                scale_x = canvas_w / body_rt_w if body_rt_w > 0 else 1.0
                scale_y = canvas_h / body_rt_h if body_rt_h > 0 else 1.0

                face_pixel_w = face_w * scale_x
                face_pixel_h = face_h * scale_y
                face_center_px = canvas_w / 2 + face_ax * scale_x
                face_center_py = canvas_h / 2 - face_ay * scale_y
                face_left = face_center_px - face_pixel_w / 2
                face_top = face_center_py - face_pixel_h / 2
            else:
                face_left = 0
                face_top = 0
                face_pixel_w = canvas_w
                face_pixel_h = canvas_h

            below = self._build_pose_overlays(
                rt_data, back_list, body_rt, canvas_w, canvas_h
            )
            fronts = self._build_pose_overlays(
                rt_data, front_list, body_rt, canvas_w, canvas_h
            )

            target_fw = int(round(face_pixel_w))
            target_fh = int(round(face_pixel_h))
            face_paste_x = int(round(face_left))
            face_paste_y = int(round(face_top))

            # 脸差分：身后层 + Body + 脸 + 前景；Back/Front 不再单独当表情导出
            export_faces = face_list or (
                [sprite_map["Normal"]] if "Normal" in sprite_map else []
            )
            if not export_faces and (below or fronts):
                # 只有背/前景时仍导出一张带 Normal 空脸的合成（仅 Body+层）
                canvas = self._composite_stack(body_img, below, fronts)
                canvas.save(output_path / f"{file_prefix}_Normal.png")
                with self._lock:
                    self.stats["expression_exported"] += 1
                    self.stats["atlas_processed"] += 1
                return folder_name

            for expr_data in export_faces:
                face_layer = self._prepare_sprite_layer(expr_data, target_fw, target_fh)
                above = [(face_layer, face_paste_x, face_paste_y)] + fronts
                canvas = self._composite_stack(body_img, below, above)
                expr_save_name = f"{file_prefix}_{expr_data['name']}.png"
                canvas.save(output_path / expr_save_name)
                with self._lock:
                    self.stats["expression_exported"] += 1

            with self._lock:
                self.stats["atlas_processed"] += 1
            return folder_name

        except Exception as e:
            console.print(f"[red]处理 SpriteAtlas 失败: {e}[/red]")
            return None

    def _export_sub_stand(
        self,
        file_prefix: str,
        output_path: Path,
        body_data: Dict[str, Any],
        sprite_map: Dict[str, Dict[str, Any]],
        sub_layout: Dict[str, Any],
        rt_data: Optional[Dict[str, Dict[str, Any]]] = None,
    ):
        """导出 sub 图层：拓展画布后分槽合成"""
        body_img = body_data["img"]
        canvas_w, canvas_h = body_img.size
        body_rt_w = sub_layout["body_w"]
        body_rt_h = sub_layout["body_h"]
        rt_data = rt_data or {}
        body_rt = rt_data.get("Body") or {
            "ax": sub_layout.get("body_pose_x", 0),
            "ay": sub_layout.get("body_pose_y", 0),
            "sw": body_rt_w,
            "sh": body_rt_h,
        }

        face_w = sub_layout["face_w"]
        face_h = sub_layout["face_h"]
        if face_w <= 0 or face_h <= 0:
            sample = next(
                (
                    data
                    for name, data in sprite_map.items()
                    if self._sprite_layer_kind(name) == "face"
                ),
                None,
            )
            if sample:
                face_w = sample["rect_w"] or sample["img_w"]
                face_h = sample["rect_h"] or sample["img_h"]

        face_left, face_top, face_pixel_w, face_pixel_h = self._compute_content_slot(
            sub_layout["face_anchor_x"],
            sub_layout["face_anchor_y"],
            face_w,
            face_h,
            canvas_w,
            canvas_h,
            body_rt_w,
            body_rt_h,
        )

        expression_list: List[Dict[str, Any]] = []
        back_list: List[Dict[str, Any]] = []
        front_overlay_list: List[Dict[str, Any]] = []
        for name, data in sprite_map.items():
            if name == body_data["name"]:
                continue
            kind = self._sprite_layer_kind(name)
            if kind == "back":
                back_list.append(data)
            elif kind == "front":
                front_overlay_list.append(data)
            else:
                expression_list.append(data)

        below = self._build_pose_overlays(
            rt_data, back_list, body_rt, canvas_w, canvas_h
        )
        glasses_list = [
            d for d in front_overlay_list if d["name"].lower().startswith("glasses")
        ]
        pose_front_list = [
            d for d in front_overlay_list if not d["name"].lower().startswith("glasses")
        ]
        pose_fronts = self._build_pose_overlays(
            rt_data, pose_front_list, body_rt, canvas_w, canvas_h
        )

        # FrontContent 槽（glasses 用 sub 布局）
        front_slot = None
        if "front_anchor_x" in sub_layout:
            front_w = sub_layout.get("front_w") or face_w
            front_h = sub_layout.get("front_h") or face_h
            front_rel_x = sub_layout["front_anchor_x"] - sub_layout["body_pose_x"]
            front_rel_y = sub_layout["front_anchor_y"] - sub_layout["body_pose_y"]
            front_left, front_top, front_pixel_w, front_pixel_h = (
                self._compute_content_slot(
                    front_rel_x,
                    front_rel_y,
                    front_w,
                    front_h,
                    canvas_w,
                    canvas_h,
                    body_rt_w,
                    body_rt_h,
                )
            )
            front_slot = {
                "left": front_left,
                "top": front_top,
                "width": front_pixel_w,
                "height": front_pixel_h,
            }

        if not expression_list and not glasses_list and not below and not pose_fronts:
            return

        target_fw = int(round(face_pixel_w))
        target_fh = int(round(face_pixel_h))
        face_paste_x = int(round(face_left))
        face_paste_y = int(round(face_top))

        base_face = sprite_map.get("Normal")

        for expr_data in expression_list:
            expr_resized = self._prepare_sprite_layer(expr_data, target_fw, target_fh)
            above: List[Tuple[Image.Image, int, int]] = [
                (expr_resized, face_paste_x, face_paste_y)
            ] + pose_fronts
            canvas = self._composite_stack(body_img, below, above)
            expr_save_name = f"{file_prefix}_{expr_data['name']}.png"
            canvas.save(output_path / expr_save_name)
            with self._lock:
                self.stats["expression_exported"] += 1

        if front_slot and glasses_list:
            front_target_w = int(round(front_slot["width"]))
            front_target_h = int(round(front_slot["height"]))
            front_paste_x = int(round(front_slot["left"]))
            front_paste_y = int(round(front_slot["top"]))

            for overlay_data in glasses_list:
                above = []
                if base_face:
                    above.append(
                        (
                            self._prepare_sprite_layer(base_face, target_fw, target_fh),
                            face_paste_x,
                            face_paste_y,
                        )
                    )
                above.extend(pose_fronts)
                overlay_layer = self._prepare_sprite_layer(
                    overlay_data, front_target_w, front_target_h
                )
                above.append((overlay_layer, front_paste_x, front_paste_y))
                canvas = self._composite_stack(body_img, below, above)
                expr_save_name = f"{file_prefix}_{overlay_data['name']}.png"
                canvas.save(output_path / expr_save_name)
                with self._lock:
                    self.stats["expression_exported"] += 1

        with self._lock:
            self.stats["atlas_processed"] += 1


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

def main():
    bundle_dir = sys.argv[1] if len(sys.argv) >= 2 else None
    if bundle_dir and not os.path.isdir(bundle_dir):
        console.print(f"[red]错误: 未找到目录: {bundle_dir}[/red]")
        sys.exit(1)

    try:
        extractor = SpriteAtlasExtractor(bundle_dir)
        extractor.ensure_assets()
        extractor.export_assets()
    except Exception as e:
        console.print(f"[red]运行错误: {e}[/red]")
        import traceback

        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
