using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14101;

public class Config
{
	public const string fxKey_Common = "fx_14101_loop_idle_tail";

	public const int buffId_Ink = 14191015;

	public static readonly int buffTag_Ink = CommonHelper.StringToHash("141_Ink");

	public static readonly int damageTag_AddInk = CommonHelper.StringToHash("141_Ink_Add");

	public static readonly Dictionary<int, int> buffIdDic_Burn = new Dictionary<int, int>
	{
		[1] = 14191011,
		[2] = 14191012,
		[3] = 14191013,
		[4] = 14191014
	};

	public static readonly int buffTag_Burn = CommonHelper.StringToHash("141_Burn");

	public static readonly int damageTag_TriggerBurn = CommonHelper.StringToHash("141_Ignite");

	public static readonly int damageTag_TriggerFireMark = CommonHelper.StringToHash("141_FireMark_Trigger");

	public static readonly int damageTag_FireMark = CommonHelper.StringToHash("141_FireMark_Boom");

	public const string tipsKey_TriggerFireMark = "FireMark_Trigger_Effect_01";

	public const int hitDamageId_FireMark = 141000001;

	public static readonly FP hitRadius_FireMark = 3;

	public const string hitFxPath_FireMark = "fx_14101_base_FireTag_Trigger";

	public const string hittedFxPath_FireMark = "fx_14101_hit_Fire";

	public static readonly FP stiffDuration_FireMark = 1;

	public static readonly FP hitStrenth_FireMark = 1;

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "Attack_1", "Attack_2", "Attack_3", "Attack_4", "Attack_5" };

	public static readonly FP delay_ResetNormalAttackStage = 1;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.3f;

	public static readonly FP distance_Dodge = 0.01f;

	public static readonly int transitionRushSkillId = 0;

	public static readonly FP realDistance_Dodge = 3f;

	public static readonly FP crossAdditionDistance_Dodge = 1.5f;

	public static readonly FP crossKeepAwayNavmeshEdgeDistance_Dodge = 0.01f;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime_Rush = 1f;

	public const string comboTag_UltraSkill_Timeline = "141_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "141_Ultra_NoTL";

	public const string eventName_UltraSkill_BeginLogic = "14101_Ultra_Target";

	public static readonly FP offsetDistance_UltraSkill_NoTarget = 6;

	public static readonly FP delayTime_UltraSkill_GenerateAreaEffect = 1;

	public const string areaEffectKey_UltraSkill = "AreaEffect_14101_Ultra_T2";

	public static readonly int areaTag_UltraSkill = CommonHelper.StringToHash("141_Ultra_Area");

	public const int perkId_41 = 514141;

	public static readonly int damageTag_Trigger_P41 = CommonHelper.StringToHash("141_Ultra_Hurt");

	public const int buffId_P41 = 14141011;

	public const int perkId_42 = 514142;

	public const string areaEffectKey_UltraSkill_P42 = "AreaEffect_14101_Ultra_P42_FireWind";

	public const int perkId_43 = 514143;

	public static readonly FP delay_GenerateAreaEffect_P43 = 0;

	public const string areaEffectKey_P43 = "AreaEffect_14101_Ultra_P43_DragonBreathe";

	public const int additionalAttrId_D1 = 14196111;

	public static readonly int damageTag_Trigger_D2 = CommonHelper.StringToHash("141_Ultra_Hurt");

	public const int additionalAttrId_D2 = 14196211;

	public const int buffId_D3 = 14196311;

	public const int buffId_D4 = 14196411;

	public const int additionalAttrId_D5 = 14196511;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public static readonly int eventHashCode_UltraSkill_BeginLogic = CommonHelper.StringToHash("UltraSkill_BeginLogic");
}
