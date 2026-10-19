using System.Collections.Generic;
using UnityEngine.Rendering.Universal.Internal;

namespace UnityEngine.Rendering.Universal;

internal class DecalGBufferRenderPass : ScriptableRenderPass
{
	private FilteringSettings m_FilteringSettings;

	private ProfilingSampler m_ProfilingSampler;

	private List<ShaderTagId> m_ShaderTagIdList;

	private DecalDrawGBufferSystem m_DrawSystem;

	private DeferredLights m_DeferredLights;

	private RenderTargetIdentifier[] m_GbufferAttachments;

	private RenderTargetIdentifier[] m_GbufferInputs;

	private bool[] m_InputsIsTransient;

	private RenderTargetBinding m_RenderTargetBinding;

	private readonly RenderBufferLoadAction[] m_ColorLoadActions = new RenderBufferLoadAction[4];

	private readonly RenderBufferStoreAction[] m_ColorStoreActions = new RenderBufferStoreAction[4];

	internal override bool supportsNativeGBufferExtensionPass => true;

	public DecalGBufferRenderPass(DecalDrawGBufferSystem drawSystem)
	{
		profilingSampler = new ProfilingSampler("DecalGBufferRenderPass");
		renderPassEvent = RenderPassEvent.DecalGBufferPass;
		m_DrawSystem = drawSystem;
		m_ProfilingSampler = new ProfilingSampler("Decal GBuffer Render");
		m_FilteringSettings = new FilteringSettings(RenderQueueRange.opaque);
		m_ShaderTagIdList = new List<ShaderTagId>();
		if (drawSystem == null)
		{
			m_ShaderTagIdList.Add(new ShaderTagId("DecalGBufferProjector"));
		}
		else
		{
			m_ShaderTagIdList.Add(new ShaderTagId("DecalGBufferMesh"));
		}
		m_InputsIsTransient = new bool[2] { true, false };
		m_RenderTargetBinding.colorLoadActions = m_ColorLoadActions;
		m_RenderTargetBinding.colorStoreActions = m_ColorStoreActions;
		m_RenderTargetBinding.depthLoadAction = RenderBufferLoadAction.Load;
		m_RenderTargetBinding.depthStoreAction = RenderBufferStoreAction.Store;
	}

	internal void Setup(DeferredLights deferredLights)
	{
		m_DeferredLights = deferredLights;
	}

	public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
	{
		if (m_GbufferAttachments == null)
		{
			m_GbufferAttachments = new RenderTargetIdentifier[4];
		}
		for (int i = 0; i < m_GbufferAttachments.Length; i++)
		{
			m_GbufferAttachments[i] = m_DeferredLights.GbufferOutputAttachmentIdentifiers[i];
		}
		m_RenderTargetBinding.colorRenderTargets = m_GbufferAttachments;
		m_RenderTargetBinding.depthRenderTarget = m_DeferredLights.DepthAttachmentIdentifier;
		ConfigureTarget(m_GbufferAttachments, m_DeferredLights.DepthAttachmentIdentifier);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		if (nativeRenderPassType == NativeRenderPassType.GBuffer)
		{
			renderingData.cmd.EnableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			nativeRenderPassManager.ConfigureInput(nativeRenderPassManager.GBufferDepthInputAttachment);
			nativeRenderPassManager.ConfigureTarget(1, 2, 3, 4);
		}
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		SortingCriteria defaultOpaqueSortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
		DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, defaultOpaqueSortFlags);
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, m_ProfilingSampler))
		{
			if (nativeRenderPassType == NativeRenderPassType.None)
			{
				cmd.SetRenderTarget(m_RenderTargetBinding);
			}
			NormalReconstruction.SetupProperties(cmd, in renderingData.cameraData);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			m_DrawSystem?.Execute(cmd);
			context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
			if (nativeRenderPassType == NativeRenderPassType.GBuffer)
			{
				cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			}
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
	}
}
