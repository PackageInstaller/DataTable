using System;
using System.ComponentModel;

namespace UnityEngine;

public enum TextureFormat
{
	Alpha8 = 1,
	ARGB4444 = 2,
	RGB24 = 3,
	RGBA32 = 4,
	ARGB32 = 5,
	RGB565 = 7,
	R16 = 9,
	DXT1 = 10,
	DXT5 = 12,
	RGBA4444 = 13,
	BGRA32 = 14,
	RHalf = 15,
	RGHalf = 16,
	RGBAHalf = 17,
	RFloat = 18,
	RGFloat = 19,
	RGBAFloat = 20,
	YUY2 = 21,
	RGB9e5Float = 22,
	BC4 = 26,
	BC5 = 27,
	BC6H = 24,
	BC7 = 25,
	DXT1Crunched = 28,
	DXT5Crunched = 29,
	PVRTC_RGB2 = 30,
	PVRTC_RGBA2 = 31,
	PVRTC_RGB4 = 32,
	PVRTC_RGBA4 = 33,
	ETC_RGB4 = 34,
	EAC_R = 41,
	EAC_R_SIGNED = 42,
	EAC_RG = 43,
	EAC_RG_SIGNED = 44,
	ETC2_RGB = 45,
	ETC2_RGBA1 = 46,
	ETC2_RGBA8 = 47,
	ASTC_4x4 = 48,
	ASTC_5x5 = 49,
	ASTC_6x6 = 50,
	ASTC_8x8 = 51,
	ASTC_10x10 = 52,
	ASTC_12x12 = 53,
	[Obsolete("Nintendo 3DS is no longer supported.")]
	ETC_RGB4_3DS = 60,
	[Obsolete("Nintendo 3DS is no longer supported.")]
	ETC_RGBA8_3DS = 61,
	RG16 = 62,
	R8 = 63,
	ETC_RGB4Crunched = 64,
	ETC2_RGBA8Crunched = 65,
	ASTC_HDR_4x4 = 66,
	ASTC_HDR_5x5 = 67,
	ASTC_HDR_6x6 = 68,
	ASTC_HDR_8x8 = 69,
	ASTC_HDR_10x10 = 70,
	ASTC_HDR_12x12 = 71,
	RG32 = 72,
	RGB48 = 73,
	RGBA64 = 74,
	[Obsolete("Enum member TextureFormat.ASTC_RGB_4x4 has been deprecated. Use ASTC_4x4 instead (UnityUpgradable) -> ASTC_4x4")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGB_4x4 = ASTC_4x4,
	[Obsolete("Enum member TextureFormat.ASTC_RGB_5x5 has been deprecated. Use ASTC_5x5 instead (UnityUpgradable) -> ASTC_5x5")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGB_5x5 = ASTC_5x5,
	[Obsolete("Enum member TextureFormat.ASTC_RGB_6x6 has been deprecated. Use ASTC_6x6 instead (UnityUpgradable) -> ASTC_6x6")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGB_6x6 = ASTC_6x6,
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Enum member TextureFormat.ASTC_RGB_8x8 has been deprecated. Use ASTC_8x8 instead (UnityUpgradable) -> ASTC_8x8")]
	ASTC_RGB_8x8 = ASTC_8x8,
	[Obsolete("Enum member TextureFormat.ASTC_RGB_10x10 has been deprecated. Use ASTC_10x10 instead (UnityUpgradable) -> ASTC_10x10")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGB_10x10 = ASTC_10x10,
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Enum member TextureFormat.ASTC_RGB_12x12 has been deprecated. Use ASTC_12x12 instead (UnityUpgradable) -> ASTC_12x12")]
	ASTC_RGB_12x12 = ASTC_12x12,
	[Obsolete("Enum member TextureFormat.ASTC_RGBA_4x4 has been deprecated. Use ASTC_4x4 instead (UnityUpgradable) -> ASTC_4x4")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGBA_4x4 = 54,
	[Obsolete("Enum member TextureFormat.ASTC_RGBA_5x5 has been deprecated. Use ASTC_5x5 instead (UnityUpgradable) -> ASTC_5x5")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGBA_5x5 = 55,
	[Obsolete("Enum member TextureFormat.ASTC_RGBA_6x6 has been deprecated. Use ASTC_6x6 instead (UnityUpgradable) -> ASTC_6x6")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGBA_6x6 = 56,
	[Obsolete("Enum member TextureFormat.ASTC_RGBA_8x8 has been deprecated. Use ASTC_8x8 instead (UnityUpgradable) -> ASTC_8x8")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	ASTC_RGBA_8x8 = 57,
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Enum member TextureFormat.ASTC_RGBA_10x10 has been deprecated. Use ASTC_10x10 instead (UnityUpgradable) -> ASTC_10x10")]
	ASTC_RGBA_10x10 = 58,
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Enum member TextureFormat.ASTC_RGBA_12x12 has been deprecated. Use ASTC_12x12 instead (UnityUpgradable) -> ASTC_12x12")]
	ASTC_RGBA_12x12 = 59
}
