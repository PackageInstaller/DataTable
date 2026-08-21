using System;

[Serializable]
public sealed class SummerRaceChallengeRoundSettlement
{
	public int round;

	public string result = string.Empty;

	public float durationSec;

	public int score;

	public SummerRaceChallengeRoundSettlement Clone()
	{
		return (SummerRaceChallengeRoundSettlement)MemberwiseClone();
	}
}
