using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/WindowStyle")]
public class WindowStyleConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public WindowStyleConnectionSO TConnectionSO => m_ConnectionSO as WindowStyleConnectionSO;

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override int GetDefault()
		{
			return PlatformConfig.Default;
		}

		public override void Init(int value)
		{
			ApplyWindowStyle(value, syncResolutionSetting: false);
		}

		private void ApplyWindowStyle(int value, bool syncResolutionSetting)
		{
			SettingOptions settingOptions = SettingsManager.Instance.RuntimeSettings.GetSettingOptions("Graphic.Resolution");
			int width = Screen.currentResolution.width;
			int height = Screen.currentResolution.height;
			int resolutionOption = GetResolutionOption(value, settingOptions, syncResolutionSetting);
			if (settingOptions?.GetConnection() is ResolutionConnectionSO.Connection connection && connection.TryGetResolutionValue(resolutionOption, out var resolution))
			{
				width = resolution.x;
				height = resolution.y;
			}
			if (syncResolutionSetting && settingOptions != null && settingOptions.GetValue() != resolutionOption)
			{
				settingOptions.SetValue(resolutionOption);
			}
			switch (value)
			{
			case 0:
				Screen.SetResolution(width, height, FullScreenMode.FullScreenWindow);
				break;
			case 1:
				Screen.SetResolution(width, height, FullScreenMode.Windowed);
				break;
			case 2:
				Screen.SetResolution(width, height, FullScreenMode.ExclusiveFullScreen);
				break;
			}
		}

		private int GetResolutionOption(int windowStyle, SettingOptions resolutionSetting, bool useResolutionCache)
		{
			if (windowStyle != 1)
			{
				return 0;
			}
			int num = (useResolutionCache ? PlayerPrefs.GetInt("Graphic.ResolutionCache", resolutionSetting?.GetValue() ?? 0) : (resolutionSetting?.GetValue() ?? 0));
			if (resolutionSetting?.GetConnection() is ResolutionConnectionSO.Connection connection && connection.TryGetResolutionValue(num, out var _))
			{
				return num;
			}
			return 0;
		}

		public override void Set(int value)
		{
			ApplyWindowStyle(value, syncResolutionSetting: true);
		}

		public override bool HasOptions()
		{
			return PlatformConfig.Options.Count > 0;
		}

		public override List<LocalizedString> GetOptionLabels()
		{
			return PlatformConfig.Options;
		}

		public override void RefreshOptions()
		{
		}
	}

	public OptionsPlatformConfig<LocalizedString> Current;

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current
		};
	}
}
