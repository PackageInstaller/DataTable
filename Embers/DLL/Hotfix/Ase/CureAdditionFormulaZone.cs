namespace Ase;

public class CureAdditionFormulaZone : CureFormulaZoneBase<CureAdditionFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcCurenAddition();
	}

	protected void CalcCurenAddition()
	{
		dataBase.cureAddition = doctorEntity.GetProperty("CureAddition");
	}
}
