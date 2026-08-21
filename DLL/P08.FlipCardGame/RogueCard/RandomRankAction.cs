using System.Collections.Generic;

namespace RogueCard;

public class RandomRankAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> getWuChangSelect = RogueCardGameMain.GameContext.GetWuChangSelect;
		if (getWuChangSelect.Count > 0)
		{
			for (int i = 0; i < getWuChangSelect.Count; i++)
			{
				RogueCardData rogueCardData = getWuChangSelect[i];
				Rank rank = (Rank)RogueCardGameMain.Random.Range(2, 12);
				rogueCardData.rank = rank;
			}
		}
	}
}
