namespace RogueCard;

public class AddUseHandTypeLevelAction : BaseAction
{
	public int num;

	public AddUseHandTypeLevelAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		RogueCardData[] cards = null;
		if (moment == TriggerMoment.OnAcquire)
		{
			cards = RogueCardGameMain.GameContext.GetWuChangSelect.ToArray();
			HandType bestHandType = RogueCardScoreSystem.Instance.GetBestHandType(cards);
			RogueCardGameMain.Instance.ShowSuitLvUp((int)bestHandType, num);
		}
		if (moment == TriggerMoment.OnScore || moment == TriggerMoment.OnCardPlayed)
		{
			cards = RogueCardGameMain.GameContext.scoreResult.scoreCardData.ToArray();
		}
		if (moment == TriggerMoment.OnDiscardPlayed || moment == TriggerMoment.OnCardDiscarded)
		{
			cards = RogueCardGameMain.GameContext.GetSelectDataList().ToArray();
		}
		if (moment == TriggerMoment.OnHandPlayed)
		{
			cards = RogueCardGameMain.GameContext.scoreResult.scoreCardData.ToArray();
			RogueCardData curEffectData = RogueCardGameMain.GameContext.curEffectData;
			if (curEffectData != null)
			{
				CardScore cardScore = ScorePool.GetCardScore(curEffectData);
				cardScore.isLevelUp = true;
				RogueCardGameMain.GameContext.scoreResult.AddScoreData(cardScore);
			}
			RogueCardGameMain.GameContext.scoreResult.shouleSubLv += num;
		}
		HandType bestHandType2 = RogueCardScoreSystem.Instance.GetBestHandType(cards);
		RogueCardGameMain.GameContext.handTypeLevel[bestHandType2] += num;
		RogueCardGameMain.Instance.RefreshMainUI();
		if (effectEntity != null && effectEntity is RogueCardJokerData)
		{
			RogueCardGameMain.GameContext.scoreResult.beforeLvJoker.Add(RogueCardGameMain.GameContext.jokerData.GetOrderedHandData().IndexOf(effectEntity as RogueCardJokerData));
		}
	}
}
