using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13401;

public class Config
{
	public const int ammoCountMax_Default = 3;

	public const int ammoCount_Default = 0;

	public static readonly int damageTag_TriggerFireMark = CommonHelper.StringToHash("134_FireTag_Trigger");

	public static readonly int damageTag_FireMark = CommonHelper.StringToHash("134_FireTag_Boom");

	public const string tipsKey_TriggerFireMark = "FireMark_Trigger_Effect_02";

	public const int hitDamageId_FireMark = 134000001;

	public static readonly FP hitRadius_FireMark = 2;

	public const string hitFxPath_FireMark = "fx_common_base_FireTag_Trigger_2";

	public const string hittedFxPath_FireMark = "";

	public static readonly FP stiffDuration_FireMark = 1;

	public static readonly FP hitStrenth_FireMark = 1;

	public static readonly List<string> comboTagList_NormalAttack_Default = new List<string> { "Attack_1", "Attack_2", "Attack_3", "Attack_4", "Attack_5" };

	public static readonly List<string> comboTagList_NormalAttack_Strength = new List<string> { "Attack_Strengthen_1", "Attack_Strengthen_2", "Attack_Strengthen_3" };

	public static readonly FP delay_ResetNormalAttackStage = 2;

	public const string eventName_NormalAttackComplete = "Attack_End";

	public const string eventName_StrengthNormalAttackConsumeAmmo = "Use_Bullet";

	public const int consumeAmmoCount_StrengthNormalAttack = 1;

	public static readonly int damageTag_NormalAttack = CommonHelper.StringToHash("134_Normal_Attack");

	public static readonly int damageTag_StrengthNormalAttack = CommonHelper.StringToHash("134_Strengthen_Attack");

	public static readonly int damageTag_TriggerFanHit_NormalAttack = CommonHelper.StringToHash("Attack_Sector");

	public const string areaEffect_FanHit_NormalAttack = "AreaEffect_13401_Attack_Sector";

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.25f;

	public static readonly FP distance_Dodge = 0.1f;

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

	public const string comboTag_UltraSkill_Timeline = "134_Ultra_TL";

	public const string comboTag_UltraSkill_NoTimeline = "134_Ultra_NoTL";

	public const string eventName_LookAtTarget_UltraSkill = "134_Ultra_Target";

	public static readonly int damageTag_UltraSkill = CommonHelper.StringToHash("134_Ultra");

	public const int attackLoopRound_UltraSkill = 2;

	public const string eventName_TurnAndDash_UltraSkill = "134_Ultra_Hurt";

	public static readonly FP dashSpeed_UltraSkill = 20;

	public static readonly FP minDashDistance_UltraSkill = 1;

	public static readonly FP maxDashDistance_UltraSkill = 6;

	public static readonly FP addSearchTargetRange_UltraSkill = 6;

	public static readonly FP changeSearchTargetDeg_UltraSkill = 15;

	public const int perkId_41 = 513441;

	public const int buffId_P41 = 13441011;

	public const int perkId_42 = 513442;

	public const int addAttackLoopRound_P42 = 2;

	public const int additionalAttrId_P42 = 13442001;

	public const int perkId_43 = 513443;

	public const string eventName_StartLogic_P43 = "134_P43_Buff";

	public const int buffId_P43 = 13443011;

	public const int maxBuffCount_P43 = 6;

	public const int minBuffCount_P43 = 0;

	public static readonly FP removeBuffInterval_P43 = 1;

	public const int buffId_D1 = 13496111;

	public const int buffId_D2 = 13496211;

	public const int buffId_D3 = 13496311;

	public const int buffId_D4 = 13496411;

	public const int additionalAttrId_D5 = 13496511;

	public const string logicTag_NormalAttackStage = "NormalAttackStage";

	public const string logicTag_StrengthNormalAttackStage = "StrengthNormalAttackStage";

	public const string logicTag_ImproveNormalAttackDamage = "ImproveNormalAttackDamage";
}
