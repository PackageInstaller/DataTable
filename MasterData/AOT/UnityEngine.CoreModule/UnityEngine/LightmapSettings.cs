using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[StaticAccessor("GetLightmapSettings()")]
[NativeHeader("Runtime/Graphics/LightmapSettings.h")]
public sealed class LightmapSettings : Object
{
	public static extern LightmapData[] lightmaps
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(ThrowsException = true)]
		[param: Unmarshalled]
		set;
	}

	public static extern LightmapsMode lightmapsMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(ThrowsException = true)]
		set;
	}

	public static extern LightProbes lightProbes
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction]
		[NativeName("SetLightProbes")]
		set;
	}

	[Obsolete("Use lightmapsMode instead.", false)]
	public static LightmapsModeLegacy lightmapsModeLegacy
	{
		get
		{
			return LightmapsModeLegacy.Single;
		}
		set
		{
		}
	}

	[Obsolete("Use QualitySettings.desiredColorSpace instead.", false)]
	public static ColorSpace bakedColorSpace
	{
		get
		{
			return QualitySettings.desiredColorSpace;
		}
		set
		{
		}
	}

	private LightmapSettings()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ResetAndAwakeFromLoad")]
	internal static extern void Reset();
}
