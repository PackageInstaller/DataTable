using System;

[Serializable]
public sealed class SummerRaceRoundSettlement
{
	public int round;

	public string result = string.Empty;

	public float durationSec;

	public SummerRaceRoundSettlement Clone()
	{
		return (SummerRaceRoundSettlement)MemberwiseClone();
	}
}
