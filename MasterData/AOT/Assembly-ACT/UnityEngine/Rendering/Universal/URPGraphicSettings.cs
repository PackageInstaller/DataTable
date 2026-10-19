using System;
using ACT;
using ACT.Rendering;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

public static class URPGraphicSettings
{
	public enum MobileAntialiasingLevel
	{
		Off,
		TAA
	}

	public enum PCAntialiasingLevel
	{
		Off,
		TAA,
		DLSS
	}

	public enum PCDLSSQualityLevel
	{
		Balanced,
		MaximumQuality,
		DLAA
	}

	public enum TemporalUpscalerQualityLevel
	{
		Performance,
		Balanced,
		Quality,
		NativeAA
	}

	private const float TAAUberPostSharpening = 0.5f;

	private static UniversalRenderer GetUniversalRenderer()
	{
		return (UniversalRenderer)((UniversalRenderPipelineAsset)QualitySettings.renderPipeline).scriptableRenderer;
	}

	private static T GetRendererFeature<T>() where T : ScriptableRendererFeature
	{
		((UniversalRenderPipelineAsset)QualitySettings.renderPipeline).scriptableRendererData.TryGetRendererFeature<T>(out var rendererFeature);
		return rendererFeature;
	}

	public static void SetVSyncCount(int count)
	{
		(SettingsManager.Instance?.FrameRateLimiter)?.SetVSyncCount(count);
	}

	public static void SetFullScreenType(int type)
	{
		Screen.fullScreenMode = (FullScreenMode)type;
	}

	public static void SetFrameRate(int level)
	{
		switch (level)
		{
		case 0:
			SetTargetFrameRate(30);
			break;
		case 1:
			SetTargetFrameRate(60);
			break;
		case 2:
			SetTargetFrameRate(90);
			break;
		case 3:
			SetTargetFrameRate(120);
			break;
		case 4:
			SetTargetFrameRate(-1);
			break;
		}
	}

	private static void SetTargetFrameRate(int targetFrameRate)
	{
		SoftwareFrameRateLimiter softwareFrameRateLimiter = SettingsManager.Instance?.FrameRateLimiter;
		if (softwareFrameRateLimiter != null)
		{
			softwareFrameRateLimiter.SetTargetFrameRate(targetFrameRate);
		}
		else
		{
			Application.targetFrameRate = targetFrameRate;
		}
	}

	public static void SetRenderScale(float scale)
	{
		GetUniversalRenderer().SetRenderScale(Mathf.Clamp(scale, 0.5f, 1f));
	}

	public static void GetEstimatedRenderResolution(float playerRenderScale, int outputWidth, int outputHeight, out int renderWidth, out int renderHeight)
	{
		outputWidth = Mathf.Max(1, outputWidth);
		outputHeight = Mathf.Max(1, outputHeight);
		UniversalRenderPipelineAsset universalRenderPipelineAsset = QualitySettings.renderPipeline as UniversalRenderPipelineAsset;
		if (universalRenderPipelineAsset == null)
		{
			renderWidth = outputWidth;
			renderHeight = outputHeight;
			return;
		}
		playerRenderScale = Mathf.Clamp(playerRenderScale, 0.5f, 1.2f);
		float num = SnapRenderScaleToOne(Mathf.Clamp(SnapRenderScaleToOne((float)Mathf.Min(universalRenderPipelineAsset.heightPixels, outputHeight) * playerRenderScale / (float)outputHeight) * universalRenderPipelineAsset.mobilePerformanceRenderScaleMultiplier, UniversalRenderPipeline.minRenderScale, UniversalRenderPipeline.maxRenderScale));
		Camera main = Camera.main;
		int frameWidth = ((main != null) ? main.pixelWidth : outputWidth);
		int frameHeight = ((main != null) ? main.pixelHeight : outputHeight);
		if (!TemporalUpscalerRenderScale.TryGetMetalFXFrameResolutions(frameWidth, frameHeight, out renderWidth, out renderHeight, out var _, out var _))
		{
			renderWidth = Mathf.Max(1, Mathf.RoundToInt((float)outputWidth * num));
			renderHeight = Mathf.Max(1, Mathf.RoundToInt((float)outputHeight * num));
		}
	}

	private static float SnapRenderScaleToOne(float renderScale)
	{
		if (!(renderScale >= 0.99f) || !(renderScale <= 1.01f))
		{
			return renderScale;
		}
		return 1f;
	}

	public static float GetEffectiveRenderScale(float playerRenderScale)
	{
		return Mathf.Clamp(Mathf.Clamp(playerRenderScale, 0.5f, 1.2f) * TemporalUpscalerRenderScale.ActiveMultiplier, UniversalRenderPipeline.minRenderScale, UniversalRenderPipeline.maxRenderScale);
	}

	public static void SetAntialiasingLevel(int level)
	{
		GameSettings gameSettings = SettingsManager.Instance?.RuntimeSettings;
		TemporalUpscalerKind upscaler = (gameSettings ? TemporalUpscalerCapabilityResolver.Resolve(gameSettings.Usage) : TemporalUpscalerKind.None);
		SetAntialiasingLevel(level, upscaler);
	}

	public static void SetAntialiasingLevel(int level, TemporalUpscalerKind upscaler)
	{
		SetAllTemporalUpscalersEnabled(TemporalUpscalerKind.None);
		PCAntialiasingLevel pCAntialiasingLevel = (PCAntialiasingLevel)Mathf.Clamp(level, 0, 2);
		switch (pCAntialiasingLevel)
		{
		case PCAntialiasingLevel.Off:
			ConfigureTAA(active: false);
			break;
		case PCAntialiasingLevel.TAA:
			ConfigureTAA(active: true);
			break;
		case PCAntialiasingLevel.DLSS:
			ConfigureTAA(active: true);
			SetAllTemporalUpscalersEnabled(upscaler);
			break;
		}
		ConfigureUberPostSharpening(pCAntialiasingLevel == PCAntialiasingLevel.TAA);
	}

	public static void SetMobileAntialiasingLevel(int level)
	{
		SetAntialiasingLevel(Mathf.Clamp(level, 0, 1), TemporalUpscalerKind.None);
	}

	public static void SetPCAntialiasingLevel(int level)
	{
		GameSettings gameSettings = SettingsManager.Instance?.RuntimeSettings;
		SettingUsage usage = ((!gameSettings) ? SettingUsage.PC : gameSettings.Usage);
		SetAntialiasingLevel(level, TemporalUpscalerCapabilityResolver.Resolve(usage));
	}

	private static void ConfigureTAA(bool active)
	{
		TAAFeature rendererFeature = GetRendererFeature<TAAFeature>();
		rendererFeature.runtimeSettings.enabled = active;
		rendererFeature.ApplyRuntimeSettings();
	}

	private static void ConfigureUberPostSharpening(bool active)
	{
		GetUniversalRenderer().SetUberPostSharpening(active ? 0.5f : 0f);
	}

	public static void SetDLSSEnabled(bool enable)
	{
		DLSSFeature rendererFeature = GetRendererFeature<DLSSFeature>();
		rendererFeature.runtimeSettings.enabled = enable;
		rendererFeature.ApplyRuntimeSettings();
	}

	public static void SetDLSSQuality(int quality)
	{
		DLSSFeature.DLSSQuality quality2 = ToDLSSQuality((PCDLSSQualityLevel)Mathf.Clamp(quality, 0, 2));
		DLSSFeature rendererFeature = GetRendererFeature<DLSSFeature>();
		rendererFeature.runtimeSettings.quality = quality2;
		rendererFeature.ApplyRuntimeSettings();
	}

	public static void SetTemporalUpscalerQuality(int quality, TemporalUpscalerKind upscaler)
	{
		TemporalUpscalerQualityLevel temporalUpscalerQualityLevel = (TemporalUpscalerQualityLevel)Mathf.Clamp(quality, 0, 3);
		switch (upscaler)
		{
		case TemporalUpscalerKind.DLSS:
		{
			DLSSFeature rendererFeature4 = GetRendererFeature<DLSSFeature>();
			rendererFeature4.runtimeSettings.quality = (DLSSFeature.DLSSQuality)temporalUpscalerQualityLevel;
			rendererFeature4.ApplyRuntimeSettings();
			break;
		}
		case TemporalUpscalerKind.FSR4:
		case TemporalUpscalerKind.FSR3:
		{
			FSR3Feature rendererFeature3 = GetRendererFeature<FSR3Feature>();
			if ((bool)rendererFeature3)
			{
				rendererFeature3.runtimeSettings.quality = (FSR3Feature.Quality)temporalUpscalerQualityLevel;
				rendererFeature3.ApplyRuntimeSettings();
			}
			break;
		}
		case TemporalUpscalerKind.MetalFX:
		{
			MetalFXFeature rendererFeature2 = GetRendererFeature<MetalFXFeature>();
			rendererFeature2.runtimeSettings.quality = (MetalFXFeature.Quality)temporalUpscalerQualityLevel;
			rendererFeature2.ApplyRuntimeSettings();
			break;
		}
		case TemporalUpscalerKind.XeSS:
		{
			XeSSFeature rendererFeature = GetRendererFeature<XeSSFeature>();
			rendererFeature.runtimeSettings.quality = (XeSSFeature.Quality)(temporalUpscalerQualityLevel + 1);
			rendererFeature.ApplyRuntimeSettings();
			break;
		}
		}
	}

	private static void SetAllTemporalUpscalersEnabled(TemporalUpscalerKind activeUpscaler)
	{
		SetDLSSEnabled(activeUpscaler == TemporalUpscalerKind.DLSS);
		SetFSR3Enabled(activeUpscaler == TemporalUpscalerKind.FSR4 || activeUpscaler == TemporalUpscalerKind.FSR3);
		SetMetalFXEnabled(activeUpscaler == TemporalUpscalerKind.MetalFX);
		SetXeSSEnabled(activeUpscaler == TemporalUpscalerKind.XeSS);
	}

	private static void SetFSR3Enabled(bool enabled)
	{
		FSR3Feature rendererFeature = GetRendererFeature<FSR3Feature>();
		if ((bool)rendererFeature)
		{
			rendererFeature.runtimeSettings.enabled = enabled;
			rendererFeature.ApplyRuntimeSettings();
		}
	}

	private static void SetMetalFXEnabled(bool enabled)
	{
		MetalFXFeature rendererFeature = GetRendererFeature<MetalFXFeature>();
		rendererFeature.runtimeSettings.enabled = enabled;
		rendererFeature.ApplyRuntimeSettings();
	}

	private static void SetXeSSEnabled(bool enabled)
	{
		XeSSFeature rendererFeature = GetRendererFeature<XeSSFeature>();
		rendererFeature.runtimeSettings.enabled = enabled;
		rendererFeature.ApplyRuntimeSettings();
	}

	private static DLSSFeature.DLSSQuality ToDLSSQuality(PCDLSSQualityLevel quality)
	{
		return quality switch
		{
			PCDLSSQualityLevel.MaximumQuality => DLSSFeature.DLSSQuality.Quality, 
			PCDLSSQualityLevel.Balanced => DLSSFeature.DLSSQuality.Balanced, 
			_ => DLSSFeature.DLSSQuality.DLAA, 
		};
	}

	public static void DisableRealtimeShadows()
	{
		GetUniversalRenderer().SetShadowSettings(0f, supportsMainLightShadows: false, supportsAdditionalLightShadows: false, 1024, 1024, 256, 1, new Vector3(1f, 0f, 0f), additionalShadowTimeSlicingEnabled: false, 0);
	}

	public static void ApplyShadowTier(ShadowQualityTier tier)
	{
		if (tier == null)
		{
			DisableRealtimeShadows();
			return;
		}
		bool supportsMainLightShadows = tier.SupportsMainLightShadows;
		bool flag = supportsMainLightShadows && tier.SupportsAdditionalLightShadows;
		bool additionalShadowTimeSlicingEnabled = flag && tier.AdditionalShadowTimeSlicingEnabled && tier.MaxAdditionalShadowTilesPerFrame > 0;
		GetUniversalRenderer().SetShadowSettings(supportsMainLightShadows ? Mathf.Max(0f, tier.ShadowDistance) : 0f, supportsMainLightShadows, flag, tier.MainLightShadowmapResolution, tier.AdditionalLightsShadowmapResolution, tier.AdditionalLightsShadowSliceResolution, Mathf.Clamp(tier.CascadeCount, 1, 3), tier.GetCascadeSplits(), additionalShadowTimeSlicingEnabled, tier.MaxAdditionalShadowTilesPerFrame);
	}

	public static void SetBloomLevel(int level)
	{
		switch (level)
		{
		case 0:
			Bloom.s_Enable = false;
			break;
		case 1:
			Bloom.s_Enable = true;
			break;
		}
	}

	public static void SetDistortionLevel(int level)
	{
		UniversalRenderer universalRenderer = GetUniversalRenderer();
		switch (level)
		{
		case 0:
			universalRenderer.EnableDistortionPass = false;
			break;
		case 1:
			universalRenderer.EnableDistortionPass = true;
			break;
		}
	}

	public static void ToggleSkyBox(bool enable)
	{
		GetUniversalRenderer().EnableSkyboxPass = enable;
	}

	public static void SetNativeRenderPass(bool enable)
	{
		GetUniversalRenderer().SetNativeRenderPass(enable);
	}

	[Obsolete("Native defer was removed. Depth sample is no longer controlled by this quality option.")]
	public static void ToggleDepthSample(bool enable)
	{
	}

	[Obsolete("Native defer was removed. This method is kept only for API compatibility.")]
	public static void ToggleNativeDefer(bool enable)
	{
	}
}
