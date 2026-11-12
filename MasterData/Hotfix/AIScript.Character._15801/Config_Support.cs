using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15801;

public class Config_Support
{
	public static readonly FP distance_ForceTrace_Transfrom = 16;

	public static readonly FP distance_StopTrace_ForPlayer_Transfrom = 4;

	public static readonly FP randomRadius_Teleport = 2;

	public static readonly FP interval_CheckTrace_Transfrom = 0.5;

	public const int skillId_Skill = 15832000;

	public const string comboTag_Skill = "158_Support_Skill";

	public const string eventName_Shoot_Skill = "158_Support_Shoot";

	public const string bulletKey_Skill = "Bullet_15801_Summon_Attack_Cannon_Support_Shoot";

	public static readonly TSVector shootPositionOffset_Skill = new TSVector(0, 1, 1);

	public const int shootTimes_Skill = 4;

	public static readonly int bulletTag_Skill = CommonHelper.StringToHash("158_Support_Gift_Bullet");

	public const int perkId_21 = 515821;

	public const string areaEffectKey_P21 = "AreaEffect_15801_Support_Skill_Cannon_Boom_P21_Fire";

	public const int perkId_22 = 515822;

	public const string bulletKey_Skill_P22 = "Bullet_15801_Summon_Attack_Cannon_Support_Shoot_P22_Big";

	public const string areaEffectKey_P21_P22 = "AreaEffect_15801_Support_Skill_Cannon_Boom_P21P22_BigFire";

	public static readonly int damageTag_Trigger_P22 = CommonHelper.StringToHash("158_P22");

	public const int additionalAttrId_P22 = 15822011;

	public const int buffId_P22 = 15822011;

	public const int perkId_23 = 515823;

	public const int buffId_P23 = 15823011;

	public static readonly FP interval_AddBuff_P23 = 1;

	public const int perkId_24 = 515824;

	public const int perkId_25 = 515825;

	public const int addShootTimes_P25 = 2;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("158_P25");

	public const int additionalAttrId_P25 = 15825001;

	public const int perkId_26 = 515826;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("158_P22");

	public const int buffId_P26 = 15826011;

	public const int perkId_27 = 515827;

	public static readonly int damageTag_Trigger_P27 = CommonHelper.StringToHash("158_P25");

	public const int additionalAttrId_P27 = 15827001;

	public const int perkId_28 = 515828;

	public const string areaEffectKey_Soldier_P28 = "AreaEffect_15801_Support_Skill_P28_Summon_BuffEachOther";

	public const int hitDamageId_Soldier_P28 = 158528001;

	public static readonly FP hitInnerRadius_Soldier_P28 = 0;

	public static readonly FP hitRadius_Soldier_P28 = 3;

	public static readonly FP hitInterval_Soldier_P28 = 1;

	public const string areaEffectKey_Warrior_P28 = "AreaEffect_15801_Support_Skill_P28_Summon_BuffEachOther_P23";

	public const int hitDamageId_Warrior_P28 = 158528002;

	public static readonly FP hitInnerRadius_Warrior_P28 = 0;

	public static readonly FP hitRadius_Warrior_P28 = 3;

	public static readonly FP hitInterval_Warrior_P28 = 0.5;

	public const string hittedFxKey_P28 = "fx_15801_hit_Lash";

	public const int perkId_29 = 515829;

	public const int parameterId_LeftTime_Soldier_P29 = 15829011;

	public const int parameterId_LeftTime_Warrior_P29 = 15829012;

	public const int buffId_P29 = 15829011;

	public static readonly FP interval_AddBuff_P29 = 30;

	public static readonly Dictionary<int, FP> modelScaleDic_P29 = new Dictionary<int, FP>
	{
		[1] = 30,
		[2] = 30,
		[3] = 30
	};

	public const int perkId_30 = 515830;

	public const int buffId_AttackSpeed_P30 = 15830011;

	public const int buffId_AddDamage_P30 = 15830012;

	public const int buffId_AddDamageAllPlayer_P30 = 15830013;

	public const int perkId_31 = 515831;

	public const int buffId_P31 = 15831011;

	public const int perkId_32 = 515832;

	public static readonly int damageTag_AddFireMark_P32 = CommonHelper.StringToHash("158_P32");

	public const int buffId_P32 = 15832011;

	public const int perkId_33 = 515833;

	public static readonly int damageTag_Trigger_P33 = CommonHelper.StringToHash("158_P33");

	public const int buffId_P33 = 15833011;

	public const int summonedId_Soldier = 15832011;

	public static readonly SummonCfg summonCfg_Soldier = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted
	};

	public const int parameterId_LeftTime_Soldier = 15832001;

	public const int maxCount_Soldier = 4;

	public static readonly FP attackRange_Soldier = 2;

	public static readonly FP teleportRadius_Soldier = 2;

	public const string comboTag_Spawn_Soldier = "15801_Soldier_Born";

	public const string comboTag_Death_Soldier = "15801_Soldier_Die";

	public const string comboTag_Death_Absorb_Soldier = "15801_Soldier_LevelUp_P23";

	public const int skillId_NormalAttack_Soldier = 15895003;

	public const string comboTag_NormalAttack_Soldier = "15801_Soldier_Attack_Support";

	public static readonly FP useInterval_NormalAttack_Soldier = 0;

	public const int skillId_Skill_Soldier = 15895004;

	public const string comboTag_Skill_Soldier = "15801_Soldier_Skill_Strengthen_Support";

	public static readonly int useInterval_Skill_Soldier = 4;

	public const int summonedId_Warrior = 15832021;

	public static readonly SummonCfg summonCfg_Warrior = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted
	};

	public const int parameterId_LeftTime_Warrior = 15823011;

	public const int maxCount_Warriorr = 1;

	public static readonly FP attackRange_Warrior = 2;

	public static readonly FP teleportRadius_Warrior = 2;

	public const string comboTag_Spawn_Warrior = "15801_Hero_Born_P23";

	public const string comboTag_Death_Warrior = "15801_Hero_Die";

	public const int skillId_NormalAttack_Warrior = 15896003;

	public const string comboTag_NormalAttack_Warrior = "15801_Hero_Attack_Support";

	public static readonly FP useInterval_NormalAttack_Warrior = 0;

	public const int skillId_Skill_Warrior = 15896004;

	public const string comboTag_Skill_Warrior = "15801_Hero_Skill_Strengthen_Support";

	public static readonly int useInterval_Skill_Warrior = 4;

	public const int summonedId_Casemate = 15832031;

	public static readonly SummonCfg summonCfg_Casemate = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		leftTime = 0,
		maxCount = 1,
		useSummonHit = true,
		summonType = SummonType.None
	};

	public const string comboTag_Spawn_Casemate = "15801_Cannon_Born";

	public const string comboTag_Death_Casemate = "15801_Cannon_Out";

	public const int skillId_Skill_Casemate = 15897003;

	public const string comboTag_Skill_Casemate = "15801_Cannon_Attack_Support";

	public const string eventName_Shoot_Skill_Casemate = "158_Support_Shoot";

	public static readonly FP summonRandomRadius_Soldier = 0.5;

	public const string logicTag_SummoneCasematePosition = "SummoneCasematePosition";

	public const string logicTag_SummoneCasemateDirection = "SummoneCasemateDirection";

	public const string logicTag_RemainingSkillShootTimes = "RemainingSkillShootTimes";

	public static readonly int eventHashCode_SummonedDestroySelf = CommonHelper.StringToHash("SummonedDestroySelf");

	public const string logicTag_IsAbsorbDeath_Soldier = "IsAbsorbDeath_Soldier";
}
