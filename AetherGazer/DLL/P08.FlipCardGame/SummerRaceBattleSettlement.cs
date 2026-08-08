using System;

[Serializable]
public sealed class SummerRaceBattleSettlement
{
	public bool isWin;

	public string mode = string.Empty;

	public string stageId = string.Empty;

	public int score;

	public int destroyedEnemies;

	public float battleElapsed;

	public string resultText = string.Empty;

	public string resultReason = string.Empty;

	public SummerRaceRoundSettlement[] roundRecords = Array.Empty<SummerRaceRoundSettlement>();

	public SummerRaceSurvivalEnemySettlement[] survivalEnemyRecords = Array.Empty<SummerRaceSurvivalEnemySettlement>();

	public int challengeReachedWave;

	public SummerRaceChallengeRoundSettlement[] challengeRoundRecords = Array.Empty<SummerRaceChallengeRoundSettlement>();

	public SummerRaceBattleSettlement Clone()
	{
		SummerRaceBattleSettlement obj = (SummerRaceBattleSettlement)MemberwiseClone();
		obj.roundRecords = CloneRoundRecords(roundRecords);
		obj.survivalEnemyRecords = CloneSurvivalEnemyRecords(survivalEnemyRecords);
		obj.challengeRoundRecords = CloneChallengeRoundRecords(challengeRoundRecords);
		return obj;
	}

	private static SummerRaceRoundSettlement[] CloneRoundRecords(SummerRaceRoundSettlement[] source)
	{
		if (source == null || source.Length == 0)
		{
			return Array.Empty<SummerRaceRoundSettlement>();
		}
		SummerRaceRoundSettlement[] array = new SummerRaceRoundSettlement[source.Length];
		for (int i = 0; i < source.Length; i++)
		{
			array[i] = ((source[i] != null) ? source[i].Clone() : new SummerRaceRoundSettlement());
		}
		return array;
	}

	private static SummerRaceSurvivalEnemySettlement[] CloneSurvivalEnemyRecords(SummerRaceSurvivalEnemySettlement[] source)
	{
		if (source == null || source.Length == 0)
		{
			return Array.Empty<SummerRaceSurvivalEnemySettlement>();
		}
		SummerRaceSurvivalEnemySettlement[] array = new SummerRaceSurvivalEnemySettlement[source.Length];
		for (int i = 0; i < source.Length; i++)
		{
			array[i] = ((source[i] != null) ? source[i].Clone() : new SummerRaceSurvivalEnemySettlement());
		}
		return array;
	}

	private static SummerRaceChallengeRoundSettlement[] CloneChallengeRoundRecords(SummerRaceChallengeRoundSettlement[] source)
	{
		if (source == null || source.Length == 0)
		{
			return Array.Empty<SummerRaceChallengeRoundSettlement>();
		}
		SummerRaceChallengeRoundSettlement[] array = new SummerRaceChallengeRoundSettlement[source.Length];
		for (int i = 0; i < source.Length; i++)
		{
			array[i] = ((source[i] != null) ? source[i].Clone() : new SummerRaceChallengeRoundSettlement());
		}
		return array;
	}
}
