using System;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
public enum GraphicsDeviceType
{
	[Obsolete("OpenGL2 is no longer supported in Unity 5.5+")]
	OpenGL2 = 0,
	[Obsolete("Direct3D 9 is no longer supported in Unity 2017.2+")]
	Direct3D9 = 1,
	Direct3D11 = 2,
	[Obsolete("PS3 is no longer supported in Unity 5.5+")]
	PlayStation3 = 3,
	Null = 4,
	[Obsolete("Xbox360 is no longer supported in Unity 5.5+")]
	Xbox360 = 6,
	OpenGLES2 = 8,
	OpenGLES3 = 11,
	[Obsolete("PVita is no longer supported as of Unity 2018")]
	PlayStationVita = 12,
	PlayStation4 = 13,
	XboxOne = 14,
	[Obsolete("PlayStationMobile is no longer supported in Unity 5.3+")]
	PlayStationMobile = 15,
	Metal = 16,
	OpenGLCore = 17,
	Direct3D12 = 18,
	[Obsolete("Nintendo 3DS support is unavailable since 2018.1")]
	N3DS = 19,
	Vulkan = 21,
	Switch = 22,
	XboxOneD3D12 = 23,
	GameCoreXboxOne = 24,
	[Obsolete("GameCoreScarlett is deprecated, please use GameCoreXboxSeries (UnityUpgradable) -> GameCoreXboxSeries", false)]
	GameCoreScarlett = -1,
	GameCoreXboxSeries = 25,
	PlayStation5 = 26,
	PlayStation5NGGC = 27
}
