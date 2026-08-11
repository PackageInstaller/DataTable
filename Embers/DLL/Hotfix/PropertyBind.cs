using System.Collections.Generic;

public class PropertyBind
{
	public static readonly Dictionary<string, List<string>> PropertyRelevant = new Dictionary<string, List<string>>
	{
		{
			"Hp",
			new List<string> { "HpRadio", "FixHp" }
		},
		{
			"HeroChargedEnergy",
			new List<string> { "HeroChargedEnergyScale" }
		},
		{
			"XpEnergy",
			new List<string> { "XpEnergyRatio" }
		},
		{
			"HeroAnger",
			new List<string> { "HeroAngerRatio" }
		},
		{
			"HeroHeat",
			new List<string> { "HeroHeatAdditionRatio", "HeroHeatReduceRatio" }
		},
		{
			"KeennessLayer",
			new List<string> { "KeennerssLayerRatio" }
		},
		{
			"HeroCourage",
			new List<string> { "HeroCourageRatio" }
		}
	};
}
