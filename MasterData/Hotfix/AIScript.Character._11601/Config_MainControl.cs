using TrueSync;

namespace AIScript.Character._11601;

public class Config_MainControl
{
	public const string fxKey_HaveAmmo_Loop = "fx_11601_loop_Attack_LongRange_Charged";

	public const string comboTag_Skill = "B1_Skill";

	public const string eventName_Shoot_Skill = "116_MainSkill_Shoot";

	public static readonly TSVector shootPositionOffset_Skill = new TSVector(-0.94, 0, 1.42);

	public const string bulletKey_Skill = "Bullet_11601_MainSkill_Seed";

	public static readonly FP minShootDistance_Skill = 1.5;

	public static readonly FP maxShootDistance_Skill = 7;

	public static readonly int damageTag_Bullet_Skill = CommonHelper.StringToHash("116_B1_Seed_Explosion");

	public const int buffId_ReduceSpeed_Skill = 11690012;

	public const string eventName_Strength_Skill = "116_MainSkill_StrengthShoot";

	public const int buffId_Strength_Skill = 11690011;

	public static readonly int buffTag_Strength_Skill = CommonHelper.StringToHash("116_MainSkill_Shoot_Strength");

	public const string comboTag_NormalAttack_Strength = "Shoot_Strength";

	public const string bulletKey_NormalAttack_Strength = "Bullet_11601_NormalBullet_MainSkill";

	public static readonly TSVector shootPositionOffset_NormalAttack_Strength = new TSVector(-0.2, 1.6, 1.4);

	public const int perkId_1 = 511601;

	public const string comboTag_Skill_P1 = "B1_Skill_Perk1";

	public const string bulletKey_Skill_P1 = "Bullet_11601_MainSkill_Seed_Perk01";

	public const int shootCount_Skill_P1 = 2;

	public static readonly FP totalAngle_Shoot_Skill_P1 = 35;

	public const int perkId_2 = 511602;

	public static readonly int bulletTag_Summoned_P2 = CommonHelper.StringToHash("Bullet_11601_MainSkill_Seed_Perk01");

	public const int summonedId_P2 = 11601111;

	public const string fxKey_Summoned_P2 = "fx_11601_loop_Skill_Main_PeaShooter_born";

	public static SummonCfg summonCfg_Summon_P2 = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		leftTime = 8,
		summonType = SummonType.None
	};

	public const int maxCount_Summoned_P2 = 2;

	public const string comboTag_SummonedSpawn_P2 = "116_PeaShooter_Born";

	public const string comboTag_SummonedDeath_P2 = "116_PeaShooter_Die";

	public const string fxKey_SummonedDeath_P2 = "fx_11601_base_PeaShooter_Die";

	public const int skillId_Summoned_P2 = 11601121;

	public const string comboTag_SummonedSkill_P2 = "116_PeaShooter_Atk";

	public const string eventName_Shoot_SummonedSkill_P2 = "PeaShooter_Fire";

	public const string bulletKey_SummonedSkill_P2 = "Bullet_11601_MainSkill_Seed_PeaShooter";

	public static readonly TSVector shootPositionOffset_SummonedSkill_P2 = new TSVector(0, 1.4, 1.51);

	public static readonly FP shootDistance_SummonedSkill_NoTarget_P2 = 7;

	public static readonly FP useSkillInterval_Summoned_P2 = 1.2;

	public const int perkId_3 = 511603;

	public static readonly int bulletTag_Trigger_P3 = CommonHelper.StringToHash("11601_Normal_Bullet");

	public const int triggerBulletCount_P3 = 12;

	public const string comboTag_NormalAttack_P3 = "Shoot_Perk03";

	public const string comboTag_NormalAttack_Strength_P3 = "Shoot_Perk03";

	public const string bulletKey_P3 = "Bullet_11601_NormalBullet_Perk03";

	public static readonly TSVector shootPositionOffset_NormalAttack_P3 = new TSVector(0, 1, 1);

	public static readonly TSVector shootPositionOffset_NormalAttack_Strength_P3 = new TSVector(0, 1, 1);

	public const int perkId_4 = 511604;

	public const int addBulletCount_NormalAttack_P4 = 2;

	public static readonly FP shootIncludedAngle_NormalAttack_P4 = 7;

	public const int perkId_5 = 511605;

	public static readonly FP addBulletScale_P5 = 35;

	public const int perkId_6 = 511606;

	public const int buffId_ReduceSpeed_Skill_P6 = 11606011;

	public static readonly int buffTag_ReduceSpeed_Skill_P6 = CommonHelper.StringToHash("116_MainSkill_SpeedDownRecorder");

	public const int buffNum_Trigger_P6 = 3;

	public const int additionalAttrId_P6 = 11606001;

	public const int perkId_7 = 511607;

	public const int parameterId_P7 = 11607011;

	public static readonly FP totalAngle_Shoot_Skill_P7 = 35;

	public static readonly FP totalAngle_Shoot_Skill_P1_P7 = 60;

	public const string eventName_Shoot_SummonedSkill_P2_P7 = "PeaShooter_RandomFire";

	public const int maxCount_Summoned_P2_P7 = 3;

	public const int perkId_8 = 511608;

	public static readonly FP addBulletScale_P8 = 30;

	public const int perkId_9 = 511609;

	public static readonly int damageTag_Trigger_P9 = CommonHelper.StringToHash("Bullet_11601_NormalBullet");

	public const int additionalAttrId_P9 = 11609001;

	public const int perkId_10 = 511610;

	public const int buffId_Strength_Skill_P10 = 11610011;

	public const int perkId_11 = 511611;

	public const int buffId_P11 = 11611011;

	public const int parameterId_P11 = 11611011;

	public const int perkId_12 = 511612;

	public const string comboTag_NormalAttack_Special_P12 = "Melee_Strengthed";

	public static readonly FP addDamageDistance_P12 = 3;

	public const int additionalAttrId_P12 = 11612001;

	public const int perkId_13 = 511613;

	public static readonly int damageTag_TriggerLandMark_P13 = CommonHelper.StringToHash("116_Ultra_AOE");

	public const int buffId_P13 = 11613011;

	public static readonly int bulletSubTag_IsStrength = CommonHelper.StringToHash("IsStrength");

	public static readonly int eventHashCode_Summoned_DestroySelf_P2 = CommonHelper.StringToHash("Summoned_DestroySelf_P2");

	public const string logicTag_SummonedCount_P2 = "SummonedCount_P2";

	public const string logicTag_TriggerBulletCount_P3 = "TriggerBulletCount_P3";

	public const string logicTag_LastTriggerTime_P11 = "LastTriggerTime_P11";
}
