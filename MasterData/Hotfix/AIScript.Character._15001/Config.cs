using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15001;

public class Config
{
	public static readonly int damageTag_TriggerLightMark = CommonHelper.StringToHash("150_LightMark_Trigger");

	public static readonly int damageTag_RateTriggerLightMark = CommonHelper.StringToHash("");

	public const int parameterId_RateTriggerLightMark = 0;

	public const string areaEffectKey_LightMark = "AreaEffect_150_LightTag_Boom";

	public const string tipsKey_TriggerLightMark = "LightMark_Trigger_Effect_02";

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "Attack_1", "Attack_2", "Attack_3", "Attack_4", "Attack_5" };

	public static readonly FP delay_ResetNormalAttackStage = 1;

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

	public const string comboTag_UltraSkill_Timeline = "150_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "150_Ultra_NoTL";

	public const string eventName_UltraSkill_Attack = "150_Ultra_Attack";

	public const string areaEffectKey_UltraSkill = "AreaEffect_150_Ultra";

	public static readonly FP offset_AreaEffect_UltraSkill = 7;

	public const int perkId_41 = 515041;

	public const string areaEffectKey_P41 = "AreaEffect_150_Ultra_P41";

	public const int perkId_42 = 515042;

	public static readonly int damageTag_Trigger_P42 = CommonHelper.StringToHash("150_Ultra_P42");

	public const int parameterId_P42_1 = 15042011;

	public const int parameterId_P42_2 = 15042012;

	public const int additionalAttrId_P42 = 15042001;

	public const int perkId_43 = 515043;

	public static readonly int damageTag_Trigger_P43 = CommonHelper.StringToHash("150_Ultra");

	public const int buffId_P43 = 15043011;

	public const int buffId_D1 = 15096111;

	public const int buffId_D2 = 15096211;

	public const int buffId_D3 = 15096311;

	public const int buffId_D4 = 15096411;

	public const int additionalAttrId_D5 = 15096511;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";
}
