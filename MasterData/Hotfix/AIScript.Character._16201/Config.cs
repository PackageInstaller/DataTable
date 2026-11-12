using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._16201;

public class Config
{
	public static readonly int damageTag_TriggerLightMark = CommonHelper.StringToHash("162LightMarkTrigger");

	public const string areaEffectKey_LightMark = "AreaEffect_162_LightTrigger_Boom";

	public const string tipsKey_TriggerMark = "LightMark_Trigger_Effect_01";

	public static readonly int damageTag_AddGlimmer_LightMark = CommonHelper.StringToHash("162TriggerAtk");

	public static readonly int buffTag_Glimmer_LightMark = CommonHelper.StringToHash("LightMarkBlink");

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "162Atk1", "162Atk2", "162Atk3", "162Atk4" };

	public const string comboTag_Dash_NormalAttack = "162AtkDashQing";

	public static readonly FP holdTime_NormalAttackStage = 2;

	public static readonly FP useDistance_Dash_NormalAttack = 2.8;

	public static readonly FP triggerCD_Dash_NormalAttack = 1.5;

	public const string eventName_TriggerSwordAura_NormalAttack = "162NrmAtkJianQI";

	public const int hitDamageId_SwordAura_NormalAttack = 162100004;

	public static readonly int damageTag_Trigger_NormalAttack = CommonHelper.StringToHash("162NrmAtk");

	public const int additionalAttrId_NormalAttack = 16290001;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.3f;

	public static readonly FP distance_Dodge = 0.01f;

	public static readonly int transitionRushSkillId = 0;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime_Rush = 1f;

	public const int buffId_Claymore_UltraSkill = 16290001;

	public const string comboTag_Claymore_UltraSkill_Timeline = "Ultra_Zhong";

	public const string comboTag_Claymore_UltraSkill_NoTimeline = "Ultra_Zhong";

	public const int buffId_Rapier_UltraSkill = 16290002;

	public const string comboTag_Rapier_UltraSkill_Timeline = "Ultra_Qing";

	public const string comboTag_Rapier_UltraSkill_NoTimeline = "Ultra_Qing";

	public const int replaceIconIndex_Rapier_UltraSkill = 1;

	public const int buffId_Burst_UltraSkill = 16290003;

	public static readonly int buffTag_Burst_UltraSkill = CommonHelper.StringToHash("162UltarBuffPower");

	public static readonly Dictionary<string, string> fxKeyDic_MainControl_UltraSkill = new Dictionary<string, string>
	{
		["162_Ultar_CamEffect_1"] = "fx_16201_base_Ultra01_NoTL_camera",
		["162_Ultar_CamEffect_2"] = "fx_16201_base_Ultra01_NoTL&TL_camera_1",
		["162_Ultar_CamEffect_3"] = "fx_16201_base_Ultra01_NoTL&TL_camera_2",
		["162_Ultar_CamEffect_4"] = "fx_16201_base_Ultra01_NoTL&TL_camera_3"
	};

	public static readonly List<string> bulletKeyList_SwordAura = new List<string> { "Bullet_162_JianQi_Heng", "Bullet_162_JianQi_Shu", "Bullet_162_JianQi_You", "Bullet_162_JianQi_Zuo" };

	public const string bulletKey_Huge_SwordAura = "Bullet_162_JianQi_Big";

	public static readonly int bulletTag_SwordAura = CommonHelper.StringToHash("162JianQi");

	public static readonly TSVector2 shootPositionOffset_SwordAura = new TSVector2(0, 0);

	public static readonly FP shootPositionY_SwordAura = 0;

	public static readonly TSVector2 shootAngleOffset_SwordAura = new TSVector2(-30, 30);

	public const int perkId_41 = 516241;

	public const string eventName_TriggerSwordAura_P41 = "162UltraJianQi";

	public const int hitDamageId_P41 = 162400006;

	public const int perkId_42 = 516242;

	public const string eventName_GenerateAreaEffect_P42 = "162P42ZhongJianArea";

	public const string areaEffectKey_P42 = "AreaEffect_162_LeiDianArea_P42";

	public static readonly TSVector2 generateOffset_P42 = new TSVector2(0, 5);

	public const int perkId_43 = 516243;

	public const int buffId_Burst_UltraSkill_P43 = 16243011;

	public const int parameterId_AddEnergyInterval_P43 = 16243011;

	public const int parameterId_AddEnergyValue_P43 = 16243002;

	public const int additionalAttrId_D1 = 16296111;

	public const int buffId_TriggerCD_D1 = 16296111;

	public const int buffId_D2 = 16296211;

	public static readonly int damageTag_Trigger_1_D2 = CommonHelper.StringToHash("QingSuper");

	public const int additionalAttrId_1_D2 = 16296211;

	public static readonly int damageTag_Trigger_2_D2 = CommonHelper.StringToHash("ZhongSuper");

	public const int additionalAttrId_2_D2 = 16296221;

	public const int additionalAttrId_D3 = 16296311;

	public const int buffId_D4 = 16296411;

	public static readonly FP triggerHpPercent_D5 = 0.2;

	public static readonly int damageTag_Trigger_Rapier_D5 = CommonHelper.StringToHash("QingAndQi");

	public const int additionalAttrId_Rapier_D5 = 16296511;

	public static readonly int damageTag_Trigger_Claymore_D5 = CommonHelper.StringToHash("Zhong");

	public const int additionalAttrId_Claymore_D5 = 16296521;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public const string logicTag_LastNormalAttackFinishTime = "LastNormalAttackFinishTime";

	public const string logicTag_LastDashNormalAttackFinishTime = "LastDashNormalAttackFinishTime";

	public static readonly int eventHashCode_TriggerSowrdAura = CommonHelper.StringToHash("TriggerSowrdAura");
}
