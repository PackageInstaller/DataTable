using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14001;

public class Config_MainControl
{
	public enum TransformMode
	{
		None,
		Tank,
		MiniGun
	}

	public const string fxKey_Perform = "fx_14001_loop_Run";

	public static readonly FP holdSkillKeyTime_P1_P2 = 1;

	public const int skillId_Default = 14031000;

	public const string comboTag_Skill_BeginTransform = "140_Main_Skill_Transform";

	public const string comboTag_Skill_TransformToTank = "140_Main_Skill_Type_Tank";

	public const string comboTag_Skill_TransformToMiniGun = "140_Main_Skill_Type_Cannon";

	public const int skillId_Skill_TransformMode = 14031004;

	public const int skillId_Dodge_TransformMode = 14031001;

	public const int skillId_Rush_TransformMode = 14031002;

	public const int skillId_Return_TransformMode = 14031003;

	public const int animationGroupIndex_Tank = 0;

	public static readonly FP durationTime_Tank = 10;

	public static readonly FP defaultSkillCD_Tank = 5;

	public const int skillId_NormalAttack_Tank = 14031011;

	public const string comboTag_NormalAttack_Tank = "140_Attack_Tank";

	public const string eventName_NormalAttack_Shoot_Tank = "Tank_Attack";

	public const string bulletKey_NormalAttack_Tank = "Bullet_140_Tank_Attack";

	public static readonly TSVector2 shootOffset_NormalAttack_Tank = new TSVector2(0, 1);

	public static readonly FP shootPositionY_NormalAttack_Tank = 1;

	public static readonly FP offsetDistance_NoTarget_NormalAttack_Tank = 1;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge_Tank = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.T };

	public static readonly FP duration_Dodge_Tank = 0.3f;

	public static readonly FP distance_Dodge_Tank = 0.01f;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Tank = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.R };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent_Tank = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey.R
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd_Tank = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd_Tank = false;

	public static readonly FP interruptTime_Rush_Tank = 1f;

	public const string comboTag_Return_Tank = "140_Main_Skill_Tank_End";

	public const int animationGroupIndex_MiniGun = 1;

	public static readonly FP durationTime_MiniGun = 10;

	public static readonly FP defaultSkillCD_MiniGun = 5;

	public const int skillId_NormalAttack_MiniGun = 14031021;

	public const string comboTag_NormalAttack_MiniGun = "140_Attack_Cannon";

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Dodge_MiniGun = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	public static readonly FP duration_Dodge_MiniGun = 0.3f;

	public static readonly FP distance_Dodge_MiniGun = 0.01f;

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_MiniGun = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_Rush_Independent_MiniGun = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey.K
	};

	public static readonly ComboInputBuffer.ActionKey[] comboKeys_SpecialRushEnd_MiniGun = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd_MiniGun = false;

	public static readonly FP interruptTime_Rush_MiniGun = 1f;

	public const string comboTag_Return_MiniGun = "140_Main_Skill_Cannon_End";

	public const int perkId_1 = 514001;

	public const int skillId_Skill_MiniGun_P1 = 14031022;

	public const string comboTag_Skill_MiniGun_P1 = "140_Cannon_P01_Skill";

	public static readonly int damageTag_AddDamage_P1 = CommonHelper.StringToHash("140_P01");

	public const int additionalAttrId_P1 = 14001011;

	public const int perkId_2 = 514002;

	public static readonly int damageTag_Trigger_P2 = CommonHelper.StringToHash("140_P02");

	public const int buffId_AttachCrystal_P2 = 14002011;

	public const int maxBuffCount_AttachCrystal_P2 = 20;

	public const int buffId_Crystallization_P2 = 14002012;

	public const int buffId_Stun_P2 = 14002013;

	public const int hitDamageId_P2 = 140502001;

	public static readonly int damageTag_AddDamage_P2 = CommonHelper.StringToHash("140_Cannon");

	public const int additionalAttrId_P2 = 14002011;

	public const int perkId_3 = 514003;

	public const int skillId_Skill_Tank_P3 = 14031012;

	public const string comboTag_Skill_Tank_P3 = "140_Tank_P03_Skill";

	public const string eventName_Skill_Shoot_Tank = "Tank_Skill";

	public const string bulletKey_Skill_Tank = "Bullet_140_Tank_Skill";

	public static readonly TSVector2 shootOffset_Skill_Tank = new TSVector2(0, 1);

	public static readonly FP shootPositionY_Skill_Tank = 1;

	public static readonly FP offsetDistance_NoTarget_Skill_Tank = 6;

	public const int shieldId_P3 = 14003011;

	public static readonly int damageTag_AddDamage_P3 = CommonHelper.StringToHash("140_P03");

	public const int additionalAttrId_P3 = 14003011;

	public const int perkId_4 = 514004;

	public const int buffId_P4 = 14004011;

	public static readonly FP addBuffInterval_P4 = 2;

	public static readonly List<string> comboTagList_NormalAttack_Tank_P4 = new List<string> { "140_Attack_Tank", "140_Attack_Tank_P04_2", "140_Attack_Tank_P04_3" };

	public const string comboTag_Skill_Tank_P3_P4 = "140_Tank_P03_Skill_P04";

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("140_Tank");

	public const int additionalAttrId_P4 = 14004011;

	public const int perkId_5 = 514005;

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("140_Cannon");

	public const int buffId_P5 = 14005011;

	public const int perkId_6 = 514006;

	public const string comboTag_Skill_TransformToMiniGun_P6 = "140_Main_Skill_Type_Fly";

	public const int animationGroupIndex_MiniGun_P6 = 2;

	public static readonly List<string> transfromStateFxList_P6 = new List<string> { "fx_14001_loop_Rush_Type_Gun_Fly", "fx_14001_loop_Rush_Type_Gun_Fly_Wheel_L", "fx_14001_loop_Rush_Type_Gun_Fly_Wheel_R" };

	public static readonly FP duration_Dodge_MiniGun_P6 = 0.3f;

	public static readonly FP distance_Dodge_MiniGun_P6 = 4f;

	public const string fxKey_Dodge_P6 = "fx_14001_base_Dodge_Type_Gun_Fly";

	public const string comboTag_NormalAttack_MiniGun_P6 = "140_Attack_Fly";

	public const string comboTag_Return_MiniGun_P6 = "140_Main_Skill_Fly_End";

	public const string comboTag_Skill_MiniGun_P1_P6 = "140_Fly_P01_Skill";

	public const int buffId_AddDamage_P6 = 14006011;

	public const int buffId_AddMoveSpeed_P6 = 14006012;

	public const int perkId_7 = 514007;

	public const int buffId_P7 = 14007011;

	public const int perkId_8 = 514008;

	public const string areaEffectKey_P8 = "AreaEffect_14001_Tank_P08";

	public const string areaEffectKey_Super_P8 = "AreaEffect_14001_Tank_P08P03";

	public const int perkId_9 = 514009;

	public const int buffId_P9 = 14009011;

	public const string bulletKey_P9 = "Bullet_140_Tank_P09";

	public static readonly int bulletTag_Trigger_P9 = CommonHelper.StringToHash("Bullet_140_Tank");

	public const int bulletCount_P9 = 5;

	public static readonly FP randomRadius_P9 = 4;

	public const int parameterId_TriggerCD_P9 = 14009011;

	public static readonly int bulletTag_Trigger_P3_P9 = CommonHelper.StringToHash("Bullet_140_Tank_Skill");

	public const int bulletCount_P3_P9 = 10;

	public static readonly FP randomRadius_P3_P9 = 6;

	public static readonly int damageTag_AddDamage_P9 = CommonHelper.StringToHash("140_Tank");

	public const int additionalAttrId_P9 = 14009001;

	public const int perkId_10 = 514010;

	public const int shieldId_P10 = 14010001;

	public const int buffId_Move_P10 = 14010012;

	public const int parameterId_Interval_P10 = 14010011;

	public const int perkId_11 = 514011;

	public const string comboTag_Return_Tank_P11 = "140_Main_Skill_Tank_End_P11";

	public const string comboTag_Return_MiniGun_P11 = "140_Main_Skill_Cannon_End_P11";

	public const string comboTag_Return_MiniGun_P6_P11 = "140_Main_Skill_Fly_End_P11";

	public const string eventName_TriggerLogic_P11 = "140_P11_Shoot";

	public static readonly FP shootDelayTime_P11 = 1;

	public const string bulletKey_P11 = "Bullet_140_P11_Boom";

	public const int bulletCount_P11 = 6;

	public static readonly FP triggerRadius_P11 = 11;

	public const int buffId_P11 = 14011011;

	public const int perkId_12 = 514012;

	public const int buffId_P12 = 14012011;

	public const int parameterId_TriggerCD_P12 = 14012011;

	public const int perkId_13 = 514013;

	public const int parameterId_TriggerDistance_P13 = 14013011;

	public const int additionalAttrId_P13 = 14013001;

	public const string logicTag_TransformMode = "TransformMode";

	public const string logicTag_IsTransformToTank = "IsTransformToTank";

	public const string logicTag_IsTransformToMiniGun = "IsTransformToMiniGun";

	public static readonly int eventHashCode_TriggerLogic_P11 = CommonHelper.StringToHash("TriggerLogic_P11");
}
