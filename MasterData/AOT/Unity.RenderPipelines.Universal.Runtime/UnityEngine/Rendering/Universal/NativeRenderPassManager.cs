using Unity.Collections;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering.Universal.Internal;

namespace UnityEngine.Rendering.Universal;

public class NativeRenderPassManager
{
	public bool autoExposureEnabledForCamera;

	private NativeRenderPassType m_CurrentPassType;

	private bool m_IsInSubPass;

	private int[] m_Targets = new int[8];

	private int[] m_Inputs = new int[8];

	private int[] m_WishTargets = new int[8];

	private int[] m_WishInputs = new int[8];

	private bool m_DepthDefaultLoadStore;

	private bool m_GBufferWritesDepthTexture;

	public const int DEPTH = 0;

	public const int GBUFFER_COLOR = 1;

	public const int GBUFFER_MOTION_FEATURE = 2;

	public const int GBUFFER_MATERIAL_1 = 3;

	public const int GBUFFER_MATERIAL_0 = 4;

	public const int GBUFFER_DEPTH_INPUT = 5;

	public const int DEFERRED_COLOR_1 = 0;

	public const int DEFERRED_MOTION_FEATURE = 1;

	public const int POST_DEFERRED_COLOR = 1;

	public const int POST_DEFERRED_MOTION_FEATURE = 2;

	public const int POST_TO_SCREEN_COLOR = 1;

	public const int POST_TO_SCREEN_SCREEN = 2;

	public const int DISTORTION_DISTORTION = 1;

	public const int DISTORTION_COLOR = 2;

	public NativeRenderPassType CurrentPassType => m_CurrentPassType;

	public bool GBufferWritesDepthTexture => m_GBufferWritesDepthTexture;

	public int GBufferDepthInputAttachment
	{
		get
		{
			if (!m_GBufferWritesDepthTexture)
			{
				return 0;
			}
			return 5;
		}
	}

	public int CurrentCameraColorAttachment => m_CurrentPassType switch
	{
		NativeRenderPassType.GBuffer => 1, 
		NativeRenderPassType.Deferred => 0, 
		NativeRenderPassType.PostDeferred => 1, 
		_ => 1, 
	};

	public int CurrentMotionFeatureAttachment => m_CurrentPassType switch
	{
		NativeRenderPassType.GBuffer => 2, 
		NativeRenderPassType.Deferred => 1, 
		_ => 2, 
	};

	public NativeRenderPassManager()
	{
		for (int i = 0; i < m_Targets.Length; i++)
		{
			m_WishTargets[i] = -1;
			m_WishInputs[i] = -1;
		}
		if (SystemInfo.hasHiddenSurfaceRemovalOnGPU && !LoadStoreActionDebugModeSettings.LoadStoreDebugModeEnabled)
		{
			m_DepthDefaultLoadStore = false;
		}
		else
		{
			m_DepthDefaultLoadStore = true;
		}
	}

	private int GetTargetCount()
	{
		int i;
		for (i = 0; i < m_Targets.Length && m_Targets[i] != -1; i++)
		{
		}
		return i;
	}

	private int GetInputCount()
	{
		int i;
		for (i = 0; i < m_Inputs.Length && m_Inputs[i] != -1; i++)
		{
		}
		return i;
	}

	private bool HasInput(int attachment)
	{
		for (int i = 0; i < m_Inputs.Length && m_Inputs[i] != -1; i++)
		{
			if (m_Inputs[i] == attachment)
			{
				return true;
			}
		}
		return false;
	}

	private void SetTargetsAndInputs()
	{
		for (int i = 0; i < m_Targets.Length; i++)
		{
			m_Targets[i] = m_WishTargets[i];
			m_Inputs[i] = m_WishInputs[i];
			m_WishTargets[i] = -1;
			m_WishInputs[i] = -1;
		}
	}

	private void ClearWishInputs()
	{
		for (int i = 0; i < m_WishInputs.Length; i++)
		{
			m_WishInputs[i] = -1;
		}
	}

	private bool IsSame()
	{
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (m_Targets[i] != m_WishTargets[i] || m_Inputs[i] != m_WishInputs[i])
			{
				return false;
			}
		}
		return true;
	}

	public void ConfigureTarget(int t1)
	{
		m_WishTargets[0] = t1;
	}

	public void ConfigureTarget(int t1, int t2)
	{
		m_WishTargets[0] = t1;
		m_WishTargets[1] = t2;
	}

	public void ConfigureTarget(int t1, int t2, int t3, int t4)
	{
		m_WishTargets[0] = t1;
		m_WishTargets[1] = t2;
		m_WishTargets[2] = t3;
		m_WishTargets[3] = t4;
	}

	public void ConfigureTarget(int t1, int t2, int t3, int t4, int t5)
	{
		m_WishTargets[0] = t1;
		m_WishTargets[1] = t2;
		m_WishTargets[2] = t3;
		m_WishTargets[3] = t4;
		m_WishTargets[4] = t5;
	}

	public void ConfigureInput(int i1)
	{
		m_WishInputs[0] = i1;
	}

	public void ConfigureInput(int i1, int i2)
	{
		m_WishInputs[0] = i1;
		m_WishInputs[1] = i2;
	}

	public void ConfigureInput(int i1, int i2, int i3)
	{
		m_WishInputs[0] = i1;
		m_WishInputs[1] = i2;
		m_WishInputs[2] = i3;
	}

	public void ConfigureInput(int i1, int i2, int i3, int i4)
	{
		m_WishInputs[0] = i1;
		m_WishInputs[1] = i2;
		m_WishInputs[2] = i3;
		m_WishInputs[3] = i4;
	}

	public void ConfigureInput(int i1, int i2, int i3, int i4, int i5)
	{
		m_WishInputs[0] = i1;
		m_WishInputs[1] = i2;
		m_WishInputs[2] = i3;
		m_WishInputs[3] = i4;
		m_WishInputs[4] = i5;
	}

	public void BeginSubPass(ref ScriptableRenderContext context)
	{
		if (m_IsInSubPass)
		{
			if (IsSame())
			{
				ClearWishInputs();
				return;
			}
			context.EndSubPass();
		}
		SetTargetsAndInputs();
		PrivateBeginSubPass(ref context);
	}

	private void PrivateBeginSubPass(ref ScriptableRenderContext context)
	{
		int targetCount = GetTargetCount();
		int inputCount = GetInputCount();
		bool flag = HasInput(0);
		if (targetCount == 0)
		{
			Debug.LogError("NativeRenderPassManager BeginSubPass targetCount == 0");
			return;
		}
		NativeArray<int> colors = new NativeArray<int>(targetCount, Allocator.Temp);
		for (int i = 0; i < targetCount; i++)
		{
			colors[i] = m_Targets[i];
		}
		if (inputCount == 0)
		{
			context.BeginSubPass(colors, flag, flag);
		}
		else
		{
			NativeArray<int> inputs = new NativeArray<int>(inputCount, Allocator.Temp);
			for (int j = 0; j < inputCount; j++)
			{
				inputs[j] = m_Inputs[j];
			}
			context.BeginSubPass(colors, inputs, flag, flag);
			inputs.Dispose();
		}
		colors.Dispose();
		m_IsInSubPass = true;
	}

	public void Begin(NativeRenderPassType type, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_CurrentPassType == type)
		{
			return;
		}
		End(ref context, renderingData.cmd);
		m_CurrentPassType = type;
		switch (type)
		{
		case NativeRenderPassType.GBuffer:
			if (renderingData.nativeDeferredMode == NativeDeferredMode.FullTile)
			{
				BeginFullTileGBuffer(ref context, ref renderingData);
			}
			else
			{
				BeginSplitAfterGBuffer(ref context, ref renderingData);
			}
			renderingData.cameraData.renderer.MarkCameraTargetsInitialized();
			break;
		case NativeRenderPassType.Deferred:
			BeginDeferred(ref context, ref renderingData);
			break;
		case NativeRenderPassType.PostDeferred:
			BeginPostDeferred(ref context, ref renderingData);
			break;
		case NativeRenderPassType.Distortion:
			BeginDistortion(ref context, ref renderingData);
			break;
		case NativeRenderPassType.Post_To_Screen:
			BeginFinalPostToScreenBlit(ref context, ref renderingData);
			break;
		}
		if (type != NativeRenderPassType.PostDeferred)
		{
			renderingData.cmd.EnableKeyword(in ShaderKeywords.NativeRPKeyword);
		}
	}

	public void End(ref ScriptableRenderContext context, CommandBuffer cmd)
	{
		if (m_CurrentPassType != NativeRenderPassType.None)
		{
			cmd.DisableKeyword(in ShaderKeywords.NativeRPKeyword);
			cmd.DisableKeyword(in ShaderKeywords.FetchGBufferKeyword);
			cmd.DisableKeyword(in ShaderKeywords.GBufferDepthOutputKeyword);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			if (m_IsInSubPass)
			{
				context.EndSubPass();
				m_IsInSubPass = false;
			}
			context.EndRenderPass();
			ScriptableRenderer.InvalidateActiveRenderTarget();
			m_CurrentPassType = NativeRenderPassType.None;
		}
	}

	private static AttachmentDescriptor CreateDepthAttachment(RenderTargetIdentifier target, bool load, bool store = true)
	{
		AttachmentDescriptor result = new AttachmentDescriptor(UniversalRenderer.cameraDepthStencilFormat);
		if (!load)
		{
			result.ConfigureClear(Color.black);
		}
		result.ConfigureTarget(target, load, store);
		return result;
	}

	private static AttachmentDescriptor CreateColorAttachment(GraphicsFormat format, RenderTargetIdentifier target, bool load, bool store, bool clear)
	{
		AttachmentDescriptor result = new AttachmentDescriptor(format);
		if (clear)
		{
			result.ConfigureClear(Color.clear);
		}
		result.ConfigureTarget(target, load, store);
		return result;
	}

	private static AttachmentDescriptor CreateMotionFeatureAttachment(GraphicsFormat format, RenderTargetIdentifier target, bool store)
	{
		AttachmentDescriptor result = new AttachmentDescriptor(format);
		result.ConfigureClear(new Color(0.5f, 0.5f, 0f, 0f));
		result.ConfigureTarget(target, loadExistingContents: false, store);
		return result;
	}

	private void BeginSplitAfterGBuffer(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		DeferredLights deferredLights = renderer.deferredLights;
		RenderTargetIdentifier[] gbufferAttachmentIdentifiers = deferredLights.GbufferAttachmentIdentifiers;
		GraphicsFormat[] gbufferFormats = deferredLights.GbufferFormats;
		m_GBufferWritesDepthTexture = renderer.WritesNativeGBufferDepthTexture(renderingData.nativeDeferredMode);
		int length = (m_GBufferWritesDepthTexture ? 5 : 4) + 1;
		NativeArray<AttachmentDescriptor> attachments = new NativeArray<AttachmentDescriptor>(length, Allocator.Temp);
		attachments[0] = CreateDepthAttachment(renderer.cameraDepthTarget, load: false);
		attachments[1] = CreateColorAttachment(renderer.cameraColorFormat, renderer.cameraColorTarget, load: false, store: true, clear: true);
		attachments[2] = CreateMotionFeatureAttachment(gbufferFormats[2], gbufferAttachmentIdentifiers[2], store: true);
		attachments[3] = CreateColorAttachment(gbufferFormats[0], gbufferAttachmentIdentifiers[0], load: false, store: true, clear: true);
		attachments[4] = CreateColorAttachment(gbufferFormats[1], gbufferAttachmentIdentifiers[1], load: false, store: true, clear: true);
		if (m_GBufferWritesDepthTexture)
		{
			attachments[5] = CreateColorAttachment(GraphicsFormat.R32_SFloat, renderer.deferredDepthTexture, load: false, store: true, clear: true);
		}
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		context.BeginRenderPass(cameraTargetDescriptor.width, cameraTargetDescriptor.height, 1, attachments, 0);
		attachments.Dispose();
		if (m_GBufferWritesDepthTexture)
		{
			renderingData.cmd.EnableKeyword(in ShaderKeywords.GBufferDepthOutputKeyword);
		}
	}

	private void BeginFullTileGBuffer(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		DeferredLights deferredLights = renderer.deferredLights;
		RenderTargetIdentifier[] gbufferAttachmentIdentifiers = deferredLights.GbufferAttachmentIdentifiers;
		GraphicsFormat[] gbufferFormats = deferredLights.GbufferFormats;
		m_GBufferWritesDepthTexture = renderer.WritesNativeGBufferDepthTexture(renderingData.nativeDeferredMode);
		int length = (m_GBufferWritesDepthTexture ? 5 : 4) + 1;
		NativeArray<AttachmentDescriptor> attachments = new NativeArray<AttachmentDescriptor>(length, Allocator.Temp);
		attachments[0] = CreateDepthAttachment(renderer.cameraDepthTarget, load: false);
		attachments[1] = CreateColorAttachment(renderer.cameraColorFormat, renderer.cameraColorTarget, load: false, store: true, clear: true);
		attachments[2] = CreateMotionFeatureAttachment(gbufferFormats[2], gbufferAttachmentIdentifiers[2], store: true);
		attachments[3] = CreateColorAttachment(gbufferFormats[0], gbufferAttachmentIdentifiers[0], load: false, store: false, clear: true);
		attachments[4] = CreateColorAttachment(gbufferFormats[1], gbufferAttachmentIdentifiers[1], load: false, store: false, clear: true);
		if (m_GBufferWritesDepthTexture)
		{
			attachments[5] = CreateColorAttachment(GraphicsFormat.R32_SFloat, renderer.deferredDepthTexture, load: false, store: true, clear: true);
		}
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		context.BeginRenderPass(cameraTargetDescriptor.width, cameraTargetDescriptor.height, 1, attachments, 0);
		attachments.Dispose();
		if (m_GBufferWritesDepthTexture)
		{
			renderingData.cmd.EnableKeyword(in ShaderKeywords.GBufferDepthOutputKeyword);
		}
	}

	private void BeginDeferred(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		int num = 2;
		NativeArray<AttachmentDescriptor> attachments = new NativeArray<AttachmentDescriptor>(num + 1, Allocator.Temp);
		attachments[0] = CreateColorAttachment(renderer.cameraColorFormat, renderer.cameraColorTarget, load: true, store: true, clear: false);
		attachments[1] = CreateColorAttachment(renderer.motionVectorFormat, renderer.gBuffer2Texture, load: true, store: true, clear: false);
		attachments[num] = CreateDepthAttachment(renderer.cameraDepthTarget, load: true);
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		context.BeginRenderPass(cameraTargetDescriptor.width, cameraTargetDescriptor.height, 1, attachments, num);
		attachments.Dispose();
	}

	private void BeginPostDeferred(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		NativeArray<AttachmentDescriptor> attachments = new NativeArray<AttachmentDescriptor>(3, Allocator.Temp);
		attachments[0] = CreateDepthAttachment(renderer.cameraDepthTarget, load: true);
		bool load = !renderingData.doGrabPass;
		attachments[1] = CreateColorAttachment(renderer.cameraColorFormat, renderer.cameraColorTarget, load, store: true, clear: false);
		attachments[2] = CreateColorAttachment(renderer.motionVectorFormat, renderer.gBuffer2Texture, load: true, store: true, clear: false);
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		context.BeginRenderPass(cameraTargetDescriptor.width, cameraTargetDescriptor.height, 1, attachments, 0);
		attachments.Dispose();
	}

	private void BeginFinalPostToScreenBlit(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		AttachmentDescriptor value = new AttachmentDescriptor(RenderTextureFormat.Depth);
		value.ConfigureClear(Color.black);
		value.ConfigureTarget(BuiltinRenderTextureType.None, loadExistingContents: false, storeResults: false);
		AttachmentDescriptor value2 = new AttachmentDescriptor(renderingData.cameraData.renderer.compactHdrColorFormat);
		value2.ConfigureClear(Color.black);
		value2.ConfigureTarget(BuiltinRenderTextureType.None, loadExistingContents: false, storeResults: false);
		AttachmentDescriptor value3 = new AttachmentDescriptor(GraphicsFormat.B8G8R8A8_UNorm);
		if (renderingData.cameraData.isReAspect)
		{
			value3.ConfigureClear(Color.black);
		}
		value3.ConfigureTarget(BuiltinRenderTextureType.CameraTarget, loadExistingContents: false, storeResults: true);
		NativeArray<AttachmentDescriptor> attachments = new NativeArray<AttachmentDescriptor>(3, Allocator.Temp);
		attachments[0] = value;
		attachments[1] = value2;
		attachments[2] = value3;
		int width = (renderingData.cameraData.isReAspect ? renderingData.cameraData.outputWidth : renderingData.cameraData.pixelWidth);
		int height = (renderingData.cameraData.isReAspect ? renderingData.cameraData.outputHeight : renderingData.cameraData.pixelHeight);
		context.BeginRenderPass(width, height, 1, 1, attachments, 0);
		attachments.Dispose();
		if (renderingData.cameraData.isReAspect)
		{
			renderingData.cmd.SetViewport(renderingData.cameraData.pixelRect);
		}
	}

	private void BeginDistortion(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		RenderTargetIdentifier cameraDepthTarget = renderer.cameraDepthTarget;
		RenderTargetIdentifier cameraColorTarget = renderer.cameraColorTarget;
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		AttachmentDescriptor value = new AttachmentDescriptor(RenderTextureFormat.Depth);
		value.ConfigureTarget(cameraDepthTarget, loadExistingContents: true, m_DepthDefaultLoadStore);
		AttachmentDescriptor value2 = new AttachmentDescriptor(GraphicsFormat.R16G16_SFloat);
		value2.ConfigureClear(Color.black);
		value2.ConfigureTarget(BuiltinRenderTextureType.None, loadExistingContents: false, storeResults: false);
		AttachmentDescriptor value3 = new AttachmentDescriptor(renderer.compactHdrColorFormat);
		value3.ConfigureTarget(cameraColorTarget, loadExistingContents: false, storeResults: true);
		NativeArray<AttachmentDescriptor> attachments = new NativeArray<AttachmentDescriptor>(3, Allocator.Temp);
		attachments[0] = value;
		attachments[1] = value2;
		attachments[2] = value3;
		context.BeginRenderPass(cameraTargetDescriptor.width, cameraTargetDescriptor.height, 1, 1, attachments, 0);
		attachments.Dispose();
	}
}
