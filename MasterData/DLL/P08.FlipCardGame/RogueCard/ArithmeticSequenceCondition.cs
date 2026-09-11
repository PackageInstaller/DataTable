using System;
using System.Collections.Generic;

namespace RogueCard;

public class ArithmeticSequenceCondition : BaseCondition
{
	public override bool Check(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnJokerPlayed)
		{
			List<RogueCardData> scoreCardData = RogueCardGameMain.GameContext.scoreResult.scoreCardData;
			if (scoreCardData.Count < 3)
			{
				return false;
			}
			int getRank = (int)scoreCardData[0].GetRank;
			int num = (int)((scoreCardData[0].GetRank == Rank.A) ? ((Rank)1) : scoreCardData[0].GetRank);
			int getRank2 = (int)scoreCardData[1].GetRank;
			int num2 = (int)((scoreCardData[1].GetRank == Rank.A) ? ((Rank)1) : scoreCardData[1].GetRank);
			int getRank3 = (int)scoreCardData[2].GetRank;
			int num3 = (int)((scoreCardData[2].GetRank == Rank.A) ? ((Rank)1) : scoreCardData[2].GetRank);
			if (!CheckCombination(getRank, getRank2, getRank3) && !CheckCombination(getRank, getRank2, num3) && !CheckCombination(getRank, num2, getRank3) && !CheckCombination(getRank, num2, num3) && !CheckCombination(num, getRank2, getRank3) && !CheckCombination(num, getRank2, num3) && !CheckCombination(num, num2, getRank3))
			{
				return CheckCombination(num, num2, num3);
			}
			return true;
		}
		return false;
	}

	private bool CheckCombination(params int[] values)
	{
		Array.Sort(values);
		return values[2] - values[1] == values[1] - values[0];
	}
}
