namespace ACT.UI;

public class SpecialEnergyData11101 : SpecialEnergyBarData
{
	public float targetValue { get; }

	public SpecialEnergyData11101(SpecialEnergyBarConfig11101 config)
	{
		targetValue = config.TargetValue;
	}
}
