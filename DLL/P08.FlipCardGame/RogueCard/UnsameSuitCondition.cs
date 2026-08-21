using System.Collections.Generic;

namespace RogueCard;

public class UnsameSuitCondition : BaseCondition
{
	public override bool Check(TriggerMoment moment)
	{
		List<RogueCardData> scoreCardData = RogueCardGameMain.GameContext.scoreResult.scoreCardData;
		if (scoreCardData.Count < 3)
		{
			return false;
		}
		List<Suit> list = new List<Suit>();
		for (int i = 0; i < 3; i++)
		{
			RogueCardData rogueCardData = scoreCardData[i];
			if (!rogueCardData.allSuit)
			{
				list.Add(rogueCardData.GetSuit);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			for (int k = j + 1; k < list.Count; k++)
			{
				if (list[j] == list[k])
				{
					return false;
				}
			}
		}
		return true;
	}
}
