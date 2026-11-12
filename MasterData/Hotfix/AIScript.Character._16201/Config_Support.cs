using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._16201;

public class Config_Support
{
	public const string comboTag_Rapier_Skill = "Skill_Sup";

	public const int loopTimes_Rapier_Skill = 4;

	public const string eventName_SearchTarget_Skill = "162SuoDi";

	public const int perkId_21 = 516221;

	public const string eventName_GenerateAreaEffect_P21 = "P21";

	public const string areaEffectKey_P21 = "AreaEffect_162_LeiDianArea_P21";

	public static readonly TSVector2 generateOffset_P21 = new TSVector2(0, 1);

	public const int perkId_22 = 516222;

	public const string eventName_GenerateAreaEffect_P22 = "162P22ZhongJianFall";

	public const string areaEffectKey_P22 = "AreaEffect_162_LeiDianZhongJian_Fall_P22";

	public static readonly List<TSVector2> generateOffsetList_P22 = new List<TSVector2>
	{
		new TSVector2(2.5, 0),
		new TSVector2(1.25, 2.16),
		new TSVector2(-1.25, 2.16),
		new TSVector2(-2.5, 0),
		new TSVector2(-1.25, -2.16),
		new TSVector2(1.25, -2.16)
	};

	public const int perkId_23 = 516223;

	public const string eventName_TriggerSwordAura_P23 = "162P23JianQi";

	public const int hitDamageId_P23 = 162320005;

	public const int perkId_24 = 516224;

	public const int parameterId_P24 = 16224011;

	public const int perkId_25 = 516225;

	public const string areaEffectKey_P22_P25 = "AreaEffect_162_LeiDianZhongJian_Fall_P22P25";

	public const int buffId_P25 = 16225011;

	public const int perkId_26 = 516226;

	public const string eventName_Trigger_P26 = "162P26UltraZhong";

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("Qing");

	public const int buffId_P26 = 16226011;

	public const int perkId_27 = 516227;

	public static readonly int damageTag_Trigger_P27 = CommonHelper.StringToHash("Zhong");

	public const int additionalAttrId_P27 = 16227001;

	public const int perkId_28 = 516228;

	public const int parameterId_P28 = 16228011;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("Qing");

	public const int additionalAttrId_P28 = 16228001;

	public const int perkId_29 = 516229;

	public const string eventName_Trigger_P29 = "162P29UltraQing";

	public static readonly int damageTag_Trigger_P29 = CommonHelper.StringToHash("Zhong");

	public const int buffId_P29 = 16229011;

	public const int perkId_30 = 516230;

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("Qing");

	public const int additionalAttrId_P30 = 16230001;

	public const int perkId_31 = 516231;

	public const int buffId_P31 = 16231011;

	public const int perkId_32 = 516232;

	public const int buffId_P32 = 16232011;

	public const int perkId_33 = 516233;

	public const int buffId_P33 = 16233011;
}
