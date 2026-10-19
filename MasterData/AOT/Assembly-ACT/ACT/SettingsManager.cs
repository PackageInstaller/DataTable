using ACT.Rendering;
using Cysharp.Threading.Tasks;
using Runtime;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT;

public class SettingsManager : MonoBehaviour
{
	private static SettingsManager m_Instance;

	[SerializeField]
	private bool m_InitOnAwake;

	[SerializeField]
	private GameSettingsProvider SettingsProvider;

	private bool m_Initialized;

	private GameSettings m_RuntimeSettings;

	private TemporalUpscalerKind m_RuntimeUpscalerKind;

	private SoftwareFrameRateLimiter m_FrameRateLimiter;

	public static SettingsManager Instance => m_Instance;

	internal GameSettingsProvider SettingsProviderAsset => SettingsProvider;

	public SoftwareFrameRateLimiter FrameRateLimiter => m_FrameRateLimiter;

	public GameSettings RuntimeSettings => m_RuntimeSettings;

	public void Initialize()
	{
		if (m_Initialized)
		{
			return;
		}
		m_Initialized = true;
		m_Instance = this;
		m_FrameRateLimiter = new SoftwareFrameRateLimiter();
		m_RuntimeSettings = CreateRuntimeSettings();
		bool num = SettingsProvider?.ShouldInitializeFromDeviceGrade ?? false;
		GameSettingsProvider settingsProvider = SettingsProvider;
		int num2;
		if ((object)settingsProvider == null)
		{
			num2 = 0;
		}
		else
		{
			num2 = (settingsProvider.ShouldResetEditorLocalSettings ? 1 : 0);
			if (num2 != 0)
			{
				SettingsProvider?.SettingsSaver?.Delete(SettingsProvider.SavingKey);
			}
		}
		SerializedSettingsData serializedData = ((num2 != 0) ? new SerializedSettingsData() : SettingsProvider?.SettingsSaver.Load(SettingsProvider.SavingKey));
		GraphicGradePreset initialGraphicGradePreset = (num ? m_RuntimeSettings.GetGraphicGradePreset(DeviceGradeInfo.CurrentGraphicPresetLevel) : null);
		m_RuntimeSettings.Initialize(serializedData, initialGraphicGradePreset);
		m_RuntimeUpscalerKind = TemporalUpscalerCapabilityResolver.Resolve(m_RuntimeSettings.Usage);
		m_RuntimeSettings.RefreshPerformanceEvaluationConfigAsync().Forget();
	}

	private GameSettings CreateRuntimeSettings()
	{
		if (SettingsProvider == null)
		{
			return ScriptableObject.CreateInstance<GameSettings>();
		}
		GameSettings platformSettingsAsset = SettingsProvider.GetPlatformSettingsAsset(out var usage);
		if (platformSettingsAsset == null)
		{
			return ScriptableObject.CreateInstance<GameSettings>();
		}
		GameSettings gameSettings = Object.Instantiate(platformSettingsAsset);
		gameSettings.SetRuntimeSettingUsage(usage);
		return gameSettings;
	}

	private void CheckTemporalUpscalerRuntimeFailure()
	{
		if (m_Initialized && (bool)m_RuntimeSettings && m_RuntimeUpscalerKind != TemporalUpscalerKind.None && TryGetRuntimeUpscaler(m_RuntimeUpscalerKind, out var runtimeUpscaler) && TemporalUpscalerRenderScale.HasRuntimeFailure(runtimeUpscaler))
		{
			m_RuntimeSettings.FallbackTemporalUpscalerToTAA();
		}
	}

	private static bool TryGetRuntimeUpscaler(TemporalUpscalerKind upscaler, out TemporalUpscaler runtimeUpscaler)
	{
		switch (upscaler)
		{
		case TemporalUpscalerKind.DLSS:
			runtimeUpscaler = TemporalUpscaler.DLSS;
			return true;
		case TemporalUpscalerKind.FSR4:
		case TemporalUpscalerKind.FSR3:
			runtimeUpscaler = TemporalUpscaler.FSR3;
			return true;
		case TemporalUpscalerKind.XeSS:
			runtimeUpscaler = TemporalUpscaler.XeSS;
			return true;
		case TemporalUpscalerKind.MetalFX:
			runtimeUpscaler = TemporalUpscaler.MetalFX;
			return true;
		default:
			runtimeUpscaler = TemporalUpscaler.DLSS;
			return false;
		}
	}

	private void Awake()
	{
		if (m_InitOnAwake)
		{
			Initialize();
		}
	}

	private void OnDestroy()
	{
		m_FrameRateLimiter?.Dispose();
		m_FrameRateLimiter = null;
		if (m_Instance == this)
		{
			m_Instance = null;
		}
	}

	private void Update()
	{
		CheckTemporalUpscalerRuntimeFailure();
	}

	public void OnApplicationQuit()
	{
		if (SettingsProvider.AutoSaveOnQuit)
		{
			Apply();
			Save();
		}
	}

	public void OnApplicationPause(bool pauseStatus)
	{
		if (SettingsProvider.AutoSaveOnQuit)
		{
			Apply();
			Save();
		}
	}

	public void Apply()
	{
		if (m_Initialized)
		{
			m_RuntimeSettings.Apply();
		}
	}

	public void Save()
	{
		if (m_Initialized && SettingsProvider != null && SettingsProvider.SettingsSaver != null)
		{
			SettingsProvider.SettingsSaver.Save(SettingsProvider.SavingKey, m_RuntimeSettings.ExportToSerializedData());
		}
	}

	public void ResetToDefault()
	{
		if (m_Initialized)
		{
			m_RuntimeSettings.ResetToDefaults();
		}
	}

	public bool TryClearSavedSettings()
	{
		if (SettingsProvider == null || SettingsProvider.SettingsSaver == null)
		{
			return false;
		}
		SettingsProvider.AutoSaveOnQuit = false;
		SettingsProvider.SettingsSaver.Delete(SettingsProvider.SavingKey);
		return true;
	}
}
