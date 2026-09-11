namespace RogueCard;

public class HandTypeCondition : BaseCondition
{
	public HandType type;

	public HandTypeCondition(int[] param)
	{
		type = (HandType)param[0];
	}

	public override bool Check(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnCardPlayed && RogueCardScoreSystem.Instance.IsContainHandType(type, RogueCardGameMain.GameContext.scoreResult.scoreCardData))
		{
			return true;
		}
		if (moment == TriggerMoment.OnJokerPlayed && RogueCardScoreSystem.Instance.IsContainHandType(type, RogueCardGameMain.GameContext.scoreResult.scoreCardData))
		{
			return true;
		}
		return false;
	}
}
