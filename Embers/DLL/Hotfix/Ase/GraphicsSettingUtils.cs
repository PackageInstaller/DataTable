#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Reflection;
using GameFramework;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Ase;

public class GraphicsSettingUtils
{
	private UniversalRenderPipelineAsset _cachedRenderPipeline;

	private int _oriScreenWidth = 2560;

	private int _oriScreenHeight = 1152;

	private static readonly Type s_pipelineAssetType = typeof(UniversalRenderPipelineAsset);

	private static readonly FieldInfo s_mainLightShadowmapResolution = s_pipelineAssetType.GetField("m_MainLightShadowmapResolution", BindingFlags.Instance | BindingFlags.NonPublic);

	private static readonly FieldInfo s_opaqueDownsampling = s_pipelineAssetType.GetField("m_OpaqueDownsampling", BindingFlags.Instance | BindingFlags.NonPublic);

	private float _tmpRenderScale;

	private UniversalRenderPipelineAsset CachedRenderPipeline
	{
		get
		{
			if ((UnityEngine.Object)(object)_cachedRenderPipeline == null)
			{
				ResetRP();
			}
			return _cachedRenderPipeline;
		}
	}

	public float CurrentRenderScale
	{
		get
		{
			VerifyCachedRenderPipeline();
			if ((UnityEngine.Object)(object)CachedRenderPipeline == null)
			{
				return -1f;
			}
			return CachedRenderPipeline.renderScale;
		}
	}

	public int CurrentVSYNCCount
	{
		get
		{
			VerifyCachedRenderPipeline();
			if ((UnityEngine.Object)(object)CachedRenderPipeline == null)
			{
				return -1;
			}
			return QualitySettings.vSyncCount;
		}
	}

	public GraphicsSettingUtils()
	{
		Resolution currentResolution = Screen.currentResolution;
		_oriScreenWidth = currentResolution.width;
		_oriScreenHeight = currentResolution.height;
	}

	public void RevertURPData()
	{
	}

	private void ResetRP(bool reset = false)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Expected O, but got Unknown
		_cachedRenderPipeline = (UniversalRenderPipelineAsset)QualitySettings.renderPipeline;
	}

	private void VerifyCachedRenderPipeline()
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Expected O, but got Unknown
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Expected O, but got Unknown
		if (!((UnityEngine.Object)(UniversalRenderPipelineAsset)QualitySettings.renderPipeline == null) && (UnityEngine.Object)(object)CachedRenderPipeline != (UnityEngine.Object)(UniversalRenderPipelineAsset)QualitySettings.renderPipeline)
		{
			ResetRP(reset: true);
		}
	}

	public void IncreaseRenderScale(float amount)
	{
		_tmpRenderScale = Mathf.Clamp(CurrentRenderScale + amount, 0.2f, 1f);
		SetRenderScale(_tmpRenderScale);
	}

	public void DecreaseRenderScale(float amount)
	{
		_tmpRenderScale = Mathf.Clamp(CurrentRenderScale - amount, 0.2f, 1f);
		SetRenderScale(_tmpRenderScale);
	}

	public void AdapterResolution(int width, bool fullScreen, bool isFreeResoScale = true, int preferredRefreshRate = 60)
	{
		int num;
		int height;
		if (isFreeResoScale)
		{
			num = Mathf.Min(width, _oriScreenWidth);
			float num2 = (float)num * 1f / (float)_oriScreenWidth;
			height = (int)((float)_oriScreenHeight * num2);
		}
		else
		{
			num = width;
			height = (int)((float)num * 0.45f);
		}
		Screen.SetResolution(num, height, fullScreen, preferredRefreshRate);
	}

	public void SetRenderScale(float value)
	{
		VerifyCachedRenderPipeline();
		if ((UnityEngine.Object)(object)CachedRenderPipeline == null)
		{
			Log.Error("[GraphicsSettingUtil](SetRenderScale): Current Pipeline is null");
		}
		else
		{
			CachedRenderPipeline.renderScale = Mathf.Clamp(value, 0.2f, 1f);
		}
	}

	public void SetOpaqueDownsampling(Downsampling down)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		VerifyCachedRenderPipeline();
		if ((UnityEngine.Object)(object)CachedRenderPipeline == null)
		{
			Log.Error("[GraphicsSettingUtil](SetRenderScale): Current Pipeline is null");
		}
		else if (CachedRenderPipeline.supportsCameraOpaqueTexture && down != CachedRenderPipeline.opaqueDownsampling)
		{
			s_opaqueDownsampling.SetValue(CachedRenderPipeline, down);
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

	public void SetAntiAliasing(Camera main, AntialiasingMode mode, bool isUseMsaa = false)
	{
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Invalid comparison between Unknown and I4
		isUseMsaa = isUseMsaa && SystemInfo.supportsMultisampledTextures != 0 && !IsGLESDevice();
		if (isUseMsaa)
		{
			VerifyCachedRenderPipeline();
			if ((UnityEngine.Object)(object)CachedRenderPipeline == null)
			{
				Log.Error("[GraphicsSettingUtil](SetAntiAliasing): Current Pipeline is null");
			}
			else
			{
				CachedRenderPipeline.msaaSampleCount = (((int)mode == 0) ? 1 : 4);
			}
			return;
		}
		UniversalAdditionalCameraData universalAdditionalCameraData = CameraExtensions.GetUniversalAdditionalCameraData(main);
		if ((UnityEngine.Object)(object)universalAdditionalCameraData != null && universalAdditionalCameraData.antialiasing != mode)
		{
			universalAdditionalCameraData.antialiasing = mode;
			if ((int)mode == 2)
			{
				universalAdditionalCameraData.antialiasingQuality = (AntialiasingQuality)0;
			}
		}
	}

	public void SetShadow(Camera main, bool enable, ShadowResolution resolution = (ShadowResolution)512)
	{
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Invalid comparison between Unknown and I4
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		UniversalAdditionalCameraData universalAdditionalCameraData = CameraExtensions.GetUniversalAdditionalCameraData(main);
		if ((UnityEngine.Object)(object)universalAdditionalCameraData != null)
		{
			if (universalAdditionalCameraData.renderShadows != enable)
			{
				universalAdditionalCameraData.renderShadows = enable;
			}
			if (enable && (int)resolution != CachedRenderPipeline.mainLightShadowmapResolution)
			{
				s_mainLightShadowmapResolution.SetValue(CachedRenderPipeline, resolution);
			}
		}
	}

	public void SetSoftShadow(Light mainLight, bool enable)
	{
		if ((bool)mainLight)
		{
			mainLight.shadows = ((!enable) ? LightShadows.Hard : LightShadows.Soft);
		}
	}

	public void SetHDR(Camera main, bool enable)
	{
		main.allowHDR = enable;
	}
}
