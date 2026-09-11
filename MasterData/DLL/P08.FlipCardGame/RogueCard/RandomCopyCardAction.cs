using System;
using System.Collections.Generic;

namespace RogueCard;

public class RandomCopyCardAction : BaseAction
{
	public int num;

	public int buffID;

	public RandomCopyCardAction(int num, int buffID)
	{
		this.num = num;
		this.buffID = buffID;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isTargetDraw)
		{
			return;
		}
		List<RogueCardData> drawCardPool = RogueCardGameMain.GameContext.drawCardPool;
		if (drawCardPool.Count != 0)
		{
			RogueCardData rogueCardData = RogueCardGameMain.Random.RandomChoice(drawCardPool);
			RogueCardData rogueCardData2 = new RogueCardData(rogueCardData);
			RogueCardEffectManager.Instance.RegistEffect(buffID, rogueCardData2);
			RogueCardGameMain.GameContext.handData.AddCardToHand(rogueCardData2);
			RogueCardGameMain.Instance.copyToHandQueue.Add(new Tuple<RogueCardData, RogueCardData>(rogueCardData, rogueCardData2));
			RogueCardGameMain.Instance.tempCopiedCards.Add(rogueCardData2);
			if (effectEntity is RogueCardJokerData value)
			{
				RogueCardGameMain.Instance.copyDestToJokerMap[rogueCardData2] = value;
			}
		}
	}
}
