namespace Ase;

public class HeroLevelFormulaData : FormulaZoneDataBase
{
	public float passAddition;

	public override string FormulaDataName => "Hero副本属性乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + passAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:1 + 副本普通增伤({passAddition}) = {base.result}";
	}
}
