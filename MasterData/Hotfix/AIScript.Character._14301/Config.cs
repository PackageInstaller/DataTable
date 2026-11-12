using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14301;

public class Config
{
	public static readonly FP distance_SwitchAttackMode = 3.3;

	public const string skillMoveFxKey_1 = "fx_14301_loop_foot_l";

	public const string skillMoveFxKey_2 = "fx_14301_loop_foot_r";

	public const string skillMoveFxKey_3 = "fx_14301_loop_foot_root";

	public const int buffId_m1 = 14396111;

	public const int buffId_m2 = 14396211;

	public const int buffId_m3 = 14396311;

	public const int buffId_m4 = 14396411;

	public const int onceId_m5 = 14396511;

	public static readonly int damageTag_TriggerWindMark = CommonHelper.StringToHash("143WindTagTrigger");

	public const string areaEffectKey_WindMark = "AreaEffect_143_WindTagTrigger_QiXuan";

	public static readonly FP randomRadius_AreaEffect_WindMark = 1.5;

	public const string tipsKey_TriggerWindMark = "WindMark_Trigger_Effect_04";

	public static readonly List<string> comboTagList_NormalAttack_Melee = new List<string> { "Atk_Jian_1", "Atk_Jian_2", "Atk_Jian_3", "Atk_Jian_4", "Atk_Jian_5", "Atk_Jian_6" };

	public static readonly List<string> comboTagList_NormalAttack_Range = new List<string> { "Atk_Qiang_1", "Atk_Qiang_2", "Atk_Qiang_3", "Atk_Qiang_4" };

	public static readonly FP delay_ResetNormalAttackStage = 2;

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

	public const string comboTag_UltraSkill_Timeline = "Ultra_TimelineOn_T2";

	public const string comboTag_UltraSkill_NoTimeline = "Ultra_TimelineOff_T2";

	public const string eventName_UltraSkill_GenerateMainAreaEffect = "WindDomainOpen";

	public const string eventName_UltraSkill_StopMainAreaEffect = "WindDomainClose";

	public const string mainAreaEffectKey_UltraSkill = "AreaEffect_143_Ultra_WindDomain";

	public static readonly List<string> loopAttackFxKeyList_UltraSkill = new List<string> { "fx_14301_base_Ultra_fast_1", "fx_14301_base_Ultra_fast_2", "fx_14301_base_Ultra_fast_3", "fx_14301_base_Ultra_fast_4" };

	public const string eventName_UltraSkill_LoopAttack_Low = "WindDomainQuickAtk_1";

	public static readonly FP fxSpeed_UltraSkill_LoopAttack_Low = 1;

	public const string eventName_UltraSkill_LoopAttack_Middle = "WindDomainQuickAtk_2";

	public static readonly FP fxSpeed_UltraSkill_LoopAttack_Middle = 1.1;

	public const string eventName_UltraSkill_LoopAttack_High = "WindDomainQuickAtk_3";

	public static readonly FP fxSpeed_UltraSkill_LoopAttack_High = 1.2;

	public const string areaEffectKey_UltraSkill_LoopAttack = "AreaEffect_143_Ultra_WindDomainQuickAtk";

	public const int perkId_41 = 514341;

	public const string comboTag_UltraSkill_Timeline_P41 = "Ultra_TimelineOn_T2P41";

	public const string comboTag_UltraSkill_NoTimeline_P41 = "Ultra_TimelineOff_T2P41";

	public const int perkId_42 = 514342;

	public const int buffId_P42 = 14342011;

	public const int perkId_43 = 514343;

	public const string pullAreaEffectKey_P43 = "AreaEffect_143_Ultra_WindDomain_P43_XiYin";

	public const string logicTag_NormalAttackStage_Melee = "NormalAttackStage_Melee";

	public const string logicTag_NormalAttackStage_Range = "NormalAttackStage_Range";

	public const string logicTag_LastNormalAttackFinsihTime_Melee = "LastNormalAttackFinsihTime_Melee";

	public const string logicTag_LastNormalAttackFinsihTime_Range = "LastNormalAttackFinsihTime_Range";
}
