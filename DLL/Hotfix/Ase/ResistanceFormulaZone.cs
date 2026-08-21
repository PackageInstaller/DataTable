namespace Ase;

public class ResistanceFormulaZone : DamageFormulaZoneBase<ResistanceFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcResistance();
	}

	protected void CalcResistance()
	{
		string text = string.Empty;
		switch (dataDamage.DamageTypeEnum)
		{
		case HeroAttributeEnum.Wind:
			text = "WindResistance";
			break;
		case HeroAttributeEnum.Water:
			text = "WaterResistance";
			break;
		case HeroAttributeEnum.Fire:
			text = "FireResistance";
			break;
		case HeroAttributeEnum.Light:
			text = "LightResistance";
			break;
		case HeroAttributeEnum.Dark:
			text = "DarkResistance";
			break;
		case HeroAttributeEnum.Ice:
			text = "IceResistance";
			break;
		case HeroAttributeEnum.Thunder:
			text = "ThunderResistance";
			break;
		case HeroAttributeEnum.Rock:
			text = "RockResistance";
			break;
		case HeroAttributeEnum.Dragon:
			text = "DragonResistance";
			break;
		}
		if (!string.IsNullOrEmpty(text))
		{
			dataBase.resistance = dataDamage.GetAttackerProperty(text);
		}
	}
}
