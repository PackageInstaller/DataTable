namespace Ase;

public class AIBeCureFormulaData : FormulaZoneDataBase
{
	public float beCureAddition;

	public float accountLevel;

	public float cureConstantA;

	public float cureConstantB;

	public override string FormulaDataName => "AI被治疗乘区";

	public override void OnFormulaSettlement()
	{
		base.result = cureConstantA + accountLevel * cureConstantB;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: 治疗修正常数A({cureConstantA}) + 账号等级({accountLevel}) * 治疗修正常数B({cureConstantB}) = {base.result}";
	}
}
