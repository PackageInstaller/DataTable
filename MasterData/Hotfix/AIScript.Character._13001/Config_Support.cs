using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13001;

public class Config_Support
{
	public const string comboTag_Skill = "B2_Skill";

	public const string eventName_Skill = "StartIceRain";

	public const string areaEffectPath_Skill = "AreaEffect_130_Support_Skill_P22_IceRain";

	public const int areaEffectCount_Skill = 20;

	public static readonly TSVector2 startAreaEffectOffset_Skill = new TSVector2(0, 0);

	public static readonly FP generateInterval_Skill = 0.05;

	public static readonly FP areaEffectDistance_Skill = 1.5;

	public const int perkId_21 = 513021;

	public const string comboTag_Skill_OneWE_P21 = "B2P21_Skill_2";

	public const string comboTag_Skill_TwoWE_P21 = "B2P21_Skill_3";

	public const int perkId_22 = 513022;

	public static readonly int damageTag_AddArrow_P22 = CommonHelper.StringToHash("130_P22_2");

	public const int buffId_Arrow_P22 = 13022011;

	public const int buffId_ArrowFx_P22 = 13022012;

	public static readonly List<int> arrowFxBuffLimitList_P22 = new List<int> { 10, 20, 30 };

	public const int hitDamageId_Attach_P22 = 130522002;

	public static readonly int damageTag_Attach_P22 = CommonHelper.StringToHash("130_P22");

	public const int additionalAttrId_Attach_P22 = 13022011;

	public const int hitDamageId_Remove_P22 = 130522001;

	public const string hittedFxPath_Remove_P22 = "fx_13001_loop_B2_Skill_Perk29_Hurt";

	public static readonly int damageTag_Remove_P22 = CommonHelper.StringToHash("130_P22");

	public const int additionalAttrId_Remove_P22 = 13022011;

	public const int perkId_23 = 513023;

	public const string comboTag_Skill_P23 = "B2P23_Skill";

	public const string comboTag_Skill_AllWe_P23 = "B2P23_Skill_3";

	public const string comboTag_Skill_OneWE_P21_P23 = "B2P21P23_Skill_2";

	public const string comboTag_Skill_TwoWE_P21_P23 = "B2P21P23_Skill_3";

	public static readonly int damageTag_Trigger_P23 = CommonHelper.StringToHash("130_B2_Water");

	public const int additionalAttrId_P23 = 13023011;

	public const int perkId_24 = 513024;

	public const string eventName_Shoot_P24 = "B2P24_Shoot";

	public static readonly List<string> bulletKeyList_P24 = new List<string> { "Bullet_130_B2P30_Attack_1", "Bullet_130_B2P30_Attack_2", "Bullet_130_B2P30_Attack_3" };

	public static readonly List<string> bulletKeyList_P23_P24 = new List<string> { "Bullet_130_B2P30_Attack_1_Big", "Bullet_130_B2P30_Attack_2_Big", "Bullet_130_B2P30_Attack_3_Big" };

	public static readonly FP searchRadius_P24 = 10;

	public static readonly TSVector shootOffset_P24 = new TSVector(0, 1.5, 1);

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("130_B2_Water");

	public const int additionalAttrId_P24 = 13024011;

	public const int perkId_25 = 513025;

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("130_B2_Penetrate");

	public const int buffId_1_P25 = 13025011;

	public const int buffId_2_P25 = 13025012;

	public const int buffId_3_P25 = 13025013;

	public const string triggerFxPath_P25 = "fx_13001_base_B2_Skill_Perk_25_atk";

	public static readonly FP hitDelay_P25 = 0.2;

	public const int hitDamageId_P25 = 130525001;

	public const string hitteFxPath_P25 = "fx_13001_hit_Water";

	public const int additionalAttrId_P25 = 13025001;

	public const int perkId_26 = 513026;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("130_B2_Penetrate");

	public const int triggerDamageCount_P26 = 3;

	public const int buffId_P26 = 13026011;

	public const int perkId_27 = 513027;

	public static readonly int damageTag_Trigger_P27 = CommonHelper.StringToHash("130_B2_Penetrate");

	public const int parameterId_P27 = 13027011;

	public const int additionalAttrId_P27 = 13027001;

	public const int perkId_28 = 513028;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("130_B2_Water");

	public const int additionalAttrId_P28 = 13028001;

	public const int buffId_P28 = 13028011;

	public const int perkId_29 = 513029;

	public static readonly int damageTag_Trigger_P29 = CommonHelper.StringToHash("130_B2_Water");

	public const int buffId_P29 = 13029012;

	public const int perkId_30 = 513030;

	public const string comboTag_Skill_P30 = "B2P30_Skill";

	public const string comboTag_Skill_OneWE_P21_P30 = "B2P30P21_Skill_2";

	public const string comboTag_Skill_TwoWE_P21_P30 = "B2P30P21_Skill_3";

	public const string comboTag_Skill_P23_P30 = "B2P30P23_Skill";

	public const string comboTag_Skill_AllWe_P23_P30 = "B2P30p23_Skill_3";

	public const string comboTag_Skill_OneWE_P21_P23_P30 = "B2p30P21P23_Skill_2";

	public const string comboTag_Skill_TwoWE_P21_P23_P30 = "B2p30P21P23_Skill_3";

	public static readonly int damageTag_Trigger_P30 = CommonHelper.StringToHash("130_B2_Water");

	public const int additionalAttrId_P30 = 13030001;

	public const int perkId_31 = 513031;

	public const string dropItemPath_P30 = "Item_130_B2P24_Letter";

	public const int buffId_P30 = 13031011;

	public const int perkId_32 = 513032;

	public static readonly int damageTag_Trigger_P32 = CommonHelper.StringToHash("130_Ultra");

	public const int buffId_Trigger_P32 = 4011;

	public static readonly int checkAreaEffectTag_P32 = CommonHelper.StringToHash("130_Ultra_Area");

	public const int buffId_Self_P32 = 13032011;

	public const int perkId_33 = 513033;

	public const int buffId_P33 = 13033011;
}
