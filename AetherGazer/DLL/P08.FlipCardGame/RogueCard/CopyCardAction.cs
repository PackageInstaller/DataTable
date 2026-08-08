using System;
using System.Collections.Generic;

namespace RogueCard;

public class CopyCardAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> getWuChangSelect = RogueCardGameMain.GameContext.GetWuChangSelect;
		if (getWuChangSelect.Count > 0)
		{
			for (int i = 0; i < getWuChangSelect.Count; i++)
			{
				RogueCardData rogueCardData = getWuChangSelect[i];
				RogueCardData rogueCardData2 = new RogueCardData(rogueCardData);
				RogueCardGameMain.GameContext.wuChangWaitCards.AddCardToHand(rogueCardData2);
				RogueCardGameMain.Instance.copyToDeckQueue.Add(new Tuple<RogueCardData, RogueCardData>(rogueCardData, rogueCardData2));
				RogueCardGameMain.Instance.tempCopiedCards.Add(rogueCardData2);
			}
		}
	}
}
