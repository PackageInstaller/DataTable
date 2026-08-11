namespace Ase;

public class CureAdditionFormulaData : FormulaZoneDataBase
{
	public float cureAddition;

	public override string FormulaDataName => "治疗加成乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + cureAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: = 1 + 治疗加成({cureAddition}) = {base.result}";
	}
}
