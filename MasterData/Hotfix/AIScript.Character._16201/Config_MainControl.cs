using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._16201;

public class Config_MainControl
{
	public const string areaEffectKey_LightingSword = "AreaEffect_162_LeiDianZhongJian_Fall_Skil_Main";

	public static readonly int areaEffectTag_LightingSword_Last = CommonHelper.StringToHash("AreaEffect_162_LeiDianZhongJian_Hold");

	public const int skillId_Skill = 16231000;

	public const string comboTag_Rapier_Skill = "Skill_Main1";

	public const string comboTag_Claymore_Skill = "Skill_Main2";

	public const string eventName_GenerateLightingSword_Skill = "162SkilMainZhongJianFall";

	public static readonly FP randomRadius_GenerateLightingSword_Skill = 3;

	public static readonly FP offsetDistance_GenerateLightingSword_Skill = 4;

	public const int perkId_1 = 516201;

	public const string comboTag_Rapier_Skill_P1 = "Skill_Main1_P1";

	public const int parameterId_P1 = 16201011;

	public const string eventName_TriggerSwordAura_P1 = "162SkillMainJianQi";

	public const int hitDamageId_P1 = 162310005;

	public const int perkId_2 = 516202;

	public const int buffId_P2 = 16202011;

	public const int parameterId_P2 = 16202011;

	public const int skillId_Skill_P2 = 16231002;

	public const string comboTag_Skill_P2 = "Skill_Main_SuperQing";

	public const string eventName_Skill_EnableInvincible_P2 = "162wudistart";

	public const string eventName_Skill_DisableInvincible_P2 = "162wudiend";

	public const string eventName_TriggerSwordAura_P2 = "162P2";

	public const int hitDamageId_P2 = 162310009;

	public const int perkId_3 = 516203;

	public const int parameterId_P3 = 16203011;

	public const string comboTag_Dash_NormalAttack_P3 = "162AtkDashZhong";

	public const string eventName_GenerateLightingSword_P3 = "162P3";

	public const int perkId_4 = 516204;

	public const string fxKey_P4 = "fx_16201_bullet_ZhongJianLoop_XiShou";

	public static readonly FP fxMoveDuration_P4 = 0.3;

	public const int buffId_P4 = 16204011;

	public const string comboTag_NormalAttack_P4 = "Skill_Main_SuperZhong";

	public static readonly List<string> comboTagList_NormalAttack_P4 = new List<string> { "162Atk1_P3", "162Atk2_P3", "162Atk3_P3", "162Atk4" };

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("162NrmAtkZhong");

	public const int additionalAttrId_P4 = 16204011;

	public const int perkId_5 = 516205;

	public static readonly Dictionary<string, string> backBulletKeyDic_SwordAura_P5 = new Dictionary<string, string>
	{
		["Bullet_162_JianQi_Big"] = "Bullet_162_JianQi_Back_Big",
		["Bullet_162_JianQi_Heng"] = "Bullet_162_JianQi_Back_Heng",
		["Bullet_162_JianQi_Shu"] = "Bullet_162_JianQi_Back_Shu",
		["Bullet_162_JianQi_You"] = "Bullet_162_JianQi_Back_You",
		["Bullet_162_JianQi_Zuo"] = "Bullet_162_JianQi_Back_Zuo"
	};

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("QingAndQi");

	public const int additionalAttrId_P5 = 16205001;

	public const int perkId_6 = 516206;

	public static readonly int damageTag_Trigger_P6 = CommonHelper.StringToHash("QingAndQi");

	public const int additionalAttrId_P6 = 16206001;

	public const int perkId_7 = 516207;

	public static readonly int damageTag_Trigger_P7 = CommonHelper.StringToHash("JianQi");

	public const int parameterId_P7 = 16207011;

	public const int buffId_ForSelf_P7 = 16207011;

	public const int buffId_ForTeammate_P7 = 16207012;

	public const int perkId_8 = 516208;

	public const string eventName_GenerateAreaEffect_P8 = "162P8LeiDianArea";

	public const string areaEffectKey_P8 = "AreaEffect_162_LeiDianArea_P8";

	public static readonly TSVector2 generateOffset_P8 = new TSVector2(0, 4);

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("Zhong");

	public const int additionalAttrId_P8 = 16208001;

	public const int perkId_9 = 516209;

	public const string lightingBulletKey_P9 = "Bullet_162_P9_LeiDian";

	public static readonly FP shootPositionY_P9 = 0;

	public const int buffId_P9 = 16209011;

	public const int perkId_10 = 516210;

	public static readonly int damageTag_Trigger_P10 = CommonHelper.StringToHash("Zhong");

	public const int additionalAttrId_P10 = 16210001;

	public const int perkId_11 = 516211;

	public const int additionalAttrId_P11 = 16211001;

	public const int perkId_12 = 516212;

	public const int buffId_P12 = 16212011;

	public static readonly int eventHashCode_TriggerLightingSword = CommonHelper.StringToHash("TriggerLightingSword");

	public const string logicTag_CanBindExtraSkill_P2 = "CanBindExtraSkill_P2";
}
