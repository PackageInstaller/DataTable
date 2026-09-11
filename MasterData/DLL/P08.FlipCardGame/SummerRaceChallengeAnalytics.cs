using System;

public static class SummerRaceChallengeAnalytics
{
	public static event Action<SummerRaceChallengeGameOverRecord> ChallengeGameOverSubmitted;

	public static void ReportGameOver(bool isWin, string resultMessage, int score, int waveReached, int bestScore, int bestWave)
	{
		SummerRaceChallengeGameOverRecord obj = new SummerRaceChallengeGameOverRecord(isWin, resultMessage, score, waveReached, bestScore, bestWave);
		SummerRaceRuntimeLog.Log("[SummerRace][ChallengeAnalytics] leaderboard game-over " + obj.ToLogLine());
		ChallengeGameOverSubmitted?.Invoke(obj);
	}
}
