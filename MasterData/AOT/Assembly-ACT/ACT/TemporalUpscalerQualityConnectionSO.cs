using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/Temporal Upscaler Quality")]
public class TemporalUpscalerQualityConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		private const int TemporalUpscalerLevel = 2;

		public Connection(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
			: base(connectionSO, setting)
		{
		}

		public override int GetDefault()
		{
			return PlatformConfig.Default;
		}

		public override bool GetUsable()
		{
			if (PlatformConfig.Usable)
			{
				return GetUpscaler() != TemporalUpscalerKind.None;
			}
			return false;
		}

		public override void Init(int value)
		{
			Apply(value);
		}

		public override void Set(int value)
		{
			Apply(value);
		}

		private void Apply(int value)
		{
			int num = m_Setting.Owner.GetSettingOptions("Graphic.AntiAlias")?.GetValue() ?? 0;
			TemporalUpscalerKind upscaler = GetUpscaler();
			if (num == 2 && upscaler != TemporalUpscalerKind.None)
			{
				URPGraphicSettings.SetTemporalUpscalerQuality(value, upscaler);
			}
		}

		private TemporalUpscalerKind GetUpscaler()
		{
			if (!(m_Setting.Owner != null))
			{
				return TemporalUpscalerKind.None;
			}
			return TemporalUpscalerCapabilityResolver.Resolve(m_Setting.Owner.Usage);
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
