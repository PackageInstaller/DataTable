using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

internal sealed class BattlePoolEntry
{
	public readonly string PoolKey;

	public readonly Stack<GameObject> InactiveInstances = new Stack<GameObject>(8);

	public BattlePoolPolicy PoolPolicy;

	public int ActiveInstanceCount;

	public int TotalCreatedCount;

	public int PrewarmCreatedCount;

	public int TotalDestroyedCount;

	public int AcquireReuseCount;

	public int AcquireCreateCount;

	public int ReleaseCount;

	public int ReleaseOverflowDestroyCount;

	public int ManualTrimDestroyCount;

	public int AutoTrimDestroyCount;

	public float LastAcquireTime;

	public float LastReleaseTime;

	public float LastTrimTime;

	public BattlePoolEntry(string key)
	{
		PoolKey = key;
		PoolPolicy = BattlePoolPolicy.Default;
	}

	public BattlePoolStats ToStats()
	{
		return new BattlePoolStats(PoolKey, ActiveInstanceCount, InactiveInstances.Count, TotalCreatedCount, PrewarmCreatedCount, TotalDestroyedCount, AcquireReuseCount, AcquireCreateCount, ReleaseCount, ReleaseOverflowDestroyCount, ManualTrimDestroyCount, AutoTrimDestroyCount, LastAcquireTime, LastReleaseTime, LastTrimTime, PoolPolicy);
	}
}
