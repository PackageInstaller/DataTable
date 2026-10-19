namespace UnityEngine.Rendering.Universal.Internal;

public class CopyDepthPass : ScriptableRenderPass
{
	private int m_GlobalTextureId = -1;

	private Material m_CopyDepthMaterial;

	private RenderTargetIdentifier destination { get; set; }

	public CopyDepthPass(RenderPassEvent evt, Material copyDepthMaterial)
	{
		profilingSampler = new ProfilingSampler("CopyDepthPass");
		m_CopyDepthMaterial = copyDepthMaterial;
		renderPassEvent = evt;
		targetCount = 0u;
	}

	public void Setup(RenderTargetIdentifier destination, int globalTextureId = -1)
	{
		this.destination = destination;
		m_GlobalTextureId = globalTextureId;
	}

	public override void Configure(ref RenderingData renderingData)
	{
		nativeRenderPassType = NativeRenderPassType.None;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_CopyDepthMaterial == null)
		{
			Debug.LogErrorFormat("Missing {0}. {1} render pass will not execute. Check for missing reference in the renderer resources.", m_CopyDepthMaterial, GetType().Name);
			return;
		}
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.CopyDepth)))
		{
			cmd.SetRenderTarget(destination, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
			ScriptableRenderer.InvalidateActiveRenderTarget();
			CameraData cameraData = renderingData.cameraData;
			bool flag = cameraData.cameraType == CameraType.Game && destination == RenderTargetHandle.CameraTarget.Identifier();
			float num = ((cameraData.isCameraProjectionMatrixFlipped && !flag) ? (-1f) : 1f);
			Vector4 value = ((num < 0f) ? new Vector4(num, 1f, -1f, 1f) : new Vector4(num, 0f, 1f, 1f));
			cmd.SetGlobalVector(ShaderPropertyId.scaleBiasRt, value);
			if (flag)
			{
				cmd.SetViewport(cameraData.pixelRect);
			}
			cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, m_CopyDepthMaterial, 0, 0);
			if (m_GlobalTextureId >= 0)
			{
				cmd.SetGlobalTexture(m_GlobalTextureId, destination);
			}
		}
	}
}
