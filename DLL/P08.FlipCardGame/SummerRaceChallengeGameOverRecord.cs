using System;

[Serializable]
public readonly struct SummerRaceChallengeGameOverRecord(bool isWin, string resultMessage, int score, int waveReached, int bestScore, int bestWave)
{
	public readonly bool IsWin = isWin;

	public readonly string ResultMessage = resultMessage ?? string.Empty;

	public readonly int Score = score;

	public readonly int WaveReached = waveReached;

	public readonly int BestScore = bestScore;

	public readonly int BestWave = bestWave;

	public string ToLogLine()
	{
		string[] obj = new string[12]
		{
			"win=", null, null, null, null, null, null, null, null, null,
			null, null
		};
		bool isWin = IsWin;
		obj[1] = isWin.ToString();
		obj[2] = " score=";
		int score = Score;
		obj[3] = score.ToString();
		obj[4] = " wave=";
		score = WaveReached;
		obj[5] = score.ToString();
		obj[6] = " bestScore=";
		score = BestScore;
		obj[7] = score.ToString();
		obj[8] = " bestWave=";
		score = BestWave;
		obj[9] = score.ToString();
		obj[10] = " msg=";
		obj[11] = ResultMessage;
		return string.Concat(obj);
	}
}
