using System;

[Serializable]
public sealed class SummerRaceActivityEnemySpawnSourceRecord
{
	public string EnemyId = string.Empty;

	public int Count = 1;

	public float SpawnDelaySeconds;

	public int Weight = 1;

	public int MinWave = 1;

	public int MaxWave = 999;
}
