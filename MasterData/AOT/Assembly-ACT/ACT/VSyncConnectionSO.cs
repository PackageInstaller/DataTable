using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/VSync")]
public class VSyncConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public VSyncConnectionSO TConnectionSO => m_ConnectionSO as VSyncConnectionSO;

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override bool GetUsable()
		{
			return PlatformConfig.Usable;
		}

		public override int GetDefault()
		{
			return PlatformConfig.Default;
		}

		public override void Init(int value)
		{
			SettingsManager.Instance.FrameRateLimiter.SetVSyncCount(value);
		}

		public override void Set(int value)
		{
			SettingsManager.Instance.FrameRateLimiter.SetVSyncCount(value);
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
