using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Experimental.Rendering;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal.Internal;

public class PostProcessPass : ScriptableRenderPass
{
	private class MaterialLibrary
	{
		public readonly Material gaussianDepthOfField;

		public readonly Material bokehDepthOfField;

		public readonly Material paniniProjection;

		public readonly Material scalingSetup;

		public readonly Material uber;

		public readonly Material finalPass;

		public readonly Material taaMat;

		public readonly ComputeShader motionBlurShader;

		public MaterialLibrary(PostProcessData data)
		{
			gaussianDepthOfField = Load(data.shaders.gaussianDepthOfFieldPS);
			bokehDepthOfField = Load(data.shaders.bokehDepthOfFieldPS);
			paniniProjection = Load(data.shaders.paniniProjectionPS);
			scalingSetup = Load(data.shaders.scalingSetupPS);
			uber = Load(data.shaders.uberPostPS);
			finalPass = Load(data.shaders.finalPostPassPS);
			taaMat = Load(data.shaders.taaShader);
			motionBlurShader = data.shaders.motionBlurShader;
		}

		private Material Load(Shader shader)
		{
			if (shader == null)
			{
				Debug.LogErrorFormat("Missing shader. " + GetType().DeclaringType.Name + " render pass will not execute. Check for missing reference in the renderer resources.");
				return null;
			}
			if (!shader.isSupported)
			{
				return null;
			}
			return CoreUtils.CreateEngineMaterial(shader);
		}

		internal void Cleanup()
		{
			CoreUtils.Destroy(gaussianDepthOfField);
			CoreUtils.Destroy(bokehDepthOfField);
			CoreUtils.Destroy(paniniProjection);
			CoreUtils.Destroy(scalingSetup);
			CoreUtils.Destroy(uber);
			CoreUtils.Destroy(finalPass);
			CoreUtils.Destroy(taaMat);
		}
	}

	private static class ShaderConstants
	{
		public static readonly int _FullCoCTexture = Shader.PropertyToID("_FullCoCTexture");

		public static readonly int _HalfCoCTexture = Shader.PropertyToID("_HalfCoCTexture");

		public static readonly int _DofTexture = Shader.PropertyToID("_DofTexture");

		public static readonly int _CoCParams = Shader.PropertyToID("_CoCParams");

		public static readonly int _BokehKernel = Shader.PropertyToID("_BokehKernel");

		public static readonly int _BokehConstants = Shader.PropertyToID("_BokehConstants");

		public static readonly int _BokehTemp = Shader.PropertyToID("_BokehTemp");

		public static readonly int _PongTexture = Shader.PropertyToID("_PongTexture");

		public static readonly int _PingTexture = Shader.PropertyToID("_PingTexture");

		public static readonly int _LastLoop = Shader.PropertyToID("_LastLoop");

		public static readonly int _ColorTexture = Shader.PropertyToID("_ColorTexture");

		public static readonly int _Params = Shader.PropertyToID("_Params");

		public static readonly int _SourceTexLowMip = Shader.PropertyToID("_SourceTexLowMip");

		public static readonly int _SourceTex_TexelSize = Shader.PropertyToID("_SourceTex_TexelSize");

		public static readonly int _UberPostSharpening = Shader.PropertyToID("_UberPostSharpening");

		public static readonly int _Bloom_Params = Shader.PropertyToID("_Bloom_Params");

		public static readonly int _Bloom_RGBM = Shader.PropertyToID("_Bloom_RGBM");

		public static readonly int _Bloom_Texture = Shader.PropertyToID("_Bloom_Texture");

		public static readonly int _LensDirt_Texture = Shader.PropertyToID("_LensDirt_Texture");

		public static readonly int _LensDirt_Params = Shader.PropertyToID("_LensDirt_Params");

		public static readonly int _LensDirt_Intensity = Shader.PropertyToID("_LensDirt_Intensity");

		public static readonly int _Vignette_Params1 = Shader.PropertyToID("_Vignette_Params1");

		public static readonly int _Vignette_Params2 = Shader.PropertyToID("_Vignette_Params2");

		public static readonly int _Lut_Params = Shader.PropertyToID("_Lut_Params");

		public static readonly int _InternalLut = Shader.PropertyToID("_InternalLut");

		public static readonly int _DownSampleScaleFactor = Shader.PropertyToID("_DownSampleScaleFactor");

		public static readonly int _DepthOfFieldDepthTexture = Shader.PropertyToID("_DepthOfFieldDepthTexture");

		public static readonly int _GaussianSource = Shader.PropertyToID("_GaussianSource");

		public static readonly int _GaussianDepthTexture = Shader.PropertyToID("_GaussianDepthTexture");

		public static readonly int _GaussianCompositeDepthTexture = Shader.PropertyToID("_GaussianCompositeDepthTexture");

		public static readonly int _GaussianHalfColor = Shader.PropertyToID("_GaussianHalfColor");

		public static readonly int _GaussianHalfCoC = Shader.PropertyToID("_GaussianHalfCoC");

		public static readonly int _GaussianHalfColorOutput = Shader.PropertyToID("_GaussianHalfColorOutput");

		public static readonly int _GaussianHalfCoCOutput = Shader.PropertyToID("_GaussianHalfCoCOutput");

		public static readonly int _GaussianBlurOutput = Shader.PropertyToID("_GaussianBlurOutput");

		public static readonly int _GaussianFullSize = Shader.PropertyToID("_GaussianFullSize");

		public static readonly int _GaussianWorkSize = Shader.PropertyToID("_GaussianWorkSize");

		public static readonly int _GaussianParams = Shader.PropertyToID("_GaussianParams");

		public static readonly int _FlareOcclusionTex = Shader.PropertyToID("_FlareOcclusionTex");

		public static readonly int _FlareOcclusionIndex = Shader.PropertyToID("_FlareOcclusionIndex");

		public static readonly int _FlareTex = Shader.PropertyToID("_FlareTex");

		public static readonly int _FlareColorValue = Shader.PropertyToID("_FlareColorValue");

		public static readonly int _FlareData0 = Shader.PropertyToID("_FlareData0");

		public static readonly int _FlareData1 = Shader.PropertyToID("_FlareData1");

		public static readonly int _FlareData2 = Shader.PropertyToID("_FlareData2");

		public static readonly int _FlareData3 = Shader.PropertyToID("_FlareData3");

		public static readonly int _FlareData4 = Shader.PropertyToID("_FlareData4");

		public static readonly int _FlareData5 = Shader.PropertyToID("_FlareData5");

		public static readonly int _FullscreenProjMat = Shader.PropertyToID("_FullscreenProjMat");

		public static readonly int _UpscaledTexture = Shader.PropertyToID("_UpscaledTexture");
	}

	private RenderTextureDescriptor m_Descriptor;

	private RenderTargetHandle m_Depth;

	private RenderTargetHandle m_InternalLut;

	private const string k_RenderPostProcessingTag = "Render PostProcessing Effects";

	private const string k_RenderFinalPostProcessingTag = "Render Final PostProcessing Pass";

	private static readonly ProfilingSampler m_ProfilingRenderPostProcessing = new ProfilingSampler("Render PostProcessing Effects");

	private static readonly ProfilingSampler m_ProfilingRenderFinalPostProcessing = new ProfilingSampler("Render Final PostProcessing Pass");

	private MaterialLibrary m_Materials;

	private PostProcessData m_Data;

	private readonly VolumeComponentCache m_VolumeComponents;

	private DepthOfField m_DepthOfField;

	private TemporalDepthOfField m_TemporalDepthOfField;

	private TemporalDepthOfFieldRenderer m_TemporalDepthOfFieldRenderer;

	private PaniniProjection m_PaniniProjection;

	private Vignette m_Vignette;

	private ColorAdjustments m_ColorAdjustments;

	private readonly GraphicsFormat m_DefaultHDRFormat;

	private readonly GraphicsFormat m_GaussianCoCFormat;

	private readonly ComputeShader m_GaussianDepthOfFieldCS;

	private readonly GraphicsFormat m_GaussianComputeColorFormat;

	private readonly int m_GaussianPrefilterKernel;

	private readonly int m_GaussianBlurKernel;

	private readonly bool m_GaussianComputeSupported;

	private int m_DitheringTextureIndex;

	private RenderTargetIdentifier[] m_MRT2;

	private Vector4[] m_BokehKernel;

	private int m_BokehHash;

	private float m_BokehMaxRadius;

	private float m_BokehRCPAspect;

	private bool m_IsFinalPass;

	private bool m_HasFinalPass;

	private bool m_NeedSRGBConversion;

	private bool m_OwnsDisplayRescale;

	private bool m_ResolveToScreen;

	private bool m_UseNativePostToScreen;

	private bool m_ReuseRenderAttachmentAfterTemporal;

	private bool m_BloomRendered;

	private AutoExposurePass m_AutoExposurePass;

	private CustomPostProcess m_CustomPostProcess;

	private RenderTargetIdentifier m_source;

	private RenderTargetIdentifier m_destination;

	private const float SizeCheck = 1080f;

	internal VolumeComponentCache volumeComponents => m_VolumeComponents;

	public ComputeShader MotionBlurCS => m_Materials.motionBlurShader;

	public ComputeShader BloomCS => m_Data.shaders.bloomCS;

	internal Shader BloomPS => m_Data.shaders.bloomPS;

	internal PostProcessPass(RenderPassEvent evt, PostProcessData data, bool final, VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		m_IsFinalPass = final;
		profilingSampler = new ProfilingSampler("PostProcessPass");
		renderPassEvent = evt;
		m_Data = data;
		m_Materials = new MaterialLibrary(data);
		m_DefaultHDRFormat = GraphicsFormat.B10G11R11_UFloatPack32;
		m_GaussianCoCFormat = SelectGaussianCoCFormat();
		m_GaussianComputeColorFormat = GraphicsFormat.B10G11R11_UFloatPack32;
		m_GaussianDepthOfFieldCS = ((!final) ? data.shaders.gaussianDepthOfFieldCS : null);
		bool flag = m_GaussianDepthOfFieldCS != null && m_GaussianDepthOfFieldCS.HasKernel("Prefilter") && m_GaussianDepthOfFieldCS.HasKernel("Blur");
		m_GaussianComputeSupported = (SystemInfo.supportsComputeShaders & flag) && SystemInfo.IsFormatSupported(m_GaussianComputeColorFormat, FormatUsage.LoadStore) && SystemInfo.IsFormatSupported(GraphicsFormat.R16_SFloat, FormatUsage.LoadStore);
		if (m_GaussianComputeSupported)
		{
			m_GaussianPrefilterKernel = m_GaussianDepthOfFieldCS.FindKernel("Prefilter");
			m_GaussianBlurKernel = m_GaussianDepthOfFieldCS.FindKernel("Blur");
			m_GaussianComputeSupported = m_GaussianDepthOfFieldCS.IsSupported(m_GaussianPrefilterKernel) && m_GaussianDepthOfFieldCS.IsSupported(m_GaussianBlurKernel);
		}
		m_MRT2 = new RenderTargetIdentifier[2];
		targetCount = 0u;
		if (!final)
		{
			m_CustomPostProcess = new CustomPostProcess(this, m_VolumeComponents);
			m_TemporalDepthOfFieldRenderer = new TemporalDepthOfFieldRenderer(data.shaders.temporalDepthOfFieldCS, data.shaders.temporalDepthOfFieldCompositePS);
		}
	}

	public void Cleanup()
	{
		m_Materials.Cleanup();
		if (m_CustomPostProcess != null)
		{
			m_CustomPostProcess.Cleanup();
			m_CustomPostProcess = null;
		}
		if (m_TemporalDepthOfFieldRenderer != null)
		{
			m_TemporalDepthOfFieldRenderer.Cleanup();
			m_TemporalDepthOfFieldRenderer = null;
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		BloomRenderer.ReleaseCameraTemporaryRTs(cmd);
	}

	public ComputeShader GetAutoEVCS()
	{
		return m_Data.shaders.AutoEVCS;
	}

	internal void SetAutoExposurePass(AutoExposurePass autoExposurePass)
	{
		m_AutoExposurePass = autoExposurePass;
	}

	internal void Setup(in PostProcessPassSetup setup)
	{
		if (!m_IsFinalPass)
		{
			m_Descriptor = setup.descriptor;
			m_Depth = setup.depth;
			m_InternalLut = setup.internalLut;
		}
		m_HasFinalPass = setup.hasFinalPass;
		m_ResolveToScreen = setup.resolveToScreen;
		m_NeedSRGBConversion = setup.needSRGBConversion;
		m_OwnsDisplayRescale = setup.ownsDisplayRescale;
		m_UseNativePostToScreen = setup.useNativePostToScreen;
		m_ReuseRenderAttachmentAfterTemporal = false;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		m_BloomRendered = false;
		if (m_IsFinalPass)
		{
			RenderFinalPP(ref context, cmd, ref renderingData);
			return;
		}
		m_DepthOfField = m_VolumeComponents.DepthOfField;
		m_TemporalDepthOfField = m_VolumeComponents.TemporalDepthOfField;
		m_PaniniProjection = m_VolumeComponents.PaniniProjection;
		m_Vignette = m_VolumeComponents.Vignette;
		m_ColorAdjustments = m_VolumeComponents.ColorAdjustments;
		RenderBasePP(cmd, ref context, ref renderingData);
	}

	public Vector2 GetSize()
	{
		return new Vector2(m_Descriptor.width, m_Descriptor.height);
	}

	private RenderTextureDescriptor GetCompatibleDescriptor()
	{
		return GetCompatibleDescriptor(m_Descriptor.width, m_Descriptor.height, m_Descriptor.graphicsFormat);
	}

	private RenderTextureDescriptor GetCompatibleDescriptor(int width, int height, GraphicsFormat format, int depthBufferBits = 0)
	{
		RenderTextureDescriptor descriptor = m_Descriptor;
		descriptor.depthBufferBits = depthBufferBits;
		descriptor.width = width;
		descriptor.height = height;
		descriptor.graphicsFormat = format;
		return descriptor;
	}

	private static GraphicsFormat SelectGaussianCoCFormat()
	{
		if (RenderingUtils.SupportsGraphicsFormat(GraphicsFormat.R16_SFloat, FormatUsage.Render))
		{
			return GraphicsFormat.R16_SFloat;
		}
		GraphicsFormat graphicsFormat = (RenderingUtils.SupportsGraphicsFormat(GraphicsFormat.R16_UNorm, FormatUsage.Render) ? GraphicsFormat.R16_UNorm : GraphicsFormat.R32_SFloat);
		Debug.Log($"[PostProcessPass] Gaussian DoF CoC format: {graphicsFormat} (R16_SFloat is not renderable here)");
		return graphicsFormat;
	}

	public RenderTextureDescriptor GetCompatibleDescriptor(int width, int height)
	{
		return GetCompatibleDescriptor(width, height, m_Descriptor.graphicsFormat);
	}

	private new void Blit(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination, Material material, int passIndex = 0)
	{
		cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, source);
		cmd.Blit(source, destination, material, passIndex);
	}

	private void DrawFullscreenMesh(CommandBuffer cmd, Material material, int passIndex)
	{
		cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, material, 0, passIndex);
	}

	private void Swap(CommandBuffer cmd, UniversalRenderer r)
	{
		r.SwapColorBuffer();
		m_source = r.cameraColorTarget;
		m_destination = r.GetCameraColorFrontBuffer(cmd);
	}

	private void ApplyTemporalUpscalerOutput(CommandBuffer cmd, UniversalRenderer renderer, ref CameraData cameraData, in TemporalResolveResult result)
	{
		RTHandle outputHandle = result.outputHandle;
		int outputWidth = result.outputWidth;
		int outputHeight = result.outputHeight;
		GraphicsFormat graphicsFormat = outputHandle.rt.graphicsFormat;
		m_Descriptor.width = outputWidth;
		m_Descriptor.height = outputHeight;
		m_Descriptor.graphicsFormat = graphicsFormat;
		renderer.BeginTemporalPostProcess(outputHandle, outputWidth, outputHeight, cameraData.cameraTargetDescriptor.width, cameraData.cameraTargetDescriptor.height, cameraData.pixelWidth, cameraData.pixelHeight, graphicsFormat);
		m_ReuseRenderAttachmentAfterTemporal = outputWidth == cameraData.cameraTargetDescriptor.width && outputHeight == cameraData.cameraTargetDescriptor.height;
		m_source = outputHandle.nameID;
		m_destination = renderer.GetCameraColorFrontBuffer(cmd);
	}

	private void RenderBasePP(CommandBuffer cmd, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		ref CameraData cameraData = ref renderingData.cameraData;
		ref UniversalRenderer renderer = ref cameraData.renderer;
		bool isSceneViewCamera = cameraData.isSceneViewCamera;
		m_source = renderer.cameraColorTarget;
		m_destination = renderer.GetCameraColorFrontBuffer(cmd);
		bool flag = m_TemporalDepthOfField.IsActive() && renderer.actualRenderingMode == RenderingMode.Deferred && cameraData.isGameCamera && cameraData.isBase && !isSceneViewCamera;
		Material material = ((m_DepthOfField.mode.value == DepthOfFieldMode.Gaussian) ? m_Materials.gaussianDepthOfField : m_Materials.bokehDepthOfField);
		int num;
		int num2;
		if (!flag && m_DepthOfField.IsActive() && !isSceneViewCamera)
		{
			num = ((material != null) ? 1 : 0);
			if (num != 0)
			{
				num2 = ((m_DepthOfField.mode.value == DepthOfFieldMode.Gaussian) ? 1 : 0);
				goto IL_00c3;
			}
		}
		else
		{
			num = 0;
		}
		num2 = 0;
		goto IL_00c3;
		IL_00c3:
		bool flag2 = (byte)num2 != 0;
		bool flag3 = num != 0 && m_DepthOfField.mode.value == DepthOfFieldMode.Bokeh;
		bool flag4 = m_PaniniProjection.IsActive() && !isSceneViewCamera;
		int i = 0;
		List<AbstractVolumeRenderer> renderers = m_CustomPostProcess.renderers;
		int count;
		for (count = renderers.Count; i < count; i++)
		{
			AbstractVolumeRenderer abstractVolumeRenderer = renderers[i];
			if (!abstractVolumeRenderer.IsBeforeTAA)
			{
				break;
			}
			if (abstractVolumeRenderer.IsActive() && abstractVolumeRenderer.Render(ref context, m_source, m_destination, this, ref renderingData))
			{
				Swap(cmd, renderer);
			}
		}
		if (flag)
		{
			if (m_TemporalDepthOfFieldRenderer.Render(cmd, m_source, m_destination, m_Depth.Identifier(), renderer, ref renderingData, m_TemporalDepthOfField))
			{
				Swap(cmd, renderer);
			}
		}
		else if (cameraData.isGameCamera && cameraData.isBase)
		{
			m_TemporalDepthOfFieldRenderer.ReleaseHistory();
		}
		if (flag3)
		{
			using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.BokehDepthOfField)))
			{
				cmd.SetGlobalMatrix(ShaderConstants._FullscreenProjMat, GL.GetGPUProjectionMatrix(Matrix4x4.identity, renderIntoTexture: true));
				DoDepthOfField(cameraData, cmd, m_source, m_destination);
				Swap(cmd, renderer);
			}
		}
		ITemporalResolver temporalResolver = renderingData.postProcessingData.temporalResolver;
		ITemporalResolver temporalFallbackResolver = renderingData.postProcessingData.temporalFallbackResolver;
		bool flag5 = cameraData.temporalUpscalerActive && (cameraData.cameraTargetDescriptor.width != cameraData.temporalOutputWidth || cameraData.cameraTargetDescriptor.height != cameraData.temporalOutputHeight);
		for (int j = 0; j < 2; j++)
		{
			ITemporalResolver temporalResolver2 = ((j == 0) ? temporalResolver : temporalFallbackResolver);
			if (temporalResolver2 == null || (j != 0 && temporalResolver2 == temporalResolver))
			{
				continue;
			}
			if ((j != 0) & flag5)
			{
				renderer.InvalidateTAAHistory();
				break;
			}
			if (temporalResolver2.TryResolve(cmd, m_source, renderer.GetCameraColorBackBufferHandle(), ref renderingData, out var result))
			{
				if (result.outputHandle != null)
				{
					ApplyTemporalUpscalerOutput(cmd, renderer, ref cameraData, in result);
					renderer.InvalidateTAAHistory();
				}
				else
				{
					m_source = result.source;
					m_ReuseRenderAttachmentAfterTemporal = result.outputWidth == cameraData.pixelWidth && result.outputHeight == cameraData.pixelHeight;
				}
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				break;
			}
		}
		if (flag2)
		{
			using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.GaussianDepthOfField)))
			{
				cmd.SetGlobalMatrix(ShaderConstants._FullscreenProjMat, GL.GetGPUProjectionMatrix(Matrix4x4.identity, renderIntoTexture: true));
				DoDepthOfField(cameraData, cmd, m_source, m_destination);
				Swap(cmd, renderer);
			}
		}
		m_AutoExposurePass?.RenderAfterTemporal(ref context, m_source, m_Descriptor.width, m_Descriptor.height, ref renderingData);
		for (; i < count; i++)
		{
			AbstractVolumeRenderer abstractVolumeRenderer2 = renderers[i];
			if (abstractVolumeRenderer2.IsActive() && abstractVolumeRenderer2.Render(ref context, m_source, m_destination, this, ref renderingData))
			{
				Swap(cmd, renderer);
			}
		}
		cmd.SetGlobalMatrix(ShaderConstants._FullscreenProjMat, GL.GetGPUProjectionMatrix(Matrix4x4.identity, renderIntoTexture: true));
		if (flag4)
		{
			using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.PaniniProjection)))
			{
				DoPaniniProjection(cameraData.camera, cmd, m_source, m_destination);
				Swap(cmd, renderer);
			}
		}
		FullscreenMaterialPostProcessPass.RenderBeforeUberPost(ref context, cmd, renderer, ref m_source, ref m_destination);
		using (new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.UberPost)))
		{
			m_Materials.uber.shaderKeywords = null;
			if (m_BloomRendered)
			{
				m_Materials.uber.EnableKeyword("_NEED_BLOOM");
			}
			SetupVignette(m_Materials.uber);
			SetupColorGrading(ref renderingData, m_Materials.uber);
			SetupDithering(in cameraData, m_Materials.uber);
			if (m_NeedSRGBConversion)
			{
				m_Materials.uber.EnableKeyword("_LINEAR_TO_SRGB_CONVERSION");
			}
			cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, m_source);
			m_Materials.uber.SetVector(ShaderConstants._SourceTex_TexelSize, new Vector4(1f / (float)m_Descriptor.width, 1f / (float)m_Descriptor.height, m_Descriptor.width, m_Descriptor.height));
			m_Materials.uber.SetFloat(ShaderConstants._UberPostSharpening, renderingData.postProcessingData.uberPostSharpening);
			RenderTargetIdentifier renderTargetIdentifier = RenderTargetHandle.CameraTarget.Identifier();
			if (m_ResolveToScreen)
			{
				cmd.SetRenderTarget(BuiltinRenderTextureType.CameraTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
				if (cameraData.isReAspect)
				{
					cmd.ClearRenderTarget(RTClearFlags.All, Color.black, 1f, 0u);
				}
				else
				{
					cmd.ClearRenderTarget(RTClearFlags.DepthStencil, Color.clear, 1f, 0u);
				}
			}
			else if (m_UseNativePostToScreen)
			{
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
				nativeRenderPassManager.Begin(NativeRenderPassType.Post_To_Screen, ref context, ref renderingData);
				nativeRenderPassManager.ConfigureTarget(1);
				nativeRenderPassManager.BeginSubPass(ref context);
			}
			else
			{
				bool num3 = m_OwnsDisplayRescale && !renderer.IsCurrentColorBufferResolution(cameraData.pixelWidth, cameraData.pixelHeight);
				bool flag6 = m_NeedSRGBConversion && !m_ReuseRenderAttachmentAfterTemporal && !renderer.IsDisplayColorBufferActive();
				if (num3 | flag6)
				{
					renderer.ChangeFrontBufferResolution(cmd, ref cameraData);
					m_destination = renderer.GetCameraColorFrontBuffer(cmd);
				}
				renderTargetIdentifier = m_destination;
				cmd.SetRenderTarget(renderTargetIdentifier, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
				cmd.ClearRenderTarget(RTClearFlags.DepthStencil, Color.clear, 1f, 0u);
				renderer.SwapColorBuffer();
				renderer.ManualSetColorAttachment(renderTargetIdentifier);
				renderer.ManualSetDepthAttachment(renderer.cameraDepthTarget);
			}
			cmd.BeginSample("UberPost");
			cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			if (m_ResolveToScreen)
			{
				cmd.SetViewport(cameraData.pixelRect);
			}
			cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, m_Materials.uber);
			cmd.EndSample("UberPost");
		}
	}

	private BuiltinRenderTextureType BlitDstDiscardContent(CommandBuffer cmd, RenderTargetIdentifier rt)
	{
		cmd.SetRenderTarget(new RenderTargetIdentifier(rt, 0, CubemapFace.Unknown, -1), RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
		return BuiltinRenderTextureType.CurrentActive;
	}

	private void DoDepthOfField(CameraData cameraData, CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination)
	{
		if (m_DepthOfField.mode.value == DepthOfFieldMode.Gaussian)
		{
			if (!DoGaussianDepthOfFieldCompute(cmd, source, destination))
			{
				DoGaussianDepthOfField(cameraData, cmd, source, destination);
			}
		}
		else if (m_DepthOfField.mode.value == DepthOfFieldMode.Bokeh)
		{
			DoBokehDepthOfField(cmd, source, destination);
		}
	}

	private bool DoGaussianDepthOfFieldCompute(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination)
	{
		if (!m_GaussianComputeSupported || m_DepthOfField.highQualitySampling.value || m_Descriptor.dimension != TextureDimension.Tex2D || m_Descriptor.volumeDepth != 1 || m_Descriptor.width < 2 || m_Descriptor.height < 2 || m_Materials.gaussianDepthOfField.passCount <= 5)
		{
			return false;
		}
		int width = m_Descriptor.width;
		int height = m_Descriptor.height;
		int num = width / 2;
		int num2 = height / 2;
		float value = m_DepthOfField.gaussianStart.value;
		float y = Mathf.Max(value, m_DepthOfField.gaussianEnd.value);
		float a = m_DepthOfField.gaussianMaxRadius.value * ((float)num / 1080f);
		a = Mathf.Min(a, 2f);
		RenderTextureDescriptor compatibleDescriptor = GetCompatibleDescriptor(num, num2, m_GaussianComputeColorFormat);
		compatibleDescriptor.depthBufferBits = 0;
		compatibleDescriptor.msaaSamples = 1;
		compatibleDescriptor.bindMS = false;
		compatibleDescriptor.enableRandomWrite = true;
		compatibleDescriptor.useMipMap = false;
		compatibleDescriptor.autoGenerateMips = false;
		compatibleDescriptor.useDynamicScale = false;
		compatibleDescriptor.memoryless = RenderTextureMemoryless.None;
		RenderTextureDescriptor compatibleDescriptor2 = GetCompatibleDescriptor(num, num2, GraphicsFormat.R16_SFloat);
		compatibleDescriptor2.depthBufferBits = 0;
		compatibleDescriptor2.msaaSamples = 1;
		compatibleDescriptor2.bindMS = false;
		compatibleDescriptor2.enableRandomWrite = true;
		compatibleDescriptor2.useMipMap = false;
		compatibleDescriptor2.autoGenerateMips = false;
		compatibleDescriptor2.useDynamicScale = false;
		compatibleDescriptor2.memoryless = RenderTextureMemoryless.None;
		cmd.GetTemporaryRT(ShaderConstants._PingTexture, compatibleDescriptor, FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._HalfCoCTexture, compatibleDescriptor2, FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._PongTexture, compatibleDescriptor, FilterMode.Bilinear);
		cmd.SetComputeVectorParam(m_GaussianDepthOfFieldCS, ShaderConstants._GaussianFullSize, new Vector4(width, height, 1f / (float)width, 1f / (float)height));
		cmd.SetComputeVectorParam(m_GaussianDepthOfFieldCS, ShaderConstants._GaussianWorkSize, new Vector4(num, num2, 1f / (float)num, 1f / (float)num2));
		cmd.SetComputeVectorParam(m_GaussianDepthOfFieldCS, ShaderConstants._GaussianParams, new Vector4(value, y, a, 0f));
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianPrefilterKernel, ShaderConstants._GaussianSource, source);
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianPrefilterKernel, ShaderConstants._GaussianDepthTexture, m_Depth.Identifier());
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianPrefilterKernel, ShaderConstants._GaussianHalfColorOutput, ShaderConstants._PingTexture);
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianPrefilterKernel, ShaderConstants._GaussianHalfCoCOutput, ShaderConstants._HalfCoCTexture);
		cmd.DispatchCompute(m_GaussianDepthOfFieldCS, m_GaussianPrefilterKernel, (num + 7) / 8, (num2 + 7) / 8, 1);
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianBlurKernel, ShaderConstants._GaussianHalfColor, ShaderConstants._PingTexture);
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianBlurKernel, ShaderConstants._GaussianHalfCoC, ShaderConstants._HalfCoCTexture);
		cmd.SetComputeTextureParam(m_GaussianDepthOfFieldCS, m_GaussianBlurKernel, ShaderConstants._GaussianBlurOutput, ShaderConstants._PongTexture);
		cmd.DispatchCompute(m_GaussianDepthOfFieldCS, m_GaussianBlurKernel, (num + 7) / 8, (num2 + 7) / 8, 1);
		PostProcessUtils.SetSourceSize(cmd, m_Descriptor);
		m_Materials.gaussianDepthOfField.SetVector(ShaderConstants._CoCParams, new Vector3(value, y, a));
		cmd.SetGlobalTexture(ShaderConstants._ColorTexture, ShaderConstants._PongTexture);
		cmd.SetGlobalTexture(ShaderConstants._GaussianCompositeDepthTexture, m_Depth.Identifier());
		Blit(cmd, source, BlitDstDiscardContent(cmd, destination), m_Materials.gaussianDepthOfField, 5);
		cmd.ReleaseTemporaryRT(ShaderConstants._PingTexture);
		cmd.ReleaseTemporaryRT(ShaderConstants._HalfCoCTexture);
		cmd.ReleaseTemporaryRT(ShaderConstants._PongTexture);
		return true;
	}

	private void DoGaussianDepthOfField(CameraData cameraData, CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination)
	{
		int num = 2;
		Material gaussianDepthOfField = m_Materials.gaussianDepthOfField;
		int num2 = m_Descriptor.width / num;
		int num3 = m_Descriptor.height / num;
		float value = m_DepthOfField.gaussianStart.value;
		float y = Mathf.Max(value, m_DepthOfField.gaussianEnd.value);
		float a = m_DepthOfField.gaussianMaxRadius.value * ((float)num2 / 1080f);
		a = Mathf.Min(a, 2f);
		CoreUtils.SetKeyword(gaussianDepthOfField, "_HIGH_QUALITY_SAMPLING", m_DepthOfField.highQualitySampling.value);
		gaussianDepthOfField.SetVector(ShaderConstants._CoCParams, new Vector3(value, y, a));
		cmd.GetTemporaryRT(ShaderConstants._FullCoCTexture, GetCompatibleDescriptor(m_Descriptor.width, m_Descriptor.height, m_GaussianCoCFormat), FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._HalfCoCTexture, GetCompatibleDescriptor(num2, num3, m_GaussianCoCFormat), FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._PingTexture, GetCompatibleDescriptor(num2, num3, m_DefaultHDRFormat), FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._PongTexture, GetCompatibleDescriptor(num2, num3, m_DefaultHDRFormat), FilterMode.Bilinear);
		PostProcessUtils.SetSourceSize(cmd, m_Descriptor);
		cmd.SetGlobalTexture(ShaderConstants._DepthOfFieldDepthTexture, m_Depth.Identifier());
		cmd.SetGlobalVector(ShaderConstants._DownSampleScaleFactor, new Vector4(1f / (float)num, 1f / (float)num, num, num));
		Blit(cmd, source, ShaderConstants._FullCoCTexture, gaussianDepthOfField);
		m_MRT2[0] = ShaderConstants._HalfCoCTexture;
		m_MRT2[1] = ShaderConstants._PingTexture;
		cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
		cmd.SetViewport(new Rect(0f, 0f, num2, num3));
		cmd.SetGlobalTexture(ShaderConstants._ColorTexture, source);
		cmd.SetGlobalTexture(ShaderConstants._FullCoCTexture, ShaderConstants._FullCoCTexture);
		cmd.SetRenderTarget(m_MRT2, ShaderConstants._HalfCoCTexture, 0, CubemapFace.Unknown, -1);
		DrawFullscreenMesh(cmd, gaussianDepthOfField, 1);
		cmd.SetViewProjectionMatrices(cameraData.GetViewMatrix(), cameraData.GetProjectionMatrix());
		cmd.SetGlobalTexture(ShaderConstants._HalfCoCTexture, ShaderConstants._HalfCoCTexture);
		Blit(cmd, ShaderConstants._PingTexture, ShaderConstants._PongTexture, gaussianDepthOfField, 2);
		Blit(cmd, ShaderConstants._PongTexture, BlitDstDiscardContent(cmd, ShaderConstants._PingTexture), gaussianDepthOfField, 3);
		cmd.SetGlobalTexture(ShaderConstants._ColorTexture, ShaderConstants._PingTexture);
		cmd.SetGlobalTexture(ShaderConstants._FullCoCTexture, ShaderConstants._FullCoCTexture);
		Blit(cmd, source, BlitDstDiscardContent(cmd, destination), gaussianDepthOfField, 4);
		cmd.ReleaseTemporaryRT(ShaderConstants._FullCoCTexture);
		cmd.ReleaseTemporaryRT(ShaderConstants._HalfCoCTexture);
		cmd.ReleaseTemporaryRT(ShaderConstants._PingTexture);
		cmd.ReleaseTemporaryRT(ShaderConstants._PongTexture);
	}

	private void PrepareBokehKernel(float maxRadius, float rcpAspect)
	{
		if (m_BokehKernel == null)
		{
			m_BokehKernel = new Vector4[42];
		}
		int num = 0;
		float num2 = m_DepthOfField.bladeCount.value;
		float p = 1f - m_DepthOfField.bladeCurvature.value;
		float num3 = m_DepthOfField.bladeRotation.value * (MathF.PI / 180f);
		float num4 = 1f / 7f;
		float num5 = MathF.PI * 2f / num2;
		float num6 = Mathf.Cos(MathF.PI / num2);
		for (int i = 1; i < 4; i++)
		{
			float num7 = ((float)i + num4) / (3f + num4);
			int num8 = i * 7;
			for (int j = 0; j < num8; j++)
			{
				float num9 = MathF.PI * 2f * (float)j / (float)num8;
				float num10 = Mathf.Cos(num9 - num5 * Mathf.Floor((num2 * num9 + MathF.PI) / (MathF.PI * 2f)));
				float num11 = num7 * Mathf.Pow(num6 / num10, p);
				float num12 = num11 * Mathf.Cos(num9 - num3);
				float num13 = num11 * Mathf.Sin(num9 - num3);
				float num14 = num12 * maxRadius;
				float num15 = num13 * maxRadius;
				float num16 = num14 * num14;
				float num17 = num15 * num15;
				float z = Mathf.Sqrt(num16 + num17);
				float w = num14 * rcpAspect;
				m_BokehKernel[num] = new Vector4(num14, num15, z, w);
				num++;
			}
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private static float GetMaxBokehRadiusInPixels(float viewportHeight)
	{
		return Mathf.Min(0.2f, 0.0129629625f);
	}

	private void DoBokehDepthOfField(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination)
	{
		int num = 2;
		Material bokehDepthOfField = m_Materials.bokehDepthOfField;
		int num2 = m_Descriptor.width / num;
		int num3 = m_Descriptor.height / num;
		float num4 = m_DepthOfField.focalLength.value / 1000f;
		float num5 = m_DepthOfField.focalLength.value / m_DepthOfField.aperture.value;
		float value = m_DepthOfField.focusDistance.value;
		float y = num5 * num4 / (value - num4);
		float maxBokehRadiusInPixels = GetMaxBokehRadiusInPixels(m_Descriptor.height);
		float num6 = 1f / ((float)num2 / (float)num3);
		cmd.SetGlobalVector(ShaderConstants._CoCParams, new Vector4(value, y, maxBokehRadiusInPixels, num6));
		int hashCode = m_DepthOfField.GetHashCode();
		if (hashCode != m_BokehHash || maxBokehRadiusInPixels != m_BokehMaxRadius || num6 != m_BokehRCPAspect)
		{
			m_BokehHash = hashCode;
			m_BokehMaxRadius = maxBokehRadiusInPixels;
			m_BokehRCPAspect = num6;
			PrepareBokehKernel(maxBokehRadiusInPixels, num6);
		}
		cmd.SetGlobalVectorArray(ShaderConstants._BokehKernel, m_BokehKernel);
		cmd.GetTemporaryRT(ShaderConstants._FullCoCTexture, GetCompatibleDescriptor(m_Descriptor.width, m_Descriptor.height, GraphicsFormat.R8_UNorm), FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._BokehTemp, GetCompatibleDescriptor(num2, num3, m_Descriptor.graphicsFormat), FilterMode.Bilinear);
		cmd.GetTemporaryRT(ShaderConstants._PingTexture, GetCompatibleDescriptor(num2, num3, m_Descriptor.graphicsFormat), FilterMode.Bilinear);
		int num7 = Mathf.CeilToInt((float)m_Descriptor.height / 1080f);
		if (num7 > 1)
		{
			cmd.GetTemporaryRT(ShaderConstants._PongTexture, GetCompatibleDescriptor(num2, num3, m_Descriptor.graphicsFormat), FilterMode.Bilinear);
		}
		PostProcessUtils.SetSourceSize(cmd, m_Descriptor);
		cmd.SetGlobalTexture(ShaderConstants._DepthOfFieldDepthTexture, m_Depth.Identifier());
		cmd.SetGlobalVector(ShaderConstants._DownSampleScaleFactor, new Vector4(1f / (float)num, 1f / (float)num, num, num));
		float num8 = 1f / (float)m_Descriptor.height * (float)num;
		cmd.SetGlobalVector(ShaderConstants._BokehConstants, new Vector4(num8, num8 * 2f));
		Blit(cmd, source, ShaderConstants._FullCoCTexture, bokehDepthOfField);
		cmd.SetGlobalTexture(ShaderConstants._FullCoCTexture, ShaderConstants._FullCoCTexture);
		Blit(cmd, source, ShaderConstants._BokehTemp, bokehDepthOfField, 1);
		int num9 = ShaderConstants._PingTexture;
		if (num7 > 1)
		{
			int num10 = num9;
			int num11 = ShaderConstants._PongTexture;
			int num12 = ShaderConstants._BokehTemp;
			for (int i = 0; i < num7; i++)
			{
				if (i == num7 - 1)
				{
					cmd.SetGlobalFloat(ShaderConstants._LastLoop, 1f);
				}
				else
				{
					cmd.SetGlobalFloat(ShaderConstants._LastLoop, 0f);
				}
				Blit(cmd, num12, num10, bokehDepthOfField, 2);
				num12 = num10;
				num9 = num10;
				int num13 = num10;
				num10 = num11;
				num11 = num13;
			}
		}
		else
		{
			Blit(cmd, ShaderConstants._BokehTemp, num9, bokehDepthOfField, 2);
		}
		Blit(cmd, num9, BlitDstDiscardContent(cmd, ShaderConstants._BokehTemp), bokehDepthOfField, 3);
		cmd.SetGlobalTexture(ShaderConstants._DofTexture, ShaderConstants._BokehTemp);
		Blit(cmd, source, BlitDstDiscardContent(cmd, destination), bokehDepthOfField, 4);
		cmd.ReleaseTemporaryRT(ShaderConstants._FullCoCTexture);
		cmd.ReleaseTemporaryRT(ShaderConstants._BokehTemp);
		cmd.ReleaseTemporaryRT(ShaderConstants._PingTexture);
		if (num7 > 1)
		{
			cmd.ReleaseTemporaryRT(ShaderConstants._PongTexture);
		}
	}

	private void DoPaniniProjection(Camera camera, CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier destination)
	{
		float value = m_PaniniProjection.distance.value;
		Vector2 vector = CalcViewExtents(camera);
		Vector2 vector2 = CalcCropExtents(camera, value);
		float a = vector2.x / vector.x;
		float b = vector2.y / vector.y;
		float value2 = Mathf.Min(a, b);
		float num = value;
		float w = Mathf.Lerp(1f, Mathf.Clamp01(value2), m_PaniniProjection.cropToFit.value);
		Material paniniProjection = m_Materials.paniniProjection;
		paniniProjection.SetVector(ShaderConstants._Params, new Vector4(vector.x, vector.y, num, w));
		paniniProjection.EnableKeyword((1f - Mathf.Abs(num) > float.Epsilon) ? "_GENERIC" : "_UNIT_DISTANCE");
		Blit(cmd, source, BlitDstDiscardContent(cmd, destination), paniniProjection);
	}

	private Vector2 CalcViewExtents(Camera camera)
	{
		float num = camera.fieldOfView * (MathF.PI / 180f);
		float num2 = (float)m_Descriptor.width / (float)m_Descriptor.height;
		float num3 = Mathf.Tan(0.5f * num);
		return new Vector2(num2 * num3, num3);
	}

	private Vector2 CalcCropExtents(Camera camera, float d)
	{
		float num = 1f + d;
		Vector2 vector = CalcViewExtents(camera);
		float num2 = Mathf.Sqrt(vector.x * vector.x + 1f);
		float num3 = 1f / num2;
		float num4 = num3 + d;
		return vector * num3 * (num / num4);
	}

	private void SetupVignette(Material material)
	{
		Color value = m_Vignette.color.value;
		Vector2 value2 = m_Vignette.center.value;
		float num = (float)m_Descriptor.width / (float)m_Descriptor.height;
		Vector4 value3 = new Vector4(value.r, value.g, value.b, m_Vignette.rounded.value ? num : 1f);
		Vector4 value4 = new Vector4(value2.x, value2.y, m_Vignette.intensity.value * 3f, m_Vignette.smoothness.value * 5f);
		material.SetVector(ShaderConstants._Vignette_Params1, value3);
		material.SetVector(ShaderConstants._Vignette_Params2, value4);
	}

	private void SetupColorGrading(ref RenderingData renderingData, Material material)
	{
		int lutSize = renderingData.postProcessingData.lutSize;
		int num = lutSize * lutSize;
		float w = Mathf.Pow(2f, m_ColorAdjustments.postExposure.value);
		material.SetVector(ShaderConstants._Lut_Params, new Vector4(1f / (float)num, 1f / (float)lutSize, (float)lutSize - 1f, w));
	}

	private void SetupDithering(in CameraData cameraData, Material material)
	{
		m_DitheringTextureIndex = PostProcessUtils.ConfigureDithering(m_Data, m_DitheringTextureIndex, cameraData.pixelWidth, cameraData.pixelHeight, material);
	}

	private void RenderFinalPP(ref ScriptableRenderContext context, CommandBuffer cmd, ref RenderingData renderingData)
	{
		using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.FinalPost)))
		{
			ref CameraData cameraData = ref renderingData.cameraData;
			Material finalPass = m_Materials.finalPass;
			finalPass.shaderKeywords = null;
			PostProcessUtils.SetSourceSize(cmd, cameraData.cameraTargetDescriptor);
			SetupDithering(in cameraData, finalPass);
			if (m_NeedSRGBConversion)
			{
				finalPass.EnableKeyword("_LINEAR_TO_SRGB_CONVERSION");
			}
			RenderTargetIdentifier cameraColorTarget = cameraData.renderer.cameraColorTarget;
			cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, cameraColorTarget);
			RenderTargetHandle cameraTarget = RenderTargetHandle.CameraTarget;
			UniversalRenderer renderer = cameraData.renderer;
			if (m_ResolveToScreen)
			{
				RenderTargetIdentifier rt = ((cameraData.targetTexture != null) ? new RenderTargetIdentifier(cameraData.targetTexture) : cameraTarget.Identifier());
				cmd.SetRenderTarget(rt, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
				cmd.ClearRenderTarget(RTClearFlags.DepthStencil, Color.clear, 1f, 0u);
				renderer.ManualSetColorAttachment(rt);
			}
			else if (m_UseNativePostToScreen)
			{
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
				nativeRenderPassManager.Begin(NativeRenderPassType.Post_To_Screen, ref context, ref renderingData);
				nativeRenderPassManager.ConfigureTarget(1);
				nativeRenderPassManager.BeginSubPass(ref context);
			}
			else
			{
				bool num = m_OwnsDisplayRescale && !renderer.IsCurrentColorBufferResolution(cameraData.pixelWidth, cameraData.pixelHeight);
				bool flag = m_NeedSRGBConversion && !renderer.IsDisplayColorBufferActive();
				if (num | flag)
				{
					renderer.ChangeFrontBufferResolution(cmd, ref cameraData);
				}
				RenderTargetIdentifier cameraColorFrontBuffer = renderer.GetCameraColorFrontBuffer(cmd);
				cmd.SetRenderTarget(cameraColorFrontBuffer, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
				cmd.ClearRenderTarget(RTClearFlags.DepthStencil, Color.clear, 1f, 0u);
				renderer.SwapColorBuffer();
				renderer.ManualSetColorAttachment(cameraColorFrontBuffer);
				renderer.ManualSetDepthAttachment(renderer.cameraDepthTarget);
			}
			cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			cmd.SetViewport(cameraData.pixelRect);
			cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, finalPass);
		}
	}

	internal void EnableBloomForUber()
	{
		m_BloomRendered = true;
	}
}
