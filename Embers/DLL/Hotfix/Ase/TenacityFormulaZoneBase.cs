using Ase.ECS;

namespace Ase;

public class TenacityFormulaZoneBase<T> : FormulaZoneBase where T : FormulaZoneDataBase, new()
{
	protected TenacityFormulaDataParams tenacityParams;

	protected BaseEntity attacker;

	protected BaseEntity defender;

	protected BuffDataDamage dataDamage;

	protected BaseWeaknessData weaknessData;

	protected int damage;

	protected T dataBase;

	protected override void OnInit(FormulaDataParams param)
	{
		base.OnInit(param);
		dataBase = new T();
		tenacityParams = param as TenacityFormulaDataParams;
		if (tenacityParams != null)
		{
			attacker = tenacityParams.attacker;
			defender = tenacityParams.defender;
			dataDamage = tenacityParams.dataDamage;
			damage = tenacityParams.damage;
			weaknessData = tenacityParams.weaknessData;
		}
	}

	public override bool CheckIsCalcFormulaZone()
	{
		if (dataDamage.isExcuteFormula)
		{
			return defender.GetEntityType() == EntityType.MONSTER;
		}
		return false;
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
