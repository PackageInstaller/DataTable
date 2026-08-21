namespace Ase;

public class HeroLevelFormulaZone : DamageFormulaZoneBase<HeroLevelFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcHeroLevelAdditon();
	}

	protected void CalcHeroLevelAdditon()
	{
		dataBase.passAddition = attacker.GetProperty("PassAddition");
	}
}
