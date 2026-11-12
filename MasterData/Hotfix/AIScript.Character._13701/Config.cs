using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13701;

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

	public static readonly FP SaveComboIndexTime = 2f;

	public static readonly List<string> comboTagListNormalAttack = new List<string> { "Atk1", "Atk2", "Atk3", "Atk4", "Atk5" };

	public static readonly int damageTag_NormalAttack_137 = CommonHelper.StringToHash("137NrmAtk");

	public const string CrossSlashTag = "Atk_Sp";

	public static readonly int CrossSlashHitTag_137 = CommonHelper.StringToHash("137ShiZiZhanAtk");

	public const string Ultra_NoTL = "Ultra_NoTL";

	public const string Ultra_TL = "Ultra_TL";

	public const string LeftUltraAtkEvt = "Ultra_Atk_Left";

	public static readonly string[] LeftUltraAtkBullet = new string[4] { "Bullet_137_UltraAtk_Bullet_1", "Bullet_137_UltraAtk_Bullet_2", "Bullet_137_UltraAtk_Bullet_3", "Bullet_137_UltraAtk_Bullet_4" };

	public static readonly TSVector2 LeftBulletOffset = new TSVector2(-0.8, 1);

	public static readonly FP LeftBulletHeight = 2;

	public const string RightUltraAtkEvt = "Ultra_Atk_Right";

	public static readonly TSVector2 RightBulletOffset = new TSVector2(0.8, 1);

	public static readonly FP RightBulletHeight = 2;

	public static readonly string[] RightUltraAtkBullet = new string[4] { "Bullet_137_UltraAtk_Bullet_5", "Bullet_137_UltraAtk_Bullet_6", "Bullet_137_UltraAtk_Bullet_7", "Bullet_137_UltraAtk_Bullet_8" };

	public static readonly FP NoTargetDistance = 6;

	public static readonly FP UltraAtkLookAtDuration = 0.1;

	public static readonly FP UltraAtkRandomRadius = 3;

	public const int UltralAtkNum = 15;

	public static readonly int UltraHitTag_137 = CommonHelper.StringToHash("137UltraAtk");

	public const int ArmedEnergyBuffId = 13700012;

	public const int ArmedEnergyMax = 10;

	public static readonly FP ArmedEnergyProbability = 80;

	public const int ArmedEnergyIncrement = 2;

	public static readonly FP ArmedEnergyCD = 2;

	public const int buffId_WindMark = 2011;

	public const string areaEffectKey_TriggerWindMark = "AreaEffect_137_WindMark1_Bloom";

	public const string tipsKey_TriggerWindMark = "WindMark_Trigger_Effect_01";

	public static readonly int CommonTag_WindMark = CommonHelper.StringToHash("137WindTagTrigger");

	public const int perkId_513741 = 513741;

	public const int buffId_513741_AddDamage = 13741011;

	public const int perkId_513742 = 513742;

	public const int buffId_513742_Mark = 13742011;

	public const int onceId_513742_Damage = 13742001;

	public const int perkId_513743 = 513743;

	public const int buffId_513743_AddBuff = 13743011;

	public const int buffId_D1 = 13796111;

	public const int buffId_D2 = 13796211;

	public const int buffId_D3 = 13796311;

	public const int buffId_D4 = 13796411;

	public const int additionalAttrId_D5 = 13796511;

	public const string NormalAttackCountName = "NormalAttackCount";

	public const string LastNormalAttackTimeName = "LastNormalAttackTime";

	public const string LastArmedEnergyTimeName = "LastArmedEnergyTime";
}
