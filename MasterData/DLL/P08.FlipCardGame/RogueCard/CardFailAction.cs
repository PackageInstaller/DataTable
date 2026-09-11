using System.Collections.Generic;

namespace RogueCard;

public class CardFailAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		if (moment == TriggerMoment.OnAcquire)
		{
			foreach (RogueCardData getAllCard in RogueCardGameMain.GameContext.GetAllCards)
			{
				if ((getAllCard.GetSuit == Suit.Spades || getAllCard.allSuit) && !getAllCard.effectDisable)
				{
					getAllCard.effectDisable = true;
				}
			}
		}
		if (moment == TriggerMoment.OnDrawInBattle)
		{
			List<RogueCardData> drawCardPool = RogueCardGameMain.GameContext.drawCardPool;
			drawCardPool[drawCardPool.Count - 1].effectDisable = true;
		}
	}

	public override void OnDisabled()
	{
	}
}
