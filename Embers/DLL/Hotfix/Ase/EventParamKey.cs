using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct EventParamKey
{
	public const string Damage = "Damage";

	public const string Tenacity = "Tenacity";

	public const string EnergyChanged = "EnergyChanged";

	public const string CurrentEnergy = "CurrentEnergy";

	public const string WeakNessLv = "WeakNessLv";

	public const string PartName = "PartName";

	public const string SiteLevel = "SiteLevel";

	public const string BulletId = "BulletId";

	public const string BulletConfigId = "BulletConfigId";

	public const string SkillId = "SkillId";

	public const string HeroSkillTypeEnum = "HeroSkillTypeEnum";

	public const string SkillLabel = "SkillLabel";

	public const string BulletLabel = "BulletLabel";

	public const string Critical = "Critical";

	public const string DefendState = "DefendState";

	public const string Accumulate = "Accumulate";

	public const string KnockDown = "KnockDown";

	public const string BossDownState = "BossDownState";

	public const string MonsterPhase = "MonsterPhase";

	public const string ImmuneState = "ImmuneState";

	public const string ParrySuccess = "ParrySuccess";

	public const string IsKillDown = "IsKillDown";

	public const string Guide_BuffCondition = "BuffCondition";
}
