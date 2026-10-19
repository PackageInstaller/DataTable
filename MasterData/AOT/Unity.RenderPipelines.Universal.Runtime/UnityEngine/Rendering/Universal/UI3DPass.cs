using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

public class UI3DPass : ScriptableRenderPass
{
	private DrawingSettings drawSettings;

	private FilteringSettings m_FilteringSettings;

	private List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

	private const SortingCriteria k_SortingCriteria = SortingCriteria.SortingLayer | SortingCriteria.RenderQueue | SortingCriteria.BackToFront;

	private Material m_material;

	private Shader m_shader;

	public UI3DPass()
	{
		profilingSampler = new ProfilingSampler("UI3DPass");
		renderPassEvent = RenderPassEvent.UI3DPass;
		m_ShaderTagIdList.Add(new ShaderTagId("ACT3DUI"));
		m_ShaderTagIdList.Add(ShaderPassTags.UniversalForward);
		m_ShaderTagIdList.Add(ShaderPassTags.UniversalForwardOnly);
		m_FilteringSettings = new FilteringSettings(RenderQueueRange.transparent, 32768);
		targetCount = 0u;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 1f);
			cmd.SetViewProjectionMatrices(renderingData.cameraData.GetViewMatrix(), renderingData.cameraData.NoJitterPMatrix);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			drawSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, SortingCriteria.SortingLayer | SortingCriteria.RenderQueue | SortingCriteria.BackToFront);
			context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref m_FilteringSettings);
			cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 0f);
		}
	}
}
