namespace ACT.Battle;

public readonly struct BattlePoolStats(string poolKey, int activeInstanceCount, int inactiveInstanceCount, int totalCreatedCount, int prewarmCreatedCount, int totalDestroyedCount, int acquireReuseCount, int acquireCreateCount, int releaseCount, int releaseOverflowDestroyCount, int manualTrimDestroyCount, int autoTrimDestroyCount, float lastAcquireTime, float lastReleaseTime, float lastTrimTime, BattlePoolPolicy poolPolicy)
{
	public string PoolKey { get; } = poolKey;

	public int ActiveInstanceCount { get; } = activeInstanceCount;

	public int InactiveInstanceCount { get; } = inactiveInstanceCount;

	public int TotalCreatedCount { get; } = totalCreatedCount;

	public int PrewarmCreatedCount { get; } = prewarmCreatedCount;

	public int TotalDestroyedCount { get; } = totalDestroyedCount;

	public int AcquireReuseCount { get; } = acquireReuseCount;

	public int AcquireCreateCount { get; } = acquireCreateCount;

	public int ReleaseCount { get; } = releaseCount;

	public int ReleaseOverflowDestroyCount { get; } = releaseOverflowDestroyCount;

	public int ManualTrimDestroyCount { get; } = manualTrimDestroyCount;

	public int AutoTrimDestroyCount { get; } = autoTrimDestroyCount;

	public float LastAcquireTime { get; } = lastAcquireTime;

	public float LastReleaseTime { get; } = lastReleaseTime;

	public float LastTrimTime { get; } = lastTrimTime;

	public BattlePoolPolicy PoolPolicy { get; } = poolPolicy;
}
