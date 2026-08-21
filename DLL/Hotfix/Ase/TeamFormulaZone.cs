namespace Ase;

public class TeamFormulaZone : DamageFormulaZoneBase<TeamFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcTeamDamageAddition();
	}

	protected void CalcTeamDamageAddition()
	{
		dataBase.teamDamageAddition = dataDamage.GetAttackerProperty("TeamDamageAddition");
	}
}
