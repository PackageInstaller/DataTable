using System;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine.Experimental.GlobalIllumination;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public sealed class UniversalRenderPipeline : RenderPipeline
{
	private static class Profiling
	{
		public static class Pipeline
		{
			public static class Renderer
			{
				private const string k_Name = "ScriptableRenderer";

				public static readonly ProfilingSampler setupCullingParameters = new ProfilingSampler("ScriptableRenderer.SetupCullingParameters");

				public static readonly ProfilingSampler setup = new ProfilingSampler("ScriptableRenderer.Setup");
			}

			public static class Context
			{
				private const string k_Name = "ScriptableRenderContext";

				public static readonly ProfilingSampler submit = new ProfilingSampler("ScriptableRenderContext.Submit");
			}

			public static readonly ProfilingSampler beginContextRendering = new ProfilingSampler("RenderPipeline.BeginContextRendering");

			public static readonly ProfilingSampler endContextRendering = new ProfilingSampler("RenderPipeline.EndContextRendering");

			public static readonly ProfilingSampler beginCameraRendering = new ProfilingSampler("RenderPipeline.BeginCameraRendering");

			public static readonly ProfilingSampler endCameraRendering = new ProfilingSampler("RenderPipeline.EndCameraRendering");

			private const string k_Name = "UniversalRenderPipeline";

			public static readonly ProfilingSampler initializeCameraData = new ProfilingSampler("UniversalRenderPipeline.InitializeCameraData");

			public static readonly ProfilingSampler updateCameraData = new ProfilingSampler("UniversalRenderPipeline.UpdateOverlayCameraData");

			public static readonly ProfilingSampler initializeStackedCameraData = new ProfilingSampler("UniversalRenderPipeline.InitializeStackedCameraData");

			public static readonly ProfilingSampler initializeAdditionalCameraData = new ProfilingSampler("UniversalRenderPipeline.InitializeAdditionalCameraData");

			public static readonly ProfilingSampler initializeRenderingData = new ProfilingSampler("UniversalRenderPipeline.InitializeRenderingData");

			public static readonly ProfilingSampler initializeShadowData = new ProfilingSampler("UniversalRenderPipeline.InitializeShadowData");

			public static readonly ProfilingSampler initializeLightData = new ProfilingSampler("UniversalRenderPipeline.InitializeLightData");

			public static readonly ProfilingSampler getPerObjectLightFlags = new ProfilingSampler("UniversalRenderPipeline.GetPerObjectLightFlags");

			public static readonly ProfilingSampler getMainLightIndex = new ProfilingSampler("UniversalRenderPipeline.GetMainLightIndex");
		}

		private static Dictionary<int, ProfilingSampler> s_HashSamplerCache = new Dictionary<int, ProfilingSampler>();

		public static readonly ProfilingSampler unknownSampler = new ProfilingSampler("Unknown");

		public static ProfilingSampler TryGetOrAddCameraSampler(Camera camera)
		{
			ProfilingSampler value = null;
			int hashCode = camera.GetHashCode();
			if (!s_HashSamplerCache.TryGetValue(hashCode, out value))
			{
				value = new ProfilingSampler("Render Single Camera : " + camera.name);
				s_HashSamplerCache.Add(hashCode, value);
			}
			return value;
		}
	}

	public const string k_ShaderTagName = "UniversalPipeline";

	private static bool s_SkipBaseCamera;

	public static int maxPerObjectLights;

	internal const int k_MaxVisibleAdditionalLightsMobileShaderLevelLessThan45 = 16;

	internal const int k_MaxVisibleAdditionalLightsMobile = 32;

	internal const int k_MaxVisibleAdditionalLightsNonMobile = 32;

	internal const int k_MaxAdditionalLightShadowSlices = 64;

	public static int maxVisibleAdditionalLights;

	private static bool s_GraphicsUVStartsAtTop;

	private static int s_LastHistoryCameraId;

	public static GraphicsFormat UnormRenderTextureGraphicsFormat;

	internal const int k_DefaultRenderingLayerMask = 1;

	private UniversalRenderPipelineGlobalSettings m_GlobalSettings;

	private readonly UniversalRenderPipelineAsset settings;

	internal static RenderTextureDescriptor colorRTDes;

	private bool hasHSRGPU;

	private PostProcessingData postProcessingData;

	private NativeRenderPassManager m_NativeRenderPassManager;

	private readonly PreparedLightFrameData m_PreparedLights;

	private static Vector4 k_DefaultLightPosition;

	private static Vector4 k_DefaultLightColor;

	private static Vector4 k_DefaultLightAttenuation;

	private static Vector4 k_DefaultLightSpotDirection;

	private static Vector4 k_DefaultLightsProbeChannel;

	private static Vector4 k_DefaultACTLightData;

	private Comparison<Camera> cameraComparison = (Camera camera1, Camera camera2) => (int)camera1.depth - (int)camera2.depth;

	private static Lightmapping.RequestLightsDelegate lightsDelegate;

	public static float maxShadowBias => 10f;

	public static float minRenderScale => 0.1f;

	public static float maxRenderScale => 2f;

	public override RenderPipelineGlobalSettings defaultSettings => m_GlobalSettings;

	public static UniversalRenderPipelineAsset asset => GraphicsSettings.currentRenderPipeline as UniversalRenderPipelineAsset;

	public static void SetBaseCameraSkip(bool skip)
	{
		Debug.Log($"[RenderPipeline][SkipBase] set={skip}, frame={Time.frameCount}");
		s_SkipBaseCamera = skip;
	}

	public static bool GetBaseCameraSkip()
	{
		return s_SkipBaseCamera;
	}

	static UniversalRenderPipeline()
	{
		s_LastHistoryCameraId = -1;
		k_DefaultLightPosition = new Vector4(0f, 0f, 1f, 0f);
		k_DefaultLightColor = Color.black;
		k_DefaultLightAttenuation = new Vector4(0f, 1f, 0f, 1f);
		k_DefaultLightSpotDirection = new Vector4(0f, 0f, 1f, 0f);
		k_DefaultLightsProbeChannel = new Vector4(0f, 0f, 0f, 0f);
		k_DefaultACTLightData = new Vector4(1f, 0f, 0f, 0f);
		lightsDelegate = (Light[] requests, NativeArray<LightDataGI> lightsOutput) =>
		{
			LightDataGI value = default;
			if (!SupportedRenderingFeatures.active.enlighten || (SupportedRenderingFeatures.active.lightmapBakeTypes | LightmapBakeType.Realtime) == 0)
			{
				for (int i = 0; i < requests.Length; i++)
				{
					Light light = requests[i];
					value.InitNoBake(light.GetInstanceID());
					lightsOutput[i] = value;
				}
			}
			else
			{
				for (int j = 0; j < requests.Length; j++)
				{
					Light light2 = requests[j];
					switch (light2.type)
					{
					case LightType.Directional:
					{
						DirectionalLight dir = default;
						LightmapperUtils.Extract(light2, ref dir);
						value.Init(ref dir);
						break;
					}
					case LightType.Point:
					{
						PointLight point = default;
						LightmapperUtils.Extract(light2, ref point);
						value.Init(ref point);
						break;
					}
					case LightType.Spot:
					{
						SpotLight spot = default;
						LightmapperUtils.Extract(light2, ref spot);
						spot.innerConeAngle = light2.innerSpotAngle * (MathF.PI / 180f);
						spot.angularFalloff = AngularFalloffType.AnalyticAndInnerAngle;
						value.Init(ref spot);
						break;
					}
					case LightType.Area:
						value.InitNoBake(light2.GetInstanceID());
						break;
					case LightType.Disc:
						value.InitNoBake(light2.GetInstanceID());
						break;
					default:
						value.InitNoBake(light2.GetInstanceID());
						break;
					}
					value.falloff = FalloffType.InverseSquared;
					lightsOutput[j] = value;
				}
			}
		};
		bool flag = GraphicsSettings.HasShaderDefine(BuiltinShaderDefine.SHADER_API_MOBILE);
		if (flag && (SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 || (SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES3 && Graphics.minOpenGLESVersion <= OpenGLESVersion.OpenGLES30)))
		{
			maxVisibleAdditionalLights = 16;
		}
		else
		{
			maxVisibleAdditionalLights = ((flag || SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLCore || SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2 || SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES3) ? 32 : 32);
		}
		maxPerObjectLights = ((SystemInfo.graphicsDeviceType == GraphicsDeviceType.OpenGLES2) ? 4 : 8);
		s_GraphicsUVStartsAtTop = SystemInfo.graphicsUVStartsAtTop;
		UnormRenderTextureGraphicsFormat = MakeUnormRenderTextureGraphicsFormat();
		if (SystemInfo.hasHiddenSurfaceRemovalOnGPU && !LoadStoreActionDebugModeSettings.LoadStoreDebugModeEnabled)
		{
			ScriptableRenderer.s_DepthStoreAction = RenderBufferStoreAction.DontCare;
			ScriptableRenderer.s_DepthLoadAction = RenderBufferLoadAction.DontCare;
		}
		else
		{
			ScriptableRenderer.s_DepthStoreAction = RenderBufferStoreAction.Store;
			ScriptableRenderer.s_DepthLoadAction = RenderBufferLoadAction.Load;
		}
	}

	public override string ToString()
	{
		return settings?.ToString();
	}

	public UniversalRenderPipeline(UniversalRenderPipelineAsset asset)
	{
		settings = asset;
		s_SkipBaseCamera = false;
		s_LastHistoryCameraId = -1;
		m_PreparedLights = new PreparedLightFrameData(maxVisibleAdditionalLights + 1);
		m_GlobalSettings = UniversalRenderPipelineGlobalSettings.instance;
		QualitySettings.antiAliasing = 0;
		Shader.globalRenderPipeline = "UniversalPipeline";
		Lightmapping.SetDelegate(lightsDelegate);
		CameraCaptureBridge.enabled = true;
		RenderingUtils.ClearSystemInfoCache();
		GraphicsSettings.lightsUseLinearIntensity = true;
		GraphicsSettings.lightsUseColorTemperature = true;
		GraphicsSettings.defaultRenderingLayerMask = 1u;
		GraphicsSettings.useScriptableRenderPipelineBatching = asset.useSRPBatcher;
		GraphicsFormat colorFormat = MakeRenderTextureGraphicsFormat(asset.supportsHDR, needsAlpha: false);
		colorRTDes = new RenderTextureDescriptor(1, 1, colorFormat, 32, 0);
		colorRTDes.sRGB = QualitySettings.activeColorSpace == ColorSpace.Linear;
		colorRTDes.autoGenerateMips = false;
		colorRTDes.useMipMap = false;
		colorRTDes.enableRandomWrite = false;
		hasHSRGPU = SystemInfo.hasHiddenSurfaceRemovalOnGPU;
		InitializePostProcessingData(out postProcessingData);
		m_NativeRenderPassManager = new NativeRenderPassManager();
		if ((settings.scriptableRendererData as UniversalRendererData).renderingMode == RenderingMode.Forward)
		{
			Shader.EnableKeyword("_ISFORWARD");
		}
	}

	protected override void Dispose(bool disposing)
	{
		Blitter.Cleanup();
		base.Dispose(disposing);
		settings.DestroyRenderers();
		Shader.globalRenderPipeline = "";
		SupportedRenderingFeatures.active = new SupportedRenderingFeatures();
		ShaderData.instance.Dispose();
		Lightmapping.ResetDelegate();
		CameraCaptureBridge.enabled = false;
	}

	protected override void Render(ScriptableRenderContext context, Camera[] cameras)
	{
		Render(context, new List<Camera>(cameras));
	}

	protected override void Render(ScriptableRenderContext context, List<Camera> cameras)
	{
		using (new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.UniversalRenderTotal)))
		{
			RenderPipeline.BeginContextRendering(context, cameras);
			CommandBuffer commandBuffer = CommandBufferPool.Get();
			SetupPerFrameShaderConstants(context, commandBuffer);
			SortCameras(cameras);
			for (int i = 0; i < cameras.Count; i++)
			{
				Camera baseCamera = cameras[i];
				if (RenderCameraStack(context, baseCamera, commandBuffer))
				{
					break;
				}
			}
			CommandBufferPool.Release(commandBuffer);
			RenderPipeline.EndContextRendering(context, cameras);
		}
	}

	public void RenderOtherSingleCamera(ScriptableRenderContext context, Camera camera, CommandBuffer cmd)
	{
		UniversalAdditionalCameraData component = null;
		if (IsGameCamera(camera))
		{
			camera.gameObject.TryGetComponent<UniversalAdditionalCameraData>(out component);
		}
		if (component != null && component.renderType != CameraRenderType.Base)
		{
			Debug.LogWarning("Only Base cameras can be rendered with standalone RenderSingleCamera. Camera will be skipped.");
			return;
		}
		InitializeCameraData(camera, component, lastCam: true, out var cameraData);
		RenderSingleCamera(context, ref cameraData, cmd);
		m_NativeRenderPassManager.End(ref context, cmd);
		context.Submit();
	}

	private void RenderSingleCamera(ScriptableRenderContext context, ref CameraData cameraData, CommandBuffer cmd)
	{
		Camera camera = cameraData.camera;
		UniversalRenderer renderer = cameraData.renderer;
		if (cameraData.skip)
		{
			using (new ProfilingScope(null, Profiling.Pipeline.Renderer.setup))
			{
				RenderingData renderingData = new RenderingData
				{
					cameraData = cameraData,
					cmd = cmd
				};
				renderer.Setup(ref context, ref renderingData);
			}
			if (cmd.sizeInBytes > 0)
			{
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
			}
		}
		else
		{
			if (!cameraData.camera.TryGetCullingParameters(stereoAware: false, out var cullingParameters))
			{
				return;
			}
			ScriptableRenderer.current = renderer;
			using (new ProfilingScope(null, Profiling.TryGetOrAddCameraSampler(camera)))
			{
				renderer.Clear(cameraData.renderType);
				renderer.OnPreCullRenderPasses(in cameraData);
				renderer.SetupCullingParameters(ref cullingParameters, ref cameraData);
				CullingResults cullResults = context.Cull(ref cullingParameters);
				InitializeRenderingData(ref cameraData, ref cullResults, cmd, out var renderingData2);
				using (new ProfilingScope(null, Profiling.Pipeline.Renderer.setup))
				{
					renderer.Setup(ref context, ref renderingData2);
				}
				renderer.Execute(context, ref renderingData2);
			}
			ScriptableRenderer.current = null;
		}
	}

	private bool RenderCameraStack(ScriptableRenderContext context, Camera baseCamera, CommandBuffer cmd)
	{
		baseCamera.TryGetComponent<UniversalAdditionalCameraData>(out var component);
		if (component != null && component.renderType == CameraRenderType.Overlay)
		{
			return false;
		}
		List<Camera> list = component?.cameraStack;
		int num = -1;
		int num2 = -1;
		if (list != null)
		{
			bool flag = false;
			for (int i = 0; i < list.Count; i++)
			{
				Camera camera = list[i];
				if (camera == null)
				{
					flag = true;
				}
				else if (camera.isActiveAndEnabled)
				{
					num = i;
					camera.TryGetComponent<UniversalAdditionalCameraData>(out var component2);
					if (component2.gammaUI)
					{
						num2 = i;
					}
				}
			}
			if (flag)
			{
				component.UpdateCameraStack();
			}
		}
		bool flag2 = num != -1;
		UpdateVolumeFramework(baseCamera, component);
		using (new ProfilingScope(null, Profiling.Pipeline.beginCameraRendering))
		{
			RenderPipeline.BeginCameraRendering(context, baseCamera);
		}
		InitializeCameraData(baseCamera, component, !flag2, out var cameraData);
		if (num2 == 0)
		{
			cameraData.nextIsGammaUI = true;
		}
		RenderSingleCamera(context, ref cameraData, cmd);
		if (flag2)
		{
			for (int j = 0; j < list.Count; j++)
			{
				Camera camera2 = list[j];
				if (camera2.isActiveAndEnabled)
				{
					camera2.TryGetComponent<UniversalAdditionalCameraData>(out var component3);
					if (component3 != null)
					{
						CameraData cameraData2 = cameraData;
						bool lastCam = j == num;
						UpdateOverlayCameraData(camera2, component3, lastCam, ref cameraData2);
						RenderSingleCamera(context, ref cameraData2, cmd);
					}
				}
			}
		}
		using (new ProfilingScope(null, Profiling.Pipeline.endCameraRendering))
		{
			RenderPipeline.EndCameraRendering(context, baseCamera);
		}
		m_NativeRenderPassManager.End(ref context, cmd);
		context.Submit();
		return true;
	}

	private static void UpdateVolumeFramework(Camera camera, UniversalAdditionalCameraData additionalCameraData)
	{
		using (new ProfilingScope(null, ProfilingSampler.Get(URPProfileId.UpdateVolumeFramework)))
		{
			_ = camera.cameraType == CameraType.SceneView;
			if (additionalCameraData != null && additionalCameraData.requiresVolumeFrameworkUpdate)
			{
				if (!s_SkipBaseCamera)
				{
					_ = !additionalCameraData.skipBase;
				}
				else
					_ = 0;
			}
			else
				_ = 0;
			camera.GetVolumeLayerMaskAndTrigger(additionalCameraData, out var layerMask, out var trigger);
			VolumeManager.instance.Update(trigger, layerMask);
		}
	}

	private static void SetSupportedRenderingFeatures()
	{
	}

	private static void UpdateOverlayCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool lastCam, ref CameraData cameraData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.updateCameraData))
		{
			cameraData.camera = camera;
			cameraData.urpCameraData = additionalCameraData;
			UpdateCameraMVP(camera, ref cameraData);
			cameraData.isBase = false;
			cameraData.renderType = CameraRenderType.Overlay;
			cameraData.postProcessEnabled = false;
			cameraData.clearDepth = additionalCameraData.clearDepth;
			cameraData.renderer = additionalCameraData.ur;
			cameraData.isGammaUI = cameraData.nextIsGammaUI;
			cameraData.skip = false;
			cameraData.lastCam = lastCam;
			cameraData.resetHistoryForCamera = false;
		}
	}

	private static void UpdateCameraMVP(Camera camera, ref CameraData cameraData)
	{
		cameraData.SetViewAndProjectionMatrix(camera.worldToCameraMatrix, camera.projectionMatrix);
		cameraData.worldSpaceCameraPos = camera.transform.position;
	}

	private void InitializeCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool lastCam, out CameraData cameraData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.initializeCameraData))
		{
			cameraData = default;
			cameraData.urpCameraData = additionalCameraData;
			InitializeStackedCameraData(camera, additionalCameraData, ref cameraData);
			InitializeAdditionalCameraData(camera, additionalCameraData, lastCam, ref cameraData);
			cameraData.cameraTargetDescriptor = CreateRenderTextureDescriptor(camera, cameraData.renderWidth, cameraData.renderHeight, cameraData.isHdrEnabled, cameraData.temporalUpscalerActive);
			cameraData.isBase = true;
			cameraData.isReAspect = camera.rect.width < 1f || camera.rect.height < 1f;
			UpdateHistoryCameraData(camera, ref cameraData);
		}
	}

	private static void UpdateHistoryCameraData(Camera camera, ref CameraData cameraData)
	{
		int num = ((camera != null) ? camera.GetInstanceID() : 0);
		cameraData.resetHistoryForCamera = num != s_LastHistoryCameraId;
		s_LastHistoryCameraId = num;
	}

	private void InitializeStackedCameraData(Camera baseCamera, UniversalAdditionalCameraData baseAdditionalCameraData, ref CameraData cameraData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.initializeStackedCameraData))
		{
			cameraData.cameraType = baseCamera.cameraType;
			if (baseAdditionalCameraData != null)
			{
				cameraData.volumeLayerMask = baseAdditionalCameraData.volumeLayerMask;
				cameraData.volumeTrigger = ((baseAdditionalCameraData.volumeTrigger == null) ? baseCamera.transform : baseAdditionalCameraData.volumeTrigger);
			}
			else
			{
				cameraData.targetTexture = baseCamera.targetTexture;
				cameraData.volumeLayerMask = 1;
				cameraData.volumeTrigger = null;
			}
			cameraData.isHdrEnabled = baseCamera.allowHDR && settings.supportsHDR;
			cameraData.pixelRect = baseCamera.pixelRect;
			cameraData.pixelWidth = baseCamera.pixelWidth;
			cameraData.pixelHeight = baseCamera.pixelHeight;
			if (baseCamera.targetTexture == null)
			{
				cameraData.outputWidth = Mathf.Max(1, Screen.width);
				cameraData.outputHeight = Mathf.Max(1, Screen.height);
			}
			else
			{
				cameraData.outputWidth = Mathf.Max(1, baseCamera.targetTexture.width);
				cameraData.outputHeight = Mathf.Max(1, baseCamera.targetTexture.height);
			}
			cameraData.aspectRatio = (float)cameraData.pixelWidth / (float)cameraData.pixelHeight;
			UniversalRenderer universalRenderer = ((baseAdditionalCameraData != null) ? baseAdditionalCameraData.ur : settings.scriptableRenderer) as UniversalRenderer;
			cameraData.nativeRenderPassEnabled = universalRenderer?.runtimeSettings.NativeRenderPass ?? settings.nativeRP;
			float runtimeRenderScale = universalRenderer?.runtimeSettings.RenderScale ?? settings.renderScale;
			SetMobileRenderScale(settings, GetConfiguredRenderScale(settings, runtimeRenderScale, cameraData.pixelHeight), ref cameraData);
			SortingCriteria sortingCriteria = SortingCriteria.CommonOpaque;
			SortingCriteria sortingCriteria2 = SortingCriteria.SortingLayer | SortingCriteria.RenderQueue | SortingCriteria.OptimizeStateChanges | SortingCriteria.CanvasOrder;
			bool flag = (baseCamera.opaqueSortMode == OpaqueSortMode.Default && hasHSRGPU) || baseCamera.opaqueSortMode == OpaqueSortMode.NoDistanceSort;
			cameraData.defaultOpaqueSortFlags = (flag ? sortingCriteria2 : sortingCriteria);
		}
	}

	private static float GetConfiguredRenderScale(UniversalRenderPipelineAsset settings, float runtimeRenderScale, int pixelHeight)
	{
		return SnapRenderScaleToOne((float)Mathf.Min(settings.heightPixels, pixelHeight) * runtimeRenderScale / (float)pixelHeight);
	}

	private static void SetNativeRenderResolution(ref CameraData cameraData)
	{
		cameraData.renderWidth = cameraData.pixelWidth;
		cameraData.renderHeight = cameraData.pixelHeight;
		cameraData.temporalOutputWidth = cameraData.pixelWidth;
		cameraData.temporalOutputHeight = cameraData.pixelHeight;
		cameraData.temporalUpscalerActive = false;
		cameraData.renderScale = 1f;
	}

	private static void SetMobileRenderScale(UniversalRenderPipelineAsset settings, float configuredRenderScale, ref CameraData cameraData)
	{
		float num = SnapRenderScaleToOne(Mathf.Clamp(configuredRenderScale * settings.mobilePerformanceRenderScaleMultiplier, minRenderScale, maxRenderScale));
		cameraData.renderWidth = Mathf.Max(1, Mathf.RoundToInt((float)cameraData.pixelWidth * num));
		cameraData.renderHeight = Mathf.Max(1, Mathf.RoundToInt((float)cameraData.pixelHeight * num));
		cameraData.temporalOutputWidth = cameraData.renderWidth;
		cameraData.temporalOutputHeight = cameraData.renderHeight;
		cameraData.temporalUpscalerActive = false;
		cameraData.renderScale = num;
		if (TemporalUpscalerRenderScale.TryGetMetalFXFrameResolutions(cameraData.pixelWidth, cameraData.pixelHeight, out var inputWidth, out var inputHeight, out var outputWidth, out var outputHeight))
		{
			cameraData.renderWidth = inputWidth;
			cameraData.renderHeight = inputHeight;
			cameraData.temporalOutputWidth = outputWidth;
			cameraData.temporalOutputHeight = outputHeight;
			cameraData.temporalUpscalerActive = true;
			cameraData.renderScale = (float)cameraData.renderHeight / (float)cameraData.pixelHeight;
		}
	}

	private static void SetPCRenderResolution(float temporalOutputScale, ref CameraData cameraData)
	{
		temporalOutputScale = SnapRenderScaleToOne(Mathf.Clamp(temporalOutputScale, minRenderScale, maxRenderScale));
		cameraData.temporalUpscalerActive = TemporalUpscalerRenderScale.IsActive;
		if (TemporalUpscalerRenderScale.TryGetMetalFXDimensions(cameraData.pixelWidth, cameraData.pixelHeight, temporalOutputScale, out var inputWidth, out var inputHeight, out var outputWidth, out var outputHeight))
		{
			cameraData.renderWidth = inputWidth;
			cameraData.renderHeight = inputHeight;
			cameraData.temporalOutputWidth = outputWidth;
			cameraData.temporalOutputHeight = outputHeight;
		}
		else
		{
			cameraData.temporalOutputWidth = Mathf.Max(1, Mathf.RoundToInt((float)cameraData.pixelWidth * temporalOutputScale));
			cameraData.temporalOutputHeight = Mathf.Max(1, Mathf.RoundToInt((float)cameraData.pixelHeight * temporalOutputScale));
			TemporalUpscalerRenderScale.GetActiveInputResolution(cameraData.temporalOutputWidth, cameraData.temporalOutputHeight, out cameraData.renderWidth, out cameraData.renderHeight);
		}
		cameraData.renderScale = (float)cameraData.renderHeight / (float)cameraData.pixelHeight;
	}

	private static float SnapRenderScaleToOne(float renderScale)
	{
		if (!(renderScale >= 0.99f) || !(renderScale <= 1.01f))
		{
			return renderScale;
		}
		return 1f;
	}

	private static bool ShouldRenderPostProcessing(Camera camera, CameraType cameraType, CameraRenderType renderType)
	{
		if (renderType != CameraRenderType.Base)
		{
			return false;
		}
		return cameraType == CameraType.Game;
	}

	private void InitializeAdditionalCameraData(Camera camera, UniversalAdditionalCameraData additionalCameraData, bool lastCam, ref CameraData cameraData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.initializeAdditionalCameraData))
		{
			cameraData.camera = camera;
			UniversalRenderer.RuntimeRenderSettings runtimeSettings = (((additionalCameraData != null) ? additionalCameraData.ur : settings.scriptableRenderer) as UniversalRenderer).runtimeSettings;
			bool flag = runtimeSettings.SupportsMainLightShadows || runtimeSettings.SupportsAdditionalLightShadows;
			cameraData.maxShadowDistance = Mathf.Min(runtimeSettings.ShadowDistance, camera.farClipPlane);
			cameraData.maxShadowDistance = ((flag && cameraData.maxShadowDistance >= camera.nearClipPlane) ? cameraData.maxShadowDistance : 0f);
			if (additionalCameraData != null)
			{
				cameraData.renderType = additionalCameraData.renderType;
				cameraData.clearDepth = additionalCameraData.renderType == CameraRenderType.Base || additionalCameraData.clearDepth;
				cameraData.maxShadowDistance = (additionalCameraData.renderShadows ? cameraData.maxShadowDistance : 0f);
				cameraData.renderer = additionalCameraData.ur;
				cameraData.isGammaUI = additionalCameraData.gammaUI;
			}
			else
			{
				cameraData.renderType = CameraRenderType.Base;
				cameraData.clearDepth = true;
				cameraData.renderer = settings.scriptableRenderer as UniversalRenderer;
			}
			cameraData.skip = cameraData.cameraType == CameraType.Game && cameraData.renderType == CameraRenderType.Base && (s_SkipBaseCamera || (additionalCameraData != null && additionalCameraData.skipBase));
			cameraData.postProcessEnabled = ShouldRenderPostProcessing(camera, cameraData.cameraType, cameraData.renderType);
			cameraData.lastCam = lastCam;
			cameraData.SetViewAndProjectionMatrix(camera.worldToCameraMatrix, camera.projectionMatrix);
			cameraData.worldSpaceCameraPos = camera.transform.position;
			cameraData.isCameraProjectionMatrixFlipped = s_GraphicsUVStartsAtTop;
		}
	}

	private void InitializeRenderingData(ref CameraData cameraData, ref CullingResults cullResults, CommandBuffer cmd, out RenderingData renderingData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.initializeRenderingData))
		{
			renderingData.cmd = cmd;
			renderingData.cullResults = cullResults;
			renderingData.cameraData = cameraData;
			renderingData.supportsDynamicBatching = settings.supportsDynamicBatching;
			renderingData.nativeRenderPass = cameraData.nativeRenderPassEnabled && cameraData.isGameCamera;
			if (renderingData.nativeRenderPass)
			{
				UniversalRenderer renderer = cameraData.renderer;
				if (renderer != null && renderer.renderPassScheduleMode == RenderPassScheduleMode.PC)
				{
					renderingData.nativeRenderPass = false;
				}
			}
			renderingData.nativeRenderPassManager = m_NativeRenderPassManager;
			renderingData.splitNativeDeferredForDepth = settings.splitNativeDeferredForDepth;
			renderingData.nativeDeferredMode = NativeDeferredMode.None;
			renderingData.nativePostDeferredPass = false;
			renderingData.preserveDepthStencilForGrabPass = false;
			renderingData.sceneToneInGrabPass = false;
			renderingData.proximaTestMat = settings.proximaTestMaterial;
			renderingData.doGrabPass = false;
			if (cameraData.isBase)
			{
				NativeArray<VisibleLight> visibleLights = cullResults.visibleLights;
				PrepareVisibleLights(visibleLights, out var mainLightIndex, out var mainLightCastShadow, out var additionalLightsCastShadow);
				bool flag = cameraData.maxShadowDistance > 0f;
				bool mainLightCastShadows = flag & mainLightCastShadow;
				bool flag2 = flag & additionalLightsCastShadow;
				InitializeLightData(visibleLights, mainLightIndex, m_PreparedLights, out renderingData.lightData);
				UniversalRenderer renderer2 = cameraData.renderer;
				InitializeShadowData(renderer2, mainLightCastShadows, flag2 && !renderingData.lightData.shadeAdditionalLightsPerVertex, out renderingData.shadowData);
				postProcessingData.uberPostSharpening = renderer2.runtimeSettings.UberPostSharpening;
				renderingData.postProcessingData = postProcessingData;
				renderingData.perObjectData = GetPerObjectLightFlags();
			}
			else
			{
				renderingData.lightData = default;
				renderingData.shadowData = default;
				renderingData.postProcessingData = default;
				renderingData.perObjectData = GetPerObjectLightFlags();
			}
			renderingData.sortingSettings = new SortingSettings(cameraData.camera);
		}
	}

	private void InitializeShadowData(UniversalRenderer renderer, bool mainLightCastShadows, bool additionalLightsCastShadows, out ShadowData shadowData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.initializeShadowData))
		{
			UniversalRenderer.RuntimeRenderSettings runtimeSettings = renderer.runtimeSettings;
			shadowData.supportsMainLightShadows = runtimeSettings.SupportsMainLightShadows & mainLightCastShadows;
			shadowData.supportsAdditionalLightShadows = runtimeSettings.SupportsAdditionalLightShadows & additionalLightsCastShadows;
			shadowData.mainLightShadowCascadesCount = runtimeSettings.ShadowCascadeCount;
			shadowData.mainLightShadowmapWidth = runtimeSettings.MainLightShadowmapResolution;
			shadowData.mainLightShadowmapHeight = runtimeSettings.MainLightShadowmapResolution;
			Vector3 mainLightShadowCascadesSplit = runtimeSettings.MainLightShadowCascadesSplit;
			switch (shadowData.mainLightShadowCascadesCount)
			{
			case 1:
				shadowData.mainLightShadowCascadesSplit = new Vector3(1f, 0f, 0f);
				break;
			case 2:
				shadowData.mainLightShadowCascadesSplit = new Vector3(mainLightShadowCascadesSplit.x, 1f, 0f);
				break;
			case 3:
				shadowData.mainLightShadowCascadesSplit = new Vector3(mainLightShadowCascadesSplit.x, mainLightShadowCascadesSplit.y, 0f);
				break;
			default:
				shadowData.mainLightShadowCascadesSplit = mainLightShadowCascadesSplit;
				break;
			}
			shadowData.mainLightShadowCascadeBorder = settings.cascadeBorder;
			shadowData.additionalLightsShadowmapWidth = runtimeSettings.AdditionalLightsShadowmapResolution;
			shadowData.additionalLightsShadowSliceResolution = runtimeSettings.AdditionalLightsShadowSliceResolution;
			shadowData.additionalShadowTimeSlicingEnabled = runtimeSettings.AdditionalShadowTimeSlicingEnabled;
			shadowData.maxAdditionalShadowTilesPerFrame = runtimeSettings.MaxAdditionalShadowTilesPerFrame;
			shadowData.mainLightCascadeDepthBias = settings.mainLightCascadeDepthBias;
			shadowData.mainLightCascadeSlopeBias = settings.mainLightCascadeSlopeBias;
			shadowData.additionalLightShadowDepthBias = settings.shadowDepthBias;
			shadowData.additionalLightShadowNormalBias = settings.shadowNormalBias;
			shadowData.additionalLightShadowSlopeBias = settings.additionalLightShadowSlopeBias;
		}
	}

	private void InitializePostProcessingData(out PostProcessingData postProcessingData)
	{
		postProcessingData.lutSize = settings.colorGradingLutSize;
		postProcessingData.motionVector = false;
		postProcessingData.motionFeature = false;
		postProcessingData.TAA_History = default;
		postProcessingData.TAA_Target = default;
		postProcessingData.temporalResolver = null;
		postProcessingData.temporalFallbackResolver = null;
		postProcessingData.temporalJitter = Vector4.zero;
		postProcessingData.TAAHistoryValid = false;
		postProcessingData.uberPostSharpening = settings.uberPostSharpening;
		postProcessingData.temporalColorHistoryProvider = null;
		postProcessingData.previousTemporalColor = default;
	}

	private void InitializeLightData(NativeArray<VisibleLight> visibleLights, int mainLightIndex, PreparedLightFrameData preparedLights, out LightData lightData)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.initializeLightData))
		{
			int val = maxPerObjectLights;
			lightData.mainLightIndex = mainLightIndex;
			lightData.preparedLights = preparedLights;
			if (settings.additionalLightsRenderingMode != LightRenderingMode.Disabled)
			{
				lightData.additionalLightsCount = Math.Min((mainLightIndex != -1) ? (visibleLights.Length - 1) : visibleLights.Length, maxVisibleAdditionalLights);
				lightData.maxPerObjectAdditionalLightsCount = Math.Min(settings.maxAdditionalLightsCount, val);
			}
			else
			{
				lightData.additionalLightsCount = 0;
				lightData.maxPerObjectAdditionalLightsCount = 0;
			}
			lightData.supportsAdditionalLights = settings.additionalLightsRenderingMode != LightRenderingMode.Disabled;
			lightData.shadeAdditionalLightsPerVertex = settings.additionalLightsRenderingMode == LightRenderingMode.PerVertex;
			lightData.visibleLights = visibleLights;
			lightData.supportsLightLayers = settings.supportsLightLayers;
		}
	}

	private static PerObjectData GetPerObjectLightFlags()
	{
		return PerObjectData.Lightmaps;
	}

	private void PrepareVisibleLights(NativeArray<VisibleLight> visibleLights, out int mainLightIndex, out bool mainLightCastShadow, out bool additionalLightsCastShadow)
	{
		using (new ProfilingScope(null, Profiling.Pipeline.getMainLightIndex))
		{
			int num = Math.Min(visibleLights.Length, m_PreparedLights.visibleLights.Length);
			mainLightIndex = -1;
			mainLightCastShadow = false;
			additionalLightsCastShadow = false;
			int preparedVisibleLightCount = 0;
			int preparedPunctualLightCount = 0;
			int preparedShadowCandidateCount = 0;
			int num2 = 0;
			bool flag = settings.mainLightRenderingMode == LightRenderingMode.PerPixel;
			if (num == 0)
			{
				m_PreparedLights.Complete(0, 0, 0, 0);
				return;
			}
			Light light = (flag ? RenderSettings.sun : null);
			bool flag2 = flag && (light == null || !light.isActiveAndEnabled);
			float num3 = 0.01f;
			for (int i = 0; i < num; i++)
			{
				VisibleLight visibleLight = visibleLights[i];
				Light light2 = visibleLight.light;
				bool num4 = light2 == null || !light2.isActiveAndEnabled;
				UniversalAdditionalLightData universalAdditionalLightData = ((light2 != null) ? light2.GetUniversalAdditionalLightData() : null);
				ref PreparedVisibleLight reference = ref m_PreparedLights.visibleLights[i];
				reference.additionalData = universalAdditionalLightData;
				InitializeLightConstants_Common(visibleLights, i, universalAdditionalLightData, out reference.position, out reference.color, out reference.attenuation, out reference.spotDirection, out reference.actData, out reference.actData2, out reference.actData3);
				reference.range = visibleLight.range;
				reference.spotAngle = visibleLight.spotAngle;
				reference.layerMask = (int)((universalAdditionalLightData != null) ? universalAdditionalLightData.lightLayerMask : LightLayerEnum.Nothing);
				reference.lightType = visibleLight.lightType;
				preparedVisibleLightCount = i + 1;
				bool flag3 = visibleLight.lightType == LightType.Spot || visibleLight.lightType == LightType.Point;
				if (flag3)
				{
					m_PreparedLights.punctualVisibleLightIndices[preparedPunctualLightCount++] = i;
				}
				if (!num4 && universalAdditionalLightData != null)
				{
					LightHalo aCT_LightHalos = universalAdditionalLightData.ACT_LightHalos;
					if (aCT_LightHalos?.HaloData != null && aCT_LightHalos.HaloData.Count > 0 && num2 < m_PreparedLights.haloCandidates.Length)
					{
						Vector4 column = visibleLight.localToWorldMatrix.GetColumn(3);
						Vector4 column2 = visibleLight.localToWorldMatrix.GetColumn(2);
						m_PreparedLights.haloCandidates[num2++] = new LightHaloCandidate(aCT_LightHalos, i, new Vector3(column.x, column.y, column.z), new Vector3(column2.x, column2.y, column2.z), visibleLight.lightType);
					}
				}
				if ((!num4 & flag3) && light2 != null && light2.shadows != LightShadows.None && !Mathf.Approximately(light2.shadowStrength, 0f))
				{
					m_PreparedLights.shadowCandidateVisibleLightIndices[preparedShadowCandidateCount++] = i;
					additionalLightsCastShadow = true;
				}
				if (num4 || !flag || visibleLight.lightType != LightType.Directional)
				{
					continue;
				}
				if (flag2)
				{
					float num5 = light2.color.grayscale * light2.intensity;
					if (num5 > num3)
					{
						num3 = num5;
						mainLightIndex = i;
						mainLightCastShadow = light2.shadows != LightShadows.None;
					}
				}
				else if (light2 == light)
				{
					mainLightCastShadow = light2.shadows != LightShadows.None;
					mainLightIndex = i;
				}
			}
			m_PreparedLights.Complete(preparedVisibleLightCount, preparedPunctualLightCount, preparedShadowCandidateCount, num2);
		}
	}

	private void SetupPerFrameShaderConstants(ScriptableRenderContext context, CommandBuffer cmd)
	{
	}

	public static bool IsGameCamera(Camera camera)
	{
		if (camera == null)
		{
			throw new ArgumentNullException("camera");
		}
		return camera.cameraType == CameraType.Game;
	}

	private void SortCameras(List<Camera> cameras)
	{
		if (cameras.Count > 1)
		{
			cameras.Sort(cameraComparison);
		}
	}

	private static GraphicsFormat MakeRenderTextureGraphicsFormat(bool isHdrEnabled, bool needsAlpha)
	{
		if (isHdrEnabled)
		{
			if (!needsAlpha)
			{
				return GraphicsFormat.B10G11R11_UFloatPack32;
			}
			return GraphicsFormat.R16G16B16A16_SFloat;
		}
		return SystemInfo.GetGraphicsFormat(DefaultFormat.LDR);
	}

	internal static GraphicsFormat MakeUnormRenderTextureGraphicsFormat()
	{
		return GraphicsFormat.A2B10G10R10_UNormPack32;
	}

	private static RenderTextureDescriptor CreateRenderTextureDescriptor(Camera camera, int renderWidth, int renderHeight, bool isHdrEnabled, bool overrideTargetTextureSize)
	{
		RenderTextureDescriptor descriptor;
		if (camera.targetTexture == null)
		{
			descriptor = colorRTDes;
			descriptor.width = renderWidth;
			descriptor.height = renderHeight;
		}
		else
		{
			descriptor = camera.targetTexture.descriptor;
			descriptor.width = (overrideTargetTextureSize ? renderWidth : camera.pixelWidth);
			descriptor.height = (overrideTargetTextureSize ? renderHeight : camera.pixelHeight);
			if (camera.cameraType == CameraType.SceneView && !isHdrEnabled)
			{
				descriptor.graphicsFormat = SystemInfo.GetGraphicsFormat(DefaultFormat.HDR);
			}
		}
		descriptor.width = Mathf.Max(1, descriptor.width);
		descriptor.height = Mathf.Max(1, descriptor.height);
		descriptor.msaaSamples = 1;
		descriptor.bindMS = false;
		return descriptor;
	}

	public static void GetLightAttenuationAndSpotDirection(LightType lightType, float lightRange, Matrix4x4 lightLocalToWorldMatrix, float spotAngle, float? innerSpotAngle, out Vector4 lightAttenuation, out Vector4 lightSpotDir)
	{
		lightAttenuation = k_DefaultLightAttenuation;
		lightSpotDir = k_DefaultLightSpotDirection;
		if (lightType != LightType.Directional)
		{
			float num = lightRange * lightRange;
			float num2 = 0.64000005f * num - num;
			float num3 = 1f / num2;
			float y = (0f - num) / num2;
			float num4 = 1f / Mathf.Max(0.0001f, num);
			lightAttenuation.x = ((GraphicsSettings.HasShaderDefine(Graphics.activeTier, BuiltinShaderDefine.SHADER_API_MOBILE) || SystemInfo.graphicsDeviceType == GraphicsDeviceType.Switch) ? num3 : num4);
			lightAttenuation.y = y;
		}
		if (lightType == LightType.Spot)
		{
			Vector4 column = lightLocalToWorldMatrix.GetColumn(2);
			lightSpotDir = new Vector4(0f - column.x, 0f - column.y, 0f - column.z, 0f);
			float num5 = Mathf.Cos(MathF.PI / 180f * spotAngle * 0.5f);
			float num6;
			if (innerSpotAngle.HasValue)
			{
				num6 = Mathf.Cos(innerSpotAngle.Value * (MathF.PI / 180f) * 0.5f);
			}
			else
			{
				float f = spotAngle * 0.5f * (MathF.PI / 180f);
				num6 = Mathf.Cos(2f * Mathf.Atan(Mathf.Tan(f) * 46f / 64f) * 0.5f);
			}
			float num7 = Mathf.Max(0.001f, num6 - num5);
			float num8 = 1f / num7;
			float w = (0f - num5) * num8;
			lightAttenuation.z = num8;
			lightAttenuation.w = w;
		}
	}

	public static void InitializeLightConstants_Common(NativeArray<VisibleLight> lights, int lightIndex, out Vector4 lightPos, out Vector4 lightColor, out Vector4 lightAttenuation, out Vector4 lightSpotDir, out Vector4 lightOcclusionProbeChannel, out Vector4 ACTLightData, out Vector4 ACTLightData2, out Vector4 ACTLightData3)
	{
		UniversalAdditionalLightData additionalLightData = null;
		if ((uint)lightIndex < (uint)lights.Length)
		{
			Light light = lights[lightIndex].light;
			if (light != null)
			{
				additionalLightData = light.GetUniversalAdditionalLightData();
			}
		}
		lightOcclusionProbeChannel = k_DefaultLightsProbeChannel;
		InitializeLightConstants_Common(lights, lightIndex, additionalLightData, out lightPos, out lightColor, out lightAttenuation, out lightSpotDir, out ACTLightData, out ACTLightData2, out ACTLightData3);
	}

	internal static void InitializeLightConstants_Common(NativeArray<VisibleLight> lights, int lightIndex, UniversalAdditionalLightData additionalLightData, out Vector4 lightPos, out Vector4 lightColor, out Vector4 lightAttenuation, out Vector4 lightSpotDir, out Vector4 ACTLightData, out Vector4 ACTLightData2, out Vector4 ACTLightData3)
	{
		lightPos = k_DefaultLightPosition;
		lightColor = k_DefaultLightColor;
		lightAttenuation = k_DefaultLightAttenuation;
		lightSpotDir = k_DefaultLightSpotDirection;
		ACTLightData = k_DefaultACTLightData;
		ACTLightData2 = k_DefaultACTLightData;
		ACTLightData3 = k_DefaultACTLightData;
		if (lightIndex >= 0)
		{
			VisibleLight visibleLight = lights[lightIndex];
			if (visibleLight.lightType == LightType.Directional)
			{
				Vector4 vector = -visibleLight.localToWorldMatrix.GetColumn(2);
				lightPos = new Vector4(vector.x, vector.y, vector.z, 0f);
			}
			else
			{
				Vector4 column = visibleLight.localToWorldMatrix.GetColumn(3);
				lightPos = new Vector4(column.x, column.y, column.z, 1f);
			}
			lightColor = visibleLight.finalColor;
			GetLightAttenuationAndSpotDirection(visibleLight.lightType, visibleLight.range, visibleLight.localToWorldMatrix, visibleLight.spotAngle, visibleLight.light?.innerSpotAngle, out lightAttenuation, out lightSpotDir);
			if (!(additionalLightData == null))
			{
				ACTLightData = new Vector4(additionalLightData.ACT_RimIntensity, additionalLightData.ACT_LightHardness, additionalLightData.ACT_LightRadius);
				ACTLightData2 = new Vector4(additionalLightData.ACT_Offset, additionalLightData.ACT_Revert ? 1 : 0, additionalLightData.ACT_IgnoreFace ? 1 : 0, additionalLightData.ACT_DepthHighLight);
				ACTLightData3 = new Vector4(additionalLightData.ACT_LightRimRange.x, additionalLightData.ACT_LightRimRange.y);
			}
		}
	}
}
