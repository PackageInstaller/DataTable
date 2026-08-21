namespace RogueCard;

public class IsTargetSuitCondition : BaseCondition
{
	public int type;

	public Suit suit;

	public IsTargetSuitCondition(int[] param)
	{
		type = param[0];
		suit = (Suit)param[1];
	}

	public override bool Check(TriggerMoment moment)
	{
		switch (moment)
		{
		case TriggerMoment.OnAcquire:
			return true;
		case TriggerMoment.OnScore:
			if (RogueCardScoreSystem.Instance.curScoringCard?.GetSuit == suit || (RogueCardScoreSystem.Instance.curScoringCard != null && RogueCardScoreSystem.Instance.curScoringCard.allSuit))
			{
				return true;
			}
			break;
		case TriggerMoment.OnJokerPlayed:
			if (type != 2)
			{
				break;
			}
			foreach (RogueCardData orderedHandDatum in RogueCardGameMain.GameContext.handData.GetOrderedHandData())
			{
				if (orderedHandDatum.GetSuit != suit && !orderedHandDatum.allSuit)
				{
					return false;
				}
			}
			return true;
		case TriggerMoment.OnDiscardPlayed:
			if (RogueCardGameMain.GameContext.curEffectData.GetSuit == suit || RogueCardGameMain.GameContext.curEffectData.allSuit)
			{
				return true;
			}
			break;
		}
		return false;
	}
}
