using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14401;

public class Config_Support
{
	public const string comboTag_Start_Skill = "144_B2_Start";

	public const string comboTag_Attack_Skill = "144_B2_Attack";

	public const string comboTag_End_Skill = "144_B2_Connect";

	public const string attackLoopFxKey_Skill = "fx_14401_base_B2_Skill_badao";

	public const string eventName_PlayAttackLoopFx_Skill = "144_B2_Atmos";

	public const string eventName_StopAttackLoopFx_Skill = "144_B2_AtmosClear";

	public const int attackTimes_Skill = 3;

	public static readonly FP attackInterval_Skill = 1.3;

	public const string eventName_Attack_Skill = "144_B2_MomentarySlash";

	public const string areaEffect_Attack_Skill = "AreaEffect_14401_B2_Skill_MomentarySlash";

	public static readonly FP areaEffectOffset_NoTarget_Skill = 6;

	public static readonly FP delayTime_Summon_Skill = 0.3;

	public static readonly List<TSVector2> summonOffsetList_Skill = new List<TSVector2>
	{
		new TSVector2(2.5, 0.5),
		new TSVector2(-2.5, 0.5)
	};

	public const int summonCount_Skill = 3;

	public static readonly FP summonInterval_Skill = 1.3;

	public const string summonedSpawnFx_Skill = "fx_14401_base_B2_Skill_chuxian";

	public static readonly FP summonedDelayUseSkillTime_Skill = 0;

	public const string comboTag_Summoned_Skill = "144_B2_Shadow_Atk";

	public const int perkId_21 = 514421;

	public static readonly int damageTag_Trigger_P21 = CommonHelper.StringToHash("144_B2");

	public const int additionalAttrId_P21 = 14421011;

	public const int addAttackTimes_Skill_P21 = 2;

	public const int perkId_22 = 514422;

	public static readonly int damageTag_Trigger_P22 = CommonHelper.StringToHash("144_B2");

	public const string areaEffect_Attack_Skill_P22 = "AreaEffect_14401_B2P22_Skill_MomentarySlash";

	public const int additionalAttrId_P22 = 14422011;

	public const int perkId_23 = 514423;

	public static readonly FP summonDelay_P23 = 0.5;

	public const int summonedCount_Group_P23 = 3;

	public static readonly FP summonInterval_EveryGroup_P23 = 1.1;

	public const int memberCount_EveryGroup_P23 = 2;

	public static readonly FP summonInterval_EveryMember_P23 = 0.2;

	public static readonly FP searchRadius_NoTarget_P23 = 15;

	public static readonly FP summoneOffset_NoTarget_P23 = 0;

	public static readonly FP summonAngle_P23 = 360;

	public static readonly FP summonInnerRadius_P23 = 5;

	public static readonly FP summonOuterRadius_P23 = 7;

	public const string comboTag_Summoned_Skill_P23 = "144_B2P23_Shadow_Atk";

	public const int perkId_24 = 514424;

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("144_B2_Shadow");

	public const int buffId_P24 = 14424011;

	public const string areaEffectKey_P24 = "AreaEffect_14401_B2P24_DelayFlash";

	public const int perkId_25 = 514425;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("144_B2");

	public const int buffId_P25 = 14425011;

	public const int additionalAttrId_P25_2 = 14425002;

	public const int parameterId_P25 = 14425011;

	public const int perkId_26 = 514426;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("144_B2");

	public const int additionalAttrId_Damage_P26 = 14426002;

	public const int perkId_27 = 514427;

	public const int addAttackTimes_Skill_P27 = 1;

	public const int perkId_28 = 514428;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("144_B2_Shadow");

	public const int additionalAttrId_Single_P28 = 14428001;

	public const int additionalAttrId_Multiple_P28 = 14428002;

	public const int perkId_29 = 514429;

	public static readonly int damageTag_Trigger_P29 = CommonHelper.StringToHash("144_B2_Shadow");

	public const int additionalAttrId_P29 = 14429001;

	public const int perkId_30 = 514430;

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("144_B2_Shadow");

	public const int parameterId_P30 = 14430011;

	public const int additionalAttrId_P30 = 14430001;

	public const int perkId_31 = 514431;

	public static readonly int damageTag_Trigger_P31 = CommonHelper.StringToHash("144_WaterTag");

	public const int additionalAttrId_P31 = 14431001;

	public const int perkId_33 = 514433;

	public const int buffId_P33 = 14433011;

	public const string logicTag_SkillAttackTimes = "SkillAttackTimes";
}
