using TrueSync;

namespace AIScript.Character._13701;

public class Config_MainControl
{
	public static readonly string ComboTagSkillMain = "Skill_Main";

	public const int buffId_State_Skill = 13700011;

	public const string AddAlertBuffEventName = "137AddJingJieBuff";

	public const string areaEffectKey_A_DiffuseAttack = "AreaEffect_137_MainSkill_Ring_OutAtk";

	public const string areaEffectKey_B_ShrinkRotate = "AreaEffect_137_MainSkill_Ring_In";

	public static readonly int AlertHitTag_137 = CommonHelper.StringToHash("137MainUavAtk");

	public static readonly FP switchTime_AToB = 1;

	public const int perkId_513701 = 513701;

	public const string CrossSlashEnhanceTag = "Atk_Sp_P1";

	public const int parameterId_513701_ArmedEnergyCDReduction = 13701011;

	public const int onceId_513701_Damage = 13701011;

	public const int perkId_513702 = 513702;

	public const int parameterId_513702_ArmedEnergyRemaining = 13702011;

	public const string bulletAlias_513702_Grenade = "Bullet_137_P2_ShouLei";

	public static readonly FP grenadeNoTargetDistance_513702 = 4;

	public static readonly FP grenadeScatterRadius_513702 = 3;

	public const int perkId_513703 = 513703;

	public const int buffId_513703_AddDamage = 13703011;

	public const string areaEffectKey_A_DiffuseAttack_513703 = "AreaEffect_137_MainSkill_Ring_OutAtk_P3";

	public const string areaEffectKey_B_ShrinkRotate_513703 = "AreaEffect_137_MainSkill_Ring_In_P3";

	public static readonly FP durationTime_A_513703 = 0.66;

	public const int perkId_513704 = 513704;

	public const int AlertReTriggerHitThreshold = 2;

	public static readonly FP AlertReTriggerCD = 0.5;

	public const int buffId_513704_AddBuff = 13704011;

	public static readonly int AlertHitTag_137Self = CommonHelper.StringToHash("137Self");

	public const string areaEffectKey_A_DiffuseAttack_NoFollow = "AreaEffect_137_MainSkill_Ring_OutAtk_P4";

	public const string areaEffectKey_A_DiffuseAttack_Fast_NoFollow = "AreaEffect_137_MainSkill_Ring_OutAtk_P4";

	public const string areaEffectKey_A_DiffuseAttack_P8_NoFollow = "AreaEffect_137_MainSkill_Ring_OutAtk_P8_P4";

	public const string areaEffectKey_A_DiffuseAttack_FastP8_NoFollow = "AreaEffect_137_MainSkill_Ring_OutAtk_P3P8_P4";

	public const int perkId_513705 = 513705;

	public const string CrossSlashExplodeTag = "Atk_Sp_P5";

	public const int onceId_513705_Damage = 13705001;

	public const string CrossSlashEnhanceExplodeTag = "Atk_Sp_P1_P5";

	public const int perkId_513706 = 513706;

	public const int buffId_513706_AddBuff = 13706011;

	public const int perkId_513707 = 513707;

	public const int buffId_513707_AddDamage = 13707011;

	public static readonly int damageTag_513707_Atk5_TriggerWindMark = CommonHelper.StringToHash("137NrmAktEnd");

	public static readonly FP randomRadius_AreaEffect_513707_TriggerWindMark = 1.5;

	public const int perkId_513708 = 513708;

	public const string areaEffectKey_A_DiffuseAttack_513708 = "AreaEffect_137_MainSkill_Ring_OutAtk_P8";

	public const int onceId_513708_Damage = 13708001;

	public const string areaEffectKey_A_DiffuseAttack_Fast_513708 = "AreaEffect_137_MainSkill_Ring_OutAtk_P3P8";

	public const int perkId_513709 = 513709;

	public static readonly FP searchRadius_513709 = 4;

	public const int buffId_513709_AddStack = 13709011;

	public const int perkId_513710 = 513710;

	public static readonly FP cd_513710 = 1;

	public const int buffId_513710_AddBuff = 13710011;

	public const int perkId_513711 = 513711;

	public const int perkId_513712 = 513712;

	public const int parameterId_513712_DodgeCDReductionPct = 13712011;

	public const int perkId_513713 = 513713;

	public const int buffId_513713_AddBuff = 13713011;

	public const string AlertSessionStartName = "AlertSessionStart";

	public static string SelectAlertSpreadKey(bool useFast, bool useP08, bool follow = true)
	{
		if (follow)
		{
			if (useP08 & useFast)
			{
				return "AreaEffect_137_MainSkill_Ring_OutAtk_P3P8";
			}
			if (useP08)
			{
				return "AreaEffect_137_MainSkill_Ring_OutAtk_P8";
			}
			if (useFast)
			{
				return "AreaEffect_137_MainSkill_Ring_OutAtk_P3";
			}
			return "AreaEffect_137_MainSkill_Ring_OutAtk";
		}
		if (useP08 & useFast)
		{
			return "AreaEffect_137_MainSkill_Ring_OutAtk_P3P8_P4";
		}
		if (useP08)
		{
			return "AreaEffect_137_MainSkill_Ring_OutAtk_P8_P4";
		}
		return "AreaEffect_137_MainSkill_Ring_OutAtk_P4";
	}
}
