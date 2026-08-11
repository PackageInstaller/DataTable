namespace Ase;

public class InteractiveDamageFormulaZone : DamageFormulaZoneBase<InteractiveDamageFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcInteractiveDamage();
	}

	protected void CalcInteractiveDamage()
	{
		float valueOrDefault = (dataDamage.bulletAttackData?.bulletData.extraData?.bulletMapExData?.Damage).GetValueOrDefault();
		if (valueOrDefault != 0f)
		{
			dataBase.interactiveDamage = defender.GetPropertyMax("Hp") * valueOrDefault * 0.01f;
		}
	}
}
