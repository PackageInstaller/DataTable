namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class DeferredLightClusterPass : ScriptableRenderPass
{
	private readonly DeferredLights m_DeferredLights;

	public DeferredLightClusterPass(RenderPassEvent evt, DeferredLights deferredLights)
	{
		profilingSampler = new ProfilingSampler("Deferred Cluster Setup");
		renderPassEvent = evt;
		m_DeferredLights = deferredLights;
		targetCount = 0u;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		m_DeferredLights.SetupDeferredCluster(renderingData.cmd, ref renderingData);
	}
}
