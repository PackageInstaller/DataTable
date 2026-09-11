namespace RogueCard;

public class AddByRankAction : BaseAction
{
	private int valueType;

	private int addType;

	private int ratio;

	public AddByRankAction(int valueType, int addType, int ratio)
	{
		this.valueType = valueType;
		this.addType = addType;
		this.ratio = ratio;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnScore)
		{
			RogueCardData curScoringCard = RogueCardScoreSystem.Instance.curScoringCard;
			if (valueType == 1 && addType == 2)
			{
				(effectEntity as RogueCardJokerData).addPoint += (int)((float)ratio / 100f * (float)curScoringCard.GetFinalRank);
			}
			if (valueType == 2 && addType == 1)
			{
				ScoreBase scoreBase = GetScoreBase();
				scoreBase.multi = (int)((float)ratio / 100f * (float)curScoringCard.GetFinalRank);
				RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(scoreBase);
			}
		}
	}
}
