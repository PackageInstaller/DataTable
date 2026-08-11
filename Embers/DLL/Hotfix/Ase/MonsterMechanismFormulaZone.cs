using Ase.ECS;

namespace Ase;

public class MonsterMechanismFormulaZone : DamageFormulaZoneBase<MonsterMechanismFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcPartAddition();
		CalcFlawAddition();
		CalcMonsterStateAddition();
	}

	protected void CalcPartAddition()
	{
		dataBase.partAddition = dataDamage.DamageScale;
		dataBase.siteLevel = (dataDamage.bulletAttackData?.HitColliderVariableData?.SiteLevel).GetValueOrDefault();
		if (dataBase.siteLevel == 1)
		{
			dataBase.partAdditionRatio = dataDamage.GetAttackerProperty("NBDamageAddition");
		}
		else if (dataBase.siteLevel == 2)
		{
			dataBase.partAdditionRatio = dataDamage.GetAttackerProperty("BDamageAddition");
		}
		else if (dataBase.siteLevel == 3)
		{
			dataBase.partAdditionRatio = dataDamage.GetAttackerProperty("HBDamageAddition");
		}
	}

	protected void CalcFlawAddition()
	{
		if (weaknessData != null)
		{
			dataBase.flawAddition = weaknessData.DamagePercent;
			if (weaknessData.Level >= 2)
			{
				dataBase.flawAdditionRatio = dataDamage.GetAttackerProperty("HighWeaknessDamageAddition");
			}
		}
	}

	protected void CalcMonsterStateAddition()
	{
		StateComponent component = defender.GetComponent<StateComponent>();
		if (component != null)
		{
			dataBase.stateAddition = component.GetEntityStateDamageRatio();
			dataBase.monsterConverselyState = component.IsDownState();
			if (dataBase.monsterConverselyState)
			{
				dataBase.converselyAdditionRatio = dataDamage.GetAttackerProperty("KnockDownDamageAddition");
			}
		}
		MonsterPhaseComponent component2 = defender.GetComponent<MonsterPhaseComponent>();
		if (component2 != null)
		{
			dataBase.monsterFuryState = component2.CheckMonsterPhaseIsOverDrive();
			if (dataBase.monsterFuryState)
			{
				dataBase.furyAddition = defender.GetComponent<MonsterPhaseComponent>()?.GetMonsterPhaseStateAttackScale() ?? 0f;
				dataBase.furyAdditionRatio = dataDamage.GetAttackerProperty("ODDamageAddition");
			}
			dataBase.monsterWeakState = component2.GetMonsterPhaseIsBreak();
			if (dataBase.monsterWeakState)
			{
				dataBase.weakAdditionRatio = dataDamage.GetAttackerProperty("BreakDamageAddition");
			}
		}
	}
}
