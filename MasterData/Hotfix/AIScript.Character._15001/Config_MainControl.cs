using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15001;

public class Config_MainControl
{
	public const string comboTag_Skill_Sweep = "150_Main_Skill_A1";

	public const string comboTag_Skill_Laser = "150_Main_Skill_B1";

	public const int perkId_1 = 515001;

	public const string eventName_GenerateAreaEffect_P1 = "ElectricGrid_Start";

	public const string areaEffectKey_P1 = "AreaEffect_150_Main_Skill_P01_ElectricGrid";

	public const int perkId_2 = 515002;

	public static readonly int damageTag_TriggerThunder_P2 = CommonHelper.StringToHash("150_P02_DoT_Trigger");

	public const int buffId_Thunder_P2 = 15002011;

	public static readonly int damageTag_TriggerDamage_P2 = CommonHelper.StringToHash("150_P02_Hurt_Trigger");

	public const int hitDamageId_P2 = 150310201;

	public const string hittedFxKey_P2 = "fx_15001_Hit_Electric";

	public const int buffId_Electricity_P2 = 15002012;

	public const int maxBuffCount_Electricity_P2 = 20;

	public const string areaEffectKey_Normal_P2 = "AreaEffect_150_Main_Skill_P02_Boom_Small";

	public const string areaEffectKey_Strength_P2 = "AreaEffect_150_Main_Skill_P02_Boom_Big";

	public const int perkId_3 = 515003;

	public static readonly List<string> comboTagList_Skill_Sweep_P3 = new List<string> { "150_Main_Skill_A1", "150_Main_Skill_A2", "150_Main_Skill_A3" };

	public static readonly List<string> comboTagList_Skill_Laser_P3 = new List<string> { "150_Main_Skill_B1", "150_Main_Skill_B2", "150_Main_Skill_B3" };

	public const int perkId_4 = 515004;

	public const int buffId_P4 = 15004011;

	public const int maxBuffCount_P4 = 3;

	public const string comboTag_Skill_Laser_P4 = "150_Main_Skill_2_C1";

	public static readonly List<string> comboTagList_Skill_Laser_P3_P4 = new List<string> { "150_Main_Skill_2_C1", "150_Main_Skill_2_C2", "150_Main_Skill_2_C3" };

	public static readonly FP rotateSpeed_P4 = 90;

	public static readonly FP laserLoopTime_MaxBuff_P4 = 4;

	public const int buffId_LaserLoop_P4 = 15004012;

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("150_P04");

	public const int additionalAttrId_P4 = 15004011;

	public const int perkId_5 = 515005;

	public const int buffId_P5 = 15005011;

	public const int perkId_6 = 515006;

	public const string comboTag_Skill_Sweep_P6 = "150_Main_Skill_P06_A1";

	public static readonly List<string> comboTagList_Skill_Sweep_P3_P6 = new List<string> { "150_Main_Skill_P06_A1", "150_Main_Skill_P06_A2", "150_Main_Skill_P06_A3" };

	public const int perkId_7 = 515007;

	public static readonly int damageTag_Trigger_P7 = CommonHelper.StringToHash("150_P07");

	public const int buffId_P7 = 15007011;

	public const int additionalAttrId_P7 = 15007001;

	public const int perkId_8 = 515008;

	public static readonly int damageTag_TriggerBuff_P8 = CommonHelper.StringToHash("150_Attack");

	public const int buffId_P8 = 15008011;

	public static readonly int damageTag_TriggerStrength_P8 = CommonHelper.StringToHash("150_Skill");

	public const int additionalAttrId_P8 = 15008001;

	public const int perkId_9 = 515009;

	public static readonly int damageTag_Trigger_P9 = CommonHelper.StringToHash("150_P09");

	public const int hitdamageId_P9 = 150310901;

	public const string attackdFx_P9 = "fx_15001_bullet_Main_Skill_P09_LightningChain";

	public static readonly FP searchRadius_P9 = 6;

	public const int maxLinkCount_P9 = 4;

	public static readonly FP firstHitDelay_P9 = 0.5;

	public static readonly FP linkInterval_P9 = 0.2;

	public const int triggerUnitTime_P9 = 1;

	public const int maxTriggerCountUnitTime_P9 = 3;

	public const int perkId_10 = 515010;

	public static readonly int damageTag_TriggerBuff_P10 = CommonHelper.StringToHash("150_P10_1");

	public const int buffId_P10 = 15010011;

	public static readonly int damageTag_TriggerStrength_P10 = CommonHelper.StringToHash("150_P10_2");

	public const int additionalAttrId_P10 = 15010001;

	public const int perkId_11 = 515011;

	public const string chargeFxKey_P11 = "fx_15001_loop_Rush_P11_Charge";

	public static readonly FP chargeTime_P11 = 2;

	public const string chargeFinishFxKey_P11 = "fx_15001_loop_Rush_P11_Charge_end";

	public const string areaEffectKey_P11 = "AreaEffect_150_Main_Skill_P11_Boom";

	public const int parameterId_P11 = 15011011;

	public const int perkId_12 = 515012;

	public static readonly int damageTag_Trigger_P12 = CommonHelper.StringToHash("150_Skill");

	public const int buffId_P12 = 15012011;

	public const int perkId_13 = 515013;

	public const int buffId_P13 = 15013011;

	public const string logicTag_AdditionalAttrCount_P4 = "AdditionalAttrCount_P4";

	public const string logicTag_AdditionalAttrCount_P8 = "AdditionalAttrCount_P8";

	public const string logicTag_LastTriggerTime_P11 = "LastTriggerTime_P11";
}
