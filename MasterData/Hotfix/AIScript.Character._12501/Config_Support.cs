using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._12501;

public class Config_Support
{
	public static readonly FP distance_ForceTrace = 16;

	public static readonly FP distance_StopTrace_ForPlayer = 4;

	public static readonly FP randomRadius_Teleport = 2;

	public const string comboTag_Skill_Normal = "B2_Skill";

	public const string comboTag_Skill_Berserk = "B2_Skill_Rage";

	public const string eventName_BeginGenIceFlower = "Start_Hurt";

	public const int count_IceFlowerLine = 3;

	public static readonly Dictionary<int, FP> includedAngleDic_IceFlowerLine = new Dictionary<int, FP>
	{
		[2] = 22.5,
		[3] = 22.5
	};

	public const string fxKey_IceFlowerLine = "fx_12501_base_B1_Skill_IceFlower_Trail_Rage";

	public static readonly FP offset_FirstIceFlower = 1;

	public const int totalFlowerCount_IceFlowerLine = 6;

	public static readonly FP distance_BetweenTwoFlower = 4;

	public const int intervalFrame_GenerateIceFlower = 3;

	public const int holdFrame_AllIceFlower = 15;

	public const string fxKey_IceFlower = "fx_12501_loop_B1_Skill_IceFlower";

	public const int hitDamageId_IceFlower_Blossom = 125320001;

	public const int hitDamageId_IceFlower_Explosion = 125320002;

	public const int durationFrame_IceFlower_Explosion = 30;

	public const int delayFrame_IceFlower_Explosion = 4;

	public static readonly FP hitRaidus_IceFlower_Blossom = 2;

	public static readonly FP hitRaidus_IceFlower_Explosion = 3;

	public static readonly HitBox.HitBoxFeatureData hitBoxFeatureData_IceFlower = new HitBox.HitBoxFeatureData
	{
		StiffDuration = 1,
		buffIdsForTarget = new List<int> { 4011 },
		hitStrenth = 4
	};

	public const string fxKey_IceFlower_Hitted = "fx_12501_hit_Ice";

	public const int perkId_21 = 512521;

	public const string fxKey_IceFlower_P21 = "fx_12501_loop_B1_Skill_IceFlower_Rage";

	public static readonly FP hitRaidus_IceFlower_Blossom_P21 = 2.5;

	public static readonly FP hitRaidus_IceFlower_Explosion_P21 = 4.5;

	public static readonly int damageTag_P21 = CommonHelper.StringToHash("125_Support_Damage");

	public const int additionalAttrId_P21 = 12521011;

	public const int perkId_22 = 512522;

	public const string fxKey_IceFlowerLine_P22 = "fx_12501_base_B1_Skill_IceFlower_Trail_Rage";

	public const int totalFlowerCount_IceFlowerLine_P22 = 8;

	public static readonly FP distance_BetweenTwoFlower_P22 = 3;

	public static readonly int damageTag_P22 = CommonHelper.StringToHash("125_Support_Damage");

	public const int additionalAttrId_P22 = 12522011;

	public const int perkId_23 = 512523;

	public const int buffId_P23 = 12523011;

	public static readonly int damageTag_Trigger_P23 = CommonHelper.StringToHash("125_P23");

	public static readonly FP triggerRate_P23 = 30;

	public const int hitDamageId_IceFlower_Blossom_P23 = 125322301;

	public const int hitDamageId_IceFlower_Explosion_P23 = 125322302;

	public static readonly FP delayGenerateTime_IceFlower_P23 = 0.2;

	public const int delayExplosionFrame_IceFlower_P23 = 30;

	public const int perkId_24 = 512524;

	public const string areaEffectKey_P24 = "AreaEffect_125_Main_P24_IceAOE";

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("125_P24");

	public static readonly FP triggerCD_P24 = 1;

	public const int perkId_25 = 512525;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("125_Support_Damage");

	public const int buffId_P25 = 12525001;

	public const int perkId_26 = 512526;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("125_Support_Damage");

	public const int buffId_P26 = 12526011;

	public static readonly int damageTag_P26 = CommonHelper.StringToHash("125_Support_Damage");

	public const int additionalAttrId_P26 = 12526001;

	public const int perkId_27 = 512527;

	public const string areaEffectKey_P27 = "AreaEffect_125_Main_P27_IceFlower";

	public const string areaEffectKey_P21_P27 = "AreaEffect_125_Main_P27P21_IceFlower_Large";

	public const int perkId_28 = 512528;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("125_NormalAttack_Rage");

	public static readonly FP triggerCD_P28 = 1;

	public const int buffId_P28 = 12528011;

	public const int perkId_29 = 512529;

	public static readonly FP addBuffInterval_P29 = 1;

	public const int buffId_P29 = 12529011;

	public const int perkId_30 = 512530;

	public const int parameterId_P30 = 12530011;

	public const int buffId_P30 = 12530011;

	public const int perkId_31 = 512531;

	public const int buffId_P31 = 12531011;

	public const int perkId_32 = 512532;

	public static readonly int damageTag_Trigger_P32 = CommonHelper.StringToHash("125_Ultra");

	public const int additionalAttrId_P32 = 12532001;

	public const int buffId_P32 = 4011;

	public const int perkId_33 = 512533;

	public const int parameterId_P33 = 12533001;

	public const int buffId_P33 = 12533011;

	public static readonly int eventHashCode_BeginGenIceFlower = CommonHelper.StringToHash("Start_Hurt");

	public static readonly FP interval_CheckTrace = 0.5;
}
