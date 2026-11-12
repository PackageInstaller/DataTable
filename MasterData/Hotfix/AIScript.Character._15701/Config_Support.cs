using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15701;

public class Config_Support
{
	public const string comboTag_Skill = "Skill_Sup";

	public static readonly Dictionary<string, (TSVector2 offsetPosition, FP offsetAngle)> shootInfoDic_Skill = new Dictionary<string, (TSVector2, FP)>
	{
		["157SkillSupHuiWu1"] = (new TSVector2(-5, 3), 90),
		["157SkillSupHuiWu2"] = (new TSVector2(5, 4), -90),
		["157SkillSupHuiWu3"] = (new TSVector2(-3, -3), 20),
		["157SkillSupHuiWu4"] = (new TSVector2(3, -2.5), -20)
	};

	public static readonly Dictionary<string, string> playFxInfoDic_Skill = new Dictionary<string, string>
	{
		["BaseHuiWu11"] = "fx_15701_base_Skill_Sup_Line_1",
		["BaseHuiWu21"] = "fx_15701_base_Skill_Sup_Line_2",
		["BaseHuiWu31"] = "fx_15701_base_Skill_Sup_Line_3",
		["BaseHuiWu41"] = "fx_15701_base_Skill_Sup_Line_4",
		["BaseHuiWu22"] = "fx_15701_base_Skill_Sup_Line_2_P23_2",
		["BaseHuiWu32"] = "fx_15701_base_Skill_Sup_Line_3_P23_2",
		["BaseHuiWu33"] = "fx_15701_base_Skill_Sup_Line_3_P23_3",
		["BaseHuiWu42"] = "fx_15701_base_Skill_Sup_Line_4_P23_2",
		["BaseHuiWu43"] = "fx_15701_base_Skill_Sup_Line_4_P23_3",
		["BaseHuiWu44"] = "fx_15701_base_Skill_Sup_Line_4_P23_4"
	};

	public static readonly FP shootPositionY_Skill = 0;

	public const string bulletKey_Skill = "Bullet_157_Skill_Sup_Fish1";

	public const string eventName_SearchAndLookAtTarget_Skill = "157SkillSupReSuoDi";

	public const int perkId_21 = 515721;

	public const string bulletKey_Skill_P21 = "Bullet_157_Skill_Sup_P21_Fish1";

	public const int perkId_22 = 515722;

	public static readonly int damageTag_Trigger_P22 = CommonHelper.StringToHash("157SkillSupFishAtk");

	public const int buffId_P22 = 15721011;

	public const int hitDamageId_P22 = 157300014;

	public const string hittedFx_P22 = "fx_15701_hit_ToothBoom";

	public const int perkId_23 = 515723;

	public const string comboTag_Skill_P23 = "Skill_Sup_P23";

	public const int perkId_24 = 515724;

	public static readonly int damageTag_Trigger_P24 = CommonHelper.StringToHash("157SkillSupHuiWu");

	public const string areaEffectKey_P24 = "AreaEffect_157_P24_Boom";

	public const int maxTriggerTimes_P24 = 4;

	public const string eventName_ResetTriggerTimes_P24 = "157RestartP24";

	public const int perkId_25 = 515725;

	public const string bulletKey_Skill_P25 = "Bullet_157_Skill_Sup_Fish1_P25";

	public const string bulletKey_Skill_P21_P25 = "Bullet_157_Skill_Sup_P21_Fish1_P25";

	public static readonly int damageTag_Trigger_P25 = CommonHelper.StringToHash("157FishAtk");

	public const int additionalAttrId_P25 = 15725001;

	public const int perkId_26 = 515726;

	public static readonly int damageTag_Trigger_P26 = CommonHelper.StringToHash("157FishAtk");

	public const int buffId_P26 = 15726011;

	public const int perkId_27 = 515727;

	public static readonly int damageTag_Trigger_P27 = CommonHelper.StringToHash("157FishAtk");

	public const int additionalAttrId_P27 = 15727001;

	public const int perkId_28 = 515728;

	public static readonly int damageTag_Trigger_P28 = CommonHelper.StringToHash("157HuiWu");

	public const int buffId_P28 = 15728011;

	public const int additionalAttrId_P28 = 15728001;

	public const int perkId_29 = 515729;

	public static readonly int damageTag_Trigger_P29 = CommonHelper.StringToHash("157HuiWu");

	public const int additionalAttrId_P29 = 15729001;

	public const int perkId_30 = 515730;

	public const int buffId_P30 = 15730011;

	public const int perkId_31 = 515731;

	public const int buffId_P31 = 15731011;

	public const int perkId_32 = 515732;

	public const int buffId_P32 = 15732011;

	public const int perkId_33 = 515733;

	public const int buffId_P33 = 15733011;
}
