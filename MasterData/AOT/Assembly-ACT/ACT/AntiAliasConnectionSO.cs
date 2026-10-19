using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/Anti Alias")]
public class AntiAliasConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		private const int TemporalUpscalerAntiAliasLevel = 2;

		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public AntiAliasConnectionSO TConnectionSO => m_ConnectionSO as AntiAliasConnectionSO;

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
			Apply(value);
		}

		public override void Set(int value)
		{
			Apply(value);
		}

		private void Apply(int antiAliasLevel)
		{
			TemporalUpscalerKind upscaler = GetUpscaler();
			if (antiAliasLevel == 2 && upscaler != TemporalUpscalerKind.None)
			{
				SettingOptions settingOptions = m_Setting.Owner.GetSettingOptions("Graphic.TemporalUpscalerQuality");
				if (settingOptions != null)
				{
					URPGraphicSettings.SetTemporalUpscalerQuality(settingOptions.GetValue(), upscaler);
				}
			}
			URPGraphicSettings.SetAntialiasingLevel(antiAliasLevel, upscaler);
			ApplyRenderScaleOption();
		}

		private void ApplyRenderScaleOption()
		{
			SettingOptions settingOptions = m_Setting.Owner.GetSettingOptions("Graphic.RenderScale");
			if (settingOptions?.GetConnection() is RenderScaleConnectionSO.Connection connection)
			{
				connection.ApplyRenderScale(settingOptions.GetValue());
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
			if (SettingsManager.Instance?.RuntimeSettings?.GetSetting("Graphic.TemporalUpscalerQuality") == null)
			{
				return PlatformConfig.Options;
			}
			List<LocalizedString> list = new List<LocalizedString>();
			int num = Mathf.Min(2, PlatformConfig.Options.Count);
			for (int i = 0; i < num; i++)
			{
				list.Add(PlatformConfig.Options[i]);
			}
			TemporalUpscalerKind upscaler = GetUpscaler();
			if (upscaler == TemporalUpscalerKind.None)
			{
				return list;
			}
			LocalizedString upscalerOption = GetUpscalerOption(upscaler);
			if (upscalerOption != null)
			{
				list.Add(upscalerOption);
			}
			return list;
		}

		private LocalizedString GetUpscalerOption(TemporalUpscalerKind upscaler)
		{
			switch (upscaler)
			{
			case TemporalUpscalerKind.DLSS:
				return TConnectionSO.DLSSOption;
			case TemporalUpscalerKind.FSR4:
			case TemporalUpscalerKind.FSR3:
				return TConnectionSO.FSROption;
			case TemporalUpscalerKind.MetalFX:
				return TConnectionSO.MetalFXOption;
			case TemporalUpscalerKind.XeSS:
				return TConnectionSO.XeSSOption;
			default:
				return null;
			}
		}

		public override void RefreshOptions()
		{
		}
	}

	public OptionsPlatformConfig<LocalizedString> Current;

	public LocalizedString DLSSOption;

	public LocalizedString FSROption;

	public LocalizedString MetalFXOption;

	public LocalizedString XeSSOption;

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current
		};
	}
}
