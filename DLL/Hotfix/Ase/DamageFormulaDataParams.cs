using Ase.ECS;

namespace Ase;

public class DamageFormulaDataParams : FormulaDataParams
{
	public BaseEntity attacker;

	public BaseEntity defender;

	public BuffDataDamage dataDamage;

	public BaseWeaknessData weaknessData;

	public bool isImmuneState;

	public bool isAttackAngleDenfense;
}
