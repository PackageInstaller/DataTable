using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/TextureQuality")]
public class TextureQualityConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public int[] mipmapLevels;

		public TextureQualityConnectionSO TConnectionSO => m_ConnectionSO as TextureQualityConnectionSO;

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
			int num = Mathf.Clamp(value, 0, mipmapLevels.Length - 1);
			UniversalRenderer.SetGlobalMipmapLimit(mipmapLevels[num]);
		}

		public override void Set(int value)
		{
			int num = Mathf.Clamp(value, 0, mipmapLevels.Length - 1);
			UniversalRenderer.SetGlobalMipmapLimit(mipmapLevels[num]);
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

	public OptionsPlatformConfig<LocalizedString> Config;

	public int[] mipmapLevels;

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Config,
			mipmapLevels = mipmapLevels
		};
	}
}
