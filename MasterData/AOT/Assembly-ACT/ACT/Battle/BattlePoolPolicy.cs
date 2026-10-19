using UnityEngine;

namespace ACT.Battle;

public readonly struct BattlePoolPolicy(int maxInactiveCount, int autoTrimInactiveCount, float autoTrimDelaySeconds, float sweepIntervalSeconds, BattlePoolAutoRecycleMode autoRecycleMode)
{
	public int MaxInactiveCount { get; } = Mathf.Max(0, maxInactiveCount);

	public int AutoTrimInactiveCount { get; } = Mathf.Clamp(autoTrimInactiveCount, 0, Mathf.Max(0, maxInactiveCount));

	public float AutoTrimDelaySeconds { get; } = Mathf.Max(0f, autoTrimDelaySeconds);

	public float SweepIntervalSeconds { get; } = Mathf.Max(0.1f, sweepIntervalSeconds);

	public BattlePoolAutoRecycleMode AutoRecycleMode { get; } = autoRecycleMode;

	public static BattlePoolPolicy Default => new BattlePoolPolicy(32, 8, 30f, 5f, BattlePoolAutoRecycleMode.Update);

	public BattlePoolPolicy WithAutoRecycleMode(BattlePoolAutoRecycleMode autoRecycleMode)
	{
		return new BattlePoolPolicy(MaxInactiveCount, AutoTrimInactiveCount, AutoTrimDelaySeconds, SweepIntervalSeconds, autoRecycleMode);
	}
}
