using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._12101;

public class Config
{
	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	public static readonly FP duration_Dodge = 0.3f;

	public static readonly FP distance_Dodge = 0.01f;

	public static readonly int transitionRushSkillId = 0;

	public static readonly FP realDistance_Dodge = 3f;

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

	public static readonly FP SaveComboIndexTime = 1f;

	public static readonly List<string> comboTagListNormalAttack = new List<string> { "Normal_Attack_1", "Normal_Attack_2", "Normal_Attack_3" };

	public const string eventName_NormalAttackHit = "121_NormalAttack_Hit";

	public static readonly int hitTag_TriggerFire = CommonHelper.StringToHash("114_FireTag1_Trigger");

	public const string fireAreaEffect = "AreaEffect_114_FireTag1_Boom";

	public const string tipsKey_TriggerMark = "FireMark_Trigger_Effect_02";

	public const string Ultra_TL = "Ultra_TL";

	public const string Ultra_NoTL = "Ultra_NoTL";

	public static readonly FP UltraNoTargetDistance = 6;

	public const string eventName_UltraBullet = "121_Ultra_Bullet";

	public const string eventName_UltraBuff_P41 = "121_Ultra_Buff_P41";

	public const string eventName_UltraBuff_P42 = "121_Ultra_Buff_P42";

	public const string bulletAlias_Ultra = "Bullet_121_UltraAtk";

	public const string NormalAttackCountName = "NormalAttackCount";

	public const string LastNormalAttackTimeName = "LastNormalAttackTime";
}
