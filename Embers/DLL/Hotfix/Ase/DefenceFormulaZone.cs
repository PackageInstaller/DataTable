using Ase.ECS;

namespace Ase;

public class DefenceFormulaZone : DamageFormulaZoneBase<DefenceFormulaData>
{
	public const int MONSTER_LEVEL = 5;

	public const int MONSTER_DEFENCE = 500;

	protected override void OnCalcFormulaZone()
	{
		CalcDefence();
		CalcLevel();
		CalcDamageModify();
		CalcExtraReduceDamage();
	}

	protected void CalcDefence()
	{
		BattleFormulaUtility.GetConstantConfigValue(103, out dataBase.defenceLevelConstant);
		BattleFormulaUtility.GetConstantConfigValue(104, out dataBase.defenceConstant);
		dataBase.isMonsterDefender = defender.GetEntityType() == EntityType.MONSTER;
		if (dataBase.isMonsterDefender)
		{
			dataBase.defenceBase = defender.GetProperty("Level") * 5f + 500f;
		}
		else
		{
			dataBase.defenceBase = BattleFormulaUtility.GetSpecialPropertyAddition(defender, "Defence");
		}
		dataBase.igoreDefence = attacker.GetProperty("IgnoreDefence");
		if (!(dataBase.igoreDefence > 1f))
		{
			dataBase.defence = dataBase.defenceBase * (1f - dataBase.igoreDefence);
		}
	}

	protected void CalcLevel()
	{
		dataBase.defenceLevel = defender.GetProperty("Level");
	}

	protected void CalcDamageModify()
	{
		dataBase.damageAddModify = defender.GetProperty("IncreaseDamageAmend");
		dataBase.damageReduceModify = defender.GetProperty("ReduceDamageAmend");
		dataBase.isDamageProbability = defender.GetComponent<EntityDefenceComponent>()?.EntityReduceDamageProbability(attacker) ?? false;
		if (dataBase.isDamageProbability)
		{
			dataBase.damageProbabilityAddition = defender.GetProperty("ProbabilityReduceDamageAmend");
		}
	}

	protected void CalcExtraReduceDamage()
	{
		if (dataDamage.bulletAttackData != null)
		{
			dataBase.isExtraReduceDamage = damageParams.isAttackAngleDenfense;
			if (dataBase.isExtraReduceDamage)
			{
				dataBase.extraReduceDamage = defender.GetComponent<EntityDefenceComponent>()?.subHarmValue ?? 0f;
			}
			if (defender.GetEntityType() == EntityType.HERO)
			{
				dataBase.envReduceDamage = defender.GetProperty("EnvReduceDamage");
			}
		}
	}
}
