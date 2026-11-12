using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14101;

public class Config_Support
{
	public const string comboTag_Skill = "141_Support_Skill";

	public static readonly FP loopTime_Skill = 6;

	public const string eventName_TriggerLogic_Skill = "141_Summon";

	public const string bulletKey_Summoned_Skill = "Bullet_14101_Support_Skill_Throw";

	public static readonly TSVector2 shootOffset_Skill = new TSVector2(0, 2);

	public static readonly FP shootPositionY_Skill = 2;

	public static readonly FP randomRadius_Summoned_Skill = 4;

	public static readonly int bulletTag_Summoned_Skill = CommonHelper.StringToHash("SummonBullet");

	public const int perkId_21 = 514121;

	public const int buffId_P21 = 14121011;

	public const int perkId_22 = 514122;

	public const int triggerCount_P22 = 2;

	public static readonly FP scaleMutli_P22 = 2;

	public static readonly FP scaleChangeTime_P22 = 0.5;

	public const int buffId_P22 = 14122011;

	public const string fxKey_Dragon_P22 = "fx_14101_Buff_Support_Skill_P22_Summon_1_Exciting";

	public const string fxKey_Tiger_P22 = "fx_14101_Buff_Support_Skill_P22_Summon_1_Exciting";

	public const int perkId_23 = 514123;

	public const string bulletKey_Summoned_Skill_P23 = "Bullet_14101_Support_Skill_Throw_P23_Tiger";

	public static readonly FP offset_Summoned_P23 = 1;

	public static readonly FP offset_Summoned_NoTarget_P23 = 4;

	public const int summonedId_Tiger_P23 = 14102111;

	public const string bulleyKey_AddBuff_P23 = "Bullet_14101_Support_Skill_Throw_P23_Buff";

	public static readonly int bulletTag_AddBuff_P23 = CommonHelper.StringToHash("141_Summon_Tiger_Buff");

	public const string fxKey_AddBuff_P23 = "fx_14101_base_Support_Skill_Summon_Strengthen";

	public const int buffId_P23 = 14123011;

	public const int perkId_24 = 514124;

	public const string areaEffectKey_Dragon_P24 = "AreaEffect_14101_Summon_Snake_P24_FireCoat";

	public const string areaEffectKey_Triger_P24 = "AreaEffect_14101_Summon_Tiger_P24_FireCoat";

	public const int perkId_25 = 514125;

	public const int buffId_P25 = 14125011;

	public const int perkId_26 = 514126;

	public const int perkId_27 = 514127;

	public const string areaEffectKey_P27 = "AreaEffect_14101_Summon_P27_Defense";

	public const int perkId_28 = 514128;

	public const int buffId_P28 = 14128011;

	public static readonly FP addBuffInterval_P28 = 1;

	public const int perkId_29 = 514129;

	public static readonly FP triggerRadius_P29 = 4;

	public const int buffId_P29 = 14129011;

	public static readonly FP triggerCD_P29 = 3;

	public const int perkId_30 = 514130;

	public static readonly FP triggerRadius_P30 = 4;

	public const int additionalAttrId_P30 = 14130001;

	public const int perkId_31 = 514131;

	public const int buffId_P31 = 14131011;

	public const int perkId_32 = 514132;

	public static readonly int damageTag_Trigger_P32 = CommonHelper.StringToHash("141_Ultra_Hurt");

	public const int buffId_Mark_P32 = 1011;

	public const int buffId_ImproveAttack_P32 = 14132011;

	public const int perkId_33 = 514133;

	public const int buffId_P33 = 14133011;

	public const string comboTag_Spawn_Dragon = "14101_Summon_Snake_Born";

	public const int skillId_Shoot_Dragon = 14132012;

	public const string comboTag_Shoot_Dragon = "14101_Summon_Snake_Attack";

	public static readonly FP useShootSkillInterval_Dragon = 0.2;

	public const int skillId_StrengthShoot_Dragon = 14132013;

	public const string comboTag_StrengthShoot_Dragon = "14101_Summon_Snake_P26_HurtSkill";

	public static readonly FP useStrengthShootSkillCD_Dragon = 1;

	public const string comboTag_Death_Dragon = "14101_Summon_Snake_Death_Rush";

	public const string comboTag_Death_NoTarget_Dragon = "14101_Summon_Snake_Death_Idle";

	public const string fxKey_Tiger_Common_1 = "fx_14101_Pet_2_loop_Support_Skill_Summon_2_LHand";

	public const string fxKey_Tiger_Common_2 = "fx_14101_Pet_2_loop_Support_Skill_Summon_2_RHand";

	public const string comboTag_Spawn_Tiger = "14101_Summon_Tiger_Born";

	public const int skillId_Dash_Tiger = 14132022;

	public const string comboTag_Dash_Tiger = "14101_Summon_Tiger_Rush";

	public static readonly FP speed_DashSkill_Tiger = 20;

	public static readonly FP minDistance_DashSkill_Tiger = 3;

	public static readonly FP maxDistance_DashSkill_Tiger = 15;

	public const int skillId_NoramlAttack_Tiger = 14132023;

	public static readonly List<string> comboTagList_NormalAttack_Tiger = new List<string> { "14101_Summon_Tiger_Attack1", "14101_Summon_Tiger_Attack2", "14101_Summon_Tiger_Attack3" };

	public const int skillId_TailFlick_Tiger = 14132024;

	public const string comboTag_TailFlick_Tiger = "14101_Summon_Tiger_P26_HurtSkill";

	public static readonly FP useTailFlickSkillCD_Tiger = 1;

	public const string comboTag_Death_Tiger = "14101_Summon_Tiger_Death";

	public const string logicTag_SummonedCount = "SummonedCount";

	public const string logicTag_IsFirstSummoned = "IsFirstSummoned";

	public const string logicTag_NormalAttackStage_Tiger = "NormalAttackStage_Tiger";
}
