using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/Bloom")]
public class BloomConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public BloomConnectionSO TConnectionSO => m_ConnectionSO as BloomConnectionSO;

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
			URPGraphicSettings.SetBloomLevel(value);
		}

		public override void Set(int value)
		{
			URPGraphicSettings.SetBloomLevel(value);
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

	public OptionsPlatformConfig<LocalizedString> PC;

	public OptionsPlatformConfig<LocalizedString> Mobile;

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current
		};
	}
}
