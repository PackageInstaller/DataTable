using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13001;

public class Config_MainControl
{
	public const string comboTag_Skill = "B1_Skill";

	public const string eventName_Summon_Skill = "B1_Summon";

	public const int monsterId_Summon_Skill = 13001111;

	public static readonly FP randomRadius_SummonPosition_Skill = 4;

	public static readonly FP durationTime_Summone_Skill = 12;

	public static readonly int damageTag_Trigger_Skill = CommonHelper.StringToHash("130_Main_Skill_Shoot");

	public const int additionalAttrId_Skill = 13093001;

	public static readonly int damageTag_Trigger_Summon = CommonHelper.StringToHash("130_Main_Skill_Pet");

	public const int additionalAttrId_Summon = 13093002;

	public const string comboTag_Spawn_Summon = "Born_Skill";

	public const string comboTag_Death_Summon = "130_Summon_End";

	public const int skillId_TauntAttack_Summon = 13031002;

	public const string comboTag_TauntAttack_Summon = "Taunt_Skill";

	public static readonly FP useInterval_TauntAttack_Summon = 4;

	public const int skillId_CoordinateAttack_Summon = 13031003;

	public const string comboTag_CoordinateAttack_Summon = "B1P03_Hurt";

	public const int skillId_StrengthenNormalAttack = 13010002;

	public const string comboTag_StrengthenNormalAttack = "B1_Attack";

	public const string fxPath_InStrength = "fx_13001_loop_B1_Skill_Weapon";

	public const int perkId_1 = 513001;

	public const int parameterId_P1 = 13001011;

	public static readonly int damageTag_Trigger_P1 = CommonHelper.StringToHash("130_B1_Bullet");

	public const int triggerDamageCount_P1 = 10;

	public const int buffId_P1 = 13005011;

	public const string eventName_ShootBullet_P1 = "Shoot_P05";

	public const string bulletKey_P1 = "Bullet_130_B1_Attack_P05";

	public static readonly List<AnimationSlotConfigComponent.SlotType> shootSlotList_P1 = new List<AnimationSlotConfigComponent.SlotType>
	{
		AnimationSlotConfigComponent.SlotType.Extra_1,
		AnimationSlotConfigComponent.SlotType.Extra_2,
		AnimationSlotConfigComponent.SlotType.Extra_3,
		AnimationSlotConfigComponent.SlotType.Extra_4,
		AnimationSlotConfigComponent.SlotType.Extra_5,
		AnimationSlotConfigComponent.SlotType.Extra_6,
		AnimationSlotConfigComponent.SlotType.Extra_7
	};

	public const int perkId_2 = 513002;

	public const string eventName_Shoot_P2 = "B1Perk02_Shoot";

	public static readonly List<string> bulletPathList_P2 = new List<string> { "Bullet_130_B1P02_Attack_1", "Bullet_130_B1P02_Attack_2", "Bullet_130_B1P02_Attack_3", "Bullet_130_B1P02_Attack_4" };

	public static readonly FP searchRadius_P2 = 6;

	public static readonly TSVector shootOffset_P2 = new TSVector(0, 1.5, 1);

	public const int perkId_3 = 513003;

	public static readonly FP triggerDiastance_P3 = 5;

	public static readonly int damageTag_PenetratingArrow_P3 = CommonHelper.StringToHash("130_B1_PenetrateBullet");

	public const int perkId_4 = 513004;

	public const int buffId_MaxHp_P4 = 13004011;

	public const int buffId_AddDamage_P4 = 13004012;

	public const string comboTag_Death_Summon_P4 = "B1P04_Boom";

	public const int perkId_5 = 513005;

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("130_B1_Bullet");

	public const int buffId_P5 = 13005012;

	public const int perkId_6 = 513006;

	public static readonly int damageTag_Trigger_P6 = CommonHelper.StringToHash("130_B1_Bullet");

	public const int buffId_P6 = 13006011;

	public const int perkId_7 = 513007;

	public static readonly int damageTag_Trigger_P7 = CommonHelper.StringToHash("130_B1_Bullet");

	public const int parameterId_P7 = 13007011;

	public const int additionalAttrId_P7 = 13007001;

	public const int perkId_8 = 513008;

	public const int buffId_P8 = 13008011;

	public const string comboTag_Spawn_Summon_P8 = "Born_Skill_P08_Large";

	public const string comboTag_Death_Summon_P4_P8 = "B1P04P08_LargeBoom";

	public const string comboTag_CoordinateAttack_Summon_P8 = "B1P03P08_LargeHurt";

	public const string comboTag_TauntAttack_Summon_P8 = "Taunt_Skill_P08_Large";

	public const int perkId_9 = 513009;

	public const int addEffectId_P9 = 13009012;

	public const int buffId_P9 = 13009011;

	public const string triggerFxPath_P9 = "fx_13001_base_B1_Skill_Summon_Perk09_Healing";

	public const int parameterId_P9 = 13009011;

	public const int perkId_10 = 513010;

	public const int shieldId_P10 = 13010001;

	public const string areaEffectKey_P10 = "AreaEffect_130_Main_Skill_P10_Shield_Boom";

	public const string areaEffectKey_P8_P10 = "AreaEffect_130_Main_Skill_P10_Shield_Boom_Strengthen";

	public const int perkId_11 = 513011;

	public const int buffId_P11 = 13011011;

	public const string comboTag_NormalAttack_P11 = "Normal_P11_Attack";

	public const string comboTag_StrengthenNormalAttack_P11 = "B1P11_Attack";

	public const int perkId_12 = 513012;

	public static readonly FP triggerTime_P12 = 1;

	public const int buffId_P12 = 13012011;

	public const int perkId_13 = 513013;

	public static readonly int damageTag_TriggerWaterCorrosion_P13 = CommonHelper.StringToHash("130_Ultra");

	public const int buffId_P13 = 13013011;

	public const string logicTag_BattleReadyDestroySelf_Summon = "BattleReadyDestroySelf_Summon";

	public static readonly int eventHashCode_DonutSummonedEvent = CommonHelper.StringToHash("DonutSummonedEvent");

	public const string logicTag_TriggerPerk_P1 = "TriggerPerk_P1";

	public const string logicTag_TriggerPerk_P11 = "TriggerPerk_P11";
}
