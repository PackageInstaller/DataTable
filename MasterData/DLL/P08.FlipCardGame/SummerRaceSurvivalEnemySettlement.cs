using System;

[Serializable]
public sealed class SummerRaceSurvivalEnemySettlement
{
	public int round;

	public string enemyId = string.Empty;

	public string result = string.Empty;

	public float durationSec;

	public bool showTime = true;

	public SummerRaceSurvivalEnemySettlement Clone()
	{
		return (SummerRaceSurvivalEnemySettlement)MemberwiseClone();
	}
}
