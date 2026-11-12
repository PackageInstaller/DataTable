using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._11501;

public class Config_MainControl
{
	public const string comboTag_Skill = "Main_Cannon_Enter";

	public const int replaceAnimationGroupIndex_Skill = 1;

	public static readonly FP durationTime_TransformState = 15;

	public const int skillId_NormalAttack_TransformState = 11511000;

	public static readonly Dictionary<int, FP> normalAttackCDDic_TransformState = new Dictionary<int, FP>
	{
		[0] = 0,
		[1] = 0,
		[2] = 0,
		[3] = 0
	};

	public static readonly FP dodge_Duration_TransformState = 0.5f;

	public static readonly FP dodge_Distance_TransformState = 8f;

	public static readonly FP dodge_Duration_Special_TransformState = 0.5f;

	public static readonly FP dodge_Distance_Special_TransformState = 4f;

	public const string dodgeFx_TransformState = "fx_11501_base_Dodge_B1B2_Tail";

	public const int skillId_Rush_TransformState = 11571000;

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_TransformState = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_Rush_Independent_TransformState = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey.L
	};

	public static readonly ComboInputBuffer.ActionKey[] actionKeys_SpecialRushEnd_TransformState = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.S };

	public const bool useSpecialRushEnd_TransformState = false;

	public static readonly FP interruptTime_TransformState = 1f;

	public const int skillId_ExitTransformState = 11531002;

	public const string comboTag_Idle_ExitTransformState = "Main_Cannon_IdleExit";

	public const string comboTag_Aim_ExitTransformState = "Main_Cannon_Exit";

	public const int perkId_1 = 511501;

	public const int skillId_NormalAttack_TransformState_P1 = 11511010;

	public const int perkId_2 = 511502;

	public static readonly int damageTag_P2 = CommonHelper.StringToHash("115_Main_Laser");

	public const int buffId_P2 = 11502011;

	public const int triggerBuffCount_P2 = 12;

	public const int buffId_Fx_P2 = 11502012;

	public const int additionalAttrId_P2 = 11502011;

	public const int perkId_3 = 511503;

	public static readonly int damageTag_P3 = CommonHelper.StringToHash("115_Main_Laser");

	public const int buffId_P3 = 11503011;

	public const string areaEffectKey_P3 = "AreaEffect_11501_Main_Skill_P06_Beam";

	public const int perkId_4 = 511504;

	public const int perkId_5 = 511505;

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("115_Main_Laser");

	public const int buffId_P5 = 11505011;

	public const int perkId_6 = 511506;

	public const int skillId_P6 = 11511030;

	public static readonly FP triggerInterval_P6 = 6;

	public const int perkId_7 = 511507;

	public static readonly FP triggerRadius_P7 = 8;

	public const int additionalAttrId_P7 = 11507001;

	public const int perkId_8 = 511508;

	public const string comboTag_Skill_P8 = "Main_Cannon_P08_Start_Hurt";

	public const string eventName_ShootFinish_P8 = "115_P08_Finish";

	public const int perkId_9 = 511509;

	public static readonly int damageTag_P9 = CommonHelper.StringToHash("115_Main_Laser");

	public static readonly FP triggerInterval_P9 = 4;

	public static readonly Dictionary<AnimationSlotConfigComponent.SlotType, string> fxKeyDic_P9 = new Dictionary<AnimationSlotConfigComponent.SlotType, string>
	{
		[AnimationSlotConfigComponent.SlotType.Extra_1] = "fx_11501_loop_Main_Skill_Cannon_Strengthen_upL_P09",
		[AnimationSlotConfigComponent.SlotType.Extra_2] = "fx_11501_loop_Main_Skill_Cannon_Strengthen_upR_P09",
		[AnimationSlotConfigComponent.SlotType.Extra_3] = "fx_11501_loop_Main_Skill_Cannon_Strengthen_downL_P09",
		[AnimationSlotConfigComponent.SlotType.Extra_4] = "fx_11501_loop_Main_Skill_Cannon_Strengthen_downR_P09"
	};

	public const string laserFx_Single_P9 = "fx_11501_bullet_B1P02_Cannon_Shoot_Strengthen";

	public const string laserFx_Single_Refraction_P9 = "fx_11501_bullet_B1P02_Cannon_Shoot_Strengthen";

	public const int additionalAttrId_P9 = 11509001;

	public const int perkId_10 = 511510;

	public static readonly int damageTag_P10 = CommonHelper.StringToHash("115_Main_Laser");

	public const int buffId_P10 = 11510011;

	public const int perkId_11 = 511511;

	public const int buffId_P11 = 11511011;

	public const int buffId_Trigger_P11 = 11511012;

	public const int perkId_12 = 511512;

	public static readonly int damageTag_TriggerLightMark_P12 = CommonHelper.StringToHash("115_Ultra");

	public const int buffId_P12 = 11512011;

	public const int perkId_13 = 511513;

	public const string areaEffectPath_P13 = "AreaEffect_11501_LimitDodge_Stun";

	public const int parameterId_13 = 11513011;

	public static readonly Dictionary<AnimationSlotConfigComponent.SlotType, List<int>> hitDamageIdDic = new Dictionary<AnimationSlotConfigComponent.SlotType, List<int>>
	{
		[AnimationSlotConfigComponent.SlotType.Extra_1] = new List<int> { 115110001, 115110401, 115110101, 115110401 },
		[AnimationSlotConfigComponent.SlotType.Extra_2] = new List<int> { 115110002, 115110402, 115110102, 115110402 },
		[AnimationSlotConfigComponent.SlotType.Extra_3] = new List<int> { 115110003, 115110403, 115110103, 115110403 },
		[AnimationSlotConfigComponent.SlotType.Extra_4] = new List<int> { 115110004, 115110404, 115110104, 115110404 }
	};

	public const int hitDamageId_SingleHit_Salvo = 115110302;

	public static readonly Dictionary<AnimationSlotConfigComponent.SlotType, int> damageTagDic_Funnel = new Dictionary<AnimationSlotConfigComponent.SlotType, int>
	{
		[AnimationSlotConfigComponent.SlotType.Extra_1] = CommonHelper.StringToHash("Cannon_1"),
		[AnimationSlotConfigComponent.SlotType.Extra_2] = CommonHelper.StringToHash("Cannon_2"),
		[AnimationSlotConfigComponent.SlotType.Extra_3] = CommonHelper.StringToHash("Cannon_3"),
		[AnimationSlotConfigComponent.SlotType.Extra_4] = CommonHelper.StringToHash("Cannon_4")
	};

	public const string eventName_SingleShoot = "115_Main_Shoot";

	public const string eventName_IrradiationShoot = "115_Main_Sustain_Shoot";

	public const string eventName_SalvoShoot = "115_Main_Salvo_Shoot";

	public static readonly List<string> comboTagList_Single = new List<string> { "Main_Cannon_Attack_1", "Main_Cannon_Attack_2", "Main_Cannon_Attack_3", "Main_Cannon_Attack_4" };

	public const string laserFx_Single = "fx_11501_bullet_B2_Attack_Cannon";

	public const string laserFx_Single_Strengthen = "fx_11501_bullet_B1P02_Cannon_Shoot_Strengthen";

	public const string laserFx_Single_Refraction = "fx_11501_bullet_B2_Attack_Cannon";

	public const string comboTag_Irradiation = "Main_Cannon_P01_Sustain";

	public const string laserFx_Irradiation = "fx_11501_bullet_B2_Attack_Cannon_Sustain";

	public const string laserFx_Irradiation_Strengthen = "fx_11501_bullet_B2_Attack_Cannon_Sustain_Strengthen";

	public const string laserFx_Irradiation_Refraction = "fx_11501_bullet_B2_Attack_Cannon_Refraction";

	public const string laserHitSound_Irradiation = "char_11501_laser_impact";

	public const string laserHitSound_Irradiation_Strengthen = "char_11501_laser_impact_strengthen";

	public static readonly FP hitInterval_Irradiation = 0.5;

	public static readonly FP interruptDistance_Irradiation = 12;

	public static readonly FP checkDistanceInterval_Irradiation = 1;

	public const string stopLaserSoundEvent_Irradiation = "char_11501_skill_branch2_all_laser_stop";

	public const int laser_RefractionMaxCount = 4;

	public const int laser_RefractionRadius = 5;

	public static readonly FP refreshTime_IrradiationRefraction = 1;

	public const string comboTag_Salvo = "Main_Cannon_P03_Salvo";

	public const string laserFx_Salvo = "fx_11501_bullet_B1P03_Cannon_Shoot";

	public static readonly FP hitDelay_Salvo = 0.2;

	public const int hitCount_SingleHit_Salvo = 4;

	public const string hittedFx_SingleHit_Salvo = "fx_11501_hit_2";

	public const string areaEffectPath_Salvo = "AreaEffect_11501_Main_Skill_P03_SalvoBoom";

	public static readonly List<AnimationSlotConfigComponent.SlotType> allLaserSlotTypes = new List<AnimationSlotConfigComponent.SlotType>
	{
		AnimationSlotConfigComponent.SlotType.Extra_1,
		AnimationSlotConfigComponent.SlotType.Extra_2,
		AnimationSlotConfigComponent.SlotType.Extra_3,
		AnimationSlotConfigComponent.SlotType.Extra_4
	};

	public static readonly int eventHashCode_Trigger_LaserStrengthen = CommonHelper.StringToHash("EventName_Trigger_LaserStrengthen");

	public static readonly int eventHashCode_Irradiation_UpdateTarget = CommonHelper.StringToHash("EventName_Irradiation_UpdateTarget");

	public static readonly int eventHashCode_AfterFunnelFireHit = CommonHelper.StringToHash("EventName_AfterFunnelFireHit");

	public const string logicTag_TriggerPerk_P2 = "TriggerPerk_P2";

	public const string logicTag_TriggerPerk_P6 = "TriggerPerk_P6";
}
