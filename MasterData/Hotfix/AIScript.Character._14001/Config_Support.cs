using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14001;

public class Config_Support
{
	public const string comboTag_Skill = "140_Support_Skill_Fireworks";

	public static readonly FP addSearchRange_Skill = 20;

	public const int maxLoopTimes_Skill = 13;

	public const string eventName_LaunchMissile_Skill = "140_Support_Shoot";

	public static readonly FP delay_MissileBeginDescent_Skill = 0.5;

	public const int totalMissleCount_Skill = 2;

	public static readonly FP interval_MissileDescent_Skill = 0.1;

	public const string bulletKey_Missile_Skill = "Bullet_140_Support_Skill_Boom";

	public static readonly FP randomRadius_Missile_Skill = 4;

	public const int lockTargetMissileRound_Skill = 5;

	public const int perkId_21 = 514021;

	public const string comboTag_Skill_P21 = "140_Support_Skill_Fireworks_P21";

	public const int totalMissleCount_Skill_P21 = 3;

	public static readonly FP interval_MissileDescent_Skill_P21 = 0.1;

	public static readonly int damageTag_Trigger_P21 = CommonHelper.StringToHash("140_Support_Hurt");

	public const int additionalAttrId_P21 = 14021011;

	public const int perkId_22 = 514022;

	public const string eventName_TriggerAddBuff_P22 = "140_P22_Rage";

	public const int buffId_Angry_P22 = 14022011;

	public const int buffId_AddDamage_P22 = 14022012;

	public const string comboTag_P22 = "140_Support_Skill_Fireworks_P22_Rush";

	public const string eventName_TriggerShoot_P22 = "140_P22_Rush";

	public const string bulletKey_P22 = "Bullet_140_Support_Skill_P22_Rush";

	public const int perkId_23 = 514023;

	public static readonly List<string> comboTagList_NormalAttack_P23 = new List<string> { "140_Attack_1_Support_P23", "140_Attack_2_Support_P23", "140_Attack_3_Support_P23" };

	public const int parameterId_Duration_P23 = 14023011;

	public static readonly FP distance_ForceTrace_P23 = 12;

	public static readonly FP distance_StopTrace_ForPlayer_P23 = 4;

	public static readonly FP interval_CheckTrace_P23 = 0.5;

	public static readonly FP randomRadius_Teleport_P23 = 2;

	public static readonly int damageTag_Trigger_P23 = CommonHelper.StringToHash("140_P23");

	public const int additionalAttrId_P23 = 14023011;

	public const int perkId_24 = 514024;

	public const string bulletKey_P24 = "Bullet_140_Support_Skill_P24_Boom";

	public static readonly FP interval_Trigger_P24 = 3.5;

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("140_P24");

	public const int additionalAttrId_P24 = 14024011;

	public const int perkId_25 = 514025;

	public const string comboTag_Skill_P25 = "140_Support_Skill_Fireworks_P25";

	public const string comboTag_Skill_P21_P25 = "140_Support_Skill_Fireworks_P25P21";

	public const string eventName_Trigger_P25 = "140_P25";

	public static readonly FP delay_bulletBeginDescent_P25 = 1;

	public static readonly FP triggerRadius_P25 = 16;

	public const string bulletKey_P25 = "Bullet_140_Support_Skill_P25_Boom";

	public const int totalBulletCount_P25 = 4;

	public const int totalBulletCount_P21_P25 = 8;

	public const int maxShootCount_SingleTarget_P25 = 2;

	public const int maxShootCount_SingleTarget_P21_P25 = 4;

	public static readonly FP interval_EveryRound_P25 = 3;

	public const int perkId_26 = 514026;

	public const int buffId_P26 = 14026011;

	public const int perkId_27 = 514027;

	public static readonly int damageTag_Trigger_P27 = CommonHelper.StringToHash("140_P27");

	public const int buffId_P27 = 14027011;

	public const int perkId_28 = 514028;

	public static readonly List<string> comboTagList_NormalAttack_P23_P28 = new List<string> { "140_Attack_1_Support_P23P28", "140_Attack_2_Support_P23P28", "140_Attack_3_Support_P23P28" };

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("140_P28");

	public const int additionalAttrId_P28 = 14028001;

	public const int perkId_29 = 514029;

	public const int buffId_P29 = 14029011;

	public const int parameterId_Interval_P29 = 14029011;

	public const int perkId_30 = 514030;

	public const int buffId_P30 = 14030011;

	public const int perkId_31 = 514031;

	public const int buffId_P31 = 14031011;

	public const int perkId_32 = 514032;

	public const int buffId_AddEnergy_P32 = 14032011;

	public const int buffId_AddDamage_P32 = 14032012;

	public const int perkId_33 = 514033;

	public const int buffId_P33 = 14033011;

	public static readonly int eventHashCode_SkillTriggerLaunchMissile = CommonHelper.StringToHash("SkillTriggerLaunchMissile");

	public static readonly int eventHashCode_TriggerPerkLogic_P25 = CommonHelper.StringToHash("TriggerPerkLogic_P25");
}
