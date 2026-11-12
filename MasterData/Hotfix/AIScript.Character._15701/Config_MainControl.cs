using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15701;

public class Config_MainControl
{
	public const int buffId_Energy = 15790011;

	public static readonly FP addBuffInterval_Energy = 1;

	public const int addBuffNum_Energy = 10;

	public const int initBuffNum_Energy = 100;

	public const int buffId_Mark_Hunting = 15790012;

	public const int buffId_Hunting = 15790013;

	public const string linkFx_Hunting = "157_SuoLian";

	public static readonly FP interruptDistance_LinkFx_Hunting = 10;

	public const int skillId_SpecialNormalAttack = 15710001;

	public const string comboTag_SpecialNormalAttack = "Atk_SuoLian";

	public const string eventName_MarkHuntingTarget_SpecialNormalAttack = "157paosuolian";

	public const string comboTag_Skill = "Skill_Main";

	public const string eventName_EnterSuperAmmo_Skill = "BaTiStart";

	public const string eventName_ExitSuperAmmo_Skill = "BaTiEnd";

	public const int buffId_SuperAmmo_Skill = 1004;

	public const string eventName_Shoot_Skill = "154MainShot";

	public const AnimationSlotConfigComponent.SlotType shootSlot_Skill = AnimationSlotConfigComponent.SlotType.Extra_1;

	public const string fxKey_Bullet_Skill = "157_Skll_Main_FlyBullt_Fx";

	public static readonly FP moveTime_BulletFx_Skill = 0.35;

	public static readonly FP offset_NoTarget_Skill = 5;

	public const string areaEffectKey_Skill = "AreaEffect_157_SkillMain_ShotBoom";

	public const int perkId_1 = 515701;

	public static readonly int damageTag_Trigger_P1 = CommonHelper.StringToHash("157P1Trigger");

	public const string areaEffectKey_P1 = "AreaEffect_157_P1_FishAtk";

	public const int parameterId_TriggerCD_P1 = 15701011;

	public const int additionalAttrId_P1 = 15701011;

	public const int perkId_2 = 515702;

	public const int buffId_P2 = 15702011;

	public const string fishOverloadEntityKey_P2 = "157SkillMainP2FishObject";

	public const int perkId_3 = 515703;

	public const string comboTag_NormalAttack_P3 = "Atk_P3";

	public const string eventName_Shoot_NormalAttack_P3 = "157diaoshe";

	public static readonly Dictionary<int, string> shootBulletKeyList_P3 = new Dictionary<int, string>
	{
		[1] = "Bullet_157_NrmAtk_1_Num2",
		[2] = "Bullet_157_NrmAtk_1_Num3",
		[3] = "Bullet_157_NrmAtk_1_Num4"
	};

	public static readonly TSVector2 shootOffset_NormalAttack_P3 = new TSVector2(0, 1);

	public static readonly FP shootPositionY_NormalAttack_P3 = 1.5;

	public static readonly Dictionary<int, List<string>> bulletKeyList_P3 = new Dictionary<int, List<string>>
	{
		[1] = new List<string> { "Bullet_157_P3_DiaoShe3" },
		[2] = new List<string> { "Bullet_157_P3_DiaoShe2", "Bullet_157_P3_DiaoShe4" },
		[3] = new List<string> { "Bullet_157_P3_DiaoShe2", "Bullet_157_P3_DiaoShe3", "Bullet_157_P3_DiaoShe4" },
		[4] = new List<string> { "Bullet_157_P3_DiaoShe1", "Bullet_157_P3_DiaoShe2", "Bullet_157_P3_DiaoShe3", "Bullet_157_P3_DiaoShe4" }
	};

	public static readonly FP randomRadius_NormalAttack_P3 = 3;

	public static readonly FP offset_NoTarget_NormalAttack_P3 = 4;

	public const int buffId_Mark_P3 = 15703011;

	public const int getBuffCount_P3 = 3;

	public const int parameterId_ReduceTime_P3 = 15703011;

	public const int buffId_P3 = 15703012;

	public const int perkId_4 = 515704;

	public const int parameterId_AddHuntingMarkTime_P4 = 15704011;

	public const string linkFx_Hunting_P4 = "157_SuoLian_P4";

	public const int hitDamageId_P4 = 157300005;

	public const string hittedFx_P4 = "fx_15701_hit_01";

	public static readonly FP hitWidth_P4 = 2;

	public static readonly FP hitInterval_P4 = 1;

	public const int addBuffNum_Energy_P4 = 10;

	public const int buffId_P4 = 15704011;

	public const int perkId_5 = 515705;

	public const int damageTimes_Trigger_P5 = 5;

	public const string areaEffectKey_P5 = "AreaEffect_157_P5_FishAtk";

	public const int parameterId_TriggerCD_P5 = 15705011;

	public const int perkId_6 = 515706;

	public static readonly int damageTag_Trigger_P6 = CommonHelper.StringToHash("157FishAtk");

	public const int buffId_ForSelf_P6 = 15706011;

	public const int buffId_ForOther_P6 = 15706012;

	public const int perkId_7 = 515707;

	public static readonly int damageTag_Trigger_P7 = CommonHelper.StringToHash("157FishAtk");

	public const int additionalAttrId_P7 = 15707001;

	public const int perkId_8 = 515708;

	public const string areaEffectKey_P8 = "AreaEffect_157_P8_HuntBreak";

	public const int buffId_P8 = 15708011;

	public const int perkId_9 = 515709;

	public static readonly int damageTag_Trigger_P9 = CommonHelper.StringToHash("157P9Trigger");

	public const int additionalAttrId_P9 = 15709001;

	public const int perkId_10 = 515710;

	public const int buffId_P10 = 15710011;

	public const int perkId_11 = 515711;

	public const int buffId_P11 = 15711011;

	public const int perkId_12 = 515712;

	public const int buffId_P12 = 15712011;

	public const int perkId_13 = 515713;

	public const int buffId_ForSelf_P13 = 15713011;

	public const int buffId_ForAll_P13 = 15713012;

	public static readonly FP followRotateSpeed_FishOverload = 180;

	public static readonly FP followRadius_FishOverload = 4;

	public const string followFxKey_FishOverload_1 = "157SkillMainP2FishSwing";

	public const string followFxKey_FishOverload_2 = "157SkillMainP2FishSwing3";

	public const string attackFxKey_FishOverload = "157SkillMainP2FishAtk";

	public static readonly FP attackDuration_FishOverload = 0.4;

	public const string attackAreaEffecyKey_FishOverload = "AreaEffect_157_P2_FishAtk";

	public static readonly FP stayTimeAfterAttack_FishOverload = 0.2;

	public const string firstAttackAreaEffectKey_Delay_FishOverload = "AreaEffect_157_P2_FishAtk_Act1";

	public static readonly FP delayTime_FirstDelayAreaEffect_FishOverload = 0.01;

	public const string secondAttackAreaEffectKey_Delay_FishOverload = "AreaEffect_157_P2_FishAtk_Act2";

	public static readonly FP delayTime_SecondDelayAreaEffect_FishOverload = 0.45;

	public static readonly FP attackInterval_FishOverload = 1;

	public static readonly FP comeBackSpeed_FishOverload = 20;

	public static readonly int eventHashCode_SkillShoot = CommonHelper.StringToHash("SkillShoot");

	public static readonly int eventHashCode_MarkHuntingTarget = CommonHelper.StringToHash("MarkHuntingTarget");

	public const string logicTag_HuntingTargetId = "HuntingTargetId";
}
