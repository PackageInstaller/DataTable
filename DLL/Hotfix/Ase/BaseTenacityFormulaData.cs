namespace Ase;

public class BaseTenacityFormulaData : FormulaZoneDataBase
{
	public float minTenacity;

	public float tenacityConstant;

	public float damage;

	public override string FormulaDataName => "基础削韧乘区";

	public override void OnFormulaSettlement()
	{
		base.result = minTenacity + tenacityConstant * damage;
	}

	public override void OnDefaultSettlement()
	{
		base.result = 0f;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: 怪物保底削韧({minTenacity}) + 削韧常数({tenacityConstant}) * 伤害({damage}) = {base.result}";
	}
}
