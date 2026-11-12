using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14901;

public class Config
{
	public static readonly int damageTag_UltraSkill = CommonHelper.StringToHash("149_Ultra");

	public static readonly int damageTag_NormalAtk = CommonHelper.StringToHash("149_NormalAtk");

	public static readonly int damageTag_Gray = CommonHelper.StringToHash("149_Gray");

	public static readonly int triggerDamageTag_EarthMark = CommonHelper.StringToHash("149_LandTagTrigger");

	public const string tipsKey_TriggerMark = "LandMark_Trigger_Effect_02";

	public const string areaEffectKey_TriggerLandMark = "AreaEffect_149_LandTag1_Stone";

	public static readonly int damageTag_GraySkill = CommonHelper.StringToHash("149_Skill");

	public const int buff_m1 = 14996111;

	public static readonly FP cd_ScriptParameter_m1 = 1;

	public const int buff_m2 = 14996211;

	public const int buff_m3 = 14996311;

	public const int buff_m4 = 14996411;

	public const int onceId_m5 = 14996511;

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "Atk1", "Atk2", "Atk3", "Atk4", "Atk5" };

	public static List<string> dicNormalTag_plus = new List<string> { "Atk1", "Atk2", "Atk3", "Atk4", "Atk5" };

	public static List<string> dicNormalTag_plus_p2 = new List<string> { "Atk1_Strength", "Atk2_Strength", "Atk3_Strength", "Atk4_Strength", "Atk5_Strength" };

	public static readonly FP holdTime_NormalAttackStage = 1;

	public const string eventName_StopLockDirection_NormalAttack = "149_S";

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.3f;

	public static readonly FP distance_Dodge = 0.01f;

	public static readonly int transitionRushSkillId = 0;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime_Rush = 1f;

	public const string comboTag_UltraSkill_Timeline = "149_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "149_Ultra_NoTL";

	public const int perkId_41 = 514941;

	public const string comboTag_UltraSkill_Timeline_41 = "149_Ultra_P41_TL";

	public const string comboTag_UltraSkill_NoTimeline_41 = "149_Ultra_P41_NoTL";

	public const int perkId_42 = 514942;

	public const int buffId_42 = 14942011;

	public const int onceId_42 = 14942001;

	public const int perkId_43 = 514943;

	public const int range_43 = 10;

	public const int onceId_43 = 14943001;

	public const int buff_tag_43 = 14943011;

	public const int buff_43 = 14943012;

	public static HotfixEnum.monsterEpicType monsterEventType = HotfixEnum.monsterEpicType.NORMAL;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";
}
