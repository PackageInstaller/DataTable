using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering.RendererUtils;

namespace UnityEngine.Rendering.Universal;

public class DistortionPass : ScriptableRenderPass
{
	private FilteringSettings m_FilteringSettings;

	private RenderStateBlock m_RenderStateBlock;

	private List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

	private ShaderTagId[] m_ShaderTagIds;

	private List<RendererList> m_RendererLists = new List<RendererList>(1);

	private RenderTargetIdentifier m_DistortionRT;

	private int DistortionRT = Shader.PropertyToID("_DistortionOffsetRT");

	private const string PASS1 = "Distortion : Create Texture";

	public DistortionPass()
	{
		profilingSampler = new ProfilingSampler("Distortion : Create Texture");
		renderPassEvent = RenderPassEvent.DistortionPass;
		m_ShaderTagIdList.Add(new ShaderTagId("ACTDistortion"));
		m_ShaderTagIds = m_ShaderTagIdList.ToArray();
		m_FilteringSettings = new FilteringSettings(RenderQueueRange.transparent);
		m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
		m_DistortionRT = new RenderTargetIdentifier(DistortionRT);
		ConfigureColorAttachment(RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, clearAttachment: true, Color.black);
		ConfigureDepthAttachment(RenderBufferLoadAction.Load, RenderBufferStoreAction.DontCare);
		nativeRenderPassType = NativeRenderPassType.Distortion;
	}

	public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
	{
		if (!renderingData.nativeRenderPass)
		{
			RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
			cmd.GetTemporaryRT(DistortionRT, cameraTargetDescriptor.width, cameraTargetDescriptor.height, 0, FilterMode.Point, GraphicsFormat.R16G16_SFloat);
		}
	}

	internal bool SetupVisible(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		RendererListDesc rendererListDesc = new RendererListDesc(m_ShaderTagIds, renderingData.cullResults, renderingData.cameraData.camera);
		rendererListDesc.renderQueueRange = RenderQueueRange.transparent;
		rendererListDesc.sortingCriteria = SortingCriteria.CommonTransparent;
		RendererListDesc desc = rendererListDesc;
		RendererList rendererList = context.CreateRendererList(desc);
		m_RendererLists.Clear();
		m_RendererLists.Add(rendererList);
		context.PrepareRendererListsAsync(m_RendererLists);
		return context.QueryRendererListStatus(rendererList) == RendererListStatus.kRendererListPopulated;
	}

	public override void Configure(ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		renderer.SwapColorBuffer();
		ConfigureTarget(m_DistortionRT, renderer.cameraDepthTarget);
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		cmd.ReleaseTemporaryRT(DistortionRT);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureTarget(1);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, SortingCriteria.CommonTransparent);
			context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings, ref m_RenderStateBlock);
		}
	}
}
