using System;
using GameFramework.Runtime;
using Naiwen.TAA;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Ase;

public class GraphicsSetting : Singleton<GraphicsSetting>
{
	public enum GraphicSettingMode
	{
		Performance,
		Quality,
		SuperHighRes,
		Custom
	}

	private GraphicsSettingUtils helper;

	private Camera mainCamera;

	private bool initialized;

	private IMessenger messenger;

	private GraphicsData graphicsData;

	private ISubscription<GraphicsData> dataChanged;

	private GraphicsResolutionEnum _curResolution = GraphicsResolutionEnum.NONE;

	private int _curFPSIdx = -1;

	private const string FPS_KEY = "GameSetting_帧率";

	public bool IsOuterScene { get; set; }

	private bool IsUseMSAA { get; set; }

	public GraphicsSetting()
	{
		helper = new GraphicsSettingUtils();
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		Init();
	}

	private void Init()
	{
		ReloadComponent();
		int settingLevelByDeviceLevel = GetSettingLevelByDeviceLevel(GetDeviceLevel());
		IsUseMSAA = settingLevelByDeviceLevel >= 2;
		GraphicsData graphicsSettingScheme = GetGraphicsSettingScheme(settingLevelByDeviceLevel);
		GameSettingExtension.InitGraphicDefaultSetting(settingLevelByDeviceLevel, graphicsSettingScheme);
		GraphicsData data = LoadCacheData();
		ReloadData(data);
		dataChanged = messenger.Subscribe<GraphicsData>("GameSetting_" + SettingTypeEnum.GraphicsSetting, ReloadData);
		initialized = true;
	}

	private void ReloadComponent()
	{
		mainCamera = GameEntry.Camera.MainCamera;
		if (initialized)
		{
			ReloadData(LoadCacheData());
		}
	}

	private void ReloadData(GraphicsData data)
	{
		graphicsData = data;
		ApplyData();
	}

	private GraphicsData LoadCacheData()
	{
		string key = "CustomSetted";
		GraphicsData graphicsData = null;
		if (PlayerPrefs.HasKey(key))
		{
			graphicsData = GameSettingExtension.GetGraphicsData();
		}
		else
		{
			PlayerPrefs.SetString(key, "true");
		}
		if (graphicsData == null)
		{
			int settingLevelByDeviceLevel = GetSettingLevelByDeviceLevel(GetDeviceLevel());
			graphicsData = GetGraphicsSettingScheme(settingLevelByDeviceLevel);
			GameSettingExtension.ApplyGraphicSetting(settingLevelByDeviceLevel, graphicsData);
		}
		return graphicsData;
	}

	private void ApplyData()
	{
		if (graphicsData != null)
		{
			SetFrameRateLock(graphicsData.FrameRataLock);
			SetRenderAccuracy(graphicsData.RenderAccuracy);
			SetShadow(graphicsData.Shadow);
			Volume[] volumes = UnityEngine.Object.FindObjectsOfType<Volume>();
			SetHDR(graphicsData.HDR, in volumes);
			SetAntiAliasing(graphicsData.AntiAliasing, in volumes);
			SetBloom(graphicsData.Bloom, in volumes);
			SetVignette(graphicsData.Vignette, in volumes);
			SendGPMEvent(graphicsData);
		}
	}

	private void SendGPMEvent(GraphicsData graphicsData)
	{
		_ = graphicsData.FrameRataLock;
		_ = graphicsData.Resolution;
		_ = graphicsData.Shadow;
		_ = graphicsData.AntiAliasing;
		_ = graphicsData.HDR;
		_ = graphicsData.Bloom;
		_ = graphicsData.Vignette;
	}

	private void SetFrameRateLock(int frameIndex)
	{
		if (_curFPSIdx != frameIndex)
		{
			_curFPSIdx = frameIndex;
			int targetFrameRate = -1;
			switch (frameIndex)
			{
			case 0:
				targetFrameRate = 30;
				break;
			case 1:
				targetFrameRate = 60;
				break;
			}
			Context.GetApplicationContext().GetService<IMessenger>().Publish("GameSetting_帧率", frameIndex);
			Application.targetFrameRate = targetFrameRate;
		}
	}

	public void LowFPS()
	{
		Singleton<GraphicsSetting>.Instance.SetFrameRateLock(0);
	}

	public void ResumeFPS()
	{
		int frameRateLock = ((Singleton<GraphicsSetting>.Instance.graphicsData == null) ? 1 : Singleton<GraphicsSetting>.Instance.graphicsData.FrameRataLock);
		Singleton<GraphicsSetting>.Instance.SetFrameRateLock(frameRateLock);
	}

	private void SetResolution(int value)
	{
		switch (value)
		{
		case 0:
			LowResolution();
			break;
		case 1:
			MidResolution();
			break;
		case 2:
			HighResolution();
			break;
		default:
			MidResolution();
			break;
		}
	}

	private void SetRenderAccuracy(float value)
	{
		float num = value;
		GraphicsResolutionEnum resolution;
		if (value > 1f)
		{
			resolution = GraphicsResolutionEnum.High;
			value = 1f;
		}
		else if (value > 0.8f)
		{
			resolution = GraphicsResolutionEnum.Mid;
			value = 1f;
		}
		else if (value > 0.6f)
		{
			resolution = GraphicsResolutionEnum.Low;
			value = 1f;
		}
		else
		{
			resolution = GraphicsResolutionEnum.Low;
			value = 0.8f;
		}
		SetResolution((int)resolution);
		helper.SetRenderScale(value);
		helper.SetOpaqueDownsampling((Downsampling)((!(num <= 1f)) ? 1 : 3));
	}

	private void SetShadow(int shadowResolution)
	{
		if (!(mainCamera == null))
		{
			if (shadowResolution <= 0)
			{
				helper.SetShadow(mainCamera, enable: false, (ShadowResolution)0);
			}
			else if (Enum.IsDefined(typeof(ShadowResolution), shadowResolution))
			{
				helper.SetShadow(mainCamera, enable: true, (ShadowResolution)shadowResolution);
			}
		}
	}

	private void SetAntiAliasing(int mode, in Volume[] volumes)
	{
		if (!mainCamera || IsOuterScene)
		{
			return;
		}
		bool flag = true;
		helper.SetAntiAliasing(mainCamera, (AntialiasingMode)((flag && mode > 0) ? 1 : 0), IsUseMSAA);
		if (volumes == null)
		{
			return;
		}
		Volume[] array = volumes;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].profile.TryGet<TemporalAntiAliasing>(out TemporalAntiAliasing component))
			{
				((VolumeComponent)(object)component).active = !flag && mode > 0;
			}
		}
	}

	private void SetHDR(bool enabled, in Volume[] volumes)
	{
		if (!mainCamera)
		{
			return;
		}
		if (volumes != null)
		{
			Volume[] array = volumes;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].profile.TryGet<Tonemapping>(out Tonemapping component);
				if ((bool)(UnityEngine.Object)(object)component)
				{
					((VolumeComponent)(object)component).active = enabled;
				}
			}
		}
		helper.SetHDR(mainCamera, enabled);
	}

	private void SetBloom(bool selected, in Volume[] volumes)
	{
		if (volumes == null)
		{
			return;
		}
		Volume[] array = volumes;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].profile.TryGet<Bloom>(out Bloom component);
			if ((bool)(UnityEngine.Object)(object)component)
			{
				((VolumeComponent)(object)component).active = selected;
			}
		}
	}

	private void SetVignette(bool selected, in Volume[] volumes)
	{
		if (volumes == null)
		{
			return;
		}
		Volume[] array = volumes;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].profile.TryGet<Vignette>(out Vignette component);
			if ((bool)(UnityEngine.Object)(object)component)
			{
				((VolumeComponent)(object)component).active = selected;
			}
		}
	}

	public static GraphicsData GetGraphicsSettingScheme(int settingIndex)
	{
		GraphicsData graphicsData = new GraphicsData
		{
			FrameRataLock = 0,
			Resolution = 1,
			RenderAccuracy = 0.8f,
			Shadow = 0,
			EffectLevel = 1,
			AntiAliasing = 1,
			HDR = false,
			Bloom = false,
			Vignette = false
		};
		return new GraphicsData
		{
			FrameRataLock = GetConfigValueByDeviceLevel("帧率", settingIndex, graphicsData.FrameRataLock),
			RenderAccuracy = GetConfigValueByDeviceLevel("渲染精度", settingIndex, graphicsData.RenderAccuracy),
			Shadow = GetConfigValueByDeviceLevel("阴影", settingIndex, graphicsData.Shadow),
			EffectLevel = GetConfigValueByDeviceLevel("特效等级", settingIndex, graphicsData.EffectLevel),
			AntiAliasing = GetConfigValueByDeviceLevel("抗锯齿", settingIndex, graphicsData.AntiAliasing),
			HDR = GetConfigValueByDeviceLevel("HDR", settingIndex, graphicsData.HDR),
			Bloom = GetConfigValueByDeviceLevel("Bloom", settingIndex, graphicsData.Bloom),
			Vignette = GetConfigValueByDeviceLevel("暗角", settingIndex, graphicsData.Vignette),
			Resolution = GetConfigValueByDeviceLevel("分辨率", settingIndex, graphicsData.Resolution)
		};
	}

	public Volume[] GetVolumes()
	{
		return UnityEngine.Object.FindObjectsOfType<Volume>();
	}

	public void DisableAntiAliasing(in Volume[] vols)
	{
		Singleton<GraphicsSetting>.Instance.SetAntiAliasing(0, in vols);
	}

	public void EnableAntiAliasing(in Volume[] vols)
	{
		Singleton<GraphicsSetting>.Instance.SetAntiAliasing(Singleton<GraphicsSetting>.Instance.graphicsData.AntiAliasing, in vols);
	}

	public void DisableBloom(in Volume[] vols)
	{
		Singleton<GraphicsSetting>.Instance.SetBloom(selected: false, in vols);
	}

	public void EnableBloom(in Volume[] vols)
	{
		Singleton<GraphicsSetting>.Instance.SetBloom(Singleton<GraphicsSetting>.Instance.graphicsData.Bloom, in vols);
	}

	public void ResumeResolution()
	{
		float num = ((Singleton<GraphicsSetting>.Instance.graphicsData != null) ? Singleton<GraphicsSetting>.Instance.graphicsData.RenderAccuracy : 1f);
		GraphicsResolutionEnum resolution = ((num > 1f) ? GraphicsResolutionEnum.High : ((num > 0.8f) ? GraphicsResolutionEnum.Mid : ((!(num > 0.6f)) ? GraphicsResolutionEnum.Low : GraphicsResolutionEnum.Low)));
		Singleton<GraphicsSetting>.Instance.SetResolution((int)resolution);
	}

	public void LowResolution()
	{
		if (_curResolution == GraphicsResolutionEnum.Low)
		{
			return;
		}
		if (IsOuterScene)
		{
			RuntimePlatform platform = Application.platform;
			if (platform == RuntimePlatform.Android || platform == RuntimePlatform.IPhonePlayer)
			{
				return;
			}
		}
		_curResolution = GraphicsResolutionEnum.Low;
		switch (Application.platform)
		{
		case RuntimePlatform.IPhonePlayer:
		case RuntimePlatform.Android:
			helper.AdapterResolution(1280, fullScreen: true);
			break;
		case RuntimePlatform.OSXPlayer:
		case RuntimePlatform.WindowsPlayer:
			helper.AdapterResolution(1920, Screen.fullScreen, isFreeResoScale: false, 0);
			break;
		}
	}

	public void MidResolution()
	{
		if (_curResolution == GraphicsResolutionEnum.Mid)
		{
			return;
		}
		if (IsOuterScene)
		{
			RuntimePlatform platform = Application.platform;
			if (platform == RuntimePlatform.Android || platform == RuntimePlatform.IPhonePlayer)
			{
				return;
			}
		}
		_curResolution = GraphicsResolutionEnum.Mid;
		switch (Application.platform)
		{
		case RuntimePlatform.IPhonePlayer:
		case RuntimePlatform.Android:
			helper.AdapterResolution(1600, fullScreen: true);
			break;
		case RuntimePlatform.OSXPlayer:
		case RuntimePlatform.WindowsPlayer:
			helper.AdapterResolution(2560, Screen.fullScreen, isFreeResoScale: false, 0);
			break;
		}
	}

	public void HighResolution()
	{
		if (_curResolution == GraphicsResolutionEnum.High)
		{
			return;
		}
		if (IsOuterScene)
		{
			RuntimePlatform platform = Application.platform;
			if (platform == RuntimePlatform.Android || platform == RuntimePlatform.IPhonePlayer)
			{
				return;
			}
		}
		_curResolution = GraphicsResolutionEnum.High;
		switch (Application.platform)
		{
		case RuntimePlatform.IPhonePlayer:
		case RuntimePlatform.Android:
			helper.AdapterResolution(1920, fullScreen: true);
			break;
		case RuntimePlatform.OSXPlayer:
		case RuntimePlatform.WindowsPlayer:
			helper.AdapterResolution(3840, Screen.fullScreen, isFreeResoScale: false, 0);
			break;
		}
	}

	public int GetDeviceLevel()
	{
		int deviceTier = GameEntry.BuiltinData.DeviceTier;
		return (deviceTier <= 0) ? 1 : deviceTier;
	}

	private int GetSettingLevelByDeviceLevel(int deviceLevel)
	{
		switch (deviceLevel)
		{
		case 1:
			return 1;
		case 2:
		case 3:
			return 2;
		case 4:
			return 3;
		default:
			return 2;
		}
	}

	public void SelectQuality(int graphicLevel)
	{
		graphicLevel = Mathf.Clamp(graphicLevel, 1, 3);
		GraphicsData graphicsSettingScheme = GetGraphicsSettingScheme(graphicLevel);
		GameSettingExtension.ApplyGraphicSetting(graphicLevel, graphicsSettingScheme);
	}

	public int GetCurQuality()
	{
		return GetSettingLevelByDeviceLevel(GetDeviceLevel());
	}

	private static bool GetConfigValueByDeviceLevel(string name, int level, bool defaultValue)
	{
		DRScreenSettings dataRow = GameEntry.DataTable.GetDataRow((DRScreenSettings p) => p.Name.Equals(name));
		if (dataRow == null)
		{
			return defaultValue;
		}
		return GetConfigValueByDeviceLevel(dataRow, level) switch
		{
			0 => false, 
			1 => true, 
			_ => defaultValue, 
		};
	}

	private static int GetConfigValueByDeviceLevel(string name, int level, int defaultValue)
	{
		DRScreenSettings dataRow = GameEntry.DataTable.GetDataRow((DRScreenSettings p) => p.Name.Equals(name));
		if (dataRow == null)
		{
			return defaultValue;
		}
		defaultValue = GetConfigValueByDeviceLevel(dataRow, level);
		if (GameSettingConfigHelper.SettingEnumValues.TryGetValue(name, out var value))
		{
			if (value.Count < level)
			{
				return defaultValue;
			}
			if (value.Count > defaultValue && int.TryParse(value[defaultValue].ToString(), out var result))
			{
				return result;
			}
		}
		return defaultValue;
	}

	private static float GetConfigValueByDeviceLevel(string name, int level, float defaultValue)
	{
		DRScreenSettings dataRow = GameEntry.DataTable.GetDataRow((DRScreenSettings p) => p.Name.Equals(name));
		if (dataRow == null)
		{
			return defaultValue;
		}
		defaultValue = GetConfigValueByDeviceLevel(dataRow, level);
		if (GameSettingConfigHelper.SettingEnumValues.TryGetValue(name, out var value))
		{
			if (value.Count < level)
			{
				return defaultValue;
			}
			if (int.TryParse(defaultValue.ToString(), out var result) && value.Count > result)
			{
				return value[result];
			}
		}
		return defaultValue;
	}

	private static int GetConfigValueByDeviceLevel(DRScreenSettings drScreenSettings, int level)
	{
		int result = 0;
		switch (level)
		{
		case 1:
			result = drScreenSettings.Value1;
			break;
		case 2:
			result = drScreenSettings.Value2;
			break;
		case 3:
			result = drScreenSettings.Value3;
			break;
		}
		return result;
	}

	public override void Dispose()
	{
		dataChanged = null;
		helper?.RevertURPData();
	}
}
