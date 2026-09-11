using System.Collections.Generic;

namespace RogueCard;

public class SameRankCondition : BaseCondition
{
	public int value;

	public SameRankCondition(int[] param)
	{
		value = param[0];
	}

	public override bool Check(TriggerMoment moment)
	{
		List<RogueCardData> list = ((moment != TriggerMoment.OnCardPlayed) ? RogueCardGameMain.GameContext.GetSelectDataList() : RogueCardGameMain.GameContext.scoreResult.scoreCardData);
		int lastNum = value;
		return GetLastNum(lastNum, 0, list.Count, list);
	}

	private bool GetLastNum(int lastNum, int index, int maxIndex, List<RogueCardData> cards)
	{
		if (index == maxIndex)
		{
			return lastNum == 0;
		}
		if (cards[index].GetRank == Rank.A)
		{
			if (!GetLastNum(lastNum - 11, index + 1, maxIndex, cards))
			{
				return GetLastNum(lastNum - 1, index + 1, maxIndex, cards);
			}
			return true;
		}
		return GetLastNum((int)(lastNum - cards[index].GetRank), index + 1, maxIndex, cards);
	}
}
