using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13901;

public class Config_MainControl
{
	public const int buffId_Soul = 13900001;

	public static readonly int buffTag_Soul = CommonHelper.StringToHash("139_Soul");

	public const int skillId_Skill = 13931000;

	public const string comboTag_Start_Skill = "139_Skill_Main_1";

	public const string comboTag_Attack_Skill = "139_Skill_Main_2";

	public const string comboTag_End_Skill = "139_Skill_Main_3";

	public const string eventName_HideModel_Skill = "139_Hide";

	public const string eventName_ShowModel_Skill = "139_Show";

	public const string eventName_EnableInvincible_Skill = "139_EnableInvincible";

	public const string eventName_DisbaleInvincible_Skill = "139_CloseInvincible";

	public const string eventName_Move_Skill = "139_Move";

	public static readonly FP distance_Move_NoTarget_Skill = 8;

	public static readonly FP duration_Move_Skill = 0.08;

	public static readonly int damageTag_GetSoul_Skill = CommonHelper.StringToHash("139_B1");

	public const int perkId_1 = 513901;

	public const int buffId_Soul_P1 = 13900002;

	public const int buffId_Soul_Dark_P1 = 13900003;

	public const int parameterId_P1 = 13901011;

	public const int skillId_P1 = 13931002;

	public const int perkId_2 = 513902;

	public const string eventName_GenerateAreaEffect_P2 = "Event_P02";

	public static readonly List<string> areaEffectKeyList_P2 = new List<string> { "AreaEffect_13901_Main_P02_A", "AreaEffect_13901_Main_P02_B", "AreaEffect_13901_Main_P02_C" };

	public static readonly List<string> areaEffectKeyList_P2_P5 = new List<string> { "AreaEffect_13901_Main_P07_A", "AreaEffect_13901_Main_P07_B", "AreaEffect_13901_Main_P07_C" };

	public static readonly FP randomRadius_AreaEffect_P2 = 1;

	public const int getBuffCount_P2 = 1;

	public static readonly int damageTag_Trigger_P2 = CommonHelper.StringToHash("139_P02");

	public const int additionalAttrId_P2 = 13902011;

	public const int parameterId_P2 = 13902011;

	public const int perkId_3 = 513903;

	public const int skillId_P3 = 13931001;

	public static readonly List<string> removeSoulFxList_P3 = new List<string> { "fx_13901_loop_Skill_Main_buff_1_trail", "fx_13901_loop_Skill_Main_buff_2_trail", "fx_13901_loop_Skill_Main_buff_3_trail" };

	public const int buffId_P3 = 13903011;

	public const int buffId_P1_P3 = 13903012;

	public static readonly int buffTag_P3 = CommonHelper.StringToHash("139_03_Buff");

	public const int perkId_4 = 513904;

	public const int buffId_FirstStage_UltraSkill_P4 = 13904011;

	public const int parameterId_P4 = 13904011;

	public const string areaEffectKey_Tide_WaterMark_P4 = "AreaEffect_13901_WaterTrigger_P04";

	public const int perkId_5 = 513905;

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("139_P05_Skill");

	public static readonly Dictionary<int, int> hitDamageIdMapping_P5 = new Dictionary<int, int>
	{
		[139400002] = 139400302,
		[139543002] = 139543302
	};

	public const int buffId_P5 = 13905011;

	public const int perkId_6 = 513906;

	public const int buffId_P6 = 13906011;

	public static readonly int damageTag_Trigger_P6 = CommonHelper.StringToHash("139_P06");

	public const int additionalAttrId_P6 = 13906001;

	public const int perkId_7 = 513907;

	public const int buffId_P7 = 13907012;

	public const int buffId_Mark_P7 = 13907001;

	public const int parameterId_ReplaceTriggerCD_P7 = 13907002;

	public const int parameterId_TriggerCD_P7 = 13907013;

	public const int perkId_8 = 513908;

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("139_P08_Mark");

	public static readonly Dictionary<int, int> hitDamageIdMapping_P8 = new Dictionary<int, int>
	{
		[139100001] = 139100201,
		[139100002] = 139100202,
		[139100003] = 139100203,
		[139100004] = 139100204,
		[139100005] = 139100205,
		[139100006] = 139100206,
		[139100007] = 139100207,
		[139100008] = 139100208,
		[139100009] = 139100209,
		[139400001] = 139400201
	};

	public const int buffId_P8 = 0;

	public const int perkId_9 = 513909;

	public const int parameterId_P9 = 13909001;

	public const int buffId_Mark_P9 = 13909011;

	public const int buffId_P9 = 13909012;

	public const int perkId_10 = 513910;

	public static readonly List<string> comboTagList_NormalAttack_P10 = new List<string> { "Atk1_P10", "Atk2_P10", "Atk3_P10", "Atk4_P10", "Atk5_P10" };

	public static readonly int damageTag_TriggerWaterMark_P10 = CommonHelper.StringToHash("139_WaterTrigger_P10");

	public static readonly int damageTag_Trigger_P10 = CommonHelper.StringToHash("139_P10");

	public const int additionalAttrId_P10 = 13910001;

	public const int perkId_11 = 513911;

	public const int buffId_P11 = 13911011;

	public const int perkId_12 = 513912;

	public const int buffId_P12 = 13912011;

	public const int perkId_13 = 513913;

	public const int parameterId_P13 = 13913011;

	public const int getBuffCount_P13 = 3;

	public const int buffId_TriggerCD_P13 = 13913012;

	public const int buffId_P13 = 13913011;

	public static readonly int eventHashCode_AddSoul = CommonHelper.StringToHash("AddSoul");

	public static readonly int eventHashCode_RemoveSoul = CommonHelper.StringToHash("RemoveSoul");

	public const string logicTag_SkillHasGetSoul = "SkillHasGetSoul";

	public const string logicTag_TriggerPersonalPerk_P1 = "TriggerPersonalPerk_P1 ";

	public const string logicTag_LastTriggerTime_P2 = "LastTriggerTime_P2";
}
