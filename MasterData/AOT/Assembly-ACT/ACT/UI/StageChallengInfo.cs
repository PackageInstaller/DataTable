namespace ACT.UI;

public class StageChallengInfo
{
	public int bossID;

	public int curScore;

	public int maxHistoryScor;

	public void SetCurScore(int score)
	{
		curScore = score;
	}

	public void SetMaxScore(int score)
	{
		maxHistoryScor = score;
	}
}
