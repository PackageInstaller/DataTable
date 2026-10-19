namespace UnityEngine.Rendering.Universal.Internal;

internal class DeferredPass : ScriptableRenderPass
{
	private readonly DeferredLights m_DeferredLights;

	public DeferredPass(RenderPassEvent evt, DeferredLights deferredLights)
	{
		profilingSampler = new ProfilingSampler("Deferred Direct Light");
		renderPassEvent = evt;
		m_DeferredLights = deferredLights;
		targetCount = 0u;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (nativeRenderPassType == NativeRenderPassType.GBuffer)
		{
			renderingData.cmd.DisableKeyword(in ShaderKeywords.GBufferDepthOutputKeyword);
			renderingData.cmd.EnableKeyword(in ShaderKeywords.FetchGBufferKeyword);
		}
		m_DeferredLights.ExecuteDeferredPass(nativeRenderPassType, ref context, ref renderingData);
	}
}
