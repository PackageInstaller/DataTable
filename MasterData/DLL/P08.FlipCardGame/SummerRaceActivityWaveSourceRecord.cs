using System;

[Serializable]
public sealed class SummerRaceActivityWaveSourceRecord
{
	public int WaveIndex;

	public float SpawnIntervalSeconds;

	public int MaxAliveEnemies;

	public int TimeLimitSeconds;

	public SummerRaceActivityEnemySpawnSourceRecord[] Enemies = Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
}
