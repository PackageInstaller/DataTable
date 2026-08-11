using Ase.ECS;

namespace Ase;

public class CritFormulaZone : DamageFormulaZoneBase<CritFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcIsCrit();
		CalcCritDamage();
	}

	protected void CalcIsCrit()
	{
		if (dataDamage.bulletAttackData != null)
		{
			PseudoCritComponent component = attacker.GetComponent<PseudoCritComponent>();
			HitColliderVariableData hitColliderVariableData = dataDamage.bulletAttackData.HitColliderVariableData;
			if (hitColliderVariableData != null)
			{
				dataBase.isCrit = component?.CalculateCrit(defender, weaknessData, hitColliderVariableData) ?? false;
			}
		}
	}

	protected void CalcCritDamage()
	{
		dataBase.critDamage = dataDamage.GetAttackerProperty("CritRadio");
	}
}
