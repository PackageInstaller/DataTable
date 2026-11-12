using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14101;

public class Config_MainControl
{
	public const string comboTag_Skill = "141_Main_Skill";

	public static readonly FP loopTime_Skill = 3;

	public static readonly FP maxRotateSpeed_Skill = 180;

	public const int buffId_Skill = 14193011;

	public static readonly FP interval_searchTargetUseInputDirection = 0.5;

	public const int perkId_1 = 514101;

	public static readonly FP addSkillLoopTime_P1 = 3;

	public static readonly int damageTag_Trigger_P1 = CommonHelper.StringToHash("141_Main_Skill_Fire");

	public const int additionalAttrId_P1 = 14101011;

	public const int perkId_2 = 514102;

	public const int buffId_Superposition_P2 = 14102011;

	public const int buffId_Strengthen_P2 = 14102012;

	public const int buffId_Superposition_Strengthen_P2 = 14102013;

	public const int maxSuperpositionBuffCount_P2 = 60;

	public static readonly FP addInterval_SuperpositionBuff_P2 = 0.1;

	public const int reduceBuffCount_SuperpositionBuff_NormalAttack_P2 = 10;

	public static readonly List<string> comboTagList_NormalAttack_Special_P2 = new List<string> { "Attack_Strengthen_1", "Attack_Strengthen_2" };

	public const int perkId_3 = 514103;

	public const int buffId_Ink_P3 = 14103011;

	public const int inkBuffCount_Trigger_P3 = 4;

	public const string areaEffectKey_P3 = "AreaEffect_14101_Main_Skill_P03_Boom";

	public const int buffId_P3 = 14103012;

	public const int perkId_4 = 514104;

	public const string comboTag_Skill_P4 = "141_Main_Skill_P04";

	public const int buffId_P4 = 14104011;

	public const int initBuffCount_P4 = 4;

	public static readonly FP reduceBuffInterval_P4 = 1;

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("141_Main_Skill_Fire");

	public const int additionalAttrId_P4 = 14104011;

	public const int perkId_5 = 514105;

	public static readonly Dictionary<int, int> buffIdDic_Burn_P5 = new Dictionary<int, int>
	{
		[1] = 14105011,
		[2] = 14105012,
		[3] = 14105013,
		[4] = 14105014
	};

	public const int perkId_6 = 514106;

	public const string areaEffectKey_P6 = "AreaEffect_14101_Main_Skill_P06_FirePit";

	public const int perkId_7 = 514107;

	public const int buffId_P7 = 14107011;

	public const int perkId_8 = 514108;

	public const int buffId_Ink_P8 = 14108011;

	public const int buffId_Ink_P3_P8 = 14108012;

	public const int perkId_9 = 514109;

	public const string comboTag_Skill_P9 = "141_Main_Skill_P09";

	public const string comboTag_Skill_P4_P9 = "141_Main_Skill_P04P09";

	public static readonly int damageTag_Trigger_P9 = CommonHelper.StringToHash("141_Main_Skill_P09_Hurt");

	public const int buffId_Mark_P9 = 14109011;

	public const int buffId_P9 = 14109012;

	public const int perkId_10 = 514110;

	public const int shieldId_P10 = 14110001;

	public const int buff_supArm = 14110011;

	public const int perkId_11 = 514111;

	public static readonly int damageTag_TriggerFireMark_P11 = CommonHelper.StringToHash("141_Ultra_Hurt");

	public const int buffId_P11 = 14111011;

	public const int perkId_12 = 514112;

	public const int buffId_P12 = 14112011;

	public const int perkId_13 = 514113;

	public const int buffId_P13 = 14113011;

	public static readonly FP buffTime_P13 = 3.5;

	public static readonly int damageTag_TriggerAddBuffTime_P13 = CommonHelper.StringToHash("141_P13");

	public static readonly FP addBuffTime_P13 = 1;

	public const int maxTriggerTimes_P13 = 3;

	public const string logicTag_NormalAttackStage_Special_P2 = "NormalAttackStage_Special_P2";
}
