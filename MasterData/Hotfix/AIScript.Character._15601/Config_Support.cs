using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15601;

public class Config_Support
{
	public enum RaffleCombinationType
	{
		None = 0,
		AAA = 2,
		AAB = 4,
		ABA = 8,
		BAA = 16,
		ABB = 32,
		BAB = 64,
		BBA = 128,
		BBB = 256,
		ALL = 510
	}

	public const string comboTag_Skill = "Skill_Sup_StartShow";

	public const int buffId_ReduceSpeed_Assit = 15691014;

	public static readonly FP randomRadius_Stroll = 5;

	public static readonly FP idleTime_BetweenStroll = 0.5;

	public static readonly FP maxDistanceWithPlayer_Stroll = 15;

	public const int skillId_Raffle = 15632001;

	public const string comboTag_Raffle = "Skill_Sup_Raffle";

	public const string eventName_PlayRaffleFx = "RaffleResult";

	public const int times_UseRaffleSkill = 5;

	public static readonly FP interval_UseRaffleSkill = 1;

	public static readonly List<FP> raffleRateList = new List<FP> { 25, 25, 25, 25 };

	public static readonly List<List<RaffleCombinationType>> raffleResultGroupList = new List<List<RaffleCombinationType>>
	{
		new List<RaffleCombinationType> { RaffleCombinationType.AAA },
		new List<RaffleCombinationType>
		{
			RaffleCombinationType.AAB,
			RaffleCombinationType.ABA,
			RaffleCombinationType.BAA
		},
		new List<RaffleCombinationType>
		{
			RaffleCombinationType.ABB,
			RaffleCombinationType.BAB,
			RaffleCombinationType.BBA
		},
		new List<RaffleCombinationType> { RaffleCombinationType.BBB }
	};

	public static readonly Dictionary<RaffleCombinationType, string> raffleResultFxDic = new Dictionary<RaffleCombinationType, string>
	{
		[RaffleCombinationType.AAA] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_aaa",
		[RaffleCombinationType.AAB] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_aab",
		[RaffleCombinationType.ABA] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_aba",
		[RaffleCombinationType.BAA] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_baa",
		[RaffleCombinationType.ABB] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_abb",
		[RaffleCombinationType.BAB] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_bab",
		[RaffleCombinationType.BBA] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_bba",
		[RaffleCombinationType.BBB] = "Actor/Character/15601/FX/fx_15601_base_Skill_Sup_Raffle_bbb"
	};

	public static readonly Dictionary<RaffleCombinationType, int> raffleResultSkillIdDic = new Dictionary<RaffleCombinationType, int>
	{
		[RaffleCombinationType.AAA] = 15632003,
		[RaffleCombinationType.AAB] = 15632005,
		[RaffleCombinationType.ABA] = 15632005,
		[RaffleCombinationType.BAA] = 15632005,
		[RaffleCombinationType.ABB] = 15632004,
		[RaffleCombinationType.BAB] = 15632004,
		[RaffleCombinationType.BBA] = 15632004,
		[RaffleCombinationType.BBB] = 15632002
	};

	public const int skillId_Sculpture = 15632003;

	public const string comboTag_Sculpture = "Skill_Sup_PenguinStatueCalling";

	public const string eventName_Shoot_Sculpture = "PenguinStatueCalling";

	public static readonly FP shootOffset_Sculpture = 1;

	public static readonly FP shootPositionY_Sculpture = 1.8;

	public const string bulletKey_Sculpture = "Bullet_156_Sup_Skill_PenguinStatueCalling_Fly";

	public static readonly FP distance_TargetPosition_Sculpture = 5;

	public static readonly FP offsetDistance_TargetPosition_Sculpture = 1;

	public static readonly int bulletTag_Sculpture = CommonHelper.StringToHash("PenguinStatueCalling_Fly");

	public const string areaEffectKey_Sculpture = "AreaEffect_156_Sup_Skill_PenguinStatue";

	public static readonly int areaEffectTag_Sculpture = CommonHelper.StringToHash("PenguinStatue");

	public const int skillId_Strafe_A = 15632005;

	public const string comboTag_Strafe_A = "Skill_Sup_Shot_Penguin";

	public const int skillId_Strafe_B = 15632004;

	public const string comboTag_Strafe_B = "Skill_Sup_Shot_Heart";

	public static readonly int bulletTag_Strafe = CommonHelper.StringToHash("156SupSkillShot");

	public const int skillId_HeartArrow = 15632002;

	public const string comboTag_HeartArrow = "Skill_Sup_ShootHeartArrow";

	public const string eventName_Shoot_HeartArrow = "ShootHeartArrow";

	public static readonly FP shootOffset_HeartArrow = 1;

	public static readonly FP shootPositionY_HeartArrow = 1.8;

	public const string bulletKey_HeartArrow = "Bullet_156_Sup_Skill_HeartArrow";

	public static readonly int bulletTag_HeartArrow = CommonHelper.StringToHash("HeartArrow");

	public const string fxKey_Hitted_HeartArrow = "Actor/Character/15601/FX/fx_15601_base_HeartArrowEffect";

	public static readonly FP delayTime_TakeEffect_HeartArrow = 0.3;

	public const int buffId_Heal_HeartArrow = 15691013;

	public const string areaEffectKey_HeartArrow = "AreaEffect_156_Sup_Skill_HeartArrowBoom";

	public const int buffId_StrengthenNormalAttack = 15691011;

	public const int buffId_StrengthenSkill = 15691012;

	public const int perkId_21 = 515621;

	public const int buffId_StrengthenNormalAttack_P21 = 15621011;

	public const string areaEffectKey_Sculpture_P21 = "AreaEffect_156_Sup_Skill_PenguinStatue_P21";

	public const int perkId_22 = 515622;

	public static readonly List<FP> raffleRateList_P22 = new List<FP> { 50, 50, 0, 0 };

	public const string areaEffectKey_Sculpture_P22 = "AreaEffect_156_Sup_Skill_PenguinStatue_P22";

	public const string areaEffectKey_Sculpture_P21_P22 = "AreaEffect_156_Sup_Skill_PenguinStatue_P22P21";

	public const int perkId_23 = 515623;

	public static readonly List<FP> raffleRateList_P23 = new List<FP> { 0, 0, 50, 50 };

	public static readonly List<FP> raffleRateList_P22_P23 = new List<FP> { 25, 25, 25, 25 };

	public static readonly FP searchRadius_P23 = 15;

	public const int perkId_24 = 515624;

	public const int buffId_StrengthenSkill_P24 = 15624011;

	public const string areaEffectKey_HeartArrow_P24 = "AreaEffect_156_Sup_Skill_HeartArrowBoom_P24";

	public const int perkId_25 = 515625;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("Shot_Penguin");

	public const string areaEffectKey_P25 = "AreaEffect_156_P25_ShotBoom";

	public const int parameterId_TriggerCD_P25 = 15625011;

	public const int parameterId_TriggerLimit_P25 = 15625012;

	public const int perkId_26 = 515626;

	public const int buffId_P26 = 15626011;

	public const int perkId_27 = 515627;

	public static readonly FP delayTime_GenerateAreaEffect_P27 = 0.1;

	public const string areaEffectKey_P27 = "AreaEffect_156_P27_PenguinStatueBoom";

	public const int perkId_28 = 515628;

	public const string comboTag_Strafe_B_P28 = "Skill_Sup_Shot_Heart_P28";

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("Shot_Heart");

	public const int buffId_P28 = 15628011;

	public const int perkId_29 = 515629;

	public const int buffId_P29 = 15629011;

	public const int perkId_30 = 515630;

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("156SupSkillAllShot");

	public const int additionalAttrId_P30 = 15630001;

	public const int buffId_Heal_HeartArrow_P30 = 15630011;

	public const int perkId_31 = 515631;

	public const int buffId_P31 = 15631011;

	public const int perkId_32 = 515632;

	public const int buffId_P32 = 15632011;

	public const int perkId_33 = 515633;

	public const int buffId_P33 = 15633011;

	public const string logicTag_RaffleCombinationType = "RaffleCombinationType";

	public const string localDataKey_NextRaffleTimes = "NextRaffleTimes";

	public const string logicTag_InitNextRaffleTimes = "InitNextRaffleTimes";
}
