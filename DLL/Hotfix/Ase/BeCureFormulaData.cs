namespace Ase;

public class BeCureFormulaData : FormulaZoneDataBase
{
	public float beCureAddition;

	public override string FormulaDataName => "被治疗乘区";

	public override void OnFormulaSettlement()
	{
		base.result = 1f + beCureAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: = 1 + 被治疗加成({beCureAddition}) = {base.result}";
	}
}
