namespace RogueCard;

public class FirstUseCardCondition : BaseCondition
{
	public override bool Check(TriggerMoment moment)
	{
		switch (moment)
		{
		case TriggerMoment.OnScore:
			return RogueCardGameMain.GameContext.roundPlayNum == 0;
		case TriggerMoment.OnJokerPlayed:
			return RogueCardGameMain.GameContext.roundPlayNum == 0;
		case TriggerMoment.OnCardDiscarded:
		case TriggerMoment.OnDiscardPlayed:
			return RogueCardGameMain.GameContext.roundDiscardNum == 0;
		default:
			return false;
		}
	}
}
