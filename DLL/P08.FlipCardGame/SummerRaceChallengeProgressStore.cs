using UnityEngine;

public static class SummerRaceChallengeProgressStore
{
	private const string KeyPrefix = "SummerRace.Challenge.";

	private const string LastScoreKey = "SummerRace.Challenge.LastScore";

	private const string LastWaveKey = "SummerRace.Challenge.LastWave";

	private const string BestScoreKey = "SummerRace.Challenge.BestScore";

	private const string BestWaveKey = "SummerRace.Challenge.BestWave";

	public static SummerRaceChallengeProgressSnapshot Load()
	{
		return new SummerRaceChallengeProgressSnapshot(PlayerPrefs.GetInt("SummerRace.Challenge.LastScore", 0), PlayerPrefs.GetInt("SummerRace.Challenge.LastWave", 1), PlayerPrefs.GetInt("SummerRace.Challenge.BestScore", 0), PlayerPrefs.GetInt("SummerRace.Challenge.BestWave", 1));
	}

	public static SummerRaceChallengeProgressSnapshot SaveRun(int score, int waveReached)
	{
		SummerRaceChallengeProgressSnapshot summerRaceChallengeProgressSnapshot = Load();
		int num = Mathf.Max(0, score);
		int num2 = Mathf.Max(1, waveReached);
		int num3 = Mathf.Max(summerRaceChallengeProgressSnapshot.BestScore, num);
		int num4 = Mathf.Max(summerRaceChallengeProgressSnapshot.BestWave, num2);
		PlayerPrefs.SetInt("SummerRace.Challenge.LastScore", num);
		PlayerPrefs.SetInt("SummerRace.Challenge.LastWave", num2);
		PlayerPrefs.SetInt("SummerRace.Challenge.BestScore", num3);
		PlayerPrefs.SetInt("SummerRace.Challenge.BestWave", num4);
		PlayerPrefs.Save();
		return new SummerRaceChallengeProgressSnapshot(num, num2, num3, num4);
	}
}
