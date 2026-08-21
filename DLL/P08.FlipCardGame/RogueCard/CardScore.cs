namespace RogueCard;

public class CardScore : ScoreBase
{
	public RogueCardData cardData;

	public RogueCardJokerData linkedJokerData;

	public override void Reset()
	{
		base.Reset();
		cardData = null;
		linkedJokerData = null;
	}

	public override int GetIndex()
	{
		if (RogueCardGameMain.Instance.gameContext.scoreResult.scoreCardData.Contains(cardData))
		{
			return RogueCardGameMain.Instance.gameContext.scoreResult.scoreCardData.IndexOf(cardData);
		}
		if (RogueCardGameMain.Instance.gameContext.handData.handCards.Contains(cardData))
		{
			return RogueCardGameMain.Instance.gameContext.handData.GetDataIndex(cardData);
		}
		return -1;
	}
}
