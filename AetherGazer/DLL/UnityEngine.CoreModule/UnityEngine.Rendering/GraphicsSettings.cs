using System.Linq;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[StaticAccessor("GetGraphicsSettings()", StaticAccessorType.Dot)]
[NativeHeader("Runtime/Camera/GraphicsSettings.h")]
public sealed class GraphicsSettings : Object
{
	public static extern TransparencySortMode transparencySortMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static Vector3 transparencySortAxis
	{
		get
		{
			get_transparencySortAxis_Injected(out var ret);
			return ret;
		}
		set
		{
			set_transparencySortAxis_Injected(ref value);
		}
	}

	public static extern bool realtimeDirectRectangularAreaLights
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

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
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern uint defaultRenderingLayerMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool useScriptableRenderPipelineBatching
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool logWhenShaderIsCompiled
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool disableBuiltinCustomRenderTextureUpdate
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern VideoShadersIncludeMode videoShadersIncludeMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern LightProbeOutsideHullStrategy lightProbeOutsideHullStrategy
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
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

	public static RenderPipelineAsset[] allConfiguredRenderPipelines => GetAllConfiguredRenderPipelines().Cast<RenderPipelineAsset>().ToArray();

	public static extern bool cameraRelativeLightCulling
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool cameraRelativeShadowCulling
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	private GraphicsSettings()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool HasShaderDefine(GraphicsTier tier, BuiltinShaderDefine defineHash);

	public static bool HasShaderDefine(BuiltinShaderDefine defineHash)
	{
		return HasShaderDefine(Graphics.activeTier, defineHash);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetAllConfiguredRenderPipelinesForScript")]
	private static extern ScriptableObject[] GetAllConfiguredRenderPipelines();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	public static extern Object GetGraphicsSettings();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetShaderModeScript")]
	public static extern void SetShaderMode(BuiltinShaderType type, BuiltinShaderMode mode);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetShaderModeScript")]
	public static extern BuiltinShaderMode GetShaderMode(BuiltinShaderType type);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetCustomShaderScript")]
	public static extern void SetCustomShader(BuiltinShaderType type, Shader shader);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetCustomShaderScript")]
	public static extern Shader GetCustomShader(BuiltinShaderType type);

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

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_transparencySortAxis_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_transparencySortAxis_Injected(ref Vector3 value);
}
