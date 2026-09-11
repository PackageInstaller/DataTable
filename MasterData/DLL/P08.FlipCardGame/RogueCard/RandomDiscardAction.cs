using System.Collections.Generic;
using UnityEngine;

namespace RogueCard;

public class RandomDiscardAction : BaseAction
{
	public int num;

	public RandomDiscardAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> orderedHandData = RogueCardGameMain.GameContext.handData.GetOrderedHandData();
		if (num <= orderedHandData.Count)
		{
			List<RogueCardData> list = RogueCardGameMain.Random.RandomSample(orderedHandData, num);
			List<RogueCardData> list2 = new List<RogueCardData>();
			for (int i = 0; i < list.Count; i++)
			{
				RogueCardData rogueCardData = list[i];
				list2.Add(rogueCardData);
				RogueCardGameMain.GameContext.curEffectData = rogueCardData;
				RogueCardEffectManager.Instance.TriggerCard(rogueCardData, TriggerMoment.OnDiscardPlayed);
			}
			if (RogueCardGameMain.Instance != null)
			{
				RogueCardGameMain.Instance.SendMessage("PlayEffectDiscardCards", list2, SendMessageOptions.DontRequireReceiver);
			}
		}
	}
}
