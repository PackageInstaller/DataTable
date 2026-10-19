namespace UnityEngine.Rendering.Universal;

public struct RenderingData
{
	internal CommandBuffer cmd;

	public CullingResults cullResults;

	public CameraData cameraData;

	public LightData lightData;

	public ShadowData shadowData;

	public PostProcessingData postProcessingData;

	public bool supportsDynamicBatching;

	public PerObjectData perObjectData;

	public SortingSettings sortingSettings;

	public bool nativeRenderPass;

	internal bool splitNativeDeferredForDepth;

	internal NativeDeferredMode nativeDeferredMode;

	internal bool nativePostDeferredPass;

	internal bool preserveDepthStencilForGrabPass;

	internal bool sceneToneInGrabPass;

	public NativeRenderPassManager nativeRenderPassManager;

	public Material proximaTestMat;

	public bool doGrabPass;
}
