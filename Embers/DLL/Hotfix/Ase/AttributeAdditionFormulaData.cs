namespace Ase;

public class AttributeAdditionFormulaData : FormulaZoneDataBase
{
	public float attributeAddition;

	public override string FormulaDataName => "元素增伤乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + attributeAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:1 + 元素增伤值({attributeAddition}) = {base.result}";
	}
}
