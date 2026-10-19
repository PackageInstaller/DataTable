using System.Collections.Generic;
using ACT.World.Modules;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT;

[CreateAssetMenu(menuName = "ACT/Settings/Connections/Graphic/ParticleSystemGrade")]
public class ParticleSystemGradeSO : OptionsConnectionSO<LocalizedString>
{
	private class Connection : BaseConnectionWithOptions<LocalizedString>
	{
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
			Singleton<GameManager>.instance.worldManager.ParticleGradeModule.ChangeActiveGrade((ParticlesGrade)value);
		}

		public override void Set(int value)
		{
			Singleton<GameManager>.instance.worldManager.ParticleGradeModule.ChangeActiveGrade((ParticlesGrade)value);
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
