using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._12501;

public class Config
{
	public static readonly int tag_Cold = CommonHelper.StringToHash("Cold");

	public static readonly int buffTag_Cold = CommonHelper.StringToHash("Cold");

	public static readonly int buffTag_Frozen = CommonHelper.StringToHash("Frozen");

	public static readonly int damageTag_TriggerWaterCorrosion = CommonHelper.StringToHash("125_WaterTag_Trigger");

	public const string areaEffectKey_TriggerWaterCorrosion = "AreaEffect_125_WaterTag1_Boom";

	public const int maxCount_ColdBuff = 3;

	public const int buffId_Cold = 4021;

	public const int buffId_Frozen = 4100;

	public const string tipsKey_TriggerMark = "WaterMark_Trigger_Effect_05";

	public const int buffId_BerserkTiming = 12500002;

	public const int addTimingBuffCount_EnterBerserk = 20;

	public static readonly FP interval_ReduceTimingBuffCount = 1;

	public const int buffId_Berserk = 12594001;

	public const int skillId_ExitBerserk = 12500002;

	public const string comboTag_ExitBerserk = "Rage_End";

	public static readonly List<string> comboTagList_Normal = new List<string> { "Attack_1", "Attack_2", "Attack_3", "Attack_4", "Attack_5" };

	public static readonly List<string> comboTagList_Berserk = new List<string> { "Attack_Rage_1", "Attack_Rage_2", "Attack_Rage_3" };

	public static readonly FP delay_ResetNormalAttackStage = 1;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Normal = 0.25f;

	public static readonly FP distance_Normal = 0.1f;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Berserk_Attack = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.R,
		ComboInputBuffer.ActionKey.D
	};

	public static readonly FP angle_CanUseAttackDodge = 45;

	public static readonly FP minDistance_CanUseAttackDodge = 1.5f;

	public static readonly FP maxDistance_CanUseAttackDodge = 8;

	public static readonly FP duration_Berserk_Attack = 0.25f;

	public static readonly FP maxDistance_Berserk_Attack = 6;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Berserk_Slide = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1750359160,
		(ComboInputBuffer.ActionKey)1348824421,
		(ComboInputBuffer.ActionKey)1550545509
	};

	public static readonly FP duration_Berserk_Slide = 0.25f;

	public static readonly FP distance_Berserk_Slide = 0.1f;

	public static readonly int transitionRushSkillId = 0;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime = 1f;

	public const string comboTag_UltraSkill_Timeline = "Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "Ultra_NoTL";

	public const string eventName_UltraSkill_EnterBerserk = "StartRage";

	public static readonly int damageTag_UltraSkill_Pull = CommonHelper.StringToHash("Ultra_Catch");

	public const string eventName_UltraSkill_BeginPull = "Start_Catch";

	public const string linkFxKey_UltraSkill_Pull = "fx_12501_bullet_Ultra_TL2_tengman";

	public static readonly FP pullTime_UltraSkill = 0.3;

	public static readonly FP pullSpeed_UltraSkill = 40;

	public static readonly FP pullInterval_UltraSkill = 0.05;

	public static readonly FP pullStrength_UltraSkill = 5;

	public static readonly FP pullStopDistance_UltraSkill = 1;

	public const int perkId_41 = 512541;

	public static readonly int damageTag_Trigger_P41 = CommonHelper.StringToHash("125_Ultra");

	public const int buffId_P41 = 12541011;

	public const int additionalAttrId_Ultra_P41 = 12541002;

	public const int additionalAttrId_Berserk_P41 = 12541001;

	public const int perkId_42 = 512542;

	public const int buffId_P42 = 12542011;

	public const int perkId_43 = 512543;

	public static readonly int damageTag_TriggerA_P43 = CommonHelper.StringToHash("125_Ultra_Frozen");

	public const int buffId_A_P43 = 4100;

	public const int buffId_B_P43 = 12543011;

	public static readonly int damageTag_TriggerB_P43 = CommonHelper.StringToHash("125_NormalAttack_Rage");

	public const int parameterId_P43 = 12543011;

	public const int additionalAttrId_P43 = 12543001;

	public static readonly int damageTag_Trigger_D1 = CommonHelper.StringToHash("Ultra_Catch");

	public const int buffId_D1 = 12596111;

	public const int buffId_D2 = 12596211;

	public static readonly int damageTag_Trigger_D3 = CommonHelper.StringToHash("125_Skill");

	public const int buffId_D3 = 12596311;

	public const int buffId_D4 = 12596411;

	public const int additionalAttrId_D5 = 12596511;

	public static readonly int eventHashCode_EnterBerserk = CommonHelper.StringToHash("StartRage");
}
