using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13701;

public static class Config
{
	public static readonly List<string> comboTagListNormalAttack = new List<string> { "Atk1", "Atk2", "Atk3", "Atk4", "Atk5" };

	public const string CrossSlashTag = "Atk_Sp";

	public const string CrossSlashEnhanceTag = "Atk_Sp_P1";

	public static readonly FP SaveComboIndexTime = 2;

	public const string NormalAttackCountName = "137TD_NormalAttackCount";

	public const string LastNormalAttackTimeName = "137TD_LastNormalAttackTime";

	public const int ArmedEnergyBuffId = 801370050;

	public const int ArmedEnergyGainPerAttack = 2;

	public const int CrossSlashCostEnergy = 10;

	public const int buffId_State_Skill = 801370040;

	public const int buffId_State_Skill_P04 = 801370060;

	public static readonly FP BaseSkillTime_Alert = 6;

	public const string ComboTagSkillMain = "Skill_Main";

	public const string areaEffectKey_A_DiffuseAttack = "AreaEffect_137_MainSkill_Ring_OutAtk";

	public const string areaEffectKey_A_DiffuseAttack_Fast = "AreaEffect_137_MainSkill_Ring_OutAtk_P3";

	public const string areaEffectKey_A_DiffuseAttack_Big = "AreaEffect_137_MainSkill_Ring_OutAtk_P8";

	public const string areaEffectKey_A_DiffuseAttack_FastBig = "AreaEffect_137_MainSkill_Ring_OutAtk_P3P8";

	public const string areaEffectKey_B_ShrinkRotate = "AreaEffect_137_MainSkill_Ring_In";

	public const string areaEffectKey_B_ShrinkRotate_Fast = "AreaEffect_137_MainSkill_Ring_In_P3";

	public static readonly FP switchTime_Alert = 1;

	public static readonly FP switchTime_Alert_Fast = 0.66;

	public const int perkId_1 = 1370101;

	public const int perkId_2 = 1370102;

	public const int perkId_3 = 1370103;

	public const int perkId_4 = 1370104;

	public const string bulletAlias_Grenade = "Bullet_137_P2_ShouLei";

	public static readonly FP grenadeScatterRadius = 3;

	public static readonly FP grenadeNoTargetDistance = 4;

	public static readonly int grenadeBulletTag = CommonHelper.StringToHash("137P2ShouLei");

	public const string areaEffectKey_Grenade = "AreaEffect_137_P2_ShouLei_Bloom";

	public const int extraEnergyGain_P03 = 2;

	public static readonly FP addDuration_P04 = 7;

	public static bool IsInAlert(AdventureActor actor)
	{
		if (!actor.buffComponent.CheckBuffByBuffID(801370040))
		{
			return actor.buffComponent.CheckBuffByBuffID(801370060);
		}
		return true;
	}

	public static string SelectAlertSpreadKey(bool useFast, bool useBig)
	{
		if (useFast & useBig)
		{
			return "AreaEffect_137_MainSkill_Ring_OutAtk_P3P8";
		}
		if (useBig)
		{
			return "AreaEffect_137_MainSkill_Ring_OutAtk_P8";
		}
		if (useFast)
		{
			return "AreaEffect_137_MainSkill_Ring_OutAtk_P3";
		}
		return "AreaEffect_137_MainSkill_Ring_OutAtk";
	}
}
