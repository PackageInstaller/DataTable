namespace RogueCard;

public class MutliTriggerAction : BaseAction
{
	private int num;

	public MutliTriggerAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (moment != TriggerMoment.OnAcquire && moment == TriggerMoment.OnScore && (effectID == 1151 || effectID == 2051) && (effectID != 1151 || RogueCardScoreSystem.Instance.curScoringIndex == 0) && !RogueCardScoreSystem.Instance.isMulting)
		{
			RogueCardData curScoringCard = RogueCardScoreSystem.Instance.curScoringCard;
			for (int i = 0; i < num; i++)
			{
				JokerScore jokerScore = GetScoreBase() as JokerScore;
				jokerScore.jokerData = effectEntity as RogueCardJokerData;
				jokerScore.isMulti = true;
				RogueCardGameMain.GameContext.scoreResult.multiTag = true;
				RogueCardGameMain.GameContext.scoreResult.AddScoreData(jokerScore);
				CardScore cardScore = ScorePool.GetCardScore(curScoringCard);
				cardScore.score = curScoringCard.GetFinalRank;
				RogueCardGameMain.GameContext.scoreResult.AddScoreData(cardScore);
				RogueCardScoreSystem.Instance.isMulting = true;
				RogueCardGameMain.GameContext.scoreResult.multiTag = true;
				RogueCardEffectManager.Instance.TriggerCard(curScoringCard, TriggerMoment.OnScore);
				RogueCardGameMain.GameContext.scoreResult.multiTag = false;
				RogueCardScoreSystem.Instance.isMulting = false;
			}
		}
	}
}
