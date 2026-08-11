namespace Ase;

public class StateTenacityFormulaData : FormulaZoneDataBase
{
	public float stateAddition;

	public override string FormulaDataName => "状态削韧乘区";

	public override void OnFormulaSettlement()
	{
		base.result = stateAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: 削韧状态加成({stateAddition}) = {base.result}";
	}
}
