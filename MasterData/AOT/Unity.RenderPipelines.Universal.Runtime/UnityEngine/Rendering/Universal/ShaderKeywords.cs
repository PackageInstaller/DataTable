namespace UnityEngine.Rendering.Universal;

public static class ShaderKeywords
{
	public static readonly GlobalKeyword SceneScatterKeyword = GlobalKeyword.Create("_SCENE_SCATTER");

	public static readonly GlobalKeyword NativeRPKeyword = GlobalKeyword.Create("_NATIVE_RP");

	public static readonly GlobalKeyword FetchGBufferKeyword = GlobalKeyword.Create("_FETCH_GBUFFER");

	public static readonly GlobalKeyword GBufferDepthOutputKeyword = GlobalKeyword.Create("_GBUFFER_DEPTH_OUTPUT");

	public static readonly GlobalKeyword CapsuleAOKeyword = GlobalKeyword.Create("_HAS_CAPSULE_OCCLUSION");

	public static readonly GlobalKeyword SSRKeyword = GlobalKeyword.Create("_SSR_FOG");

	public static readonly GlobalKeyword FilmBlackKeyword = GlobalKeyword.Create("_NEED_FILM_BLACK");

	public static readonly GlobalKeyword MobileRenderPassScheduleKeyword = GlobalKeyword.Create("_RENDER_PASS_SCHEDULE_MOBILE");

	public static readonly GlobalKeyword SkyMotionMrtKeyword = GlobalKeyword.Create("_ACT_SKY_MOTION_MRT");
}
