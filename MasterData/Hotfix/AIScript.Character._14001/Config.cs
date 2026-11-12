using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14001;

public class Config
{
	public static readonly int damageTag_TriggerLandMark = CommonHelper.StringToHash("140_LandTag_Trigger");

	public const string areaEffectKey_LandMark = "AreaEffect_14001_LandTag1_Boom";

	public const string tipsKey_TriggerLandMark = "LandMark_Trigger_Effect_02";

	public const int skillId_NormalAttack_Default = 14010000;

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "140_Attack_1", "140_Attack_2", "140_Attack_3" };

	public static readonly FP holdTime_NormalAttackStage = 1;

	public const int skillId_Dodge_Default = 14020000;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.3f;

	public static readonly FP distance_Dodge = 0.01f;

	public const int skillId_Rush_Default = 14070000;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime_Rush = 1f;

	public const string comboTag_Timeline_FirstStage_UltraSkill = "140_Ultra_TL1";

	public const string comboTag_Timeline_SecondStage_UltraSkill = "140_Ultra_TL2";

	public const string comboTag_NoTimeline_AllStage_UltraSkill = "140_Ultra_NoTL";

	public static readonly FP addSearchRange_UltraSkill = 5;

	public const string eventName_HideModel_UltraSkill = "140_Ultra_P1_Start";

	public const string eventName_ShowModel_UltraSkill = "140_Ultra_P1_End";

	public const string eventName_LookAtTarget_UltraSkill = "140_Ultra_Lock";

	public const string eventName_GenerateAreaEffect_UltraSkill_1 = "140_Ultra_Area";

	public const string areaEffectKey_UltraSkill_1 = "AreaEffect_14001_Ultra";

	public const string eventName_GenerateAreaEffect_UltraSkill_2 = "140_Ultra_Shoot";

	public const string areaEffectKey_UltraSkill_2 = "AreaEffect_14001_Ultra_Boom";

	public static readonly FP areaEffectOffset_NoTarget_UltraSkill = 6;

	public const int perkId_41 = 514041;

	public const string dropItemKey_P41 = "Item_140_Ultra_P41";

	public const int dropItemCount_P41 = 3;

	public static readonly FP randomDropRadius_P41 = 10;

	public const int buffId_P41 = 14041011;

	public const int triggerBuffCount_P41 = 3;

	public const int hitDamageId_P41 = 140541001;

	public const string hittedFxKey_P41 = "fx_14001_Hit_Attack";

	public const int parameterId_TriggerDamageCD_P41 = 14041011;

	public const int perkId_42 = 514042;

	public const string comboTag_Timeline_SecondStage_UltraSkill_P42 = "140_Ultra_TL2_P42";

	public const string comboTag_NoTimeline_AllStage_UltraSkill_P42 = "140_Ultra_NoTL_P42";

	public const string areaEffectKey_UltraSkill_2_P42 = "AreaEffect_14001_Ultra_Boom_P42";

	public static readonly int damageTag_Trigger_P42 = CommonHelper.StringToHash("140_P42");

	public const int buffId_P42 = 14042011;

	public const int perkId_43 = 514043;

	public static readonly int damageTag_Trigger_P43 = CommonHelper.StringToHash("140_Ultra");

	public const int buffId_P43 = 14043011;

	public const int buffId_D1 = 14096111;

	public const int buffId_D2 = 14096211;

	public const int buffId_D3 = 14096311;

	public const int buffId_D4 = 14096411;

	public const int additionalAttrId_D5 = 14096511;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";
}
