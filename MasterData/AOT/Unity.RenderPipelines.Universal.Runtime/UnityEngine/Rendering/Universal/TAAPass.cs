namespace UnityEngine.Rendering.Universal;

public class TAAPass : ITemporalResolver
{
	private const float k_EdgeHistoryWeight = 0.4f;

	private Material m_BlitMaterial;

	private float m_StaticHistoryWeight;

	private float m_MovingHistoryWeight;

	private float m_MotionThreshold;

	private int m_TAAData;

	private int m_TAASize;

	private ProfilingSampler m_profilingSampler;

	public bool usesTemporalOutput => false;

	public TAAPass(Material blitMat, TAAFeature.Settings settings)
	{
		m_profilingSampler = new ProfilingSampler("TAAPass");
		m_BlitMaterial = blitMat;
		m_TAAData = Shader.PropertyToID("_TAAData");
		m_TAASize = Shader.PropertyToID("_TAASize");
		Setup(settings);
	}

	internal void Setup(TAAFeature.Settings settings)
	{
		m_StaticHistoryWeight = Mathf.Clamp01(settings.staticHistoryWeight);
		m_MovingHistoryWeight = Mathf.Clamp01(settings.movingHistoryWeight);
		m_MotionThreshold = Mathf.Max(settings.motionThreshold, 0.001f);
	}

	public RenderTargetIdentifier TAABlend(CommandBuffer cmd, RenderTargetIdentifier source, ref RenderingData renderingData)
	{
		if (m_BlitMaterial == null)
		{
			return source;
		}
		using (new ProfilingScope(cmd, m_profilingSampler))
		{
			UniversalRenderer renderer = renderingData.cameraData.renderer;
			if (renderer == null || !renderer.PrepareTAAResolve(ref renderingData))
			{
				return source;
			}
			RenderTargetIdentifier tAA_Target = renderingData.postProcessingData.TAA_Target;
			cmd.SetGlobalVector(m_TAAData, new Vector4(m_StaticHistoryWeight, m_MovingHistoryWeight, 0.4f, m_MotionThreshold));
			int width = renderingData.cameraData.cameraTargetDescriptor.width;
			int height = renderingData.cameraData.cameraTargetDescriptor.height;
			cmd.SetGlobalVector(m_TAASize, new Vector4(width, height, 1f / (float)width, 1f / (float)height));
			cmd.SetRenderTarget(tAA_Target, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
			cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, source);
			cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, m_BlitMaterial, 0, 0);
			renderer.CommitTAAResolve();
			return tAA_Target;
		}
	}

	bool ITemporalResolver.TryResolve(CommandBuffer cmd, RenderTargetIdentifier source, RTHandle sourceHandle, ref RenderingData renderingData, out TemporalResolveResult result)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		if (m_BlitMaterial == null || renderer == null || !renderer.PrepareTAAResolve(ref renderingData))
		{
			result = default;
			return false;
		}
		RenderTargetIdentifier source2 = TAABlend(cmd, source, ref renderingData);
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		result = new TemporalResolveResult(source2, null, cameraTargetDescriptor.width, cameraTargetDescriptor.height);
		return true;
	}
}
