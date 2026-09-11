using System;

[Serializable]
public sealed class SummerRaceActivityStageSourceRecord
{
	public string Id = string.Empty;

	public string DisplayName = string.Empty;

	public SummerRaceActivityMode Mode;

	public int SortOrder;

	public bool IsMainline = true;

	public string UnlockStageId = string.Empty;

	public string FirstClearRewardGroupId = string.Empty;

	public string StartStoryId = string.Empty;

	public string EndStoryId = string.Empty;

	public string MapName = string.Empty;

	public string ChallengePoolId = string.Empty;

	public int RecommendedPower;

	public int TimeLimitSeconds;

	public int SurvivalDurationSeconds;

	public float ChallengeWaveHealRatio;

	public float DamageToEnergyRatio = 0.25f;

	public float EnergyRegenPerSecond = 1.8f;

	public float MaxEnergy = 10f;

	public int[] ChallengeWaveScoreTable = Array.Empty<int>();

	public SummerRaceActivitySpecialDefeatRuleSourceRecord[] SpecialDefeatRules = Array.Empty<SummerRaceActivitySpecialDefeatRuleSourceRecord>();

	public SummerRaceActivityWaveSourceRecord[] Waves = Array.Empty<SummerRaceActivityWaveSourceRecord>();

	public SummerRaceActivityEnemySpawnSourceRecord[] SurvivalRandomPool = Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();

	public SummerRaceActivityEnemySpawnSourceRecord[] ChallengeRandomPool = Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
}
