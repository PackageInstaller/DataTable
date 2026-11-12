using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15801;

public class Config
{
	public static readonly int damageTag_AddFireMark = CommonHelper.StringToHash("158_FireTag_Add");

	public const int buffId_FireMark = 1011;

	public static readonly int damageTag_TriggerFireMark = CommonHelper.StringToHash("158_FireTag_Trigger");

	public static readonly int damageTag_FireMark = CommonHelper.StringToHash("158_FireTag_Damage");

	public const string tipsKey_TriggerFireMark = "FireMark_Trigger_Effect_02";

	public const int hitDamageId_FireMark = 158000001;

	public static readonly FP hitRadius_FireMark = 2;

	public const string hitFxKey_FireMark = "fx_common_base_FireTag_Trigger_2";

	public const string hittedFxKey_FireMark = "";

	public static readonly FP stiffDuration_FireMark = 1;

	public static readonly FP hitStrenth_FireMark = 1;

	public const int skillId_NormalAttack_Default = 15810000;

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "Attack_1", "Attack_2", "Attack_3", "Attack_4", "Attack_5" };

	public static readonly FP holdTime_NormalAttackStage = 0.5;

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

	public const string comboTag_UltraSkill_Timeline = "158_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "158_Ultra_NoTL";

	public const string eventName_SwitchModel_UltraSkill = "158_Change_Start";

	public static readonly FP aimRange_Transfrom = 12;

	public static readonly FP addAttackRange_Transform = 7.5;

	public const string modelGroupName_Transfrom = "toylaru";

	public const int shield_Transfrom = 15840011;

	public const int parameterId_DurationTime_Transform = 15840001;

	public const int skillId_NormalAttack_Transform = 15810001;

	public const string comboTag_NormalAttack_MainControl_Transform = "Attack_Ultra";

	public const string comboTag_NormalAttack_Support_Transform = "Attack_Ultra_Support";

	public const int skillId_Skill_Transform = 15834001;

	public const string comboTag_Skill_MainControl_Transform = "158_Skill_Ultra";

	public const string comboTag_Skill_Support_Transform = "158_Skill_Ultra_Support";

	public const int skillId_Return_Transfrom = 15834002;

	public const string comboTag_Return_Transform = "158_Ultra_End";

	public const string eventName_SwitchModel_Transform = "158_Change_End";

	public static readonly FP assistSkillRadius_Transform = 5;

	public static readonly FP distance_ForceTrace_Summoned = 12;

	public static readonly FP distance_StopTrace_ForPlayer_Summoned = 4;

	public static readonly FP interval_CheckTrace_Summoned = 0.5;

	public const int perkId_41 = 515841;

	public const int buffId_P41 = 15841011;

	public const string comboTag_NormalAttack_MainControl_Transform_P41 = "Attack_Ultra";

	public const string comboTag_NormalAttack_Support_Transform_P41 = "Attack_Ultra_Support";

	public const int perkId_42 = 515842;

	public static readonly int damageTag_Trigger_P42 = CommonHelper.StringToHash("158_P42");

	public const int buffId_P42 = 15842011;

	public const int perkId_43 = 515843;

	public const int buffId_P43 = 15843011;

	public static readonly FP interval_AddBuff_P43 = 1;

	public const int buffId_D1 = 15896111;

	public const int buffId_Skill_D2 = 15896211;

	public const int buffId_Minion_D2 = 15896221;

	public const int additionalAttrId_D3 = 15896511;

	public const int buffId_D4 = 15896411;

	public const int buffId_D5 = 15896311;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public static readonly int eventHashCode_SummonedDeathFinish = CommonHelper.StringToHash("SummonedDeathFinish");
}
