using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering.Universal.Internal;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

public sealed class UniversalRenderer : ScriptableRenderer
{
	internal sealed class RuntimeRenderSettings
	{
		internal float RenderScale = 1f;

		internal bool NativeRenderPass;

		internal float ShadowDistance;

		internal bool SupportsMainLightShadows;

		internal bool SupportsAdditionalLightShadows;

		internal int MainLightShadowmapResolution;

		internal int AdditionalLightsShadowmapResolution;

		internal int AdditionalLightsShadowSliceResolution;

		internal int ShadowCascadeCount;

		internal Vector3 MainLightShadowCascadesSplit = new Vector3(1f, 0f, 0f);

		internal bool AdditionalShadowTimeSlicingEnabled;

		internal int MaxAdditionalShadowTilesPerFrame;

		internal float UberPostSharpening = 0.5f;
	}

	[Flags]
	private enum NativeDeferredUnsupportedReason
	{
		None = 0,
		GraphicsApi = 1,
		DepthStencil = 2,
		SplitAfterGBufferMrt = 0x40,
		GBufferDepthMrt = 0x80,
		NativeRenderPass = 0x200,
		Schedule = 0x400,
		Camera = 0x800,
		XR = 0x1000,
		Deferred = 0x4000
	}

	private readonly struct PostToScreenPlan
	{
		internal readonly bool applyFinalPostProcessing;

		internal readonly bool postProcessNeedsSRGBConversion;

		internal readonly bool finalPostProcessNeedsSRGBConversion;

		internal readonly bool postProcessOwnsDisplayRescale;

		internal readonly bool finalPostProcessOwnsDisplayRescale;

		internal readonly bool useNativePostToScreen;

		internal PostToScreenPlan(bool applyFinalPostProcessing, bool postProcessNeedsSRGBConversion, bool finalPostProcessNeedsSRGBConversion, bool postProcessOwnsDisplayRescale, bool finalPostProcessOwnsDisplayRescale, bool useNativePostToScreen)
		{
			this.applyFinalPostProcessing = applyFinalPostProcessing;
			this.postProcessNeedsSRGBConversion = postProcessNeedsSRGBConversion;
			this.finalPostProcessNeedsSRGBConversion = finalPostProcessNeedsSRGBConversion;
			this.postProcessOwnsDisplayRescale = postProcessOwnsDisplayRescale;
			this.finalPostProcessOwnsDisplayRescale = finalPostProcessOwnsDisplayRescale;
			this.useNativePostToScreen = useNativePostToScreen;
		}

		internal PostProcessPassSetup CreateMainPassSetup(in RenderTextureDescriptor descriptor, in RenderTargetHandle depth, in RenderTargetHandle internalLut, bool resolveToScreen, bool needSRGBConversion)
		{
			return new PostProcessPassSetup(in descriptor, in depth, in internalLut, resolveToScreen, applyFinalPostProcessing, needSRGBConversion, postProcessOwnsDisplayRescale, useNativePostToScreen && !applyFinalPostProcessing);
		}

		internal PostProcessPassSetup CreateFinalPassSetup(bool resolveToScreen, bool needSRGBConversion)
		{
			return new PostProcessPassSetup(default(RenderTextureDescriptor), default(RenderTargetHandle), default(RenderTargetHandle), resolveToScreen, hasFinalPass: false, needSRGBConversion, finalPostProcessOwnsDisplayRescale, useNativePostToScreen);
		}
	}

	public enum TextureSampleLevel
	{
		High,
		medium,
		low
	}

	[NonSerialized]
	private readonly RuntimeRenderSettings m_RuntimeSettings = new RuntimeRenderSettings();

	private MainLightShadowCasterPass m_MainLightShadowCasterPass;

	private AdditionalLightsShadowCasterPass m_AdditionalLightsShadowCasterPass;

	private bool m_AdditionalLightShadowsRuntimeEnabled;

	private int m_VisibleLightCount;

	private GBufferPass m_GBufferPass;

	private SelectivePreZPass m_SelectivePreZPass;

	private DeferredLightClusterPass m_DeferredLightClusterPass;

	private DeferredPass m_DeferredPass;

	private DeferredEnvironmentPass m_DeferredEnvironmentPass;

	private DrawObjectsPass m_RenderOpaqueForwardOnlyPass;

	private DrawObjectsPass m_RenderOpaqueForwardPass;

	private DrawSkyboxPass m_DrawDeferredSkyboxPass;

	private CopyDepthPass m_CopyDepthPass;

	private CopyDepthPass m_DeferredDepthCopyPass;

	private TransparentForwardPass m_TransparentForwardPass;

	private ScreenLeftCharacterPass m_ScreenLeftCharacterPass;

	private FinalBlitPass m_FinalBlitPass;

	private SetGlobalParamPass m_SetGlobalParamPass;

	private TemporalJitterPreparePass m_TemporalJitterPreparePass;

	private ScreenShotPass m_ScreenShotPass;

	private ScreenShotPass m_FinalScreenShotPass;

	private UI3DPass m_UI3DPass;

	internal static readonly RenderTargetBufferSystem s_ColorBufferSystem = new RenderTargetBufferSystem("_CameraColorAttachment");

	private RenderTargetBufferSystem m_ColorBufferSystem = s_ColorBufferSystem;

	private static int s_ColorBufferSystemReferenceCount;

	private bool m_ColorBufferSystemRegistered;

	private GraphicsFormat m_CameraColorFormat;

	private GraphicsFormat m_CompactHdrColorFormat;

	private GraphicsFormat m_MotionVectorFormat;

	private static GraphicsFormat s_CameraDepthStencilFormat = GraphicsFormat.None;

	private static bool s_CameraDepthStencilFormatInitialized;

	private const GraphicsFormat s_CameraDepthTextureFormat = GraphicsFormat.R32_SFloat;

	private NativeDeferredUnsupportedReason m_NativeDeferredUnsupportedReason;

	private bool m_SupportsNativeSplitAfterGBuffer;

	private bool m_SupportsNativeFullTile;

	private bool m_SupportsNativeGBufferDepthOutput;

	private RenderTargetHandle m_CameraDepthAttachment;

	private RTHandle m_CameraDepthTexture;

	private RTHandle m_DeferredDepthTexture;

	private RTHandle m_GBuffer2Texture;

	private ForwardLights m_ForwardLights;

	private DeferredLights m_DeferredLights;

	private RenderingMode m_RenderingMode;

	private RenderPassScheduleMode m_RenderPassScheduleMode;

	private Material m_BlitMaterial;

	private Material m_CopyDepthMaterial;

	private Material m_StencilDeferredMaterial;

	private Material m_SSSMaterial;

	private Material m_DistortionMaterial;

	private Texture2D m_PerlinNoiseTex;

	private Texture2D m_PreIntegralDataTex;

	private readonly VolumeComponentCache m_VolumeComponents;

	private PostProcessPasses m_PostProcessPasses;

	private AtmosphereBuild m_AtmospherePass;

	private DistortionPass m_DistortionPass;

	private DistortionMergePass m_DistortionMergePass;

	[NonSerialized]
	public bool EnableDistortionPass = true;

	[NonSerialized]
	public bool EnableSkyboxPass = true;

	private MaterialOverridePass m_MaterialOverridePass;

	private DrawUIPass M_DrawUIPass;

	[NonSerialized]
	private bool m_ShadowTransparentReceive;

	[NonSerialized]
	private bool m_CharacterMainLightShadowReceive;

	[NonSerialized]
	private bool m_DisableAdvancedFaceHair;

	[NonSerialized]
	private bool m_DrawCharacterOutline;

	[NonSerialized]
	private bool m_CharacterPureOuterOutline;

	[NonSerialized]
	private int m_SpecialCharacterLayerMask;

	public static TextureSampleLevel sampleLevel = TextureSampleLevel.High;

	public bool CurrentFrameNeedTAA;

	internal bool CurrentFrameNeedTemporalJitter;

	public bool CurrentFrameNeedTemporalDepth;

	private float m_CurrentFrameTemporalHistoryResetDeltaTime;

	private bool m_TAATexExist;

	private bool m_TAAHistoryValid;

	private RenderTexture m_TAA_0;

	private RenderTexture m_TAA_1;

	private RenderTargetIdentifier TAA_0;

	private RenderTargetIdentifier TAA_1;

	private bool m_HistoryIs0;

	internal RuntimeRenderSettings runtimeSettings => m_RuntimeSettings;

	internal RenderingMode renderingMode => m_RenderingMode;

	internal RenderPassScheduleMode renderPassScheduleMode => m_RenderPassScheduleMode;

	internal RenderingMode actualRenderingMode => m_RenderingMode;

	public int visibleLightCount => m_VisibleLightCount;

	public int additionalLightShadowSliceCount => m_AdditionalLightsShadowCasterPass?.shadowSliceCount ?? 0;

	public int additionalLightShadowTotalCount => m_AdditionalLightsShadowCasterPass?.shadowTotalCount ?? 0;

	public int additionalLightShadowArea => m_AdditionalLightsShadowCasterPass?.lightArea ?? 0;

	internal static GraphicsFormat cameraDepthStencilFormat => s_CameraDepthStencilFormat;

	internal GraphicsFormat cameraColorFormat => m_CameraColorFormat;

	internal GraphicsFormat compactHdrColorFormat => m_CompactHdrColorFormat;

	internal GraphicsFormat motionVectorFormat => m_MotionVectorFormat;

	internal ComputeShader uiBlurComputeShader { get; }

	public RenderTargetIdentifier cameraDepthTexture
	{
		get
		{
			if (actualRenderingMode != RenderingMode.Deferred)
			{
				if (!IsPersistentRTCreated(m_CameraDepthTexture))
				{
					return default;
				}
				return m_CameraDepthTexture.nameID;
			}
			return deferredDepthTexture;
		}
	}

	internal Texture cameraDepthTextureRT
	{
		get
		{
			if (actualRenderingMode != RenderingMode.Deferred)
			{
				if (!IsPersistentRTCreated(m_CameraDepthTexture))
				{
					return null;
				}
				return m_CameraDepthTexture.rt;
			}
			if (!IsPersistentRTCreated(m_DeferredDepthTexture))
			{
				return null;
			}
			return m_DeferredDepthTexture.rt;
		}
	}

	internal RenderTargetIdentifier deferredDepthTexture
	{
		get
		{
			if (!IsPersistentRTCreated(m_DeferredDepthTexture))
			{
				return default;
			}
			return m_DeferredDepthTexture.nameID;
		}
	}

	internal RenderTargetIdentifier gBuffer2Texture
	{
		get
		{
			if (!IsPersistentRTCreated(m_GBuffer2Texture))
			{
				return default;
			}
			return m_GBuffer2Texture.nameID;
		}
	}

	internal Texture gBuffer2TextureRT
	{
		get
		{
			if (!IsPersistentRTCreated(m_GBuffer2Texture))
			{
				return null;
			}
			return m_GBuffer2Texture.rt;
		}
	}

	internal bool requiresMotionVectorDecode => m_MotionVectorFormat != GraphicsFormat.R16G16_SFloat;

	internal VolumeComponentCache volumeComponents => m_VolumeComponents;

	internal ColorGradingLutPass colorGradingLutPass => m_PostProcessPasses.colorGradingLutPass;

	internal PostProcessPass postProcessPass => m_PostProcessPasses.postProcessPass;

	internal PostProcessPass finalPostProcessPass => m_PostProcessPasses.finalPostProcessPass;

	internal AutoExposurePass autoExposurePass => m_PostProcessPasses.autoExposurePass;

	internal RenderTargetHandle colorGradingLut => m_PostProcessPasses.colorGradingLut;

	internal DeferredLights deferredLights => m_DeferredLights;

	internal bool shadowTransparentReceive => m_ShadowTransparentReceive;

	internal bool characterMainLightShadowReceive => m_CharacterMainLightShadowReceive;

	public bool advancedFaceHairEnabled => !m_DisableAdvancedFaceHair;

	private bool characterOutlineEnabled => m_DrawCharacterOutline;

	private bool transparentCharacterOutlineEnabled => characterOutlineEnabled;

	public bool characterPureOuterOutline => m_CharacterPureOuterOutline;

	public LayerMask specialCharacterLayerMask => m_SpecialCharacterLayerMask;

	public bool specialCharacterRenderingEnabled => m_SpecialCharacterLayerMask != 0;

	public override int SupportedCameraStackingTypes()
	{
		return m_RenderingMode switch
		{
			RenderingMode.Forward => 3, 
			RenderingMode.Deferred => 1, 
			_ => 0, 
		};
	}

	internal bool UsesNativeGBufferDepthStencilInput(NativeDeferredMode mode)
	{
		UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
		if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.Vulkan && asset != null && (mode == NativeDeferredMode.SplitAfterGBuffer || asset.nativeDeferredUseDepthStencilInput || !m_SupportsNativeGBufferDepthOutput) && m_DeferredLights != null)
		{
			return m_DeferredLights.UsesMaterialClassDeferredLayout();
		}
		return false;
	}

	internal bool WritesNativeGBufferDepthTexture(NativeDeferredMode mode)
	{
		if (m_SupportsNativeGBufferDepthOutput)
		{
			return !UsesNativeGBufferDepthStencilInput(mode);
		}
		return false;
	}

	private void InitializeCameraColorFormat()
	{
		m_CompactHdrColorFormat = GraphicsFormat.B10G11R11_UFloatPack32;
		m_CameraColorFormat = m_CompactHdrColorFormat;
	}

	private void InitializeMotionVectorFormat()
	{
		m_MotionVectorFormat = GraphicsFormat.A2B10G10R10_UNormPack32;
	}

	private static void InitializeCameraDepthStencilFormat()
	{
		if (s_CameraDepthStencilFormatInitialized)
		{
			return;
		}
		s_CameraDepthStencilFormatInitialized = true;
		GraphicsFormat[] array = new GraphicsFormat[5]
		{
			GraphicsFormat.D24_UNorm_S8_UInt,
			GraphicsFormat.D32_SFloat_S8_UInt,
			GraphicsFormat.D32_SFloat,
			GraphicsFormat.D24_UNorm,
			GraphicsFormat.D16_UNorm
		};
		foreach (GraphicsFormat graphicsFormat in array)
		{
			if (RenderingUtils.SupportsGraphicsFormat(graphicsFormat, FormatUsage.Render))
			{
				s_CameraDepthStencilFormat = graphicsFormat;
				Debug.Log($"URP camera depth/stencil format: {graphicsFormat}");
				return;
			}
		}
		s_CameraDepthStencilFormat = SystemInfo.GetCompatibleFormat(GraphicsFormat.D24_UNorm_S8_UInt, FormatUsage.Render);
		Debug.LogWarning($"URP camera depth/stencil format fallback: {s_CameraDepthStencilFormat}");
	}

	public static void SetGlobalMipmapLimit(int limit)
	{
		if (QualitySettings.globalTextureMipmapLimit != limit)
		{
			QualitySettings.globalTextureMipmapLimit = limit;
		}
	}

	public void SetCharacterOutlineEnable(bool enable)
	{
		m_DrawCharacterOutline = enable;
	}

	public void SetCharacterOutlineConfiguration(bool enable)
	{
		m_DrawCharacterOutline = enable;
	}

	public void SetHairShadowEnable(bool enable)
	{
		m_DisableAdvancedFaceHair = !enable;
	}

	public void SetCharacterOutlineForceGreater(bool enable)
	{
		m_CharacterPureOuterOutline = enable;
	}

	public void SetCharacterMainLightShadowReceive(bool enable)
	{
		m_CharacterMainLightShadowReceive = enable;
	}

	public void SetSpecialCharacterLayerMask(LayerMask layerMask)
	{
		int num = layerMask;
		if (m_SpecialCharacterLayerMask != num)
		{
			m_SpecialCharacterLayerMask = num;
			m_GBufferPass?.SetSpecialCharacterLayerMask(layerMask);
			m_SelectivePreZPass?.SetSpecialCharacterLayerMask(layerMask);
			m_RenderOpaqueForwardOnlyPass?.SetSpecialCharacterLayerMask(layerMask);
			m_RenderOpaqueForwardPass?.SetSpecialCharacterLayerMask(layerMask);
			m_TransparentForwardPass?.SetSpecialCharacterLayerMask(layerMask);
		}
	}

	public void SetRenderScale(float scale)
	{
		m_RuntimeSettings.RenderScale = Mathf.Clamp(scale, UniversalRenderPipeline.minRenderScale, UniversalRenderPipeline.maxRenderScale);
	}

	public void SetUberPostSharpening(float sharpening)
	{
		m_RuntimeSettings.UberPostSharpening = Mathf.Clamp01(sharpening);
	}

	public void SetNativeRenderPass(bool enable)
	{
		m_RuntimeSettings.NativeRenderPass = enable;
	}

	public void SetShadowSettings(float shadowDistance, bool supportsMainLightShadows, bool supportsAdditionalLightShadows, int mainLightShadowmapResolution, int additionalLightsShadowmapResolution, int additionalLightsShadowSliceResolution, int shadowCascadeCount, Vector3 mainLightShadowCascadesSplit, bool additionalShadowTimeSlicingEnabled, int maxAdditionalShadowTilesPerFrame)
	{
		m_RuntimeSettings.ShadowDistance = Mathf.Max(0f, shadowDistance);
		m_RuntimeSettings.SupportsMainLightShadows = supportsMainLightShadows;
		m_RuntimeSettings.SupportsAdditionalLightShadows = supportsAdditionalLightShadows;
		m_RuntimeSettings.MainLightShadowmapResolution = mainLightShadowmapResolution;
		m_RuntimeSettings.AdditionalLightsShadowmapResolution = additionalLightsShadowmapResolution;
		m_RuntimeSettings.AdditionalLightsShadowSliceResolution = additionalLightsShadowSliceResolution;
		m_RuntimeSettings.ShadowCascadeCount = shadowCascadeCount;
		m_RuntimeSettings.MainLightShadowCascadesSplit = mainLightShadowCascadesSplit;
		m_RuntimeSettings.AdditionalShadowTimeSlicingEnabled = additionalShadowTimeSlicingEnabled;
		m_RuntimeSettings.MaxAdditionalShadowTilesPerFrame = Mathf.Max(0, maxAdditionalShadowTilesPerFrame);
	}

	private void SyncAdditionalLightShadowRuntimeState()
	{
		bool supportsAdditionalLightShadows = m_RuntimeSettings.SupportsAdditionalLightShadows;
		if (m_AdditionalLightShadowsRuntimeEnabled && !supportsAdditionalLightShadows)
		{
			m_AdditionalLightsShadowCasterPass?.ReleaseCachedShadowAtlas();
		}
		m_AdditionalLightShadowsRuntimeEnabled = supportsAdditionalLightShadows;
	}

	public UniversalRenderer(UniversalRendererData data, RenderPassScheduleMode renderPassScheduleMode)
		: base(data)
	{
		uiBlurComputeShader = data.shaders.uiBlurCS;
		s_ColorBufferSystemReferenceCount++;
		m_ColorBufferSystemRegistered = true;
		m_VolumeComponents = new VolumeComponentCache();
		m_TAA_0 = new RenderTexture(1, 1, 0)
		{
			hideFlags = HideFlags.HideAndDontSave,
			name = "TAA_0"
		};
		m_TAA_1 = new RenderTexture(1, 1, 0)
		{
			hideFlags = HideFlags.HideAndDontSave,
			name = "TAA_1"
		};
		m_CameraDepthTexture = CreatePersistentRTHandle("_CameraDepthTexture", FilterMode.Point);
		m_DeferredDepthTexture = CreatePersistentRTHandle("_DeferredDepthTexture", FilterMode.Point);
		m_GBuffer2Texture = CreatePersistentRTHandle("_GBuffer2", FilterMode.Point);
		m_BlitMaterial = CoreUtils.CreateEngineMaterial(data.shaders.blitPS);
		m_PerlinNoiseTex = data.shaders.PerlinNoiseTex;
		m_PreIntegralDataTex = data.shaders.PreIntegralDataTex;
		m_ForwardLights = new ForwardLights();
		m_RenderingMode = data.renderingMode;
		m_RenderPassScheduleMode = renderPassScheduleMode;
		m_ShadowTransparentReceive = data.shadowTransparentReceive;
		m_CharacterMainLightShadowReceive = data.characterMainLightShadowReceive;
		m_DisableAdvancedFaceHair = data.disableAdvancedFaceHair;
		m_DrawCharacterOutline = data.drawCharacterOutline;
		m_CharacterPureOuterOutline = data.characterPureOuterOutline;
		m_SpecialCharacterLayerMask = data.specialCharacterLayerMask;
		InitializeRuntimeSettings();
		InitializeCameraColorFormat();
		InitializeMotionVectorFormat();
		InitializeCameraDepthStencilFormat();
		if (IsGLESDevice())
		{
			Shader.SetGlobalFloat("_ISOPENGL", 1f);
		}
		else
		{
			Shader.SetGlobalFloat("_ISOPENGL", 0f);
		}
		if (renderingMode == RenderingMode.Deferred)
		{
			m_StencilDeferredMaterial = CoreUtils.CreateEngineMaterial(data.shaders.stencilDeferredPS);
			m_DeferredLights = new DeferredLights(new DeferredLights.InitParams
			{
				stencilDeferredMaterial = m_StencilDeferredMaterial,
				deferredClusterComputeShader = data.shaders.DeferredLightClusterCompute
			}, m_RenderPassScheduleMode);
			m_DeferredLightClusterPass = new DeferredLightClusterPass(RenderPassEvent.DeferredLightClusterPass, m_DeferredLights);
			m_GBufferPass = new GBufferPass(RenderPassEvent.GBufferPass, RenderQueueRange.opaque, data.opaqueLayerMask, m_SpecialCharacterLayerMask, m_DeferredLights);
			m_SelectivePreZPass = new SelectivePreZPass(RenderPassEvent.SelectivePreZPass, RenderQueueRange.opaque, data.opaqueLayerMask, m_SpecialCharacterLayerMask);
			ShaderTagId[] deferredForwardOnlyShaderTags = ShaderPassTags.DeferredForwardOnlyShaderTags;
			m_DeferredPass = new DeferredPass(RenderPassEvent.DeferredDirectLightPass, m_DeferredLights);
			m_DeferredEnvironmentPass = new DeferredEnvironmentPass(RenderPassEvent.DeferredEnvironmentPass, m_DeferredLights);
			m_RenderOpaqueForwardOnlyPass = new DrawObjectsPass("Render Opaques Forward Only", deferredForwardOnlyShaderTags, opaque: true, RenderPassEvent.ForwardOnlyOpaquePass, RenderQueueRange.opaque, data.opaqueLayerMask, RenderBufferStoreAction.Store, writeMotionFeatureMrt: true, m_SpecialCharacterLayerMask);
			m_MaterialOverridePass = new MaterialOverridePass();
		}
		InitializeNativeDeferredSupport();
		m_RenderOpaqueForwardPass = new DrawObjectsPass("Render Opaques Forward", opaque: true, RenderPassEvent.ForwardOnlyOpaquePass, RenderQueueRange.opaque, data.opaqueLayerMask, RenderBufferStoreAction.Store, m_SpecialCharacterLayerMask);
		m_PostProcessPasses = new PostProcessPasses(data.postProcessData, m_VolumeComponents);
		RenderQueueRange renderQueueRange = RenderQueueRange.transparent;
		if (data.isUI)
		{
			renderQueueRange = RenderQueueRange.all;
			M_DrawUIPass = new DrawUIPass();
		}
		else
		{
			m_DrawDeferredSkyboxPass = new DrawSkyboxPass(writesDeferredSkyMotion: true);
			m_DistortionMaterial = CoreUtils.CreateEngineMaterial(data.shaders.DistortionOffsetShader);
			m_CopyDepthMaterial = CoreUtils.CreateEngineMaterial(data.shaders.copyDepthPS);
			m_CopyDepthPass = new CopyDepthPass(RenderPassEvent.CopyDepthAfterGBufferPass, m_CopyDepthMaterial);
			m_DeferredDepthCopyPass = new CopyDepthPass(RenderPassEvent.CopyDepthAfterGBufferPass, m_CopyDepthMaterial);
			m_AtmospherePass = new AtmosphereBuild(data.shaders.AtmosphereCS, data.shaders.AtmospherePreIntegralTex, data.shaders.AtmosphereMultiScatterTex, data.shaders.AtmosphereSceneScatterDepthTex, m_VolumeComponents);
			m_DistortionPass = new DistortionPass();
			m_DistortionMergePass = new DistortionMergePass(m_DistortionMaterial);
			m_MainLightShadowCasterPass = new MainLightShadowCasterPass(RenderPassEvent.MainLightShadowPass);
			m_AdditionalLightsShadowCasterPass = new AdditionalLightsShadowCasterPass(RenderPassEvent.AdditionalLightShadowPass, m_CopyDepthMaterial);
		}
		m_TransparentForwardPass = new TransparentForwardPass("Transparent Forward", RenderPassEvent.TransparentForwardPass, renderQueueRange, data.transparentLayerMask, RenderBufferStoreAction.Store, m_SpecialCharacterLayerMask);
		m_ScreenLeftCharacterPass = new ScreenLeftCharacterPass("Screen Left Character", RenderPassEvent.ScreenLeftCharacterPass);
		m_FinalBlitPass = new FinalBlitPass(RenderPassEvent.FinalBlitPass, m_BlitMaterial);
		m_SetGlobalParamPass = new SetGlobalParamPass(m_PerlinNoiseTex, m_PreIntegralDataTex, m_VolumeComponents, this);
		m_TemporalJitterPreparePass = new TemporalJitterPreparePass();
		m_ScreenShotPass = new ScreenShotPass();
		m_FinalScreenShotPass = new ScreenShotPass(finalOutputPass: true);
		m_UI3DPass = new UI3DPass();
		m_CameraDepthAttachment.Init(ShaderPropertyId._CameraDepthAttachment);
		if (renderingMode == RenderingMode.Deferred)
		{
			unsupportedGraphicsDeviceTypes = new GraphicsDeviceType[3]
			{
				GraphicsDeviceType.OpenGLCore,
				GraphicsDeviceType.OpenGLES2,
				GraphicsDeviceType.OpenGLES3
			};
		}
	}

	private void InitializeRuntimeSettings()
	{
		UniversalRenderPipelineAsset universalRenderPipelineAsset = QualitySettings.renderPipeline as UniversalRenderPipelineAsset;
		if (universalRenderPipelineAsset != null)
		{
			m_RuntimeSettings.RenderScale = universalRenderPipelineAsset.renderScale;
			m_RuntimeSettings.NativeRenderPass = universalRenderPipelineAsset.nativeRP;
			m_RuntimeSettings.ShadowDistance = universalRenderPipelineAsset.shadowDistance;
			m_RuntimeSettings.SupportsMainLightShadows = universalRenderPipelineAsset.supportsMainLightShadows;
			m_RuntimeSettings.SupportsAdditionalLightShadows = universalRenderPipelineAsset.supportsAdditionalLightShadows;
			m_RuntimeSettings.MainLightShadowmapResolution = universalRenderPipelineAsset.mainLightShadowmapResolution;
			m_RuntimeSettings.AdditionalLightsShadowmapResolution = universalRenderPipelineAsset.additionalLightsShadowmapResolution;
			m_RuntimeSettings.AdditionalLightsShadowSliceResolution = universalRenderPipelineAsset.additionalLightsShadowSliceResolution;
			m_RuntimeSettings.ShadowCascadeCount = universalRenderPipelineAsset.shadowCascadeCount;
			m_RuntimeSettings.MainLightShadowCascadesSplit = GetPipelineAssetCascadeSplits(universalRenderPipelineAsset);
			m_RuntimeSettings.AdditionalShadowTimeSlicingEnabled = universalRenderPipelineAsset.additionalShadowTimeSlicingEnabled;
			m_RuntimeSettings.MaxAdditionalShadowTilesPerFrame = universalRenderPipelineAsset.maxAdditionalShadowTilesPerFrame;
			m_RuntimeSettings.UberPostSharpening = universalRenderPipelineAsset.uberPostSharpening;
		}
	}

	public static Vector3 GetPipelineAssetCascadeSplits(UniversalRenderPipelineAsset pipelineAsset)
	{
		switch (pipelineAsset.shadowCascadeCount)
		{
		case 3:
		{
			Vector2 cascade3Split = pipelineAsset.cascade3Split;
			return new Vector3(cascade3Split.x, cascade3Split.y, 0f);
		}
		case 4:
			return pipelineAsset.cascade4Split;
		default:
			return new Vector3(pipelineAsset.cascade2Split, 1f, 0f);
		}
	}

	private bool IsGLESDevice()
	{
		if (SystemInfo.graphicsDeviceType != GraphicsDeviceType.OpenGLES2)
		{
			return SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES3;
		}
		return true;
	}

	private static bool HasStencil(GraphicsFormat format)
	{
		if (format != GraphicsFormat.D32_SFloat_S8_UInt)
		{
			return format == GraphicsFormat.D24_UNorm_S8_UInt;
		}
		return true;
	}

	private void InitializeNativeDeferredSupport()
	{
		NativeDeferredUnsupportedReason nativeDeferredUnsupportedReason = NativeDeferredUnsupportedReason.None;
		GraphicsDeviceType graphicsDeviceType = SystemInfo.graphicsDeviceType;
		if (graphicsDeviceType != GraphicsDeviceType.Vulkan && graphicsDeviceType != GraphicsDeviceType.Metal)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.GraphicsApi;
		}
		if (!HasStencil(s_CameraDepthStencilFormat))
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.DepthStencil;
		}
		int supportedRenderTargetCount = SystemInfo.supportedRenderTargetCount;
		if (supportedRenderTargetCount < 4)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.SplitAfterGBufferMrt;
		}
		if (supportedRenderTargetCount < 5)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.GBufferDepthMrt;
		}
		m_NativeDeferredUnsupportedReason = nativeDeferredUnsupportedReason;
		bool flag = (nativeDeferredUnsupportedReason & NativeDeferredUnsupportedReason.GBufferDepthMrt) == 0;
		bool flag2 = SystemInfo.graphicsDeviceType == GraphicsDeviceType.Metal;
		m_SupportsNativeSplitAfterGBuffer = (nativeDeferredUnsupportedReason & (NativeDeferredUnsupportedReason.GraphicsApi | NativeDeferredUnsupportedReason.DepthStencil | NativeDeferredUnsupportedReason.SplitAfterGBufferMrt)) == 0 && (!flag2 | flag);
		m_SupportsNativeFullTile = m_SupportsNativeSplitAfterGBuffer;
		m_SupportsNativeGBufferDepthOutput = m_SupportsNativeSplitAfterGBuffer & flag;
	}

	private NativeDeferredMode ResolveNativeDeferredMode(ref RenderingData renderingData)
	{
		ref CameraData cameraData = ref renderingData.cameraData;
		NativeDeferredUnsupportedReason nativeDeferredUnsupportedReason = NativeDeferredUnsupportedReason.None;
		if (!renderingData.nativeRenderPass)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.NativeRenderPass;
		}
		if (m_RenderPassScheduleMode != RenderPassScheduleMode.Mobile)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.Schedule;
		}
		if (actualRenderingMode != RenderingMode.Deferred)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.Deferred;
		}
		if (!cameraData.isGameCamera || !cameraData.isBase)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.Camera;
		}
		if (cameraData.camera != null && cameraData.camera.stereoEnabled)
		{
			nativeDeferredUnsupportedReason |= NativeDeferredUnsupportedReason.XR;
		}
		NativeDeferredMode result = NativeDeferredMode.None;
		if (nativeDeferredUnsupportedReason == NativeDeferredUnsupportedReason.None && renderingData.splitNativeDeferredForDepth)
		{
			result = (m_SupportsNativeSplitAfterGBuffer ? NativeDeferredMode.SplitAfterGBuffer : NativeDeferredMode.None);
		}
		else if (nativeDeferredUnsupportedReason == NativeDeferredUnsupportedReason.None && m_SupportsNativeFullTile)
		{
			result = NativeDeferredMode.FullTile;
		}
		return result;
	}

	private NativeDeferredMode ResolveFeatureCompatibleNativeDeferredMode(NativeDeferredMode mode)
	{
		if (mode == NativeDeferredMode.None)
		{
			return mode;
		}
		for (int i = 0; i < m_ActiveRenderPassQueue.Count; i++)
		{
			ScriptableRenderPass scriptableRenderPass = m_ActiveRenderPassQueue[i];
			bool flag = scriptableRenderPass.supportsNativeGBufferExtensionPass && scriptableRenderPass.renderPassEvent < RenderPassEvent.DrawSkyboxPass;
			if (scriptableRenderPass.renderPassEvent > RenderPassEvent.GBufferPass && scriptableRenderPass.renderPassEvent <= RenderPassEvent.DeferredDirectLightPass && !flag)
			{
				return NativeDeferredMode.None;
			}
		}
		return mode;
	}

	protected override void Dispose(bool disposing)
	{
		m_DeferredLights?.Dispose();
		m_AdditionalLightsShadowCasterPass?.Dispose();
		m_SetGlobalParamPass?.Dispose();
		m_PostProcessPasses.Dispose();
		CoreUtils.Destroy(m_BlitMaterial);
		CoreUtils.Destroy(m_CopyDepthMaterial);
		CoreUtils.Destroy(m_StencilDeferredMaterial);
		CoreUtils.Destroy(m_SSSMaterial);
		CoreUtils.Destroy(m_DistortionMaterial);
		if (m_ColorBufferSystemRegistered)
		{
			m_ColorBufferSystemRegistered = false;
			if (--s_ColorBufferSystemReferenceCount == 0)
			{
				s_ColorBufferSystem.Dispose();
			}
		}
		ReleaseCameraDepthTexture(destroyTexture: true);
		ReleaseDeferredDepthTexture(destroyTexture: true);
		ReleaseGBuffer2Texture(destroyTexture: true);
		ReleaseTAART(destroyTextures: true);
		m_AtmospherePass?.Dispose();
		m_GBufferPass?.Dispose();
		m_SelectivePreZPass?.Dispose();
		M_DrawUIPass?.Dispose();
		ACTRenderingFunction.ReleaseResources();
	}

	private static bool CanUseNativePostToScreen(ref RenderingData renderingData, bool hasShotPass)
	{
		if (renderingData.nativeRenderPass && !hasShotPass && !ScreenShotPass.IsFinalOutputCaptureRequested)
		{
			return DrawUIPass.CanUseNativeRenderPass();
		}
		return false;
	}

	private PostToScreenPlan BuildPostToScreenPlan(ref RenderingData renderingData, bool applyPostProcessing, bool hasShotPass)
	{
		ref CameraData cameraData = ref renderingData.cameraData;
		bool num = cameraData.cameraTargetDescriptor.width != cameraData.pixelWidth || cameraData.cameraTargetDescriptor.height != cameraData.pixelHeight;
		bool flag = false;
		ITemporalResolver temporalResolver = renderingData.postProcessingData.temporalResolver;
		if (temporalResolver != null && temporalResolver.usesTemporalOutput)
		{
			flag = cameraData.temporalOutputWidth != cameraData.pixelWidth || cameraData.temporalOutputHeight != cameraData.pixelHeight;
		}
		bool flag2 = num | flag;
		bool nextIsGammaUI = renderingData.cameraData.nextIsGammaUI;
		bool flag3 = nextIsGammaUI & applyPostProcessing;
		bool flag4 = nextIsGammaUI && !flag3;
		bool flag5 = m_PostProcessPasses.isCreated & flag4;
		return new PostToScreenPlan(flag5, flag3, flag4, flag2 && !flag5, flag2 & flag5, CanUseNativePostToScreen(ref renderingData, hasShotPass));
	}

	private void OverlaySetup(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		bool flag = m_ColorBufferSystem.IsRTAllocated();
		bool num = renderingData.cameraData.isGameCamera && renderingData.cameraData.lastCam && ScreenShotPass.IsFinalOutputCaptureRequested;
		bool flag2 = CanUseNativePostToScreen(ref renderingData, hasShotPass: false);
		EnqueuePass(M_DrawUIPass);
		if (num)
		{
			EnqueuePass(m_FinalScreenShotPass);
		}
		m_FinalBlitPass.Setup(renderingData.cameraData.isGammaUI);
		EnqueuePass(m_FinalBlitPass);
		if (flag)
		{
			if (renderingData.nativeRenderPass)
			{
				NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
				if (flag2 && nativeRenderPassManager.CurrentPassType == NativeRenderPassType.Post_To_Screen)
				{
					M_DrawUIPass.nativeRenderPassType = (m_FinalBlitPass.nativeRenderPassType = NativeRenderPassType.Post_To_Screen);
				}
				else
				{
					M_DrawUIPass.nativeRenderPassType = (m_FinalBlitPass.nativeRenderPassType = NativeRenderPassType.None);
				}
			}
		}
		else if (flag2)
		{
			NativeRenderPassManager nativeRenderPassManager2 = renderingData.nativeRenderPassManager;
			nativeRenderPassManager2.Begin(NativeRenderPassType.Post_To_Screen, ref context, ref renderingData);
			nativeRenderPassManager2.ConfigureTarget(1);
			nativeRenderPassManager2.BeginSubPass(ref context);
			M_DrawUIPass.nativeRenderPassType = (m_FinalBlitPass.nativeRenderPassType = NativeRenderPassType.Post_To_Screen);
		}
		else
		{
			M_DrawUIPass.nativeRenderPassType = (m_FinalBlitPass.nativeRenderPassType = NativeRenderPassType.None);
			ref RenderTextureDescriptor cameraTargetDescriptor = ref renderingData.cameraData.cameraTargetDescriptor;
			cameraTargetDescriptor.width = renderingData.cameraData.pixelWidth;
			cameraTargetDescriptor.height = renderingData.cameraData.pixelHeight;
			RenderTextureDescriptor desc = cameraTargetDescriptor;
			desc.depthBufferBits = 0;
			desc.graphicsFormat = m_CameraColorFormat;
			desc.enableRandomWrite = false;
			RenderTargetIdentifier renderTargetIdentifier = m_ColorBufferSystem.Create1RT(cmd, desc);
			desc.graphicsFormat = GraphicsFormat.None;
			desc.depthStencilFormat = s_CameraDepthStencilFormat;
			desc.memoryless = RenderTextureMemoryless.None;
			cmd.GetTemporaryRT(m_CameraDepthAttachment.id, desc);
			RenderTargetIdentifier renderTargetIdentifier2 = m_CameraDepthAttachment.Identifier();
			cmd.SetRenderTarget(renderTargetIdentifier, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, renderTargetIdentifier2, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
			cmd.ClearRenderTarget(RTClearFlags.All, Color.black, 1f, 0u);
			ManualSetColorAttachment(renderTargetIdentifier);
			ManualSetDepthAttachment(renderTargetIdentifier2);
		}
		MarkCameraTargetsInitialized();
		SetShaderTimeValues(cmd);
	}

	internal void RequestTemporalJitter(float historyResetDeltaTime)
	{
		CurrentFrameNeedTemporalJitter = true;
		if (historyResetDeltaTime > 0f && (m_CurrentFrameTemporalHistoryResetDeltaTime <= 0f || historyResetDeltaTime < m_CurrentFrameTemporalHistoryResetDeltaTime))
		{
			m_CurrentFrameTemporalHistoryResetDeltaTime = historyResetDeltaTime;
		}
	}

	private void SetupTAA(ref RenderingData renderingData)
	{
		if (CurrentFrameNeedTAA)
		{
			CreateCurrentTAATarget(ref renderingData);
			AssignTAAHistory(ref renderingData);
		}
		else if (m_TAATexExist)
		{
			ReleaseTAART();
		}
	}

	private void CreateCurrentTAATarget(ref RenderingData renderingData)
	{
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		cameraTargetDescriptor.depthBufferBits = 0;
		cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
		if (m_HistoryIs0)
		{
			EnsureTAATarget(ref m_TAA_1, ref TAA_1, cameraTargetDescriptor);
		}
		else
		{
			EnsureTAATarget(ref m_TAA_0, ref TAA_0, cameraTargetDescriptor);
		}
		m_TAATexExist = true;
	}

	private static void EnsureTAATarget(ref RenderTexture texture, ref RenderTargetIdentifier identifier, RenderTextureDescriptor descriptor)
	{
		if (!texture.IsCreated() || texture.width != descriptor.width || texture.height != descriptor.height)
		{
			if (texture.IsCreated())
			{
				texture.Release();
			}
			texture.descriptor = descriptor;
			texture.Create();
			identifier = new RenderTargetIdentifier(texture);
		}
	}

	private static void ReleaseTAATarget(ref RenderTexture texture, ref RenderTargetIdentifier identifier, bool destroyTexture)
	{
		if (texture != null)
		{
			if (texture.IsCreated())
			{
				texture.Release();
			}
			if (destroyTexture)
			{
				CoreUtils.Destroy(texture);
				texture = null;
			}
		}
		identifier = default;
	}

	private void AssignTAAHistory(ref RenderingData renderingData)
	{
		renderingData.postProcessingData.TAAHistoryValid = m_TAAHistoryValid;
		renderingData.postProcessingData.TAA_History = (m_HistoryIs0 ? TAA_0 : TAA_1);
		renderingData.postProcessingData.TAA_Target = (m_HistoryIs0 ? TAA_1 : TAA_0);
	}

	private void ResolvePreviousTemporalColor(ref RenderingData renderingData)
	{
		ref PostProcessingData postProcessingData = ref renderingData.postProcessingData;
		postProcessingData.previousTemporalColor = default;
		ITemporalColorHistoryProvider temporalColorHistoryProvider = postProcessingData.temporalColorHistoryProvider;
		if (temporalColorHistoryProvider != null && temporalColorHistoryProvider.TryGetPreviousTemporalColor(out var history) && history.isValid)
		{
			postProcessingData.previousTemporalColor = history;
		}
		else if (postProcessingData.TAAHistoryValid)
		{
			RenderTexture renderTexture = (m_HistoryIs0 ? m_TAA_0 : m_TAA_1);
			if (!(renderTexture == null) && renderTexture.IsCreated())
			{
				postProcessingData.previousTemporalColor = new TemporalColorHistory(postProcessingData.TAA_History, renderTexture.width, renderTexture.height);
			}
		}
	}

	internal bool PrepareTAAResolve(ref RenderingData renderingData)
	{
		return m_TAATexExist;
	}

	internal void CommitTAAResolve()
	{
		m_TAAHistoryValid = true;
		m_HistoryIs0 = !m_HistoryIs0;
	}

	internal void InvalidateTAAHistory()
	{
		m_TAAHistoryValid = false;
	}

	private void ReleaseTAART(bool destroyTextures = false)
	{
		ReleaseTAATarget(ref m_TAA_0, ref TAA_0, destroyTextures);
		ReleaseTAATarget(ref m_TAA_1, ref TAA_1, destroyTextures);
		m_TAATexExist = false;
		m_TAAHistoryValid = false;
		m_HistoryIs0 = false;
	}

	public override void Setup(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		m_ScreenLeftCharacterPass?.SetPreZPrimed(primed: false);
		SyncAdditionalLightShadowRuntimeState();
		if (!m_AdditionalLightShadowsRuntimeEnabled)
		{
			renderingData.shadowData.supportsAdditionalLightShadows = false;
		}
		m_ColorBufferSystem = s_ColorBufferSystem;
		m_VolumeComponents.EnsureCurrent();
		cameraClearFlag = ScriptableRenderer.GetCameraClearFlag(ref renderingData.cameraData);
		renderingData.cameraData.cameraTargetDescriptor.graphicsFormat = m_CameraColorFormat;
		m_ActiveRenderPassQueue.Clear();
		if (!renderingData.cameraData.isBase)
		{
			OverlaySetup(ref context, ref renderingData);
			return;
		}
		if (renderingData.cameraData.skip)
		{
			if (renderingData.cameraData.isGameCamera)
			{
				ScreenShotPass.DiscardPendingShot();
				ReconcileFeaturePersistentRenderResources(ref renderingData);
				m_ColorBufferSystem.ReleaseRenderBuffers();
				ReleaseTemporalUpscalerOutput();
				ReleaseCameraDepthTexture();
				ReleaseDeferredDepthTexture();
				ReleaseGBuffer2Texture();
				ReleaseTAART();
				m_AtmospherePass?.ReleasePersistentRenderResources();
				DrawUIPass.ReconcilePersistentRenderResources();
				ScreenShotPass.ReconcilePersistentRenderResources();
				colorGradingLutPass?.ReleasePersistentRenderResources();
				autoExposurePass?.ReleasePersistentRenderResources();
			}
			return;
		}
		ref CameraData cameraData = ref renderingData.cameraData;
		Camera camera = cameraData.camera;
		bool flag = false;
		CommandBuffer cmd = renderingData.cmd;
		CurrentFrameNeedTAA = false;
		CurrentFrameNeedTemporalJitter = false;
		CurrentFrameNeedTemporalDepth = false;
		m_CurrentFrameTemporalHistoryResetDeltaTime = 0f;
		bool lastCam = cameraData.lastCam;
		bool isGameCamera = renderingData.cameraData.isGameCamera;
		RenderTextureDescriptor descriptor = cameraData.cameraTargetDescriptor;
		renderingData.postProcessingData.motionFeature = actualRenderingMode == RenderingMode.Deferred;
		if (renderingData.postProcessingData.motionFeature)
		{
			camera.depthTextureMode |= DepthTextureMode.Depth | DepthTextureMode.MotionVectors;
		}
		renderingData.nativeDeferredMode = ResolveNativeDeferredMode(ref renderingData);
		if (m_DeferredLights != null)
		{
			m_DeferredLights.CreateGbufferAttachments();
		}
		AddFeaturePasses(ref context, ref renderingData);
		RegisterTemporalFallbackIfNeeded(ref renderingData);
		if (CurrentFrameNeedTemporalJitter)
		{
			UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
			float jitterSize = ((asset != null) ? asset.temporalJitterScale : 1f);
			m_TemporalJitterPreparePass.Setup(jitterSize, m_CurrentFrameTemporalHistoryResetDeltaTime);
			EnqueuePass(m_TemporalJitterPreparePass);
		}
		renderingData.nativeDeferredMode = ResolveFeatureCompatibleNativeDeferredMode(renderingData.nativeDeferredMode);
		if (isGameCamera && renderingData.cameraData.renderType == CameraRenderType.Base)
		{
			ReconcileFeaturePersistentRenderResources(ref renderingData);
			ITemporalResolver temporalResolver = renderingData.postProcessingData.temporalResolver;
			if (temporalResolver == null || !temporalResolver.usesTemporalOutput)
			{
				ReleaseTemporalUpscalerOutput();
			}
			DrawUIPass.ReconcilePersistentRenderResources();
			ScreenShotPass.ReconcilePersistentRenderResources();
		}
		EnqueuePass(m_SetGlobalParamPass);
		if (actualRenderingMode == RenderingMode.Deferred && cameraData.isBase)
		{
			EnqueuePass(m_DeferredLightClusterPass);
		}
		bool flag2 = cameraData.postProcessEnabled && m_PostProcessPasses.isCreated;
		if (!flag2)
		{
			colorGradingLutPass?.ReleasePersistentRenderResources();
		}
		bool num = flag2 && colorGradingLutPass.Setup(colorGradingLut, ref renderingData);
		bool isSceneViewCamera = cameraData.isSceneViewCamera;
		m_MainLightShadowCasterPass.Setup(cmd, ref renderingData);
		EnqueuePass(m_MainLightShadowCasterPass);
		bool flag3 = false;
		flag3 = m_AdditionalLightsShadowCasterPass.Setup(cmd, ref renderingData);
		EnqueuePass(m_AdditionalLightsShadowCasterPass);
		if (isGameCamera)
		{
			m_VisibleLightCount = renderingData.lightData.visibleLights.Length;
		}
		if (actualRenderingMode == RenderingMode.Forward)
		{
			m_CopyDepthPass.renderPassEvent = RenderPassEvent.ForwardCopyDepthPass;
		}
		CreateCameraRenderTarget(cmd, ref descriptor, renderingData.postProcessingData.requiresMotionVectorOutput);
		RenderTargetHandle depth = ((!flag) ? m_CameraDepthAttachment : RenderTargetHandle.CameraTarget);
		if (!flag)
		{
			ConfigureCameraColorTarget(m_ColorBufferSystem.GetBackBuffer());
		}
		else
		{
			ConfigureCameraColorTarget(RenderTargetHandle.CameraTarget.Identifier());
		}
		ConfigureCameraDepthTarget(depth.Identifier());
		bool flag4 = true;
		if (num)
		{
			EnqueuePass(colorGradingLutPass);
		}
		if (camera.clearFlags == CameraClearFlags.Skybox && EnableSkyboxPass && actualRenderingMode == RenderingMode.Deferred && cameraData.isGameCamera && cameraData.isBase)
		{
			EnqueuePass(m_DrawDeferredSkyboxPass);
		}
		if (((m_AtmospherePass != null) & isGameCamera) && cameraData.isBase && (m_VolumeComponents.Atmosphere.IsActive() || m_AtmospherePass.hasAllocatedResources))
		{
			EnqueuePass(m_AtmospherePass);
		}
		if (actualRenderingMode == RenderingMode.Deferred)
		{
			if (renderingData.nativeDeferredMode == NativeDeferredMode.None || (renderingData.nativeDeferredMode == NativeDeferredMode.SplitAfterGBuffer && UsesNativeGBufferDepthStencilInput(renderingData.nativeDeferredMode)))
			{
				m_DeferredDepthCopyPass.renderPassEvent = ((renderingData.nativeDeferredMode == NativeDeferredMode.SplitAfterGBuffer) ? RenderPassEvent.CopyDepthAfterSkyboxPass : RenderPassEvent.CopyDepthAfterGBufferPass);
				m_DeferredDepthCopyPass.Setup(deferredDepthTexture, ShaderPropertyId._CameraDepthTexture);
				EnqueuePass(m_DeferredDepthCopyPass);
			}
			EnqueueDeferred(ref renderingData, hasDepthPrepass: false, hasNormalPrepass: false, flag3);
			if (renderingData.nativeDeferredMode == NativeDeferredMode.FullTile && UsesNativeGBufferDepthStencilInput(renderingData.nativeDeferredMode))
			{
				m_DeferredDepthCopyPass.renderPassEvent = RenderPassEvent.CopyDepthAfterDeferredEnvironmentPass;
				m_DeferredDepthCopyPass.Setup(deferredDepthTexture, ShaderPropertyId._CameraDepthTexture);
				EnqueuePass(m_DeferredDepthCopyPass);
			}
		}
		else
		{
			RenderBufferStoreAction storeAction = ((!flag4) ? RenderBufferStoreAction.DontCare : RenderBufferStoreAction.Store);
			m_RenderOpaqueForwardPass.ConfigureDepthAttachment(RenderBufferLoadAction.Load, storeAction);
			m_RenderOpaqueForwardPass.SetTransparentOutlineEnabled(characterOutlineEnabled);
			EnqueuePass(m_RenderOpaqueForwardPass);
		}
		if (flag4 && actualRenderingMode != RenderingMode.Deferred)
		{
			m_CopyDepthPass.Setup(cameraDepthTexture, ShaderPropertyId._CameraDepthTexture);
			EnqueuePass(m_CopyDepthPass);
		}
		if (isGameCamera)
		{
			SetupTAA(ref renderingData);
		}
		ResolvePreviousTemporalColor(ref renderingData);
		renderingData.nativeRenderPassManager.autoExposureEnabledForCamera = false;
		if (autoExposurePass != null && autoExposurePass.Setup(ref renderingData, flag2))
		{
			EnqueuePass(autoExposurePass);
		}
		if (isGameCamera & flag2)
		{
			ACTRenderingFunction.ACT_ShakeCamera(ref renderingData, m_VolumeComponents);
		}
		m_TransparentForwardPass.Setup(cameraData.isGammaUI);
		m_TransparentForwardPass.SetOutlineEnabled(transparentCharacterOutlineEnabled);
		EnqueuePass(m_TransparentForwardPass);
		if (m_ScreenLeftCharacterPass != null)
		{
			EnqueuePass(m_ScreenLeftCharacterPass);
		}
		if (EnableDistortionPass && !flag && m_DistortionPass.SetupVisible(ref context, ref renderingData))
		{
			EnqueuePass(m_DistortionPass);
			EnqueuePass(m_DistortionMergePass);
		}
		bool flag5 = isGameCamera && ScreenShotPass.IsBaseCameraCaptureRequested;
		if (flag5)
		{
			EnqueuePass(m_ScreenShotPass);
		}
		PostToScreenPlan postToScreenPlan = BuildPostToScreenPlan(ref renderingData, flag2, flag5);
		if (lastCam)
		{
			bool flag6 = isGameCamera && ScreenShotPass.IsFinalOutputCaptureRequested;
			bool flag7 = flag && !flag6;
			if (!flag7 & flag2)
			{
				flag7 = !postToScreenPlan.applyFinalPostProcessing && !flag6;
				PostProcessPassSetup setup = postToScreenPlan.CreateMainPassSetup(in descriptor, in depth, colorGradingLut, flag7, needSRGBConversion: false);
				postProcessPass.Setup(in setup);
				EnqueuePass(postProcessPass);
			}
			if (!flag7 && postToScreenPlan.applyFinalPostProcessing)
			{
				flag7 = !flag6;
				PostProcessPassSetup setup2 = postToScreenPlan.CreateFinalPassSetup(flag7, needSRGBConversion: false);
				finalPostProcessPass.Setup(in setup2);
				EnqueuePass(finalPostProcessPass);
			}
			if (!flag7)
			{
				m_FinalBlitPass.nativeRenderPassType = ((flag2 && postToScreenPlan.useNativePostToScreen && !flag6) ? NativeRenderPassType.Post_To_Screen : NativeRenderPassType.None);
				if (flag6)
				{
					EnqueuePass(m_FinalScreenShotPass);
				}
				m_FinalBlitPass.Setup(inputGamma: false);
				EnqueuePass(m_FinalBlitPass);
			}
		}
		else
		{
			if (flag2)
			{
				PostProcessPassSetup setup3 = postToScreenPlan.CreateMainPassSetup(in descriptor, in depth, colorGradingLut, resolveToScreen: false, postToScreenPlan.postProcessNeedsSRGBConversion);
				postProcessPass.Setup(in setup3);
				EnqueuePass(postProcessPass);
			}
			if (postToScreenPlan.applyFinalPostProcessing)
			{
				PostProcessPassSetup setup4 = postToScreenPlan.CreateFinalPassSetup(resolveToScreen: false, postToScreenPlan.finalPostProcessNeedsSRGBConversion);
				finalPostProcessPass.Setup(in setup4);
				EnqueuePass(finalPostProcessPass);
			}
		}
		if (isGameCamera | isSceneViewCamera)
		{
			EnqueuePass(m_UI3DPass);
			m_UI3DPass.nativeRenderPassType = (postToScreenPlan.useNativePostToScreen ? NativeRenderPassType.Post_To_Screen : NativeRenderPassType.None);
		}
		SetupNativeDeferredPasses(ref renderingData);
	}

	private void SetupNativeDeferredPasses(ref RenderingData renderingData)
	{
		NativeDeferredMode nativeDeferredMode = renderingData.nativeDeferredMode;
		renderingData.nativePostDeferredPass = false;
		m_AtmospherePass.renderPassEvent = ((nativeDeferredMode != NativeDeferredMode.None) ? RenderPassEvent.AtmosphereBeforeGBufferPass : RenderPassEvent.AtmospherePass);
		int num = int.MaxValue;
		if (nativeDeferredMode != NativeDeferredMode.None)
		{
			for (int i = 0; i < m_ActiveRenderPassQueue.Count; i++)
			{
				ScriptableRenderPass scriptableRenderPass = m_ActiveRenderPassQueue[i];
				if (scriptableRenderPass.renderPassEvent > RenderPassEvent.GBufferPass && scriptableRenderPass.renderPassEvent < RenderPassEvent.DeferredDirectLightPass && !scriptableRenderPass.supportsNativeGBufferExtensionPass)
				{
					num = Mathf.Min(num, (int)scriptableRenderPass.renderPassEvent);
				}
			}
		}
		for (int j = 0; j < m_ActiveRenderPassQueue.Count; j++)
		{
			ScriptableRenderPass scriptableRenderPass2 = m_ActiveRenderPassQueue[j];
			if (scriptableRenderPass2.supportsNativeGBufferExtensionPass)
			{
				scriptableRenderPass2.nativeRenderPassType = ((nativeDeferredMode != NativeDeferredMode.None && scriptableRenderPass2.renderPassEvent > RenderPassEvent.GBufferPass && scriptableRenderPass2.renderPassEvent < RenderPassEvent.DrawSkyboxPass && (int)scriptableRenderPass2.renderPassEvent < num) ? NativeRenderPassType.GBuffer : NativeRenderPassType.None);
			}
			else if (scriptableRenderPass2.renderPassEvent >= RenderPassEvent.ForwardOnlyOpaquePass && scriptableRenderPass2.renderPassEvent <= RenderPassEvent.ScreenLeftCharacterPass)
			{
				scriptableRenderPass2.nativeRenderPassType = NativeRenderPassType.None;
			}
		}
		if (m_GBufferPass == null)
		{
			return;
		}
		m_GBufferPass.nativeRenderPassType = ((nativeDeferredMode != NativeDeferredMode.None) ? NativeRenderPassType.GBuffer : NativeRenderPassType.None);
		if (m_SelectivePreZPass != null)
		{
			m_SelectivePreZPass.nativeRenderPassType = ((nativeDeferredMode != NativeDeferredMode.None) ? NativeRenderPassType.GBuffer : NativeRenderPassType.None);
		}
		NativeRenderPassType nativeRenderPassType = nativeDeferredMode switch
		{
			NativeDeferredMode.FullTile => NativeRenderPassType.GBuffer, 
			NativeDeferredMode.SplitAfterGBuffer => NativeRenderPassType.Deferred, 
			_ => NativeRenderPassType.None, 
		};
		m_DrawDeferredSkyboxPass.nativeRenderPassType = ((nativeDeferredMode != NativeDeferredMode.None) ? NativeRenderPassType.GBuffer : NativeRenderPassType.None);
		m_DeferredPass.nativeRenderPassType = nativeRenderPassType;
		int num2 = int.MaxValue;
		if (nativeDeferredMode != NativeDeferredMode.None)
		{
			for (int k = 0; k < m_ActiveRenderPassQueue.Count; k++)
			{
				ScriptableRenderPass scriptableRenderPass3 = m_ActiveRenderPassQueue[k];
				if (scriptableRenderPass3.renderPassEvent >= RenderPassEvent.ForwardOnlyOpaquePass && scriptableRenderPass3.renderPassEvent <= RenderPassEvent.DeferredEnvironmentPass && !scriptableRenderPass3.supportsNativePostDeferredPass)
				{
					num2 = Mathf.Min(num2, (int)scriptableRenderPass3.renderPassEvent);
				}
			}
			for (int l = 0; l < m_ActiveRenderPassQueue.Count; l++)
			{
				ScriptableRenderPass scriptableRenderPass4 = m_ActiveRenderPassQueue[l];
				if (scriptableRenderPass4.renderPassEvent >= RenderPassEvent.ForwardOnlyOpaquePass && scriptableRenderPass4.renderPassEvent <= RenderPassEvent.DeferredEnvironmentPass && (int)scriptableRenderPass4.renderPassEvent < num2 && scriptableRenderPass4.supportsNativePostDeferredPass)
				{
					scriptableRenderPass4.nativeRenderPassType = nativeRenderPassType;
				}
			}
		}
		bool flag = false;
		bool flag2 = true;
		for (int m = 0; m < m_ActiveRenderPassQueue.Count; m++)
		{
			ScriptableRenderPass scriptableRenderPass5 = m_ActiveRenderPassQueue[m];
			if (scriptableRenderPass5.renderPassEvent >= RenderPassEvent.GrabPass && scriptableRenderPass5.renderPassEvent <= RenderPassEvent.ScreenLeftCharacterPass)
			{
				flag = true;
				if (!scriptableRenderPass5.supportsNativePostDeferredPass)
				{
					flag2 = false;
				}
			}
		}
		bool flag3 = nativeDeferredMode != NativeDeferredMode.None && num2 > 247;
		if (!((nativeDeferredMode != NativeDeferredMode.None) & flag3 & flag & flag2))
		{
			return;
		}
		renderingData.nativePostDeferredPass = true;
		for (int n = 0; n < m_ActiveRenderPassQueue.Count; n++)
		{
			ScriptableRenderPass scriptableRenderPass6 = m_ActiveRenderPassQueue[n];
			if (scriptableRenderPass6.renderPassEvent >= RenderPassEvent.GrabPass && scriptableRenderPass6.renderPassEvent <= RenderPassEvent.ScreenLeftCharacterPass)
			{
				scriptableRenderPass6.nativeRenderPassType = NativeRenderPassType.PostDeferred;
			}
		}
	}

	public override void SetupLights(CommandBuffer cmd, ref RenderingData renderingData)
	{
		cmd.SetGlobalFloat(DeferredLights.ShaderConstants._DeferredSSREnabled, 0f);
		m_ForwardLights.SetupLights(cmd, ref renderingData);
		if (actualRenderingMode == RenderingMode.Deferred)
		{
			m_DeferredLights.SetupLights(cmd, ref renderingData);
			return;
		}
		CoreUtils.SetKeyword(cmd, "_CLUSTERED_LIGHTING", state: false);
		CoreUtils.SetKeyword(cmd, "_DEFERRED_BAKERY_VOLUME_GI", state: false);
		int[] deferredClusterSceneScatterLightMasks = DeferredLights.ShaderConstants._DeferredClusterSceneScatterLightMasks;
		foreach (int nameID in deferredClusterSceneScatterLightMasks)
		{
			cmd.SetGlobalInteger(nameID, 0);
		}
		cmd.SetGlobalFloat(DeferredLights.ShaderConstants._DeferredFullscreenMediaCompositeEnabled, 0f);
		CoreUtils.SetKeyword(cmd, "_DEFERRED_REFLECTION_PROBE_RUNTIME_ATLAS", state: false);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredBakeryVolumeValid, 0);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredBakeryShadowMaskInRed, DeferredSceneLightingRegistry.GetShadowMaskInRed() ? 1 : 0);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredReflectionProbeEnabled, 0);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredReflectionProbeCount, 0);
		cmd.SetGlobalInteger(DeferredLights.ShaderConstants._DeferredReflectionProbeActiveMask, 0);
	}

	public override void SetupCullingParameters(ref ScriptableCullingParameters cullingParameters, ref CameraData cameraData)
	{
		bool isPreviewCamera = cameraData.isPreviewCamera;
		if (Mathf.Approximately(cameraData.maxShadowDistance, 0f) | isPreviewCamera)
		{
			cullingParameters.cullingOptions &= ~CullingOptions.ShadowCasters;
		}
		if (!cameraData.isBase)
		{
			cullingParameters.cullingOptions &= ~(CullingOptions.NeedsLighting | CullingOptions.NeedsReflectionProbes);
		}
		if (actualRenderingMode == RenderingMode.Deferred && !isPreviewCamera)
		{
			cullingParameters.maximumVisibleLights = UniversalRenderPipeline.maxVisibleAdditionalLights + 1;
		}
		else
		{
			cullingParameters.maximumVisibleLights = UniversalRenderPipeline.maxVisibleAdditionalLights + 1;
		}
		cullingParameters.shadowDistance = (isPreviewCamera ? 0f : cameraData.maxShadowDistance);
	}

	private void EnqueueDeferred(ref RenderingData renderingData, bool hasDepthPrepass, bool hasNormalPrepass, bool applyAdditionalShadow)
	{
		m_DeferredLights.Setup(applyAdditionalShadow ? m_AdditionalLightsShadowCasterPass : null, hasDepthPrepass, hasNormalPrepass, m_CameraDepthAttachment, m_ColorBufferSystem.GetRenderBackBufferHandle(), m_GBuffer2Texture);
		bool flag = advancedFaceHairEnabled;
		bool enableCharacterOutline = characterOutlineEnabled;
		m_SelectivePreZPass.SetAdvancedFaceHairEnabled(flag);
		EnqueuePass(m_SelectivePreZPass);
		m_ScreenLeftCharacterPass?.SetPreZPrimed(primed: true);
		m_GBufferPass.SetCharacterOutlineAndHairShadowEnable(enableCharacterOutline, flag, m_CharacterPureOuterOutline);
		EnqueuePass(m_GBufferPass);
		EnqueuePass(m_DeferredPass);
		m_RenderOpaqueForwardOnlyPass.SetHairShadowEnabled(flag);
		EnqueuePass(m_RenderOpaqueForwardOnlyPass);
		CameraType cameraType = renderingData.cameraData.cameraType;
		if ((cameraType == CameraType.SceneView || cameraType == CameraType.Game) && MaterialOverride.HasRenderableOverride())
		{
			m_MaterialOverridePass.renderPassEvent = ((m_RenderPassScheduleMode == RenderPassScheduleMode.Mobile) ? RenderPassEvent.MaterialOverridePass : RenderPassEvent.MaterialOverridePass);
			EnqueuePass(m_MaterialOverridePass);
		}
		EnqueuePass(m_DeferredEnvironmentPass);
	}

	private void CreateCameraRenderTarget(CommandBuffer cmd, ref RenderTextureDescriptor descriptor, bool needsMotionVector)
	{
		RenderTextureDescriptor desc = descriptor;
		desc.depthBufferBits = 0;
		desc.graphicsFormat = m_CameraColorFormat;
		m_ColorBufferSystem.Create2RT(desc);
		RenderTextureDescriptor renderTextureDescriptor = descriptor;
		renderTextureDescriptor.graphicsFormat = GraphicsFormat.None;
		renderTextureDescriptor.depthStencilFormat = s_CameraDepthStencilFormat;
		cmd.GetTemporaryRT(m_CameraDepthAttachment.id, renderTextureDescriptor);
		renderTextureDescriptor.graphicsFormat = GraphicsFormat.R32_SFloat;
		renderTextureDescriptor.depthStencilFormat = GraphicsFormat.None;
		renderTextureDescriptor.depthBufferBits = 0;
		if (actualRenderingMode == RenderingMode.Deferred)
		{
			ReleaseCameraDepthTexture();
			EnsureDeferredDepthTexture(renderTextureDescriptor);
			cmd.SetGlobalTexture(ShaderPropertyId._DeferredDepthTexture, m_DeferredDepthTexture.rt);
			cmd.SetGlobalTexture(ShaderPropertyId._CameraDepthTexture, m_DeferredDepthTexture.rt);
		}
		else
		{
			ReleaseDeferredDepthTexture();
			EnsureCameraDepthTexture(renderTextureDescriptor);
			cmd.SetGlobalTexture(ShaderPropertyId._CameraDepthTexture, m_CameraDepthTexture.rt);
		}
		if (needsMotionVector)
		{
			RenderTextureDescriptor descriptor2 = descriptor;
			descriptor2.depthBufferBits = 0;
			descriptor2.depthStencilFormat = GraphicsFormat.None;
			descriptor2.graphicsFormat = m_MotionVectorFormat;
			descriptor2.useMipMap = false;
			descriptor2.autoGenerateMips = false;
			descriptor2.enableRandomWrite = false;
			EnsureGBuffer2Texture(descriptor2);
			cmd.SetGlobalTexture(ShaderPropertyId._GBuffer2, m_GBuffer2Texture.rt);
		}
		else
		{
			ReleaseGBuffer2Texture();
			if (m_RenderPassScheduleMode == RenderPassScheduleMode.Mobile)
			{
				cmd.SetGlobalTexture(ShaderPropertyId._GBuffer2, Texture2D.blackTexture);
			}
		}
	}

	private void EnsureCameraDepthTexture(RenderTextureDescriptor descriptor)
	{
		RenderTexture renderTexture = ((m_CameraDepthTexture != null) ? m_CameraDepthTexture.rt : null);
		if (!(renderTexture != null) || !renderTexture.IsCreated() || renderTexture.width != descriptor.width || renderTexture.height != descriptor.height)
		{
			ReleaseCameraDepthTexture();
			CreatePersistentRT(m_CameraDepthTexture, descriptor, "_CameraDepthTexture", FilterMode.Point);
		}
	}

	private void ReleaseCameraDepthTexture(bool destroyTexture = false)
	{
		if (m_CameraDepthTexture != null)
		{
			if (destroyTexture)
			{
				RTHandles.Release(m_CameraDepthTexture);
				m_CameraDepthTexture = null;
			}
			else if (m_CameraDepthTexture.rt.IsCreated())
			{
				m_CameraDepthTexture.rt.Release();
			}
		}
	}

	private void EnsureDeferredDepthTexture(RenderTextureDescriptor descriptor)
	{
		RenderTexture renderTexture = ((m_DeferredDepthTexture != null) ? m_DeferredDepthTexture.rt : null);
		if (!(renderTexture != null) || !renderTexture.IsCreated() || renderTexture.width != descriptor.width || renderTexture.height != descriptor.height)
		{
			ReleaseDeferredDepthTexture();
			CreatePersistentRT(m_DeferredDepthTexture, descriptor, "_DeferredDepthTexture", FilterMode.Point);
		}
	}

	private void ReleaseDeferredDepthTexture(bool destroyTexture = false)
	{
		if (m_DeferredDepthTexture != null)
		{
			if (destroyTexture)
			{
				RTHandles.Release(m_DeferredDepthTexture);
				m_DeferredDepthTexture = null;
			}
			else if (m_DeferredDepthTexture.rt.IsCreated())
			{
				m_DeferredDepthTexture.rt.Release();
			}
		}
	}

	private void EnsureGBuffer2Texture(RenderTextureDescriptor descriptor)
	{
		RenderTexture renderTexture = ((m_GBuffer2Texture != null) ? m_GBuffer2Texture.rt : null);
		if (!(renderTexture != null) || !renderTexture.IsCreated() || renderTexture.width != descriptor.width || renderTexture.height != descriptor.height)
		{
			ReleaseGBuffer2Texture();
			CreatePersistentRT(m_GBuffer2Texture, descriptor, "_GBuffer2", FilterMode.Point);
		}
	}

	private void ReleaseGBuffer2Texture(bool destroyTexture = false)
	{
		if (m_GBuffer2Texture != null)
		{
			if (destroyTexture)
			{
				RTHandles.Release(m_GBuffer2Texture);
				m_GBuffer2Texture = null;
			}
			else if (m_GBuffer2Texture.rt.IsCreated())
			{
				m_GBuffer2Texture.rt.Release();
			}
		}
	}

	private static RTHandle CreatePersistentRTHandle(string name, FilterMode filterMode)
	{
		return RTHandles.Alloc(new RenderTexture(1, 1, 0)
		{
			hideFlags = HideFlags.HideAndDontSave,
			name = name,
			filterMode = filterMode,
			wrapMode = TextureWrapMode.Clamp
		});
	}

	private static bool IsPersistentRTCreated(RTHandle handle)
	{
		if (handle != null && handle.rt != null)
		{
			return handle.rt.IsCreated();
		}
		return false;
	}

	private static void CreatePersistentRT(RTHandle handle, RenderTextureDescriptor descriptor, string name, FilterMode filterMode)
	{
		RenderTexture rt = handle.rt;
		rt.descriptor = descriptor;
		rt.name = name;
		rt.filterMode = filterMode;
		rt.wrapMode = TextureWrapMode.Clamp;
		rt.Create();
	}

	public override void FinishRendering(CommandBuffer cmd)
	{
		m_ColorBufferSystem.ReleaseTemporaryBuffers(cmd);
		m_ColorBufferSystem.Clear();
		cmd.ReleaseTemporaryRT(m_CameraDepthAttachment.id);
	}

	private void RegisterTemporalFallbackIfNeeded(ref RenderingData renderingData)
	{
		ref PostProcessingData postProcessingData = ref renderingData.postProcessingData;
		if (postProcessingData.temporalResolver == null || postProcessingData.temporalFallbackResolver != null)
		{
			return;
		}
		List<ScriptableRendererFeature> list = rendererFeatures;
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] is TAAFeature tAAFeature)
			{
				tAAFeature.SetupFallback(this, ref renderingData);
				break;
			}
		}
	}

	internal static void ReleaseTemporalUpscalerOutput()
	{
		s_ColorBufferSystem.ReleaseTemporalOutput();
	}

	internal override void SwapColorBuffer()
	{
		m_ColorBufferSystem.Swap();
		RenderTargetIdentifier backBuffer = m_ColorBufferSystem.GetBackBuffer();
		ConfigureCameraColorTarget(backBuffer);
	}

	internal override RenderTargetIdentifier GetCameraColorFrontBuffer(CommandBuffer cmd)
	{
		return m_ColorBufferSystem.GetFrontBuffer(cmd);
	}

	internal bool IsCurrentColorBufferResolution(int width, int height)
	{
		return m_ColorBufferSystem.IsCurrentResolution(width, height);
	}

	internal RenderTextureDescriptor GetCurrentColorBufferDescriptor()
	{
		return m_ColorBufferSystem.GetCurrentDescriptor();
	}

	internal bool IsDisplayColorBufferActive()
	{
		return m_ColorBufferSystem.IsDisplayScreenActive();
	}

	internal override RTHandle GetCameraColorBackBufferHandle()
	{
		return m_ColorBufferSystem.GetRenderBackBufferHandle();
	}

	internal void ChangeFrontBufferResolution(CommandBuffer cmd, ref CameraData cameraData, GraphicsFormat colorFormat = GraphicsFormat.None)
	{
		if (colorFormat == GraphicsFormat.None)
		{
			colorFormat = m_CameraColorFormat;
		}
		m_ColorBufferSystem.BeginDisplayScreen(cameraData.pixelWidth, cameraData.pixelHeight, colorFormat);
		cmd.ReleaseTemporaryRT(m_CameraDepthAttachment.id);
		RenderTextureDescriptor desc = new RenderTextureDescriptor(cameraData.pixelWidth, cameraData.pixelHeight);
		desc.graphicsFormat = GraphicsFormat.None;
		desc.depthStencilFormat = s_CameraDepthStencilFormat;
		desc.memoryless = RenderTextureMemoryless.None;
		cmd.GetTemporaryRT(m_CameraDepthAttachment.id, desc);
		ConfigureCameraDepthTarget(m_CameraDepthAttachment.Identifier());
	}

	internal void BeginTemporalPostProcess(RTHandle temporalOutput, int width, int height, int renderWidth, int renderHeight, int displayWidth, int displayHeight, GraphicsFormat colorFormat)
	{
		ConfigureCameraColorTarget(temporalOutput.nameID);
		if (width != renderWidth || height != renderHeight)
		{
			if (width == displayWidth && height == displayHeight)
			{
				m_ColorBufferSystem.BeginDisplayScreen(width, height, colorFormat);
				ConfigureCameraDepthTarget(RenderTargetHandle.CameraTarget.Identifier());
			}
			else
			{
				m_ColorBufferSystem.BeginUpscaleScreen(width, height, colorFormat);
			}
		}
	}

	internal RTHandle PrepareTemporalOutput(int width, int height, GraphicsFormat colorFormat)
	{
		return m_ColorBufferSystem.PrepareTemporalOutput(width, height, colorFormat);
	}
}
