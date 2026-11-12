using TrueSync;

namespace AIScript.Character._11501;

public class Config
{
	public static readonly int damageTag_AddLightMark = CommonHelper.StringToHash("115_LightTag_Add");

	public const int buffId_LightMark = 3011;

	public static readonly int damageTag_TriggerLightMark = CommonHelper.StringToHash("115_LightTag_Trigger");

	public const string areaEffectKey_LightMark = "AreaEffect_11501_LightTag_Boom_H2";

	public const string tipsKey_TriggerMark = "LightMark_Trigger_Effect_01";

	public const int skillId_NormalAttack_Default = 11510000;

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_NormalAttack = new ComboInputBuffer.ActionKey[3];

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.25f;

	public static readonly FP distance_Dodge = 0.1f;

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime_Rush = 1f;

	public const string comboTag_OneStage_Timeline_UltraSkill = "Ultra_TL";

	public const string comboTag_TwoStage_Timeline_UltraSkill = "Ultra_TL_H6";

	public const string comboTag_AllStage_NoTimeline_UltraSkill = "Ultra_NoTL_H6";

	public static readonly FP maxShootTime_UltraSkill = 1.8;

	public static readonly FP addSearchRange_MainControl_UltraSkill = 4;

	public static readonly FP addSearchRange_Support_UltraSkill = 10;

	public const int perkId_41 = 511541;

	public const int buffId_P41 = 11541011;

	public const int perkId_42 = 511542;

	public const string comboTag_OneStage_Timeline_UltraSkill_P42 = "Ultra_TL_P42";

	public const string comboTag_AllStage_NoTimeline_UltraSkill_P42 = "Ultra_NoTL_H6_P42";

	public static readonly int damageTag_Trigger_P42 = CommonHelper.StringToHash("115_Ultra");

	public const int additionalAttrId_P42 = 11542001;

	public const int perkId_43 = 511543;

	public static readonly int damageTag_Trigger_P43 = CommonHelper.StringToHash("115_Ultra");

	public const int parameterId_43 = 11543011;

	public const int additionalAttrId_P43 = 11543001;

	public const int buffId_D1 = 11596111;

	public const int buffId_D2 = 11596211;

	public const int buffId_D3 = 11596311;

	public const int buffId_D4 = 11596411;

	public const int additionalAttrId_D5 = 11596511;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public const string logicTag_CanTrigger_P41 = "CanTrigger_P41";
}
