using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14301;

public class Config_Support
{
	public const string comboTag_Skill_Stage1 = "Skill_Sup_LianHuan_1";

	public const string comboTag_Skill_Stage2 = "Skill_Sup_LianHuan_2";

	public static readonly List<TSVector2> hitPositionOffest_Skill_Stage2 = new List<TSVector2>
	{
		new TSVector2(0, 5)
	};

	public const int perkId_21 = 514321;

	public const string eventName_GenerateTornadoAreaEffect_P21 = "143_P21_LongJuanFeng";

	public const string tornadoAreaEffectKey_P21 = "AreaEffect_143_P21_LongJuanFeng";

	public const int perkId_22 = 514322;

	public const string eventName_GenerateFissureAreaEffect_P22 = "143_P21_DiLie";

	public const string fissureAreaEffectKey_P22 = "AreaEffect_143_P22_DiLie";

	public static readonly TSVector2 generatefissureAreaEffectOffset_P22 = new TSVector2(0, 0);

	public const int perkId_23 = 514323;

	public const string comboTag_Skill_Stage1_P23 = "Skill_Sup_LianHuan_1_P23";

	public const int perkId_24 = 514324;

	public const string comboTag_Skill_Stage2_P24 = "Skill_Sup_LianHuan_2_P24";

	public static readonly List<TSVector2> hitPositionOffest_Skill_Stage2_P24 = new List<TSVector2>
	{
		new TSVector2(0, 7.5)
	};

	public const int perkId_25 = 514325;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("143SupSkillAllAtk");

	public static readonly FP randomRadius_P25 = 1;

	public const string laserAreaEffectKey_P25 = "AreaEffect_143_P25_JiGuang";

	public static readonly FP generateLaserPositionY_P25 = 1;

	public const int parameterId_TriggerRate_P25 = 14325011;

	public const int parameterId_TriggerCD_P25 = 14325012;

	public const int perkId_26 = 514326;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("143SupSkillAllAtk");

	public const int buffId_P26 = 14326011;

	public const int perkId_27 = 514327;

	public const int buffId_P27 = 14327011;

	public const int perkId_28 = 514328;

	public static readonly int damageTag_TriggerBuff_P28 = CommonHelper.StringToHash("143SupJianAtk");

	public const int buffId_HitCount_P28 = 14328011;

	public static readonly int damageTag_TriggerImprove_P28 = CommonHelper.StringToHash("143SupQiangAtk");

	public const int additionalAttrId_P28 = 14328001;

	public const int perkId_29 = 514329;

	public static readonly int damageTag_Trigger_P29 = CommonHelper.StringToHash("143SupSkillAtk");

	public const int additionalAttrId_P29 = 14329001;

	public const int perkId_30 = 514330;

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("143SupJianAtk");

	public const int additionalAttrId_P30 = 14330001;

	public const int additionalAttrId_OnlyOne_P30 = 14330002;

	public const int perkId_31 = 514331;

	public static readonly int damageTag_Trigger_P31 = CommonHelper.StringToHash("143SupSkillAllAtk");

	public const int additionalAttrId_P31 = 14331001;

	public const int perkId_32 = 514332;

	public const int parameterId_TriggerProbability_P32 = 14332011;

	public const string areaEffectKey_P32 = "AreaEffect_143_P32_LongJuanFeng";

	public const int parameterId_TriggerCoolDown_P32 = 14332012;

	public const int perkId_33 = 514333;

	public const int buffId_P33 = 14333011;
}
