namespace RogueCard;

public class DrawSameRankCardAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		if (effectEntity is RogueCardData)
		{
			RogueCardData rogueCardData = effectEntity as RogueCardData;
			RogueCardGameMain.Instance.DrawCard(1, rogueCardData.GetRank);
		}
	}
}
