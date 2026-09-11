using Google.Protobuf.Reflection;

namespace Config;

public enum AttributeName
{
	[OriginalName("AttributeName_None")]
	None = 0,
	[OriginalName("AttributeName_ATTACK_VALUE")]
	AttackValue = 1,
	[OriginalName("AttributeName_DEFENSE_VALUE")]
	DefenseValue = 2,
	[OriginalName("AttributeName_HEALTH_VALUE")]
	HealthValue = 3,
	[OriginalName("AttributeName_DAMAGE_BONUS")]
	DamageBonus = 4,
	[OriginalName("AttributeName_DAMAGE_REDUCTION")]
	DamageReduction = 5,
	[OriginalName("AttributeName_FIXED_DAMAGE")]
	FixedDamage = 6,
	[OriginalName("AttributeName_FIXED_DAMAGE_REDUCTION")]
	FixedDamageReduction = 7,
	[OriginalName("AttributeName_ATTACK_VALUE_BONUS")]
	AttackValueBonus = 11,
	[OriginalName("AttributeName_ATTACK_FIXED_BONUS")]
	AttackFixedBonus = 12,
	[OriginalName("AttributeName_SCORE_ATTACK_VALUE_BONUS")]
	ScoreAttackValueBonus = 13,
	[OriginalName("AttributeName_DEFENSE_VALUE_BONUS")]
	DefenseValueBonus = 21,
	[OriginalName("AttributeName_DEFENSE_FIXED_BONUS")]
	DefenseFixedBonus = 22,
	[OriginalName("AttributeName_IGNORE_FIXED_DEFENSE")]
	IgnoreFixedDefense = 23,
	[OriginalName("AttributeName_ARMOR_PENETRATION")]
	ArmorPenetration = 24,
	[OriginalName("AttributeName_TARGET_SUNDER")]
	TargetSunder = 25,
	[OriginalName("AttributeName_HEALTH_VALUE_BONUS")]
	HealthValueBonus = 31,
	[OriginalName("AttributeName_FIXED_HEALTH_VALUE_BONUS")]
	FixedHealthValueBonus = 32,
	[OriginalName("AttributeName_FIXED_HEAL_BONUS")]
	FixedHealBonus = 41,
	[OriginalName("AttributeName_HEAL_BONUS")]
	HealBonus = 42,
	[OriginalName("AttributeName_FIXED_HEALED_BONUS")]
	FixedHealedBonus = 43,
	[OriginalName("AttributeName_HEALED_BONUS")]
	HealedBonus = 44,
	[OriginalName("AttributeName_SKILL1_BONUS")]
	Skill1Bonus = 51,
	[OriginalName("AttributeName_SKILL2_BONUS")]
	Skill2Bonus = 52,
	[OriginalName("AttributeName_SKILL3_BONUS")]
	Skill3Bonus = 53,
	[OriginalName("AttributeName_SKILL4_BONUS")]
	Skill4Bonus = 54,
	[OriginalName("AttributeName_SKILL5_BONUS")]
	Skill5Bonus = 55,
	[OriginalName("AttributeName_SKILL6_BONUS")]
	Skill6Bonus = 56,
	[OriginalName("AttributeName_SKILL7_BONUS")]
	Skill7Bonus = 57,
	[OriginalName("AttributeName_SKILL8_BONUS")]
	Skill8Bonus = 58,
	[OriginalName("AttributeName_CRIT_RATE")]
	CritRate = 81,
	[OriginalName("AttributeName_CRIT_DAMAGE_BONUS")]
	CritDamageBonus = 82,
	[OriginalName("AttributeName_CRIT_RESIST")]
	CritResist = 83,
	[OriginalName("AttributeName_CRIT_DAMAGE_REDUCTION")]
	CritDamageReduction = 84,
	[OriginalName("AttributeName_MELEE_ATTACK_DAMAGE_BONUS")]
	MeleeAttackDamageBonus = 101,
	[OriginalName("AttributeName_RANGE_ATTACK_DAMAGE_BONUS")]
	RangeAttackDamageBonus = 102,
	[OriginalName("AttributeName_MELEE_ATTACK_DAMAGE_REDUCTION")]
	MeleeAttackDamageReduction = 111,
	[OriginalName("AttributeName_RANGE_ATTACK_DAMAGE_REDUCTION")]
	RangeAttackDamageReduction = 112,
	[OriginalName("AttributeName_GREECE_BONUS")]
	GreeceBonus = 121,
	[OriginalName("AttributeName_EGYPT_BONUS")]
	EgyptBonus = 122,
	[OriginalName("AttributeName_JAPAN_BONUS")]
	JapanBonus = 123,
	[OriginalName("AttributeName_NORTH_ERNEUROPE_BONUS")]
	NorthErneuropeBonus = 124,
	[OriginalName("AttributeName_OTHER_RACE_BONUS")]
	OtherRaceBonus = 125,
	[OriginalName("AttributeName_CHINA_BONUS")]
	ChinaBonus = 126,
	[OriginalName("AttributeName_GREECE_DAMAGE_REDUCTION")]
	GreeceDamageReduction = 131,
	[OriginalName("AttributeName_EGYPT_DAMAGE_REDUCTION")]
	EgyptDamageReduction = 132,
	[OriginalName("AttributeName_JAPAN_DAMAGE_REDUCTION")]
	JapanDamageReduction = 133,
	[OriginalName("AttributeName_NORTH_ERNEUROPE_DAMAGE_REDUCTION")]
	NorthErneuropeDamageReduction = 134,
	[OriginalName("AttributeName_OTHER_RACE_DAMAGE_REDUCTION")]
	OtherRaceDamageReduction = 135,
	[OriginalName("AttributeName_CHINA_DAMAGE_REDUCTION")]
	ChinaDamageReduction = 136,
	[OriginalName("AttributeName_PHYSIC_DAMAGE_BONUS")]
	PhysicDamageBonus = 151,
	[OriginalName("AttributeName_WIND_DAMAGE_BONUS")]
	WindDamageBonus = 152,
	[OriginalName("AttributeName_FIRE_DAMAGE_BONUS")]
	FireDamageBonus = 153,
	[OriginalName("AttributeName_ICE_DAMAGE_BONUS")]
	IceDamageBonus = 154,
	[OriginalName("AttributeName_WATER_DAMAGE_BONUS")]
	WaterDamageBonus = 155,
	[OriginalName("AttributeName_DARK_DAMAGE_BONUS")]
	DarkDamageBonus = 156,
	[OriginalName("AttributeName_LIGHT_DAMAGE_BONUS")]
	LightDamageBonus = 157,
	[OriginalName("AttributeName_THUNDER_DAMAGE_BONUS")]
	ThunderDamageBonus = 158,
	[OriginalName("AttributeName_ELEMENT_DAMAGE_BONUS")]
	ElementDamageBonus = 159,
	[OriginalName("AttributeName_PHYSIC_DAMAGE_REDUCTION")]
	PhysicDamageReduction = 161,
	[OriginalName("AttributeName_WIND_DAMAGE_REDUCTION")]
	WindDamageReduction = 162,
	[OriginalName("AttributeName_FIRE_DAMAGE_REDUCTION")]
	FireDamageReduction = 163,
	[OriginalName("AttributeName_ICE_DAMAGE_REDUCTION")]
	IceDamageReduction = 164,
	[OriginalName("AttributeName_WATER_DAMAGE_REDUCTION")]
	WaterDamageReduction = 165,
	[OriginalName("AttributeName_DARK_DAMAGE_REDUCTION")]
	DarkDamageReduction = 166,
	[OriginalName("AttributeName_LIGHT_DAMAGE_REDUCTION")]
	LightDamageReduction = 167,
	[OriginalName("AttributeName_THUNDER_DAMAGE_REDUCTION")]
	ThunderDamageReduction = 168,
	[OriginalName("AttributeName_ELEMENT_DAMAGE_REDUCTION")]
	ElementDamageReduction = 169,
	[OriginalName("AttributeName_PHYSIC_HERO_DAMAGE")]
	PhysicHeroDamage = 171,
	[OriginalName("AttributeName_WIND_HERO_DAMAGE")]
	WindHeroDamage = 172,
	[OriginalName("AttributeName_FIRE_HERO_DAMAGE")]
	FireHeroDamage = 173,
	[OriginalName("AttributeName_ICE_HERO_DAMAGE")]
	IceHeroDamage = 174,
	[OriginalName("AttributeName_WATER_HERO_DAMAGE")]
	WaterHeroDamage = 175,
	[OriginalName("AttributeName_DARK_HERO_DAMAGE")]
	DarkHeroDamage = 176,
	[OriginalName("AttributeName_LIGHT_HERO_DAMAGE")]
	LightHeroDamage = 177,
	[OriginalName("AttributeName_THUNDER_HERO_DAMAGE")]
	ThunderHeroDamage = 178,
	[OriginalName("AttributeName_ELEMENT_HERO_DAMAGE")]
	ElementHeroDamage = 179,
	[OriginalName("AttributeName_PHYSIC_HERO_REDUCTION")]
	PhysicHeroReduction = 181,
	[OriginalName("AttributeName_WIND_HERO_REDUCTION")]
	WindHeroReduction = 182,
	[OriginalName("AttributeName_FIRE_HERO_REDUCTION")]
	FireHeroReduction = 183,
	[OriginalName("AttributeName_ICE_HERO_REDUCTION")]
	IceHeroReduction = 184,
	[OriginalName("AttributeName_WATER_HERO_REDUCTION")]
	WaterHeroReduction = 185,
	[OriginalName("AttributeName_DARK_HERO_REDUCTION")]
	DarkHeroReduction = 186,
	[OriginalName("AttributeName_LIGHT_HERO_REDUCTION")]
	LightHeroReduction = 187,
	[OriginalName("AttributeName_THUNDER_HERO_REDUCTION")]
	ThunderHeroReduction = 188,
	[OriginalName("AttributeName_ELEMENT_HERO_REDUCTION")]
	ElementHeroReduction = 189,
	[OriginalName("AttributeName_ATTACK_HUMAN_ENEMY_BONUS")]
	AttackHumanEnemyBonus = 201,
	[OriginalName("AttributeName_ATTACK_MACHINE_ENEMY_BONUS")]
	AttackMachineEnemyBonus = 202,
	[OriginalName("AttributeName_ATTACK_BUG_ENEMY_BONUS")]
	AttackBugEnemyBonus = 203,
	[OriginalName("AttributeName_ATTACK_OTHER_ENEMY_BONUS")]
	AttackOtherEnemyBonus = 204,
	[OriginalName("AttributeName_HUMAN_ENEMY_DAMAGE_REDUCTION")]
	HumanEnemyDamageReduction = 211,
	[OriginalName("AttributeName_MACHINE_ENEMY_DAMAGE_REDUCTION")]
	MachineEnemyDamageReduction = 212,
	[OriginalName("AttributeName_BUG_ENEMY_DAMAGE_REDUCTION")]
	BugEnemyDamageReduction = 213,
	[OriginalName("AttributeName_OTHER_ENEMY_DAMAGE_REDUCTION")]
	OtherEnemyDamageReduction = 214,
	[OriginalName("AttributeName_ATTACK_NORMAL_ENEMY_BONUS")]
	AttackNormalEnemyBonus = 221,
	[OriginalName("AttributeName_ATTACK_BOSS_BONUS")]
	AttackBossBonus = 222,
	[OriginalName("AttributeName_NORMAL_ENEMY_DAMAGE_REDUCTION")]
	NormalEnemyDamageReduction = 231,
	[OriginalName("AttributeName_BOSS_DAMAGE_REDUCTION")]
	BossDamageReduction = 232,
	[OriginalName("AttributeName_NORMAL_ATTACK_DAMAGE_BONUS")]
	NormalAttackDamageBonus = 301,
	[OriginalName("AttributeName_ALL_SKILL_DAMAGE_BONUS")]
	AllSkillDamageBonus = 302,
	[OriginalName("AttributeName_UNIQUE_SKILL_DAMAGE_BONUS")]
	UniqueSkillDamageBonus = 303,
	[OriginalName("AttributeName_MARK_CHAR_DAMAGE_BONUS")]
	MarkCharDamageBonus = 311,
	[OriginalName("AttributeName_OTHER_ENERGY_CHAR_DAMAGE_BONUS")]
	OtherEnergyCharDamageBonus = 312,
	[OriginalName("AttributeName_RAGE_ENERGY_CHAR_BONUS")]
	RageEnergyCharBonus = 313,
	[OriginalName("AttributeName_ENERGY_CHAR_DAMAGE_BONUS")]
	EnergyCharDamageBonus = 314,
	[OriginalName("AttributeName_CHARGE_SKILL_DAMAGE_BONUS")]
	ChargeSkillDamageBonus = 315,
	[OriginalName("AttributeName_TRANSFIGURATION_SKILL_DAMAGE_BONUS")]
	TransfigurationSkillDamageBonus = 316,
	[OriginalName("AttributeName_PERSIST_SKILL_DAMAGE_BONUS")]
	PersistSkillDamageBonus = 317,
	[OriginalName("AttributeName_STRENGTHEN_SKILL_DAMAGE_BONUS")]
	StrengthenSkillDamageBonus = 318,
	[OriginalName("AttributeName_SWITCH_SKILL_DAMAGE_BONUS")]
	SwitchSkillDamageBonus = 319,
	[OriginalName("AttributeName_PREPARE_SKILL_DAMAGE_BONUS")]
	PrepareSkillDamageBonus = 320,
	[OriginalName("AttributeName_TUNE_CHAR_DAMAGE_BONUS")]
	TuneCharDamageBonus = 321,
	[OriginalName("AttributeName_ATTACK_EX_DAMAGE")]
	AttackExDamage = 330,
	[OriginalName("AttributeName_SKILL1_EX_DAMAGE")]
	Skill1ExDamage = 331,
	[OriginalName("AttributeName_SKILL2_EX_DAMAGE")]
	Skill2ExDamage = 332,
	[OriginalName("AttributeName_SKILL3_EX_DAMAGE")]
	Skill3ExDamage = 333,
	[OriginalName("AttributeName_UNIQUESKILL_EX_DAMAGE")]
	UniqueskillExDamage = 334,
	[OriginalName("AttributeName_COMMON_DAMAGE_BONUS")]
	CommonDamageBonus = 401,
	[OriginalName("AttributeName_COMMON_HURT_BONUS")]
	CommonHurtBonus = 402,
	[OriginalName("AttributeName_SOURCE_SPACE_DAMAGE_BONUS")]
	SourceSpaceDamageBonus = 421,
	[OriginalName("AttributeName_DAMAGE_MUTIPLY")]
	DamageMutiply = 450,
	[OriginalName("AttributeName_ROLE_DAMAGE_MUTIPLY")]
	RoleDamageMutiply = 460,
	[OriginalName("AttributeName_COMMON_DAMAGE_REDUCTION")]
	CommonDamageReduction = 500,
	[OriginalName("AttributeName_HUMAN_S_DAMAGE_REDUCTION")]
	HumanSDamageReduction = 511,
	[OriginalName("AttributeName_MACHINE_S_DAMAGE_REDUCTION")]
	MachineSDamageReduction = 512,
	[OriginalName("AttributeName_BUG_S_DAMAGE_REDUCTION")]
	BugSDamageReduction = 513,
	[OriginalName("AttributeName_OTHER_ENEMY_S_DAMAGE_REDUCTION")]
	OtherEnemySDamageReduction = 514,
	[OriginalName("AttributeName_NORMAL_ENEMY_S_DAMAGE_REDUCTION")]
	NormalEnemySDamageReduction = 521,
	[OriginalName("AttributeName_BOSS_S_DAMAGE_REDUCTION")]
	BossSDamageReduction = 522,
	[OriginalName("AttributeName_ROGUELIKE_DAMAGE_BONUS")]
	RoguelikeDamageBonus = 600,
	[OriginalName("AttributeName_ROLE_DAMAGE_UP1")]
	RoleDamageUp1 = 701,
	[OriginalName("AttributeName_ROLE_DAMAGE_UP2")]
	RoleDamageUp2 = 702,
	[OriginalName("AttributeName_ROLE_DAMAGE_UP3")]
	RoleDamageUp3 = 703,
	[OriginalName("AttributeName_MAX_CD_REDUCTION")]
	MaxCdReduction = 1001,
	[OriginalName("AttributeName_ENDURANCE_CONSUME_REDUCTION")]
	EnduranceConsumeReduction = 1002,
	[OriginalName("AttributeName_ENDURANCE_RECOVER_BONUS")]
	EnduranceRecoverBonus = 1003,
	[OriginalName("AttributeName_ADDITIONAL_ENDURANCE_MAX")]
	AdditionalEnduranceMax = 1004,
	[OriginalName("AttributeName_AVOID_SKILL_MAX_CD_REDUCTION")]
	AvoidSkillMaxCdReduction = 1005,
	[OriginalName("AttributeName_AVOID_SKILL_EFFECT_DURATION_BONUS")]
	AvoidSkillEffectDurationBonus = 1006,
	[OriginalName("AttributeName_UNIQUE_SKILL_VALUE_GET_BONUS")]
	UniqueSkillValueGetBonus = 1101,
	[OriginalName("AttributeName_RAGE_ENERGY_GET_BONUS")]
	RageEnergyGetBonus = 1102,
	[OriginalName("AttributeName_ENERGY_GET_BONUS")]
	EnergyGetBonus = 1103,
	[OriginalName("AttributeName_OTHER_ENERGY_GET_BONUS")]
	OtherEnergyGetBonus = 1104,
	[OriginalName("AttributeName_EXPOSED_VALUE_HURT_BONUS")]
	ExposedValueHurtBonus = 1105,
	[OriginalName("AttributeName_COMBO_SCORE_GET_BONUS")]
	ComboScoreGetBonus = 1106,
	[OriginalName("AttributeName_RANDOM_EXTRA_MARK")]
	RandomExtraMark = 1107,
	[OriginalName("AttributeName_RANDOM_RECOVER_MARK")]
	RandomRecoverMark = 1108,
	[OriginalName("AttributeName_RAGE_ENERGY_CONSUME_REDUCTION")]
	RageEnergyConsumeReduction = 1109,
	[OriginalName("AttributeName_ENERGY_CONSUME_REDUCTION")]
	EnergyConsumeReduction = 1110,
	[OriginalName("AttributeName_OTHER_ENERGY_CONSUME_REDUCTION")]
	OtherEnergyConsumeReduction = 1111,
	[OriginalName("AttributeName_RAGE_FIXED_CONSUME")]
	RageFixedConsume = 1112,
	[OriginalName("AttributeName_ENERGY_FIXED_CONSUME")]
	EnergyFixedConsume = 1113,
	[OriginalName("AttributeName_MARK_FIXED_CONSUME")]
	MarkFixedConsume = 1114,
	[OriginalName("AttributeName_RAGE_FIXED_BONUS")]
	RageFixedBonus = 1115,
	[OriginalName("AttributeName_ENERGY_FIXED_BONUS")]
	EnergyFixedBonus = 1116,
	[OriginalName("AttributeName_MARK_FIXED_BONUS")]
	MarkFixedBonus = 1117,
	[OriginalName("AttributeName_TUNE_GET_BONUS")]
	TuneGetBonus = 1118,
	[OriginalName("AttributeName_TUNE_CONSUME_REDUCTION")]
	TuneConsumeReduction = 1119,
	[OriginalName("AttributeName_TUNE_FIXED_BONUS")]
	TuneFixedBonus = 1120,
	[OriginalName("AttributeName_TUNE_FIXED_CONSUME")]
	TuneFixedConsume = 1121
}
