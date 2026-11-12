using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14401;

public class Config
{
	public static readonly Dictionary<int, int> hitDamageIdMapping = new Dictionary<int, int>
	{
		[144311111] = 144311101,
		[144311112] = 144311102,
		[144310211] = 144310201,
		[144310212] = 144310202,
		[144310213] = 144310203,
		[144310218] = 144310208,
		[144310214] = 144310204,
		[144310215] = 144310205,
		[144310219] = 144310209,
		[144310216] = 144310206,
		[144310217] = 144310207,
		[144310411] = 144310401,
		[144310412] = 144310402,
		[144310413] = 144310403,
		[144320012] = 144320002,
		[144322311] = 144322301
	};

	public static readonly int damageTag_TriggerWaterMark = CommonHelper.StringToHash("144_WaterTag_Trigger");

	public const string areaEffectKey_TriggerWaterMark = "AreaEffect_144_WaterTag1_Boom";

	public const string tipsKey_TriggerWarterMark = "WaterMark_Trigger_Effect_05";

	public const int buffId_Cold = 4021;

	public static readonly int buffTag_Cold = CommonHelper.StringToHash("Cold");

	public const int maxCount_ColdBuff = 3;

	public const int buffId_Frozen = 4100;

	public const int monsterId_Summon = 14401111;

	public static readonly Dictionary<int, int> replaceMonsterIdDic_Summon_ForSkin = new Dictionary<int, int> { [14403] = 14401112 };

	public const int skillId_Summon = 14410010;

	public static readonly FP delayDestoryTime_Summon = 0;

	public static readonly SummonCfg summonCfg_Summon = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		summonType = SummonType.None
	};

	public static readonly List<string> comboTagList_NormalAttack = new List<string> { "Atk1", "Atk2", "Atk3", "Atk4", "Atk5", "Atk6" };

	public const string eventName_AddBuff_NormalAttack = "144_AtkInvincibleAdd";

	public const string eventName_RemoveBuff_NormalAttack = "144_AtkInvincibleRemove";

	public const string eventName_StopLockDirection_NormalAttack = "144_S";

	public const int buffId_NormalAttack = 14400001;

	public static readonly FP holdTime_NormalAttackStage = 0.5;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.3f;

	public static readonly FP distance_Dodge = 0.01f;

	public static readonly int transitionRushSkillId = 0;

	public static readonly FP realDistance_Dodge = 3.2f;

	public static readonly FP crossAdditionDistance_Dodge = 1.5f;

	public static readonly FP crossKeepAwayNavmeshEdgeDistance_Dodge = 0.01f;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd = false;

	public static readonly FP interruptTime_Rush = 1f;

	public const string comboTag_UltraSkill_Timeline = "144_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "144_Ultra_NoTL";

	public const string eventName_HideModel_UltraSkill = "144_UltraFXAdd";

	public const string eventName_ShowModel_UltraSkill = "144_UltraFXRemove";

	public const int perkId_41 = 514441;

	public static readonly int damageTag_Trigger_P41 = CommonHelper.StringToHash("144_Ultra");

	public const int additionalAttrId_P41 = 14441001;

	public const int parameterId_P41 = 14441011;

	public const int perkId_42 = 514442;

	public const int buffId_P42 = 14442011;

	public const int perkId_43 = 514443;

	public static readonly int damageTag_Trigger_P43 = CommonHelper.StringToHash("144_Ultra");

	public const int additionalAttrId_P43 = 14443001;

	public const int buffId_D1 = 14496111;

	public const int buffId_D2 = 14496211;

	public static readonly int damageTag_Trigger_D3 = CommonHelper.StringToHash("144_B2_Shadow");

	public const int buffId_D3 = 14496311;

	public const int buffId_D4 = 14496411;

	public const int additionalAttrId_D5 = 14496511;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public const string logicTag_SetDataFinish_Summon = "SummonFinish_Summon";

	public const string logicTag_SpawnFx_Summon = "SpawnFx_Summon";

	public const string logicTag_DelayUseSkillTime_Summon = "DelayUseSkillTime_Summon";

	public const string logicTag_SkillComboTag_Summon = "SkillComboTag_Summon";

	public const string logicTag_CloseBlock_Summon = "CloseBlock_Summon";

	public const string logicTag_OpenCrossObstacleMode_Summon = "OpenCrossObstacleMode_Summon";
}
