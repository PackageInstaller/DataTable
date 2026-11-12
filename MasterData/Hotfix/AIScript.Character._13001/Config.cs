using TrueSync;

namespace AIScript.Character._13001;

public class Config
{
	public static readonly int tag_Cold = CommonHelper.StringToHash("Cold");

	public static readonly int damageTag_TriggerWaterCorrosion = CommonHelper.StringToHash("130_WaterTagTrigger");

	public const string areaEffectKey_TriggerWaterCorrosion = "AreaEffect_130_WaterTag1_Boom";

	public const int maxCount_ColdBuff = 3;

	public const int buffId_Cold = 4021;

	public const int buffId_Freezing = 4100;

	public const string tipsKey_TriggerMark = "WaterMark_Trigger_Effect_05";

	public const int skillId_NormalAttack_Default = 13010001;

	public const string comboTag_NormalAttack = "Attack";

	public const string eventName_ChangeAttackRound_NormalAttack = "130_Shoot";

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

	public const string comboTag_Timeline_UltraSkill = "Ultra_TL";

	public const string comboTag_NoTimeline_UltraSkill = "Ultra_NoTL";

	public const string eventName_PlayAreaEffect_UltraSkill = "130_Ultra_Area";

	public const string areaEffectPath_UltraSkill = "AreaEffect_130_Ultra";

	public static readonly FP offset_NoTarget_UltraSkill = 5;

	public static readonly int areaEffectTag_UltraSkill = CommonHelper.StringToHash("130_Ultra_Area");

	public static readonly int damageTag_UltraSkill = CommonHelper.StringToHash("130_Ultra");

	public const int perkId_41 = 513041;

	public const string areaEffectPath_P41 = "AreaEffect_130_Ultra_Perk41";

	public const int additionalAttrId_P41 = 13041001;

	public const int perkId_42 = 513042;

	public const int buffId_P42 = 13042011;

	public const int perkId_43 = 513043;

	public const int parameterId_AddTime_P43 = 13043011;

	public const int additionalAttrId_P43 = 13043001;

	public const int parameterId_MaxCount_P43 = 13043013;

	public const int buffId_D1 = 13096111;

	public const int buffId_D2 = 13096211;

	public const int buffId_D3 = 13096311;

	public const int buffId_D4 = 13096411;

	public const int additionalAttrId_D5 = 13096511;
}
