namespace Ase;

public class AttributeRestraintFormulaData : FormulaZoneDataBase
{
	public HeroAttributeEnum attributeEnum;

	public string propertyKeyTo;

	public float attributeRestraint;

	public string propertyKeyBy;

	public float attributeBeRestraint;

	public override string FormulaDataName => "属性克制乘区";

	public override void OnFormulaSettlement()
	{
		base.result = (1f + attributeRestraint) * (1f + attributeBeRestraint);
	}

	public override string ToString()
	{
		return $"{FormulaDataName}的最终数据:元素属性({attributeEnum}) => (1 + 属性克制值({propertyKeyTo}:{attributeRestraint})) * (1 + 属性被克制值({propertyKeyBy}:{attributeBeRestraint})) = {base.result}";
	}
}
