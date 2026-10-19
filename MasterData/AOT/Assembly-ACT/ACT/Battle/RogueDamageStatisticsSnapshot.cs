namespace ACT.Battle;

public sealed class RogueDamageStatisticsSnapshot
{
	public bool IsRecording { get; }

	public int TotalDamageDealt { get; }

	public int DamageCount { get; }

	public int MaxDamageDealt { get; }

	public int MinDamageDealt { get; }

	public int CriticalCount { get; }

	public int TotalDamageTaken { get; }

	public int TotalKillCount { get; }

	public int NormalKillCount { get; }

	public int EliteKillCount { get; }

	public float ElapsedTime { get; }

	public float DamagePerSecond { get; }

	public int TotalDamage => TotalDamageDealt;

	public int MaxDamage => MaxDamageDealt;

	public int MinDamage => MinDamageDealt;

	public RogueDamageStatisticsSnapshot(bool isRecording, int totalDamageDealt, int damageCount, int maxDamageDealt, int minDamageDealt, int criticalCount, int totalDamageTaken, int totalKillCount, int normalKillCount, int eliteKillCount, float elapsedTime, float damagePerSecond)
	{
		IsRecording = isRecording;
		TotalDamageDealt = totalDamageDealt;
		DamageCount = damageCount;
		MaxDamageDealt = maxDamageDealt;
		MinDamageDealt = minDamageDealt;
		CriticalCount = criticalCount;
		TotalDamageTaken = totalDamageTaken;
		TotalKillCount = totalKillCount;
		NormalKillCount = normalKillCount;
		EliteKillCount = eliteKillCount;
		ElapsedTime = elapsedTime;
		DamagePerSecond = damagePerSecond;
	}
}
