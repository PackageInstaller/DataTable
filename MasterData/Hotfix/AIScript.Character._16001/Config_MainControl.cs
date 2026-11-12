using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._16001;

public class Config_MainControl
{
	public const int buffId_Mark = 16000010;

	public const int additionalAttrId_Mark = 16000010;

	public const int buffId_BubbleGun = 16000021;

	public const int buffId_Megaphone = 16000022;

	public const int buffId_Decibel_Empty = 16000002;

	public const int buffId_Decibel_Stack = 16000003;

	public const int buffId_Decibel_Max = 16000004;

	public const int initDecibelCount = 80;

	public static readonly List<string> comboTagList_NormalAttack_BubbleGun = new List<string> { "PaoAttack_1", "PaoAttack_2", "PaoAttack_3", "PaoAttack_4" };

	public static readonly List<string> comboTagList_NormalAttack_Megaphone = new List<string> { "YinAttack_1", "YinAttack_2", "YinAttack_3", "YinAttack_4" };

	public const string eventName_AddDecibel_NormalAttack = "160_AddEnergy";

	public const string eventName_AddDecibel_NormalAttack_Final = "160_AddEnergy_Final";

	public const int addDecibelCount_NormalAttack = 3;

	public const int addDecibelCount_NormalAttack_Final = 4;

	public static readonly FP holdTime_NormalAttackStage = 1;

	public const int skillId_Skill_BubbleGun = 16031000;

	public const int skillId_Skill_Megaphone = 16031001;

	public const string comboTag_SwitchMode_Skill = "160_Main_Skill_Switch";

	public const string eventName_SwitchMode_Skill = "Event_160_Switch";

	public const int skillId_Skill_Strength = 16031002;

	public const string comboTag_Skill_Strength = "160_Main_Skill";

	public const string eventName_Summon_Skill_Strength = "160_Summon";

	public static readonly FP offset_Summon_Skill_Strength = 1;

	public const int summonedId = 16000011;

	public static SummonCfg summonCfg_Summoned = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		summonType = SummonType.None,
		useSummonHit = true
	};

	public static readonly FP durationTime_Summoned = 15;

	public const string comboTag_Spawn_Summoned = "BubbleDoll_Born";

	public const string comboTag_Death_Summoned = "BubbleDoll_Dead";

	public const int skillId_Bounce_Summoned = 16010010;

	public const string comboTag_Bounce_Summoned = "BubbleDoll_Skill";

	public const string eventName_TriggerBounce_Summoned = "160_JumpBounce";

	public static readonly int damageTag_AddBuffForPlayer_Summoned = CommonHelper.StringToHash("160_BubbleDoll");

	public static readonly int buffId_ForPlayer_Summoned = 16093011;

	public static readonly FP triggerCD_AddBuff_Summoned = 1;

	public const int perkId_1 = 516001;

	public const string dropItemKey_P1 = "Item_16001_Main_P01_Bubble";

	public const string dropItemTag_P1 = "Item_16001_Main_P01_Bubble_Tag";

	public static readonly FP dropItemPositionY_P1 = 2;

	public const string fxKey_DropItemPickUp_P1 = "fx_16001_base_popoball_Skill_Main_Perk01";

	public static readonly FP dropInterval_Normal_P1 = 5;

	public static readonly FP dropInterval_Elite_P1 = 1.75;

	public static readonly FP dropInterval_Boss_P1 = 1.6;

	public const int dropCount_Normal_P1 = 1;

	public const int dropCount_Elite_P1 = 1;

	public const int dropCount_Boss_P1 = 2;

	public static readonly FP addModelScaleMutil_P1 = 0.1;

	public static readonly FP maxModelScale_P1 = 2;

	public static readonly int damageTag_Trigger_P1 = CommonHelper.StringToHash("160_BubbleDoll");

	public const int additionalAttrId_P1 = 16001011;

	public static readonly FP unitExtraModelScale_P1 = 0.1;

	public const int perkId_2 = 516002;

	public const string areaFxKey_P2 = "fx_16001_loop_Skill_Main_Perk02";

	public const string areaEffectKey_P2 = "AreaEffect_16001_Main_P02";

	public const int perkId_3 = 516003;

	public const string comboTag_Spawn_Summoned_P3 = "BubbleDoll_Born_P03";

	public const string comboTag_Bounce_Summoned_P3 = "BubbleDoll_Skill_P03";

	public static readonly int damageTag_Trigger_P3 = CommonHelper.StringToHash("160_BubbleDoll");

	public const int additionalAttrId_P3 = 16003011;

	public const int parameterId_P3 = 16008011;

	public const int perkId_4 = 516004;

	public const string areaEffectKey_P4 = "AreaEffect_16001_Main_P04";

	public const int triggerTimes_Rebound_P4 = 3;

	public static readonly FP reboundInterval_P4 = 0.3;

	public static readonly FP unitAddScale_AreaEffect_P4 = 0.05;

	public const int unitDecibel_AddScale_P4 = 10;

	public const int perkId_5 = 516005;

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("160_P5");

	public const int buffId_P5 = 16005011;

	public const int perkId_6 = 516006;

	public const int buffId_P6 = 16006011;

	public const int perkId_7 = 516007;

	public static readonly List<string> comboTagList_NormalAttack_BubbleGun_P7 = new List<string> { "PaoAttack_1_P7", "PaoAttack_2_P7", "PaoAttack_3_P7", "PaoAttack_4_P7" };

	public const int additionalAttrId_P7 = 16007001;

	public const int perkId_8 = 516008;

	public const int buffId_P8 = 16008011;

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("160_P4");

	public const int perkId_9 = 516009;

	public const int buffId_AllTeam_P9 = 16009011;

	public const int buffId_OtherElement_P9 = 16009012;

	public const int perkId_10 = 516010;

	public const int bounceTimes_Trigger_P10 = 2;

	public const string areaEffectKey_P10 = "AreaEffect_16001_Main_P10";

	public const int perkId_11 = 516011;

	public const int buffId_P11 = 16011011;

	public const int perkId_12 = 516012;

	public static readonly int damageTag_Trigger_P12 = CommonHelper.StringToHash("160_BubbleDoll");

	public const int shieldId_P12 = 16012001;

	public const int parameterId_P12 = 16012011;

	public const int buffId_P12 = 16012011;

	public const int perkId_13 = 516013;

	public const int parameterId_P13 = 16013011;

	public const int buffId_P13 = 16013011;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public static readonly FP interval_CheckTrace_Summoned = 0.5;

	public const string logicTag_BounceTimes_Summoned = "BounceTimes_Summoned";

	public static readonly int eventHashCode_Bounce_Summoned = CommonHelper.StringToHash("Bounce_Summoned");
}
