namespace Ase;

public class AttributeAdditionFormulaZone : DamageFormulaZoneBase<AttributeAdditionFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcAttributeAddition();
	}

	protected void CalcAttributeAddition()
	{
		string elementAdditionPropertyKey = BattleFormulaUtility.GetElementAdditionPropertyKey(dataDamage.DamageTypeEnum);
		if (!string.IsNullOrEmpty(elementAdditionPropertyKey))
		{
			dataBase.attributeAddition = dataDamage.GetAttackerProperty(elementAdditionPropertyKey);
		}
	}
}
