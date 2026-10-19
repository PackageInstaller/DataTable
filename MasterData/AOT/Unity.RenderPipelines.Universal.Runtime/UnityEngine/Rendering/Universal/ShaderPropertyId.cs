namespace UnityEngine.Rendering.Universal;

internal static class ShaderPropertyId
{
	public static readonly int glossyEnvironmentColor = Shader.PropertyToID("_GlossyEnvironmentColor");

	public static readonly int subtractiveShadowColor = Shader.PropertyToID("_SubtractiveShadowColor");

	public static readonly int glossyEnvironmentCubeMap = Shader.PropertyToID("_GlossyEnvironmentCubeMap");

	public static readonly int glossyEnvironmentCubeMapHDR = Shader.PropertyToID("_GlossyEnvironmentCubeMap_HDR");

	public static readonly int ambientSkyColor = Shader.PropertyToID("unity_AmbientSky");

	public static readonly int ambientEquatorColor = Shader.PropertyToID("unity_AmbientEquator");

	public static readonly int ambientGroundColor = Shader.PropertyToID("unity_AmbientGround");

	public static readonly int time = Shader.PropertyToID("_Time");

	public static readonly int sinTime = Shader.PropertyToID("_SinTime");

	public static readonly int cosTime = Shader.PropertyToID("_CosTime");

	public static readonly int deltaTime = Shader.PropertyToID("unity_DeltaTime");

	public static readonly int timeParameters = Shader.PropertyToID("_TimeParameters");

	public static readonly int scaledScreenParams = Shader.PropertyToID("_ScaledScreenParams");

	public static readonly int worldSpaceCameraPos = Shader.PropertyToID("_WorldSpaceCameraPos");

	public static readonly int screenParams = Shader.PropertyToID("_ScreenParams");

	public static readonly int projectionParams = Shader.PropertyToID("_ProjectionParams");

	public static readonly int zBufferParams = Shader.PropertyToID("_ZBufferParams");

	public static readonly int orthoParams = Shader.PropertyToID("unity_OrthoParams");

	public static readonly int globalMipBias = Shader.PropertyToID("_GlobalMipBias");

	public static readonly int screenSize = Shader.PropertyToID("_ScreenSize");

	public static readonly int viewMatrix = Shader.PropertyToID("unity_MatrixV");

	public static readonly int projectionMatrix = Shader.PropertyToID("glstate_matrix_projection");

	public static readonly int viewAndProjectionMatrix = Shader.PropertyToID("unity_MatrixVP");

	public static readonly int inverseViewMatrix = Shader.PropertyToID("unity_MatrixInvV");

	public static readonly int inverseProjectionMatrix = Shader.PropertyToID("unity_MatrixInvP");

	public static readonly int inverseViewAndProjectionMatrix = Shader.PropertyToID("unity_MatrixInvVP");

	public static readonly int worldToCameraMatrix = Shader.PropertyToID("unity_WorldToCamera");

	public static readonly int cameraToWorldMatrix = Shader.PropertyToID("unity_CameraToWorld");

	public static readonly int cameraWorldClipPlanes = Shader.PropertyToID("unity_CameraWorldClipPlanes");

	public static readonly int billboardNormal = Shader.PropertyToID("unity_BillboardNormal");

	public static readonly int billboardTangent = Shader.PropertyToID("unity_BillboardTangent");

	public static readonly int billboardCameraParams = Shader.PropertyToID("unity_BillboardCameraParams");

	public static readonly int sourceTex = Shader.PropertyToID("_SourceTex");

	public static readonly int scaleBias = Shader.PropertyToID("_ScaleBias");

	public static readonly int scaleBiasRt = Shader.PropertyToID("_ScaleBiasRt");

	public static readonly int RectChangeData = Shader.PropertyToID("_RectChangeData");

	public static readonly int RectChangeData2 = Shader.PropertyToID("_RectChangeData2");

	public static readonly int RectChangeEnabled = Shader.PropertyToID("_RectChangeEnabled");

	public static readonly int rendererColor = Shader.PropertyToID("_RendererColor");

	public static readonly int isInUICamera = Shader.PropertyToID("_IsInUICamera");

	public static readonly int _CameraDepthAttachment = Shader.PropertyToID("_CameraDepthAttachment");

	public static readonly int _CameraDepthTexture = Shader.PropertyToID("_CameraDepthTexture");

	public static readonly int _DeferredDepthTexture = Shader.PropertyToID("_DeferredDepthTexture");

	public static readonly int _GBuffer2 = Shader.PropertyToID("_GBuffer2");

	public static readonly int _TemporalMotionVectorTexture = Shader.PropertyToID("_TemporalMotionVectorTexture");

	public static readonly int _BackBuffer = Shader.PropertyToID("_BackBuffer");

	public static readonly int _SSSTexture = Shader.PropertyToID("_SSSTexture");

	public static readonly int _Spec0_Tex = Shader.PropertyToID("_Spec0_Tex");

	public static readonly int _Spec0_Len = Shader.PropertyToID("_Spec0_Len");

	public static readonly int _Spec0_Param = Shader.PropertyToID("_Spec0_Param");

	public static readonly int _Spec0_HDRParam = Shader.PropertyToID("_Spec0_HDRParam");

	public static readonly int _Spec1_Tex = Shader.PropertyToID("_Spec1_Tex");

	public static readonly int _Spec1_Len = Shader.PropertyToID("_Spec1_Len");

	public static readonly int _Spec1_Param = Shader.PropertyToID("_Spec1_Param");

	public static readonly int _Spec1_HDRParam = Shader.PropertyToID("_Spec1_HDRParam");
}
