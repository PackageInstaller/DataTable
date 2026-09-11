namespace RogueCard;

public class DeleteSelfAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnCardDiscarded)
		{
			RogueCardData data = RogueCardGameMain.GameContext.GetSelectDataList()[0];
			RogueCardGameMain.GameContext.RemoveCard(data);
		}
		if (moment == TriggerMoment.OnRoundWin && effectEntity is RogueCardData)
		{
			RogueCardGameMain.GameContext.RemoveCard(effectEntity as RogueCardData);
		}
	}
}
