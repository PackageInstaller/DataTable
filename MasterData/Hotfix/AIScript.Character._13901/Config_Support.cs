using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13901;

public class Config_Support
{
	public const string comboTag_Skill = "139_Skill_Sup";

	public const int loopTimes_Skill = 1;

	public const string eventName_GenerateAreaEffect_Skill = "139_Sup_Area";

	public const string areaEffectKey_Skill = "AreaEffect_13901_Sup";

	public static readonly TSVector2 offset_AreaEffect_Skill = new TSVector2(0, 3);

	public const int perkId_21 = 513921;

	public static readonly Dictionary<string, (string bulletKey, FP offsetAngle)> shootInfoDic_P21 = new Dictionary<string, (string, FP)>
	{
		["Event_139_Sup"] = ("Bullet_13901_Sup_P21", 0),
		["Event_139_Sup_l30"] = ("Bullet_13901_Sup_P21_l30", 0),
		["Event_139_Sup_l90"] = ("Bullet_13901_Sup_P21_l90", 0),
		["Event_139_Sup_r30"] = ("Bullet_13901_Sup_P21_r30", 0)
	};

	public static readonly FP shootRadius_P21 = 3;

	public static readonly FP shootPositionY_P21 = 1.5;

	public const int perkId_22 = 513922;

	public const string comboTag_Skill_P22 = "139_Skill_Sup_P22";

	public const int parameterId_P22 = 13922011;

	public static readonly int damageTag_Trigger_P22 = CommonHelper.StringToHash("139_B2_Loop");

	public const int additionalAttrId_P22 = 13922011;

	public const int perkId_23 = 513923;

	public const string comboTag_Skill_P23 = "139_Skill_Sup_P23";

	public const string comboTag_Skill_P22_P23 = "139_Skill_Sup_P23P22";

	public static readonly int damageTag_Trigger_P23 = CommonHelper.StringToHash("139_B2_End");

	public const int additionalAttrId_P23 = 13923011;

	public const int perkId_24 = 513924;

	public const string areaEffectKey_Skill_P24 = "AreaEffect_13901_Sup_P24";

	public static readonly TSVector2 offset_AreaEffect_Skill_P24 = new TSVector2(0, 3);

	public const int perkId_25 = 513925;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("139_B2_Loop");

	public const int additionalAttrId_P25 = 13925001;

	public const int additionalAttrId_Toughness_P25 = 13925002;

	public const int perkId_26 = 513926;

	public const int parameterId_P26 = 13926011;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("139_B2_Loop");

	public const int additionalAttrId_P26 = 13926001;

	public const int perkId_27 = 513927;

	public const int buffId_P27 = 13927011;

	public const int parameterId_P27 = 13927011;

	public const int perkId_28 = 513928;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("139_B2_End");

	public const int additionalAttrId_P28 = 13928001;

	public const int additionalAttrId_Extra_P28 = 13928002;

	public const int perkId_29 = 513929;

	public const int parameterId_P29 = 13929011;

	public static readonly int damageTag_Trigger_P29 = CommonHelper.StringToHash("139_B2_End");

	public const int additionalAttrId_P29 = 13929001;

	public const int perkId_30 = 513930;

	public const string areaEffectKey_Skill_P30 = "AreaEffect_13901_Sup_P30";

	public static readonly TSVector2 offset_AreaEffect_Skill_P30 = new TSVector2(0, 3);

	public const string areaEffectKey_Skill_P24_P30 = "AreaEffect_13901_Sup_P30P24";

	public static readonly TSVector2 offset_AreaEffect_Skill_P24_P30 = new TSVector2(0, 3);

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("139_B2_End");

	public const int additionalAttrId_P30 = 13930001;

	public const int perkId_31 = 513931;

	public static readonly int damageTag_Trigger_P31 = CommonHelper.StringToHash("139_Sup_P31");

	public const int additionalAttrId_P31 = 13931001;

	public const int perkId_33 = 513933;

	public const int buffId_P33 = 13933011;
}
