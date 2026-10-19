namespace UnityEngine.Rendering.Universal;

public class DrawSkyboxPass : ScriptableRenderPass
{
	private FilteringSettings m_FilteringSettings;

	private DrawingSettings m_DrawingSettings;

	private ShaderTagId m_ShaderTagId;

	private readonly RenderTargetIdentifier[] m_DeferredColorAttachments;

	private readonly bool m_WritesDeferredSkyMotion;

	public DrawSkyboxPass()
		: this(writesDeferredSkyMotion: false)
	{
	}

	internal DrawSkyboxPass(bool writesDeferredSkyMotion)
	{
		profilingSampler = new ProfilingSampler(writesDeferredSkyMotion ? "Draw Deferred Skybox" : "Draw Other Camera Skybox");
		renderPassEvent = RenderPassEvent.DrawSkyboxPass;
		ConfigureDepthAttachment();
		m_WritesDeferredSkyMotion = writesDeferredSkyMotion;
		if (writesDeferredSkyMotion)
		{
			m_DeferredColorAttachments = new RenderTargetIdentifier[2];
		}
		m_FilteringSettings = new FilteringSettings(RenderQueueRange.all);
		m_ShaderTagId = new ShaderTagId("SkyElement");
	}

	public override void Configure(ref RenderingData renderingData)
	{
		if (!m_WritesDeferredSkyMotion)
		{
			overrideCameraTarget = false;
			targetCount = 1u;
			return;
		}
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		m_DeferredColorAttachments[0] = renderer.cameraColorTarget;
		m_DeferredColorAttachments[1] = renderer.deferredLights.GbufferAttachmentIdentifiers[2];
		ConfigureTarget(m_DeferredColorAttachments, renderer.cameraDepthTarget);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment, nativeRenderPassManager.CurrentMotionFeatureAttachment);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		Camera camera = renderingData.cameraData.camera;
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			cmd.SetKeyword(in ShaderKeywords.SkyMotionMrtKeyword, m_WritesDeferredSkyMotion);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			context.DrawSkybox(camera);
			cmd.Clear();
			m_DrawingSettings = CreateDrawingSettings(m_ShaderTagId, ref renderingData, SortingCriteria.CommonTransparent);
			context.DrawRenderers(renderingData.cullResults, ref m_DrawingSettings, ref m_FilteringSettings);
			cmd.DisableKeyword(in ShaderKeywords.SkyMotionMrtKeyword);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
		}
	}
}
