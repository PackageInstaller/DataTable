using TrueSync;

namespace AIScript.Character._11601;

public class Config_Support
{
	public const string comboTag_Skill = "B2_Skill";

	public const string eventName_GenerateAreaEffect_Skill = "SupSkill_SeedRain";

	public const string areaEffectKey_Skill = "AreaEffect_11601_Skill_Sup_Seed";

	public static readonly FP generateDistance_NoTarget_Skill = 6;

	public const int buffId_Seed_Skill = 11691011;

	public static readonly int buffTag_Seed_Skill = CommonHelper.StringToHash("116_SupSkill_Seed_Attach");

	public static readonly int damageTag_AddSeedBuff_Skill = CommonHelper.StringToHash("116_B2_Seed_Fall");

	public const string fxKey_SeedExplosion_Skill = "fx_11601_base_Skill_Sup_seed_bomb_explosion";

	public const string areaEffectKey_SeedExplosion_Skill = "AreaEffect_11601_Skill_Sup_AttachSeedBoom";

	public static readonly int damageTag_SeedExplosion_Skill = CommonHelper.StringToHash("116_B2_Seed_AttachExplosion");

	public const int maxReceiveExplosionDamageTimes_EveryUnitTime_Skill = 6;

	public static readonly FP unitTime_TriggerSeedExplosion_Skill = 2;

	public const int buffId_ImmuneExplosionDamage_Skill = 11691013;

	public const int perkId_21 = 511621;

	public const int additionalAttrId_P21 = 11621001;

	public const string areaEffectKey_Skill_P21 = "AreaEffect_11601_Skill_Sup_Seed";

	public static readonly FP useSkillInterval_P21 = 0;

	public const int perkId_22 = 511622;

	public const string comboTag_Skill_P22 = "B2_Skill_Perk22";

	public const string areaEffectKey_Skill_P22 = "AreaEffect_11601_Skill_Sup_Seed_Perk22";

	public const string areaEffectKey_Skill_P21_P22 = "AreaEffect_11601_Skill_Sup_Seed_Perk22";

	public static readonly int damageTag_Trigger_P22 = CommonHelper.StringToHash("116_B2_Seed_Fall");

	public const int additionalAttrId_P22 = 11622001;

	public const int perkId_23 = 511623;

	public const int buffId_Seed_Skill_P23 = 11623011;

	public static readonly int damageTag_Trigger_P23 = CommonHelper.StringToHash("116_B2_Seed_AttachExplosion");

	public const int additionalAttrId_P23 = 11623001;

	public const int buffId_P23 = 6011;

	public const int perkId_24 = 511624;

	public static readonly FP addAreaEffectScale_P24 = 50;

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("116_B2_Seed_AttachExplosion");

	public const int additionalAttrId_P24 = 11624001;

	public const int buffId_P24 = 11691014;

	public const int maxExplosionTimes_EverySkill_P24 = 10;

	public const int perkId_25 = 511625;

	public const int buffId_P25 = 11625011;

	public static readonly FP addBuffInterval_P25 = 0.5;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("116_B2_Seed_Fall");

	public const int additionalAttrId_P25 = 11625001;

	public const int perkId_26 = 511626;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("116_B2_Seed_Fall");

	public const int buffId_P26 = 11626011;

	public const int perkId_27 = 511627;

	public const string areaEffectKey_Skill_P27 = "AreaEffect_11601_Skill_Sup_Seed_Perk27";

	public const string areaEffectKey_Skill_P21_P27 = "AreaEffect_11601_Skill_Sup_Seed_Perk27";

	public const string areaEffectKey_Skill_P22_P27 = "AreaEffect_11601_Skill_Sup_Seed_Perk22_Perk27";

	public const string areaEffectKey_Skill_P21_P22_P27 = "AreaEffect_11601_Skill_Sup_Seed_Perk22_Perk27";

	public static readonly int damageTag_Trigger_P27 = CommonHelper.StringToHash("116_B2_Seed_Fall");

	public const int additionalAttrId_P27 = 11627001;

	public const int perkId_28 = 511628;

	public static readonly int buffTag_Check_P28 = CommonHelper.StringToHash("116_SupSkill_Seed_Attach");

	public const int additionalAttrId_P28 = 11628001;

	public const int perkId_29 = 511629;

	public const int buffId_P29 = 11629011;

	public const int buffId_P23_P29 = 11629012;

	public const int perkId_30 = 511630;

	public const string bulletKey_P30 = "Bullet_11601_Skill_Sup_Seed_Perk30";

	public static readonly FP searchRadius_P30 = 10;

	public static readonly TSVector shootOffset_P30 = new TSVector(0, 1, 1);

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("116_B2_Seed_AttachExplosion");

	public const int additionalAttrId_P30 = 11630001;

	public const int perkId_31 = 511631;

	public static readonly int damageTag_Trigger_P31 = CommonHelper.StringToHash("116_Ultra_AOE");

	public const int buffId_P31 = 6011;

	public const int perkId_33 = 511633;

	public const int buffId_P33 = 11633011;

	public const string logicTag_TriggerPerk_P21 = "TriggerPerk_P21";

	public const string logicTag_TriggerExplosionTimes_P24 = "TriggerExplosionTimes_P24";
}
