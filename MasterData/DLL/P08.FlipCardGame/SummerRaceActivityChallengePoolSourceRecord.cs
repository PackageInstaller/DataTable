using System;

[Serializable]
public sealed class SummerRaceActivityChallengePoolSourceRecord
{
	public string Id = string.Empty;

	public string DisplayName = string.Empty;

	public int MinWave = 1;

	public int MaxWave = 999;

	public SummerRaceActivityEnemySpawnSourceRecord[] Entries = Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
}
