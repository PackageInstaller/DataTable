namespace Ase;

public class IntensifyTenacityFormulaData : FormulaZoneDataBase
{
	public float intensifyAddition;

	public float treeAddition;

	public float extraTreeAddition;

	public override string FormulaDataName => "强化削韧乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + intensifyAddition + treeAddition + extraTreeAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: 1 + 削韧强化加成({intensifyAddition}) + 行为树加成({treeAddition}) + 额外行为树加成({extraTreeAddition}) = {base.result}";
	}
}
