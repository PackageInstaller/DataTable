namespace Ase;

public class SpecialTenacityFormulaZone : TenacityFormulaZoneBase<SpecialTenacityFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcSpecialAddition();
	}

	protected void CalcSpecialAddition()
	{
		dataBase.tenacityAdd = defender.GetProperty("TenacityIncrease");
		dataBase.tenacityReduce = defender.GetProperty("TenacityMitigate");
	}
}
