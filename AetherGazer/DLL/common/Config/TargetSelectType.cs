using Google.Protobuf.Reflection;

namespace Config;

public enum TargetSelectType
{
	[OriginalName("TargetSelectType_none")]
	None,
	[OriginalName("TargetSelectType_nearest")]
	Nearest,
	[OriginalName("TargetSelectType_farthest")]
	Farthest,
	[OriginalName("TargetSelectType_hp_least")]
	HpLeast,
	[OriginalName("TargetSelectType_hp_maximum")]
	HpMaximum,
	[OriginalName("TargetSelectType_battle_ability_max")]
	BattleAbilityMax,
	[OriginalName("TargetSelectType_random")]
	Random,
	[OriginalName("TargetSelectType_thrown_caster_target")]
	ThrownCasterTarget,
	[OriginalName("TargetSelectType_without_self")]
	WithoutSelf
}
