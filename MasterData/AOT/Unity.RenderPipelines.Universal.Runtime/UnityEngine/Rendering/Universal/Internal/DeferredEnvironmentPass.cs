namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class DeferredEnvironmentPass : ScriptableRenderPass
{
	private readonly DeferredLights m_DeferredLights;

	internal override bool supportsNativePostDeferredPass => true;

	public DeferredEnvironmentPass(RenderPassEvent evt, DeferredLights deferredLights)
	{
		profilingSampler = new ProfilingSampler("DeferredEnvironmentPass");
		renderPassEvent = evt;
		m_DeferredLights = deferredLights;
		targetCount = 0u;
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		m_DeferredLights.BeginEnvironmentSubPass(nativeRenderPassType, ref context, ref renderingData);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		m_DeferredLights.ExecuteDeferredEnvironmentPass(nativeRenderPassType, ref context, ref renderingData);
	}
}
