namespace Ase;

public class WeaponSkillAdditionFormulaData : FormulaZoneDataBase
{
	public float weaponAddition;

	public float skillGlobalAddition;

	public override string FormulaDataName => "角色&武器增伤乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + weaponAddition + skillGlobalAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:1 + 武器增伤({weaponAddition}) + 角色增伤({skillGlobalAddition}) = {base.result}";
	}
}
