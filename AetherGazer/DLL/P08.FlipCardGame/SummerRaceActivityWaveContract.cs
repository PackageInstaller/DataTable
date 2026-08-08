using System;

[Serializable]
public sealed class SummerRaceActivityWaveContract
{
	public int WaveIndex;

	public float SpawnIntervalSeconds;

	public int MaxAliveEnemies;

	public int TimeLimitSeconds;

	public SummerRaceActivityEnemySpawnContract[] Enemies = Array.Empty<SummerRaceActivityEnemySpawnContract>();
}
