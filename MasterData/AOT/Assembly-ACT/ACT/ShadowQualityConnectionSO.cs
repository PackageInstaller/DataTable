using System.Collections.Generic;
using ACT.Rendering;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Rendering.Universal;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/ShadowQuality")]
public class ShadowQualityConnectionSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
		public OptionsPlatformConfig<LocalizedString> PlatformConfig;

		public List<ShadowQualityTier> Tiers;

		public ShadowQualityConnectionSO TConnectionSO => m_ConnectionSO as ShadowQualityConnectionSO;

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

		private void Apply(int value)
		{
			if (!GameRenderScene.RealtimeLightShadowsEnabled)
			{
				URPGraphicSettings.DisableRealtimeShadows();
				return;
			}
			ShadowQualityTier tier = GetTier(value);
			if (tier == null)
			{
				URPGraphicSettings.DisableRealtimeShadows();
			}
			else
			{
				URPGraphicSettings.ApplyShadowTier(tier);
			}
		}

		private ShadowQualityTier GetTier(int value)
		{
			if (Tiers == null || Tiers.Count == 0)
			{
				return null;
			}
			int index = Mathf.Clamp(value, 0, Tiers.Count - 1);
			return Tiers[index];
		}

		public override bool HasOptions()
		{
			if (PlatformConfig.Options != null)
			{
				return PlatformConfig.Options.Count > 0;
			}
			return false;
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

	public List<ShadowQualityTier> Tiers = new List<ShadowQualityTier>();

	protected override IConnectionWithOptions<LocalizedString> GetConnectionWithOptions(ISettingWithValue<int> owner)
	{
		return new Connection(this, owner)
		{
			PlatformConfig = Current,
			Tiers = Tiers
		};
	}
}
