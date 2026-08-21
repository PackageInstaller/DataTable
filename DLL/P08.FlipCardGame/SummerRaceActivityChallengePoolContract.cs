using System;

[Serializable]
public sealed class SummerRaceActivityChallengePoolContract : SummerRaceActivityIdentifiedContract
{
	public int MinWave = 1;

	public int MaxWave = 999;

	public SummerRaceActivityEnemySpawnContract[] Entries = Array.Empty<SummerRaceActivityEnemySpawnContract>();
}
