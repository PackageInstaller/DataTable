namespace UnityEngine.Rendering.Universal;

public class MaterialOverridePass : ScriptableRenderPass
{
	private RenderTargetHandle depth;

	internal override bool supportsNativePostDeferredPass => true;

	public MaterialOverridePass()
	{
		renderPassEvent = RenderPassEvent.MaterialOverridePass;
		profilingSampler = new ProfilingSampler("MaterialOverridePass");
		ConfigureDepthAttachment();
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (renderingData.cameraData.cameraType == CameraType.SceneView || renderingData.cameraData.cameraType == CameraType.Game)
		{
			CommandBuffer cmd = renderingData.cmd;
			using (new ProfilingScope(cmd, profilingSampler))
			{
				MaterialOverride.DrawOverride(cmd);
			}
		}
	}
}
