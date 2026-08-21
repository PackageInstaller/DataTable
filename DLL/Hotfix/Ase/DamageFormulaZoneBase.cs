using Ase.ECS;

namespace Ase;

public class DamageFormulaZoneBase<T> : FormulaZoneBase where T : FormulaZoneDataBase, new()
{
	protected DamageFormulaDataParams damageParams;

	protected BaseEntity attacker;

	protected BaseEntity defender;

	protected BuffDataDamage dataDamage;

	protected BaseWeaknessData weaknessData;

	protected bool isImmuneState;

	protected T dataBase;

	protected override void OnInit(FormulaDataParams param)
	{
		base.OnInit(param);
		dataBase = new T();
		damageParams = param as DamageFormulaDataParams;
		if (damageParams != null)
		{
			attacker = damageParams.attacker;
			defender = damageParams.defender;
			dataDamage = damageParams.dataDamage;
			weaknessData = damageParams.weaknessData;
			isImmuneState = damageParams.isImmuneState;
		}
	}

	public override bool CheckIsCalcFormulaZone()
	{
		return dataDamage.isExcuteFormula;
	}

	protected override void OnCalcFormulaZone()
	{
	}

	protected override FormulaZoneDataBase GetDataBase()
	{
		return dataBase;
	}

	protected override void OnFormulaSettlement()
	{
		dataBase.OnFormulaSettlement();
	}
}
