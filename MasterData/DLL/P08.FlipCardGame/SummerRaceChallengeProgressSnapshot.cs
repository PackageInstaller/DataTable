using UnityEngine;

public readonly struct SummerRaceChallengeProgressSnapshot(int lastScore, int lastWave, int bestScore, int bestWave)
{
	public readonly int LastScore = Mathf.Max(0, lastScore);

	public readonly int LastWave = Mathf.Max(1, lastWave);

	public readonly int BestScore = Mathf.Max(0, bestScore);

	public readonly int BestWave = Mathf.Max(1, bestWave);
}
