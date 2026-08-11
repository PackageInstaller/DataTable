using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Camera/GraphicsSettings.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
public sealed class GraphicsSettings : Object
{
	public static extern bool lightsUseLinearIntensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool lightsUseColorTemperature
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern uint defaultRenderingLayerMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool useScriptableRenderPipelineBatching
	{
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeName("CurrentRenderPipeline")]
	private static extern ScriptableObject INTERNAL_currentRenderPipeline
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static RenderPipelineAsset currentRenderPipeline => INTERNAL_currentRenderPipeline as RenderPipelineAsset;

	public static RenderPipelineAsset renderPipelineAsset
	{
		get
		{
			return defaultRenderPipeline;
		}
		set
		{
			defaultRenderPipeline = value;
		}
	}

	[NativeName("DefaultRenderPipeline")]
	private static extern ScriptableObject INTERNAL_defaultRenderPipeline
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static RenderPipelineAsset defaultRenderPipeline
	{
		get
		{
			return INTERNAL_defaultRenderPipeline as RenderPipelineAsset;
		}
		set
		{
			INTERNAL_defaultRenderPipeline = value;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool HasShaderDefine(GraphicsTier tier, BuiltinShaderDefine defineHash);

	public static bool HasShaderDefine(BuiltinShaderDefine defineHash)
	{
		return HasShaderDefine(Graphics.activeTier, defineHash);
	}

	public static void RegisterRenderPipelineSettings<T>(RenderPipelineGlobalSettings settings) where T : RenderPipeline
	{
		RegisterRenderPipeline(typeof(T).FullName, settings);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("RegisterRenderPipelineSettings")]
	private static extern void RegisterRenderPipeline(string renderpipelineName, Object settings);

	public static void UnregisterRenderPipelineSettings<T>() where T : RenderPipeline
	{
		UnregisterRenderPipeline(typeof(T).FullName);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("UnregisterRenderPipelineSettings")]
	private static extern void UnregisterRenderPipeline(string renderpipelineName);

	public static RenderPipelineGlobalSettings GetSettingsForRenderPipeline<T>() where T : RenderPipeline
	{
		return GetSettingsForRenderPipeline(typeof(T).FullName) as RenderPipelineGlobalSettings;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetSettingsForRenderPipeline")]
	private static extern Object GetSettingsForRenderPipeline(string renderpipelineName);
}
