using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Rendering;

namespace UnityEngine;

[StaticAccessor(/*Could not decode attribute arguments.*/)]
[NativeHeader("Runtime/Graphics/QualitySettings.h")]
[NativeHeader("Runtime/Misc/PlayerSettings.h")]
public sealed class QualitySettings : Object
{
	public static extern int pixelLightCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("ShadowQuality")]
	public static extern ShadowQuality shadows
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern ShadowProjection shadowProjection
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int shadowCascades
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float shadowDistance
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("ShadowResolution")]
	public static extern ShadowResolution shadowResolution
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("ShadowmaskMode")]
	public static extern ShadowmaskMode shadowmaskMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float shadowNearPlaneOffset
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float shadowCascade2Split
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static Vector3 shadowCascade4Split
	{
		get
		{
			get_shadowCascade4Split_Injected(out var ret);
			return ret;
		}
		set
		{
			set_shadowCascade4Split_Injected(ref value);
		}
	}

	[NativeProperty("LODBias")]
	public static extern float lodBias
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("AnisotropicTextures")]
	public static extern AnisotropicFiltering anisotropicFiltering
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int masterTextureLimit
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int maximumLODLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int particleRaycastBudget
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool softParticles
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool softVegetation
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int vSyncCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int realtimeGICPUUsage
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int antiAliasing
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int asyncUploadTimeSlice
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int asyncUploadBufferSize
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool asyncUploadPersistentBuffer
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool realtimeReflectionProbes
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool billboardsFaceCameraPosition
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float resolutionScalingFixedDPIFactor
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeName("RenderPipeline")]
	private static extern ScriptableObject INTERNAL_renderPipeline
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static RenderPipelineAsset renderPipeline
	{
		get
		{
			return INTERNAL_renderPipeline as RenderPipelineAsset;
		}
		set
		{
			INTERNAL_renderPipeline = value;
		}
	}

	[Obsolete("blendWeights is obsolete. Use skinWeights instead (UnityUpgradable) -> skinWeights", true)]
	public static extern BlendWeights blendWeights
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetSkinWeights")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetSkinWeights")]
		set;
	}

	public static extern SkinWeights skinWeights
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool streamingMipmapsActive
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float streamingMipmapsMemoryBudget
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int streamingMipmapsRenderersPerFrame
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int streamingMipmapsMaxLevelReduction
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool streamingMipmapsAddAllCameras
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int streamingMipmapsMaxFileIORequests
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public static extern int maxQueuedFrames
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("QualitySettingsNames")]
	public static extern string[] names
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern ColorSpace desiredColorSpace
	{
		[MethodImpl((MethodImplOptions)4096)]
		[StaticAccessor(/*Could not decode attribute arguments.*/)]
		[NativeName("GetColorSpace")]
		get;
	}

	public static extern ColorSpace activeColorSpace
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetColorSpace")]
		[StaticAccessor(/*Could not decode attribute arguments.*/)]
		get;
	}

	[Obsolete("Use GetQualityLevel and SetQualityLevel", false)]
	public static QualityLevel currentLevel
	{
		get
		{
			return (QualityLevel)GetQualityLevel();
		}
		set
		{
			SetQualityLevel((int)value, applyExpensiveChanges: true);
		}
	}

	private QualitySettings()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetLODSettings")]
	public static extern void SetLODSettings(float lodBias, int maximumLODLevel, bool setDirty = true);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetRenderPipelineAssetAt")]
	internal static extern ScriptableObject InternalGetRenderPipelineAssetAt(int index);

	public static RenderPipelineAsset GetRenderPipelineAssetAt(int index)
	{
		if (index < 0 || index >= names.Length)
		{
			throw new IndexOutOfRangeException(string.Format("{0} is out of range [0..{1}[", "index", names.Length));
		}
		return InternalGetRenderPipelineAssetAt(index) as RenderPipelineAsset;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetCurrentIndex")]
	public static extern int GetQualityLevel();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	public static extern Object GetQualitySettings();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetCurrentIndex")]
	public static extern void SetQualityLevel(int index, [DefaultValue("true")] bool applyExpensiveChanges);

	public static void IncreaseLevel([DefaultValue("false")] bool applyExpensiveChanges)
	{
		SetQualityLevel(GetQualityLevel() + 1, applyExpensiveChanges);
	}

	public static void DecreaseLevel([DefaultValue("false")] bool applyExpensiveChanges)
	{
		SetQualityLevel(GetQualityLevel() - 1, applyExpensiveChanges);
	}

	public static void SetQualityLevel(int index)
	{
		SetQualityLevel(index, applyExpensiveChanges: true);
	}

	public static void IncreaseLevel()
	{
		IncreaseLevel(applyExpensiveChanges: false);
	}

	public static void DecreaseLevel()
	{
		DecreaseLevel(applyExpensiveChanges: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_shadowCascade4Split_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_shadowCascade4Split_Injected(ref Vector3 value);
}
