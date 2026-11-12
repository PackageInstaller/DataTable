using TrueSync;

namespace AIScript.Character._15801;

public class Config_MainControl
{
	public const int skillId_Skill = 15831000;

	public const string comboTag_Skill = "158_Main_Skill";

	public const string eventName_Hit_Skill = "158_Main_Skill_Hurt";

	public const string eventName_HitWithAirBorne_Skill = "158_Main_Skill_Hurt_Fly";

	public const int hitDamageId_Skill = 158310001;

	public static readonly FP hitOffset_Skill = 0;

	public static readonly FP hitInnerRadius_Skill = 0;

	public static readonly FP hitRadius_Skill = 6;

	public static readonly FP hitAngle_Skill = 210;

	public const string hittedFxKey_Skill = "fx_15801_hit_Lash";

	public static readonly FP stiffDuration_Skill = 1;

	public static readonly FP airBorneForce_Skill = 20;

	public static readonly FP hitStrenth_Skill = 4;

	public const int addMoraleBuffCount_Skill = 1;

	public const int perkId_1 = 515801;

	public const string comboTag_CoordinateAttack_Soldier_P1 = "15801_Soldier_Skill_Strengthen";

	public const string comboTag_CoordinateAttack_Warrior_P1 = "15801_Hero_Skill_Strengthen";

	public const string comboTag_NormalAttack_Queen_P1 = "15801_Queen_Attack_Shoot_Strengthen";

	public const int perkId_2 = 515802;

	public const int addMoraleBuffCount_P2 = 2;

	public const int parameterId_TriggerCD_P2 = 15802011;

	public const int perkId_3 = 515803;

	public const string comboTag_Skill_P3 = "158_Main_Skill_P03";

	public const int hitDamageId_Skill_P3 = 158503001;

	public static readonly FP hitOffset_Skill_P3 = 0;

	public static readonly FP hitInnerRadius_Skill_P3 = 0;

	public static readonly FP hitRadius_Skill_P3 = 5;

	public static readonly FP hitAngle_Skill_P3 = 360;

	public const int perkId_4 = 515804;

	public const int buffId_P4 = 15804011;

	public static readonly int damageTag_AddBuff_P4 = CommonHelper.StringToHash("158_P04");

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("158_Main_Sill_Hurt");

	public const string areaEffectKey_P4 = "AreaEffect_15801_Main_Skill_P04_Boom";

	public const string areaEffectKey_P4_P9 = "AreaEffect_15801_Main_Skill_P04P09_Boom";

	public const int perkId_5 = 515805;

	public const int parameterId_TriggerRate_P5 = 15805011;

	public const int addMoraleBuffCount_P5 = 1;

	public const int buffId_P5 = 15805011;

	public const int perkId_6 = 515806;

	public const string areaEffectKey_P6 = "AreaEffect_15801_Main_Skill_P06_Fire";

	public const int perkId_7 = 515807;

	public static readonly int damageTag_Trigger_P7 = CommonHelper.StringToHash("158_P07");

	public const int additionalAttrId_P7 = 15807001;

	public const int parameterId_P7 = 15807011;

	public const int perkId_8 = 515808;

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("158_Main_Sill_Hurt");

	public const int buffId_P8 = 15808011;

	public const int perkId_9 = 515809;

	public const string comboTag_Skill_P9 = "158_Main_Skill_P09";

	public const int hitDamageId_Skill_P9 = 158310001;

	public static readonly FP hitOffset_Skill_P9 = 0;

	public static readonly FP hitInnerRadius_Skill_P9 = 0;

	public static readonly FP hitRadius_Skill_P9 = 7;

	public static readonly FP hitAngle_Skill_P9 = 240;

	public const string comboTag_Skill_P3_P9 = "158_Main_Skill_P03P09";

	public const int hitDamageId_Skill_P3_P9 = 158503001;

	public static readonly FP hitOffset_Skill_P3_P9 = 0;

	public static readonly FP hitInnerRadius_Skill_P3_P9 = 0;

	public static readonly FP hitRadius_Skill_P3_P9 = 6;

	public static readonly FP hitAngle_Skill_P3_P9 = 360;

	public const string comboTag_Skill_Transform_P9 = "158_Skill_Ultra";

	public static readonly int damageTag_Trigger_P9 = CommonHelper.StringToHash("158_P09");

	public const int additionalAttrId_P9 = 15809001;

	public const int perkId_10 = 515810;

	public static readonly int damageTag_Trigger_P10 = CommonHelper.StringToHash("158_P10");

	public const int buffId_P10 = 15810011;

	public const int perkId_11 = 515811;

	public static readonly int damageTag_Trigger_P11 = CommonHelper.StringToHash("158_P11");

	public const int parameterId_TriggerRate_P11 = 15811011;

	public const int parameterId_TriggerCD_P11 = 15811012;

	public static readonly int damageTag_AddBuff_P11 = CommonHelper.StringToHash("158_P11_2");

	public const int buffId_P11 = 15811011;

	public const int perkId_12 = 515812;

	public static readonly int damageTag_AddTriggerMark_P12 = CommonHelper.StringToHash("158_P12");

	public const int buffId_P12 = 15812011;

	public const int perkId_13 = 515813;

	public const int buffId_Mark_P13 = 15813011;

	public const int parameterId_TriggerCD_P13 = 15813011;

	public const int buffId_AddDamage_P13 = 15813012;

	public const int buffId_Morale_Solider = 15800001;

	public const int buffId_Morale_Warrior = 15800003;

	public const int buffId_Morale_ForPlayer = 15800002;

	public const int parameterId_MaxBuffNum_Morale = 15800002;

	public static readonly int damageTag_TriggerMorale = CommonHelper.StringToHash("158_Morale");

	public const int singleAddMoraleBuffCount_Solider = 1;

	public const int singleRemoveMoraleBuffCount_Warrior = 2;

	public const int summonedId_Soldier = 15831011;

	public static readonly SummonCfg summonCfg_Soldier = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		leftTime = 0,
		maxCount = 1
	};

	public static readonly FP defaultSummonRadius_Soldier = 2;

	public static readonly FP attackRange_Soldier = 2;

	public const string comboTag_Spawn_Soldier = "15801_Soldier_Born";

	public const string comboTag_Spawn_Return_Solider = "15801_Soldier_ReBorn";

	public const string comboTag_Death_Soldier = "15801_Soldier_LevelUp";

	public const int skillId_NormalAttack_Soldier = 15891003;

	public const string comboTag_NormalAttack_Soldier = "15801_Soldier_Attack";

	public static readonly FP useInterval_NormalAttack_Soldier = 0;

	public const int skillId_CoordinateAttack_Soldier = 15891004;

	public const string comboTag_CoordinateAttack_Soldier = "15801_Soldier_Skill";

	public const int summonedId_Warrior = 15831021;

	public static readonly SummonCfg summonCfg_Warrior = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		leftTime = 0,
		maxCount = 1
	};

	public static readonly FP defaultSummonRadius_Warrior = 2;

	public static readonly FP attackRange_Warrior = 2;

	public const string comboTag_Spawn_Warrior = "15801_Hero_Born";

	public const string comboTag_Death_Warrior = "15801_Hero_Out";

	public const int skillId_NormalAttack_Warrior = 15892003;

	public const string comboTag_NormalAttack_Warrior = "15801_Hero_Attack";

	public static readonly FP useInterval_NormalAttack_Warrior = 0;

	public const int skillId_CoordinateAttack_Warrior = 15892004;

	public const string comboTag_CoordinateAttack_Warrior = "15801_Hero_Skill";

	public const int summonedId_Queen = 15831031;

	public static readonly SummonCfg summonCfg_Queen = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		maxCount = 1
	};

	public const int parameterId_LeftTime_Queen = 15802012;

	public static readonly FP summonRadius_NoTarget_Queen = 2;

	public static readonly FP summonRadius_Queen = 10;

	public static readonly FP summonRandomRadius_Queen = 2;

	public static readonly FP attackRange_Queen = 15;

	public const string comboTag_Spawn_Queen = "15801_Queen_Born";

	public const string comboTag_Death_Queen = "15801_Queen_Out";

	public const int skillId_NormalAttack_Queen = 15893003;

	public const string comboTag_NormalAttack_Queen = "15801_Queen_Attack_Shoot";

	public const string eventName_NormalAttackBrgin_Queen = "15801_Queen_Shoot_Start";

	public const int summonedId_Casemate = 15831041;

	public static readonly SummonCfg summonCfg_Casemate = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		maxCount = 1
	};

	public const int parameterId_LeftTime_Casemate = 15811013;

	public static readonly FP summonRadius_NoTarget_Casemate = 8;

	public static readonly FP summonRadius_Casemate = 7;

	public static readonly FP summonRandomRadius_Casemate = 3;

	public static readonly FP attackRange_Casemate = 15;

	public const string comboTag_Spawn_Casemate = "15801_Cannon_Born";

	public const string comboTag_Death_Casemate = "15801_Cannon_Out";

	public const int skillId_NormalAttack_Casemate = 15894003;

	public const string comboTag_NormalAttack_Casemate = "15801_Cannon_Attack";

	public static readonly FP useInterval_NormalAttack_Casemate = 0;

	public const string localDataKey_SummonedIsWarrior = "SummonedIsWarrior";

	public const string logicTag_IsToyChange = "IsToyChange";

	public const string logicTag_SoldierReturnSpawn = "SoldierReturn";

	public const string logicTag_ToySummonedCount = "ToySummonedCount";

	public static readonly int eventHashCode_QueenBeginNormalAttack = CommonHelper.StringToHash("QueenBeginNormalAttack");

	public static readonly int eventHashCode_SummonedCoordinateAttack = CommonHelper.StringToHash("SummonedCoordinateAttack");
}
