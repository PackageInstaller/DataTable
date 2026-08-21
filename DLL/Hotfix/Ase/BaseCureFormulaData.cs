namespace Ase;

public class BaseCureFormulaData : FormulaZoneDataBase
{
	public float propertyAddition;

	public float fixedAddition;

	public bool isFormula;

	public override string FormulaDataName => "基础治疗乘区";

	public override void OnFormulaSettlement()
	{
		base.result = propertyAddition + fixedAddition;
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据: = [是否走公式:{isFormula}] 属性加成({propertyAddition}) + 固定加成({fixedAddition}) = {base.result}";
	}
}
