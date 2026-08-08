namespace RogueCard;

public class AddByDeckNumAction : BaseAction
{
	private int type;

	private int numType;

	private int num;

	public int Num => num;

	public AddByDeckNumAction(int type, int numType, int num)
	{
		this.type = type;
		this.numType = numType;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnJokerPlayed)
		{
			int num = 40 - RogueCardGameMain.GameContext.GetAllCards.Count;
			if (num > 0)
			{
				ScoreBase scoreBase = GetScoreBase();
				scoreBase.multi = num * this.num;
				RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase);
			}
		}
	}
}
