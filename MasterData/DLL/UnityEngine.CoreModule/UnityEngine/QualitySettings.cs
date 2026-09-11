using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Misc/PlayerSettings.h")]
[NativeHeader("Runtime/Graphics/QualitySettings.h")]
[StaticAccessor("GetQualitySettings()", StaticAccessorType.Dot)]
public sealed class QualitySettings : Object
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static Action<int, int> activeQualityLevelChanged;

	public static extern int pixelLightCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("LODBias")]
	public static extern float lodBias
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern int vSyncCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int asyncUploadTimeSlice
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int asyncUploadBufferSize
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeName("RenderPipeline")]
	private static extern ScriptableObject INTERNAL_renderPipeline
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static RenderPipelineAsset renderPipeline => INTERNAL_renderPipeline as RenderPipelineAsset;

	public static extern ColorSpace activeColorSpace
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetColorSpace")]
		[StaticAccessor("GetPlayerSettings()", StaticAccessorType.Dot)]
		get;
	}

	[RequiredByNativeCode]
	internal static void OnActiveQualityLevelChanged(int previousQualityLevel, int currentQualityLevel)
	{
		activeQualityLevelChanged?.Invoke(previousQualityLevel, currentQualityLevel);
	}
}
