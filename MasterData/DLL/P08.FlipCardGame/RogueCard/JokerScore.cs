namespace RogueCard;

public class JokerScore : ScoreBase
{
	public RogueCardJokerData jokerData;

	public RogueCardData linkedCardData;

	public override void Reset()
	{
		base.Reset();
		jokerData = null;
		linkedCardData = null;
	}

	public override int GetIndex()
	{
		return RogueCardGameMain.GameContext.jokerData.GetOrderedHandData().IndexOf(jokerData);
	}
}
