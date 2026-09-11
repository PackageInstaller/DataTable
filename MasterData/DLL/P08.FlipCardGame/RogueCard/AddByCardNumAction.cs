namespace RogueCard;

public class AddByCardNumAction : BaseAction
{
	private int numType;

	private int num;

	public AddByCardNumAction(int numType, int num)
	{
		this.numType = numType;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		int count = RogueCardGameMain.GameContext.handData.handCards.Count;
		if (moment == TriggerMoment.OnJokerPlayed)
		{
			JokerScore jokerScore = GetScoreBase() as JokerScore;
			jokerScore.allMulti *= (float)num * (float)count / 100f;
			RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(jokerScore);
		}
		else
		{
			ScoreBase scoreBase = GetScoreBase();
			scoreBase.allMulti *= (float)num * (float)count / 100f;
			RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase);
		}
	}
}
