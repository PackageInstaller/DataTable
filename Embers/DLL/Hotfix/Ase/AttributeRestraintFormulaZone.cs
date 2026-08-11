namespace Ase;

public class AttributeRestraintFormulaZone : DamageFormulaZoneBase<AttributeRestraintFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcAttributeRestraint();
	}

	protected void CalcAttributeRestraint()
	{
		dataBase.attributeEnum = dataDamage.DamageTypeEnum;
		dataBase.propertyKeyTo = BattleFormulaUtility.GetElementToRelation(dataDamage.DamageTypeEnum);
		dataBase.attributeRestraint = dataDamage.GetAttackerProperty(dataBase.propertyKeyTo);
		dataBase.propertyKeyBy = BattleFormulaUtility.GetElementByRelation(dataDamage.DamageTypeEnum);
		dataBase.attributeBeRestraint = defender.GetProperty(dataBase.propertyKeyBy);
	}
}
