namespace UnityEngine.Rendering.Universal;

public class DistortionMergePass : ScriptableRenderPass
{
	private Material m_material;

	private const string PASS2 = "Distortion : Blend";

	public DistortionMergePass(Material mat)
	{
		profilingSampler = new ProfilingSampler("Distortion : Blend");
		m_material = mat;
		renderPassEvent = RenderPassEvent.DistortionMergePass;
		nativeRenderPassType = NativeRenderPassType.Distortion;
		ConfigureColorAttachment(RenderBufferLoadAction.DontCare);
	}

	public override void Configure(ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		ConfigureTarget(renderer.cameraColorTarget, BuiltinRenderTextureType.None);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureTarget(2);
		nativeRenderPassManager.ConfigureInput(1);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			UniversalRenderer renderer = renderingData.cameraData.renderer;
			cmd.SetGlobalTexture(ACTRenderingFunction.MainTexTag, renderer.GetCameraColorFrontBuffer(cmd));
			RenderingUtils.DrawProcedural(cmd, m_material, 0, Vector2.one);
		}
	}
}
