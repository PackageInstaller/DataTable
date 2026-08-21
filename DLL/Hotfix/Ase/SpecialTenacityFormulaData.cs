namespace Ase;

public class SpecialTenacityFormulaData : FormulaZoneDataBase
{
	public float tenacityAdd;

	public float tenacityReduce;

	public override string FormulaDataName => "特殊削韧乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + tenacityAdd - tenacityReduce;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: 1 + 削韧增加({tenacityAdd}) - 削韧减免({tenacityReduce}) = {base.result}";
	}
}
