using TrueSync;

namespace AIScript.Character._13401;

public class Config_Support
{
	public const string comboTag_Skill_Rush = "134_Support_Rush";

	public const string comboTag_Skill_Attack = "134_Support_Hurt";

	public static readonly FP speed_Skill_Dash = 30;

	public static readonly FP maxDistance_Skill_Dash = 8;

	public static readonly FP reduceDistance_Skill_Dash_HaveTarget = 2;

	public const string eventName_Skill_Hit = "134_Support_Hit";

	public static readonly int damageTag_Skill = CommonHelper.StringToHash("134_Support_Hurt");

	public static readonly int damageTag_Skill_Rush = CommonHelper.StringToHash("134_Support_RushTag");

	public static readonly int damageTag_Skill_Attack = CommonHelper.StringToHash("134_Support_HurtTag");

	public static readonly int areaEffectTag_Skill = CommonHelper.StringToHash("134_Support_Skill_Area");

	public const int perkId_21 = 513421;

	public const string comboTag_Skill_Attack_P21 = "134_Support_Hurt_P21";

	public const string comboTag_Skill_Attack_P21_P23 = "134_Support_Hurt_P21P23";

	public const int perkId_22 = 513422;

	public const string comboTag_Skill_End_P22 = "134_Support_End_P22";

	public const int perkId_23 = 513423;

	public const string comboTag_Skill_Attack_P23 = "134_Support_Hurt_P23";

	public const int additionalAttrId_P23 = 13423011;

	public const int perkId_24 = 513424;

	public const string comboTag_Skill_Attack_P24 = "134_Support_Hurt_P24";

	public const string comboTag_Skill_Attack_P23_P24 = "134_Support_Hurt_P24P23";

	public const int additionalAttrId_P24 = 13424011;

	public static readonly FP addAdditionalAttrInterval_P24 = 0.5;

	public static readonly FP addAdditionalAttrInterval_P24_P30 = 0.5;

	public const int perkId_25 = 513425;

	public const int buffId_P25 = 13425011;

	public static readonly FP addBuffDelay_P25 = 0;

	public const int perkId_26 = 513426;

	public const string comboTag_Skill_Rush_P26 = "134_Support_Rush_P26";

	public const string comboTag_Skill_Rush_P23_P26 = "134_Support_Rush_P26P23";

	public const int perkId_27 = 513427;

	public const int buffId_P27 = 13427011;

	public static readonly FP addBuffInterval_P27 = 1;

	public const int perkId_28 = 513428;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("134_P28");

	public const int hitDamageId_P28 = 134528001;

	public const string hittedFxPath_P28 = "fx_13401_hit_Normal";

	public const int perkId_29 = 513429;

	public const int buffId_P29 = 13429011;

	public static readonly FP addBuffInterval_P29 = 1;

	public const int perkId_30 = 513430;

	public const string comboTag_Skill_Attack_P30 = "134_Support_Hurt_P30";

	public const string comboTag_Skill_Attack_P23_P30 = "134_Support_Hurt_P23P30";

	public const string comboTag_Skill_Attack_P24_P30 = "134_Support_Hurt_P24P30";

	public const string comboTag_Skill_Attack_P23_P24_P30 = "134_Support_Hurt_P24P30P23";

	public const int additionalAttrId_P30 = 13430001;

	public const int perkId_31 = 513431;

	public const int additionalAttrId_P31 = 13431001;

	public const int perkId_32 = 513432;

	public const int buffId_P32 = 13432011;

	public const int perkId_33 = 513433;

	public const int buffId_P33 = 13433011;
}
