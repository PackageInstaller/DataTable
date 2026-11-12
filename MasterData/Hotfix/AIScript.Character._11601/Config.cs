using TrueSync;

namespace AIScript.Character._11601;

public class Config
{
	public static readonly int damageTag_TriggerLandMark = CommonHelper.StringToHash("116_LandTag_Trigger");

	public const string tipsKey_TriggerLandMark = "LandMark_Trigger_Effect_02";

	public const string areaEffectKey_LandMark = "AreaEffect_11601_LandTag1_Stone";

	public const string comboTag_NormalAttack = "Shoot";

	public const string eventName_Shoot_NormalAttack = "116_Event_NormalAtk_Shoot";

	public const string bulletKey_NormalAttack = "Bullet_11601_NormalBullet";

	public const int bulletCount_NormalAttack = 2;

	public static readonly FP shootIncludedAngle_NormalAttack = 7;

	public static readonly TSVector shootPositionOffset_NormalAttack = new TSVector(-0.2, 1.6, 1.4);

	public const string comboTag_NormalAttack_Special = "Melee";

	public static readonly FP distance_UseSpecialCombo_NormalAttack = 2;

	public static readonly FP interval_UseSpecialCombo_NormalAttack = 10;

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

	public const string comboTag_UltraSkill_Timeline = "116_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "116_Ultra_NoTL";

	public const string eventName_GenerateAreaEffect_UltraSkill = "116_Ultra_Area";

	public const string areaEffectKey_UltraSkill_Timeline = "AreaEffect_11601_Ultra_TL";

	public const string areaEffectKey_UltraSkill_NoTimeline = "AreaEffect_11601_Ultra";

	public const string eventName_BeginMove_UltraSkill = "116_UltraSkill_Movement";

	public static readonly FP maxMoveDistance_UltraSkill = 8;

	public static readonly FP moveDuration_UltraSkill = 0.07;

	public const string eventName_HideModel_UltraSkill = "HideModel";

	public const string eventName_ShowModel_UltraSkill = "ShowModel";

	public const int perkId_41 = 511641;

	public static readonly int damageTag_Trigger_P41 = CommonHelper.StringToHash("116_Ultra_Final");

	public const int additionalAttrId_P41 = 11641001;

	public const int perkId_42 = 511642;

	public static readonly int damageTag_Trigger_P42 = CommonHelper.StringToHash("116_Ultra_AOE");

	public const int additionalAttrId_P42 = 11642001;

	public const int parameterId_P42 = 11642011;

	public const int perkId_43 = 511643;

	public const int buffId_P43 = 11643011;

	public static readonly int damageTag_Trigger_D1 = CommonHelper.StringToHash("116_SP");

	public const int buffId_D1 = 11696111;

	public const int buffId_D2 = 11696211;

	public const int triggerTimes_D3 = 20;

	public const int buffId_D3 = 11696311;

	public const int additionalAttrId_D4 = 11696411;

	public static readonly int damageTag_Trigger_D5 = CommonHelper.StringToHash("116_SP");

	public const int buffId_D5 = 11696511;

	public const string logicTag_LastUseSpecialCombo_NormalAttack = "LastUseSpecialCombo_NormalAttack";

	public const string logicTag_UltraSkillHitTimes = "UltraSkillHitTimes";
}
