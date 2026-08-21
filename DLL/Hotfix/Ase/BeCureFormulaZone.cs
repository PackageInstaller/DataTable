namespace Ase;

public class BeCureFormulaZone : CureFormulaZoneBase<BeCureFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcBeCureAddition();
	}

	protected void CalcBeCureAddition()
	{
		dataBase.beCureAddition = cureEntity.GetProperty("CureExtraScale");
	}
}
