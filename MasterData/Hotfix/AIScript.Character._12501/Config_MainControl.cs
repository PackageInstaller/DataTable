using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._12501;

public class Config_MainControl
{
	public const string comboTag_Skill_Charge_Start = "125_Main_Charge_Start";

	public const string comboTag_Skill_Charge_Idle_Loop = "125_Main_Charge_Idle_Loop";

	public const string comboTag_Skill_Charge_Run_Loop = "125_Main_Charge_Run_Loop";

	public const string comboTag_Skill_Attack = "125_Main_Skill_WhirlWind";

	public const int buffId_ChangeMoveSpeed_Skill_Charge = 12593001;

	public const int minLoopTimes_Skill_Attack = 2;

	public const int chargeAddLoopTimes_Skill = 2;

	public static readonly FP chargeInterval_Skill = 0.5;

	public static readonly Dictionary<int, string> chargeFxKeyDic_Skill = new Dictionary<int, string>
	{
		[1] = "fx_12501_loop_Main_SKill_Charge_2_Loop_Level1",
		[2] = "fx_12501_loop_Main_SKill_Charge_2_Loop_Level2"
	};

	public const int maxLoopTimes_Skill_Attack = 6;

	public static readonly FP singleLoopTime_Skill_Attack = 0.53;

	public static readonly FP holdButtonTime_AutoBattle_Skill = 1.5;

	public const int perkId_1 = 512501;

	public const string eventName_PlayAreaEffect_P1 = "Add_IceFog";

	public const string areaEffectKey_P1 = "AreaEffect_125_B2P22_IceFog";

	public const int perkId_2 = 512502;

	public const string comboTag_Skill_Attack_P2 = "125_Main_Skill_P02_WhirlWind";

	public static readonly int damageTag_Trigger_P2 = CommonHelper.StringToHash("125_P02");

	public static readonly FP reduceCd_P2 = 2;

	public static readonly FP maxReduceCd_P2 = 6;

	public const int perkId_3 = 512503;

	public const int minLoopTimes_Skill_Attack_P3 = 4;

	public const int chargeAddLoopTimes_Skill_P3 = 4;

	public const int maxLoopTimes_Skill_Attack_P3 = 12;

	public static readonly int damageTag_P3 = CommonHelper.StringToHash("125_Main_Skill_Damage");

	public const int additionalAttrId_P3 = 12503011;

	public const int perkId_4 = 512504;

	public const string comboTag_Skill_Attack_P4 = "125_Main_Skill_P04_WhirlWind";

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("125_Main_Skill_Damage");

	public static readonly int damageTag_P4 = CommonHelper.StringToHash("125_Main_Skill_Damage");

	public const int additionalAttrId_P4 = 12504011;

	public const int parameterId_P4 = 12504011;

	public const string comboTag_Skill_Attack_P2_P4 = "125_Main_Skill_P02P04_WhirlWind";

	public const int perkId_5 = 512505;

	public const int buffId_P5 = 12505001;

	public const int perkId_6 = 512506;

	public const int buffId_P6 = 12506011;

	public static readonly int damageTag_A_P6 = CommonHelper.StringToHash("125_Ultra");

	public const int additionalAttrId_DamageA_P6 = 12506001;

	public static readonly int damageTag_B_P6 = CommonHelper.StringToHash("125_NormalAttack_Rage");

	public const int additionalAttrId_DamageB_P6 = 12506002;

	public const int perkId_7 = 512507;

	public const int buffId_P7 = 12507011;

	public const int perkId_8 = 512508;

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("125_Main_Skill_Damage");

	public const int parameterId_P8_1 = 12508011;

	public const int additionalAttrId_P8 = 12508001;

	public const int perkId_9 = 512509;

	public const int loopTimes_Trigger_P9 = 2;

	public const string areaEffectKey_P9 = "AreaEffect_125_Main_P09_Axe";

	public const string areaEffectKey_P4_P9 = "AreaEffect_125_Main_P04P09_Axe";

	public const int perkId_10 = 512510;

	public static readonly FP increaseInterval_P10 = 1;

	public static readonly int damageTag_P10 = CommonHelper.StringToHash("125_Main_Skill_Damage");

	public const int additionalAttrId_P10 = 12510001;

	public const int parameterId_P10 = 12510011;

	public const int perkId_11 = 512511;

	public const int parameterId_AddBuffCount_P11 = 12511001;

	public const int parameterId__MaxTimes_P11 = 12511002;

	public const int perkId_12 = 512512;

	public static readonly int damageTag_TriggerWaterCorrosion_P12 = CommonHelper.StringToHash("125_Ultra");

	public const int buffId_P12 = 12512011;

	public const int perkId_13 = 512513;

	public const int skillId_Dodge_P13 = 12520002;

	public const int parameterId_AddEnergy_P13 = 12513001;

	public const int parameterId_TriggerCD_P13 = 12513012;
}
