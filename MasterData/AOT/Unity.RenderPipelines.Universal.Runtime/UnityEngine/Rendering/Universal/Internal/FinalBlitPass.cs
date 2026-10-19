namespace UnityEngine.Rendering.Universal.Internal;

public class FinalBlitPass : ScriptableRenderPass
{
	private Material m_BlitMaterial;

	private bool m_InputGamma;

	private GlobalKeyword KW_SRGBToLinearConversion;

	public FinalBlitPass(RenderPassEvent evt, Material blitMaterial)
	{
		profilingSampler = new ProfilingSampler("FinalBlitPass");
		m_BlitMaterial = blitMaterial;
		renderPassEvent = evt;
		KW_SRGBToLinearConversion = GlobalKeyword.Create("_SRGB_TO_LINEAR_CONVERSION");
		ConfigureTarget(BuiltinRenderTextureType.CameraTarget);
		ConfigureColorAttachment(RenderBufferLoadAction.DontCare);
		ConfigureDepthAttachment(RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureInput(1);
		nativeRenderPassManager.ConfigureTarget(2);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public void Setup(bool inputGamma)
	{
		m_InputGamma = inputGamma;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			Vector4 scaleBiasTex = Vector2.one;
			bool flag = renderingData.nativeRenderPass && nativeRenderPassType == NativeRenderPassType.Post_To_Screen;
			if (!flag)
			{
				cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, renderingData.cameraData.renderer.cameraColorTarget);
				if (renderingData.cameraData.isGameCamera)
				{
					scaleBiasTex.y = -1f;
					scaleBiasTex.w = 1f;
				}
			}
			Camera camera = renderingData.cameraData.camera;
			bool flag2 = renderingData.cameraData.isReAspect && camera.cameraType == CameraType.Game && !flag;
			if (flag2)
			{
				cmd.SetGlobalVector(ShaderPropertyId.RectChangeData, new Vector4(camera.rect.x, camera.rect.y, camera.rect.width, camera.rect.height));
				cmd.SetGlobalVector(ShaderPropertyId.RectChangeData2, new Vector4(camera.pixelWidth, camera.pixelHeight, Screen.width, Screen.height));
			}
			cmd.SetGlobalFloat(ShaderPropertyId.RectChangeEnabled, flag2 ? 1f : 0f);
			cmd.SetKeyword(in KW_SRGBToLinearConversion, m_InputGamma);
			RenderingUtils.DrawProcedural(cmd, m_BlitMaterial, 0, scaleBiasTex);
			cmd.SetKeyword(in KW_SRGBToLinearConversion, value: false);
			cmd.SetGlobalFloat(ShaderPropertyId.RectChangeEnabled, 0f);
		}
	}
}
