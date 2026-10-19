namespace UnityEngine.Rendering.Universal;

public static class ShaderKeywordStrings
{
	public const string AdditionalLightsVertex = "_ADDITIONAL_LIGHTS_VERTEX";

	public const string EnvironmentRim = "_ENVIRONMENT_RIM";

	public const string AdditionalLightsPixel = "_ADDITIONAL_LIGHTS";

	internal const string ClusteredLighting = "_CLUSTERED_LIGHTING";

	internal const string DeferredClusterEditor128 = "_DEFERRED_CLUSTER_EDITOR_128";

	internal const string FogLinear = "FOG_LINEAR";

	public const string SkyMotionMrt = "_ACT_SKY_MOTION_MRT";

	internal const string ACTCurve = "_ACT_CURVE";

	public const string DeferredReflectionProbeRuntimeAtlas = "_DEFERRED_REFLECTION_PROBE_RUNTIME_ATLAS";

	public const string DeferredBakeryVolumeGI = "_DEFERRED_BAKERY_VOLUME_GI";

	public const string SoftShadows = "_SHADOWS_SOFT";

	public const string LightLayers = "_LIGHT_LAYERS";

	public const string NATIVE_RP = "_NATIVE_RP";

	public const string FETCH_GBUFFER = "_FETCH_GBUFFER";

	public const string GBUFFER_DEPTH_OUTPUT = "_GBUFFER_DEPTH_OUTPUT";

	public const string UNITY_NATIVE_RP = "_RENDER_PASS_ENABLED";

	public const string _PP_DISABLE = "_PP_DISABLE";

	public const string _IS_SCENE_VIEW = "_IS_SCENE_VIEW";

	public const string _SSR_FOG = "_SSR_FOG";

	public const string LinearToSRGBConversion = "_LINEAR_TO_SRGB_CONVERSION";

	public const string SRGBToLinearConversion = "_SRGB_TO_LINEAR_CONVERSION";

	internal const string NeedBloom = "_NEED_BLOOM";

	public const string PaniniGeneric = "_GENERIC";

	public const string PaniniUnitDistance = "_UNIT_DISTANCE";

	public const string TonemapACES = "_TONEMAP_ACES";

	public const string TonemapNeutral = "_TONEMAP_NEUTRAL";

	public const string FilmGrain = "_FILM_GRAIN";

	public const string HighQualitySampling = "_HIGH_QUALITY_SAMPLING";

	public const string _DEFERRED_FIRST_LIGHT = "_DEFERRED_FIRST_LIGHT";

	public const string _GBUFFER_NORMALS_OCT = "_GBUFFER_NORMALS_OCT";

	public const string DEBUG_DISPLAY = "DEBUG_DISPLAY";

	public const string _DEBUG = "_DEBUG";

	public const string _HAS_CAPSULE_OCCLUSION = "_HAS_CAPSULE_OCCLUSION";

	public const string _ACT_ARTLINE = "_ACT_ARTLINE";

	public const string _ISFORWARD = "_ISFORWARD";

	public const string MobileRenderPassSchedule = "_RENDER_PASS_SCHEDULE_MOBILE";

	public const string TemporalHistoryAvailable = "_TEMPORAL_HISTORY_AVAILABLE";

	public const string _GTAO_ON = "_GTAO_ON";

	public const string _SCENE_SCATTER = "_SCENE_SCATTER";

	public const string _BaseColorCheck = "_BASECOLOR_CHECK";

	public const string _MetallicColorCheck = "_METALLIC_CHECK";

	public const string _SmoothnessColorCheck = "_SMOOTHNESS_CHECK";

	public const string _NormalCheck = "_WORLDNORMAL_CHECK";

	public const string _AmbientDiffCheck = "_AMBIENT_DIFFUSE_CHECK";

	public const string _AmbientSpecCheck = "_AMBIENT_SPEC_CHECK";

	public const string _ShadowMaskCheck = "_SHADOW_MASK_CHECK";

	public const string _LuminanceCheck = "_LUMINANCE_CHECK";

	public const string _PixelDensityCheck = "_PIXEL_DENSITY_CHECK";
}
