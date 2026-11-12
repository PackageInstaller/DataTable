using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class Config_Support
{
	public enum DecibelState
	{
		None,
		Soft,
		Loud
	}

	public const int buffId_Decibel_Empty = 16000005;

	public const int buffId_Decibel_Stack = 16000006;

	public const int buffId_Decibel_Max = 16000007;

	public const int decibelCount_EnterLoudState = 40;

	public const int buffId_Decibel_Soft = 16000008;

	public const int buffId_Decibel_Loud = 16000009;

	public const string comboTag_NormalAttack = "160_Sup_Shoot";

	public const string eventName_TriggerShoot_NormalAttack = "Event_160_Sup_Shoot";

	public const int addDecibelCount_NormalAttack = 2;

	public const string comboTag_Skill = "160_Sup";

	public const string eventName_GenerateAreaEffect_Skill = "Event_160_Sup";

	public const string areaEffectKey_Skill = "AreaEffect_16001_SupArea";

	public const string areaEffectKey_Skill_D2 = "AreaEffect_16001_SupArea_T2";

	public static readonly int areaEffectTag_Skill = CommonHelper.StringToHash("AreaEffect_160_SupArea_Tag");

	public static readonly FP durationTime_Assit = 17;

	public static readonly FP distance_StartTrace_ForPlayer = 3.5;

	public static readonly FP randomRadius_TracePosition_ForPlayer = 2;

	public static readonly FP randomAngle_TracePosition_ForPlayer = 150;

	public static readonly FP distance_StopTrace_ForPlayer = 1;

	public static readonly FP randomRadius_Teleport = 2;

	public const int buffId_ReduceSpeed = 16000011;

	public const int skillId_Teleport = 16032002;

	public const string comboTag_Teleport = "160_Sup_Transmit";

	public const string eventName_CloseAreaEffect_Teleport = "Event_160_Sup_CloseArea";

	public const string fxKey_AreaEffect_Teleport = "fx_16001_base_Skill_Sup_WaterRing_close";

	public const string eventName_Teleport = "Event_160_Sup_Transmit";

	public static readonly FP distance_CanTeleport = 10;

	public static readonly FP triggerCD_Teleport = 6;

	public const int skillId_ComeBackAassit_FromUltra = 16032007;

	public const string comboTag_ComeBackAassit_FromUltra = "160_Sup_Back";

	public const int skillId_ExitAssit = 16032001;

	public const string comboTag_ExitAssit = "160_Sup_Out";

	public const int perkId_21 = 516021;

	public const int triggerTimes_Shoot_P21 = 10;

	public const int skillId_LineFire_P21 = 16032004;

	public const string comboTag_LineFire_P21 = "160_Sup_Perk21";

	public const string eventName_BeginLink_P21 = "160_Sup_Perk21_BeginLink";

	public const string eventName_StopLink_P21 = "160_Sup_Perk21_StopLink";

	public const string linkSlotEntityKey_P21 = "Link_Skill_Sup_Perk21";

	public const string fxKey_P21 = "fx_16001_base_Skill_Sup_Perk21_Slot";

	public const string linkFxKey_P21 = "fx_16001_loop_Skill_Sup_Spout_Perk21";

	public const int hitDamageId_Check_P21 = 160521003;

	public static readonly CommomAreaHitConfig commomAreaHitConfig_P21 = new CommomAreaHitConfig
	{
		hitDamageId = 160521001,
		hitFlags = HitBox.FeatureFlag.Stiff,
		hitFeatureData = new HitBox.HitBoxFeatureData
		{
			StiffDuration = 0.3,
			hitStrenth = 3
		},
		hittedEffectAlias = "fx_16001_hit_atk_Perk21",
		hurtAnimType = HitBox.HurtAnimType.Small
	};

	public static readonly FP hitWidth_P21 = 2.5;

	public const int buffId_Immunity_P21 = 16021012;

	public const int addDecibelCount_P21 = 30;

	public const string eventName_StopLockDirection_P21 = "160_Sup_Perk21_StopLockDirection";

	public static readonly int damageTag_Trigger_P21 = CommonHelper.StringToHash("160_B2_Ray21");

	public const int buffId_P21 = 16021011;

	public const int perkId_22 = 516022;

	public const int decibelCount_Trigger_P22 = 40;

	public const int skillId_RotateFire_P22 = 16032005;

	public const string comboTag_RotateFire_P22 = "160_Sup_Perk22";

	public const string eventName_BeginLink_P22 = "160_Sup_Perk22_BeginLink";

	public const string eventName_StopLink_P22 = "160_Sup_Perk22_StopLink";

	public const string linkSlotEntityKey_P22 = "Link_Skill_Sup_Perk_22";

	public const string fxKey_P22 = "fx_16001_base_Skill_Sup_Perk22_Slot";

	public const string linkFxKey_P22 = "fx_16001_loop_Skill_Sup_Spout_Perk22";

	public const int hitDamageId_Check_P22 = 160521003;

	public static readonly CommomAreaHitConfig commomAreaHitConfig_P22 = new CommomAreaHitConfig
	{
		hitDamageId = 160522001,
		hitFlags = HitBox.FeatureFlag.Stiff,
		hitFeatureData = new HitBox.HitBoxFeatureData
		{
			StiffDuration = 0.5,
			hitStrenth = 3
		},
		hittedEffectAlias = "fx_16001_hit_atk_Perk22",
		hurtAnimType = HitBox.HurtAnimType.Small
	};

	public static readonly FP hitWidth_P22 = 2.5;

	public const int buffId_Immunity_P22 = 16021012;

	public static readonly int damageTag_Trigger_P22 = CommonHelper.StringToHash("160_B2_Ray22");

	public const int buffId_P22 = 16021011;

	public const int perkId_23 = 516023;

	public const int initDecibelCount_P23 = 70;

	public const int skillId_TorrentialFire_P23 = 16032006;

	public const string comboTag_TorrentialFire_P23 = "160_Sup_Perk23";

	public const int buffId_P23 = 16023011;

	public const string eventName_TriggerShoot_TorrentialFire_P23 = "Event_160_Sup_P23";

	public const int removeDecibelCount_TorrentialFire_P23 = 2;

	public const int decibelCount_FinishTorrentialFire_P23 = 50;

	public const int perkId_24 = 516024;

	public const int addDecibelCount_NormalAttack_P24 = 4;

	public const string comboTag_NormalAttack_Loud_P24 = "160_Sup_Perk24";

	public const string comboTag_TorrentialFire_Loud_P23_P24 = "160_Sup_Perk24Perk23";

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("160_B2_Bullet");

	public const int buffId_P24 = 16024011;

	public const int additionalAttrId_P24 = 16024011;

	public const int perkId_25 = 516025;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("160_B2_P25");

	public const int buffId_P25 = 16025001;

	public const int buffId_P21_P25 = 16025001;

	public const int buffId_P22_P25 = 16025001;

	public const int perkId_26 = 516026;

	public static readonly int buffTag_Check_P26 = CommonHelper.StringToHash("160_P21");

	public const int hitDamageId_P26 = 160526001;

	public const string hittedFx_P26 = "";

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("160_P26");

	public const int additionalAttrId_P26 = 16026001;

	public const int parameterId_P26 = 16026011;

	public const int perkId_27 = 516027;

	public const int addDecibelCount_P27 = 8;

	public const int parameterId_P27 = 16027011;

	public const int buffId_P27 = 16027011;

	public static readonly FP addBuffInterval_P27 = 2;

	public const int perkId_28 = 516028;

	public static readonly FP addScale_AreaEffect_P28 = 0.005;

	public static readonly FP addScaleInterval_AreaEffect_P28 = 0.1;

	public const int maxAddScaleTimes_AreaEffect_P28 = 60;

	public const int buffId_P28 = 16028011;

	public const int perkId_29 = 516029;

	public const int buffId_P29 = 16029011;

	public const int perkId_30 = 516030;

	public const int triggerTimes_Shoot_P30 = 8;

	public const string areaEffectKey_Red_P30 = "AreaEffect_16001_Sup_P30_Red";

	public static readonly int areaEffectTag_Red_P30 = CommonHelper.StringToHash("AreaEffect_16001_Sup_P30_Red");

	public const int buffId_Red_P30 = 16030012;

	public const int buffId_Red_Main_P30 = 16030011;

	public const string areaEffectKey_Blue_P30 = "AreaEffect_16001_Sup_P30_Blue";

	public static readonly int areaEffectTag_Blue_P30 = CommonHelper.StringToHash("AreaEffect_16001_Sup_P30_Blue");

	public const int buffId_Red_Blue_P30 = 16030012;

	public static readonly FP randomRadius_P30 = 1;

	public const int perkId_31 = 516031;

	public static readonly FP durationTime_StayInAreaEffect_P31 = 5;

	public const int shieldId_P31 = 16031001;

	public const int perkId_32 = 516032;

	public const int buffId_P32 = 16032011;

	public const int perkId_33 = 516033;

	public const int buffId_P33 = 16033011;

	public static readonly FP interval_CheckTrace = 0.2;

	public const string logicTag_DecibelState = "DecibelState";

	public static readonly int eventHashCode_TriggerShoot = CommonHelper.StringToHash("TriggerShoot");

	public const string logicTag_ShootTimes = "ShootTimes";

	public static readonly int eventHashCode_GenerateSkillAreaEffect = CommonHelper.StringToHash("GenerateSkillAreaEffect");

	public static readonly int eventHashCode_CloseAreaEffect = CommonHelper.StringToHash("CloseAreaEffect");

	public const string logicTag_CanTrace_Teleport = "CanTrace_Teleport";

	public static readonly int eventHashCode_TeleportFinish = CommonHelper.StringToHash("TeleportFinish");

	public const string logicTag_CanLineFire_P21 = "CanLineFire_P21";

	public const string logicTag_CanRotateFire_P22 = "CanRotateFire_P22";

	public const string logicTag_IsLinkSlotEntity_P21 = "IsLinkSlotEntity_P21";

	public const string logicTag_IsLinkSlotEntity_P22 = "IsLinkSlotEntity_P22";

	public const string logicTag_CanTorrentialFire_P23 = "CanTriggerPerk_P23";

	public const string logicTag_FinishTorrentialFire_P23 = "FinishTorrentialFire_P23";

	public const string localDataKey_SkillAreaEffectScaleAddTimes_P28 = "SkillAreaEffectScaleAddTimes_P28";
}
