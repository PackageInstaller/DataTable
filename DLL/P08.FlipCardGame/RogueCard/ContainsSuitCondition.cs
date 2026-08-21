using System.Collections.Generic;

namespace RogueCard;

public class ContainsSuitCondition : BaseCondition
{
	private Rank rank;

	public ContainsSuitCondition(int[] value)
	{
		rank = (Rank)value[0];
	}

	public override bool Check(TriggerMoment moment)
	{
		List<RogueCardData> list = ((moment != TriggerMoment.OnCardPlayed) ? RogueCardGameMain.GameContext.GetSelectDataList() : RogueCardGameMain.GameContext.scoreResult.scoreCardData);
		foreach (RogueCardData item in list)
		{
			if (item.GetRank == rank)
			{
				return true;
			}
		}
		return false;
	}
}
