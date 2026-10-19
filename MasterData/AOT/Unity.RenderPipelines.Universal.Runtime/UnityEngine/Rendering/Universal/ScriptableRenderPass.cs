using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public abstract class ScriptableRenderPass
{
	public NativeRenderPassType nativeRenderPassType;

	private RenderBufferStoreAction m_ColorStoreAction;

	private RenderBufferStoreAction m_DepthStoreAction;

	private RenderBufferLoadAction m_ColorLoadAction;

	private RenderBufferLoadAction m_DepthLoadAction;

	private RenderTargetIdentifier[] m_ColorAttachments;

	internal RenderTargetIdentifier[] m_InputAttachments;

	internal bool[] m_InputAttachmentIsTransient;

	private RenderTargetIdentifier m_DepthAttachment;

	private ClearFlag m_ClearFlag;

	private Color m_ClearColor = Color.black;

	internal virtual bool supportsNativePostDeferredPass => false;

	internal virtual bool supportsNativeGBufferExtensionPass => false;

	public RenderPassEvent renderPassEvent { get; set; }

	public RenderTargetIdentifier[] colorAttachments => m_ColorAttachments;

	public RenderTargetIdentifier colorAttachment => m_ColorAttachments[0];

	public RenderTargetIdentifier depthAttachment => m_DepthAttachment;

	public RenderBufferStoreAction colorStoreAction => m_ColorStoreAction;

	public RenderBufferStoreAction depthStoreAction => m_DepthStoreAction;

	public ClearFlag clearFlag => m_ClearFlag;

	public Color clearColor => m_ClearColor;

	public uint targetCount { get; set; } = 1u;

	protected internal ProfilingSampler profilingSampler { get; set; }

	internal bool overrideCameraTarget { get; set; }

	internal bool isBlitRenderPass { get; set; }

	internal int renderTargetWidth { get; set; }

	internal int renderTargetHeight { get; set; }

	internal bool depthOnly { get; set; }

	internal bool isLastPass { get; set; }

	internal int renderPassQueueIndex { get; set; }

	public virtual void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
	}

	public ScriptableRenderPass()
	{
		renderPassEvent = RenderPassEvent.RenderObjectsAfterOpaquePass;
		m_ColorAttachments = new RenderTargetIdentifier[8]
		{
			BuiltinRenderTextureType.CameraTarget,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		};
		m_InputAttachments = new RenderTargetIdentifier[8] { -1, -1, -1, -1, -1, -1, -1, -1 };
		m_InputAttachmentIsTransient = new bool[8];
		m_DepthAttachment = BuiltinRenderTextureType.None;
		m_ColorStoreAction = RenderBufferStoreAction.Store;
		m_DepthStoreAction = RenderBufferStoreAction.Store;
		m_ColorLoadAction = RenderBufferLoadAction.Load;
		m_DepthLoadAction = RenderBufferLoadAction.Load;
		m_ClearFlag = ClearFlag.None;
		m_ClearColor = Color.black;
		overrideCameraTarget = false;
		isBlitRenderPass = false;
		profilingSampler = new ProfilingSampler("Unnamed_ScriptableRenderPass");
		renderTargetWidth = -1;
		renderTargetHeight = -1;
		renderPassQueueIndex = -1;
		depthOnly = false;
	}

	public void ConfigureColorAttachment(RenderBufferLoadAction loadAction = RenderBufferLoadAction.Load, RenderBufferStoreAction storeAction = RenderBufferStoreAction.Store, bool clearAttachment = false, Color clearColor = default(Color))
	{
		if (loadAction == RenderBufferLoadAction.Clear)
		{
			loadAction = RenderBufferLoadAction.DontCare;
			clearAttachment = true;
		}
		m_ColorLoadAction = loadAction;
		m_ColorStoreAction = storeAction;
		ConfigureClearFlag(ClearFlag.Color, clearAttachment, clearColor);
	}

	public void ConfigureDepthAttachment(RenderBufferLoadAction loadAction = RenderBufferLoadAction.Load, RenderBufferStoreAction storeAction = RenderBufferStoreAction.Store, ClearFlag clearFlag = ClearFlag.None, Color clearColor = default(Color))
	{
		if (loadAction == RenderBufferLoadAction.Clear)
		{
			loadAction = RenderBufferLoadAction.DontCare;
			clearFlag |= ClearFlag.DepthStencil;
		}
		m_DepthLoadAction = loadAction;
		m_DepthStoreAction = storeAction;
		ConfigureClearFlag(ClearFlag.DepthStencil, enabled: false, clearColor);
		clearFlag &= ClearFlag.DepthStencil;
		ConfigureClearFlag(clearFlag, clearFlag != ClearFlag.None, clearColor);
	}

	internal RenderBufferLoadAction GetColorLoadAction()
	{
		return m_ColorLoadAction;
	}

	internal RenderBufferLoadAction GetDepthLoadAction()
	{
		return m_DepthLoadAction;
	}

	private void ConfigureClearFlag(ClearFlag clearFlag, bool enabled, Color clearColor)
	{
		if (enabled)
		{
			m_ClearFlag |= clearFlag;
			m_ClearColor = clearColor;
		}
		else
		{
			m_ClearFlag &= ~clearFlag;
		}
	}

	internal void ConfigureInputAttachments(RenderTargetIdentifier input, bool isTransient = false)
	{
		m_InputAttachments[0] = input;
		m_InputAttachmentIsTransient[0] = isTransient;
	}

	internal void ConfigureInputAttachments(RenderTargetIdentifier[] inputs)
	{
		m_InputAttachments = inputs;
	}

	internal void ConfigureInputAttachments(RenderTargetIdentifier[] inputs, bool[] isTransient)
	{
		ConfigureInputAttachments(inputs);
		m_InputAttachmentIsTransient = isTransient;
	}

	internal void SetInputAttachmentTransient(int idx, bool isTransient)
	{
		m_InputAttachmentIsTransient[idx] = isTransient;
	}

	internal bool IsInputAttachmentTransient(int idx)
	{
		return m_InputAttachmentIsTransient[idx];
	}

	public void ConfigureTarget(RenderTargetIdentifier colorAttachment, RenderTargetIdentifier depthAttachment)
	{
		m_DepthAttachment = depthAttachment;
		ConfigureTarget(colorAttachment);
	}

	internal void ConfigureTarget(RenderTargetIdentifier colorAttachment, RenderTargetIdentifier depthAttachment, GraphicsFormat format)
	{
		m_DepthAttachment = depthAttachment;
		ConfigureTarget(colorAttachment, format, depth: false);
	}

	public void ConfigureTarget(RenderTargetIdentifier[] colorAttachments, RenderTargetIdentifier depthAttachment)
	{
		overrideCameraTarget = true;
		targetCount = RenderingUtils.GetValidColorBufferCount(colorAttachments);
		m_ColorAttachments = colorAttachments;
		m_DepthAttachment = depthAttachment;
	}

	public void ConfigureTarget(RenderTargetIdentifier colorAttachment)
	{
		overrideCameraTarget = true;
		m_ColorAttachments[0] = colorAttachment;
		for (int i = 1; i < m_ColorAttachments.Length; i++)
		{
			m_ColorAttachments[i] = 0;
		}
	}

	internal void ConfigureTarget(RenderTargetIdentifier colorAttachment, GraphicsFormat format, bool depth)
	{
		ConfigureTarget(colorAttachment);
		depthOnly = depth;
	}

	public void ConfigureClear(ClearFlag clearFlag, Color clearColor)
	{
		m_ClearFlag = clearFlag;
		m_ClearColor = clearColor;
	}

	public virtual void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
	{
	}

	public virtual void Configure(ref RenderingData renderingData)
	{
	}

	public virtual void OnCameraCleanup(CommandBuffer cmd)
	{
	}

	public abstract void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData);

	public void Blit(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination, Material material = null, int passIndex = 0)
	{
		ScriptableRenderer.SetRenderTarget(cmd, destination, BuiltinRenderTextureType.None, clearFlag, clearColor);
		cmd.Blit(source, destination, material, passIndex);
	}

	public void Blit(CommandBuffer cmd, ref RenderingData data, Material material, int passIndex = 0)
	{
		UniversalRenderer renderer = data.cameraData.renderer;
		Blit(cmd, renderer.cameraColorTarget, renderer.GetCameraColorFrontBuffer(cmd), material, passIndex);
		renderer.SwapColorBuffer();
	}

	public DrawingSettings CreateDrawingSettings(ShaderTagId shaderTagId, ref RenderingData renderingData, SortingCriteria sortingCriteria)
	{
		Camera camera = renderingData.cameraData.camera;
		SortingSettings sortingSettings = renderingData.sortingSettings;
		sortingSettings.criteria = sortingCriteria;
		DrawingSettings result = new DrawingSettings(shaderTagId, sortingSettings);
		result.perObjectData = renderingData.perObjectData;
		result.mainLightIndex = renderingData.lightData.mainLightIndex;
		result.enableDynamicBatching = renderingData.supportsDynamicBatching;
		result.enableInstancing = camera.cameraType != CameraType.Preview;
		return result;
	}

	public DrawingSettings CreateDrawingSettings(List<ShaderTagId> shaderTagIdList, ref RenderingData renderingData, SortingCriteria sortingCriteria)
	{
		if (shaderTagIdList == null || shaderTagIdList.Count == 0)
		{
			Debug.LogWarning("ShaderTagId list is invalid. DrawingSettings is created with default pipeline ShaderTagId");
			return CreateDrawingSettings(new ShaderTagId("UniversalPipeline"), ref renderingData, sortingCriteria);
		}
		DrawingSettings result = CreateDrawingSettings(shaderTagIdList[0], ref renderingData, sortingCriteria);
		for (int i = 1; i < shaderTagIdList.Count; i++)
		{
			result.SetShaderPassName(i, shaderTagIdList[i]);
		}
		return result;
	}

	public DrawingSettings CreateDrawingSettings(ShaderTagId[] shaderTagIdList, ref RenderingData renderingData, SortingCriteria sortingCriteria)
	{
		if (shaderTagIdList == null || shaderTagIdList.Length == 0)
		{
			Debug.LogWarning("ShaderTagId list is invalid. DrawingSettings is created with default pipeline ShaderTagId");
			return CreateDrawingSettings(new ShaderTagId("UniversalPipeline"), ref renderingData, sortingCriteria);
		}
		DrawingSettings result = CreateDrawingSettings(shaderTagIdList[0], ref renderingData, sortingCriteria);
		for (int i = 1; i < shaderTagIdList.Length; i++)
		{
			result.SetShaderPassName(i, shaderTagIdList[i]);
		}
		return result;
	}

	public void UpdateDrawingSettings(ref DrawingSettings drawSettings, ref RenderingData renderingData)
	{
		SortingSettings sortingSettings = renderingData.sortingSettings;
		sortingSettings.criteria = drawSettings.sortingSettings.criteria;
		drawSettings.sortingSettings = sortingSettings;
		drawSettings.mainLightIndex = renderingData.lightData.mainLightIndex;
		drawSettings.perObjectData = renderingData.perObjectData;
	}

	public static bool operator <(ScriptableRenderPass lhs, ScriptableRenderPass rhs)
	{
		return lhs.renderPassEvent < rhs.renderPassEvent;
	}

	public static bool operator >(ScriptableRenderPass lhs, ScriptableRenderPass rhs)
	{
		return lhs.renderPassEvent > rhs.renderPassEvent;
	}
}
