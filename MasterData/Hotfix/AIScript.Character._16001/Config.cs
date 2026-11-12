using TrueSync;

namespace AIScript.Character._16001;

public class Config
{
	public static readonly int damageTag_AddWaterMark = CommonHelper.StringToHash("160_WaterMark");

	public const int buffId_WaterMark = 4011;

	public const int buffId_Decibel = 16000001;

	public const string fxKey_AddDecibel = "fx_16001_base_Skill_Main_Energy_get";

	public static readonly FP triggerCD_PlatAddDecibelFx = 0.5;

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

	public const string comboTag_UltraSkill_Timeline = "160_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "160_Ultra_NoTL";

	public const string eventName_HideModel_UltraSkill = "160_Ultra_HideModel";

	public const string eventName_ShowModel_UltraSkill = "160_Ultra_ShowModel";

	public static readonly FP offset_CameraPosition_UltraSkill = 4.5f;

	public static readonly FP duration_CameraMove_UltraSkill = 0.25f;

	public static readonly int damageTag_Trigger_UltraSkill = CommonHelper.StringToHash("160_Ultra");

	public const int buffId_UltraSkill = 16094011;

	public const int perkId_41 = 516041;

	public const int parameterId_TriggerInterval_P41 = 16041011;

	public const int parameterId_DecibelCount_P41 = 16041012;

	public const int parameterId_TriggerCount_P41 = 16041013;

	public const int perkId_42 = 516042;

	public const string eventName_AddBuff_UltraSkill_p42 = "160_Ultra_Buff";

	public const int buffId_P42 = 16042011;

	public const int perkId_43 = 516043;

	public static readonly int damageTag_Trigger_P43 = CommonHelper.StringToHash("160_Ultra");

	public const int buffId_P43 = 16043011;

	public const int buffId_D1 = 16096111;

	public const int buffId_D2 = 16096211;

	public const int buffId_D3 = 16096311;

	public const int buffId_D4 = 16096411;

	public const int parameterId_D4 = 16096411;

	public const int buffId_D5 = 16096511;

	public static readonly int eventHashCode_AddDecibel = CommonHelper.StringToHash("AddDecibel");

	public static readonly int eventHashCode_RemoveDecibel = CommonHelper.StringToHash("RemoveDecibel");
}
