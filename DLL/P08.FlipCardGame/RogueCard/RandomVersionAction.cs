using System;
using System.Collections.Generic;
using System.Linq;

namespace RogueCard;

public class RandomVersionAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		List<RogueCardJokerData> list = new List<RogueCardJokerData>();
		for (int i = 0; i < RogueCardGameMain.GameContext.jokerData.HandCount; i++)
		{
			RogueCardJokerData rogueCardJokerData = RogueCardGameMain.GameContext.jokerData.handCards[i];
			if (rogueCardJokerData.versionID == 0)
			{
				list.Add(rogueCardJokerData);
			}
		}
		if (list.Count == 0)
		{
			return;
		}
		RogueCardJokerData rogueCardJokerData2 = RogueCardGameMain.Random.RandomChoice(list);
		if (rogueCardJokerData2 != null)
		{
			List<RogueCardEnhanceCfg> list2 = RogueCardDataManager.enhanceDatabase.Values.ToList().FindAll((RogueCardEnhanceCfg cfg) => cfg.type == EnhanceType.Version);
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardGameMain.Random.RandomChoice(list2);
			rogueCardJokerData2.AddVersion(rogueCardEnhanceCfg.id);
			RogueCard card = RogueCardGameMain.Instance.jokerHolder.GetCard(RogueCardGameMain.GameContext.jokerData.GetDataIndex(rogueCardJokerData2));
			(card.cardVisual as VisualJokerCard)?.ShowVersionAni();
			(card.cardVisual as VisualJokerCard)?.PlayAnimation("UI_Com_JokerCarditem_refresh");
			float delayTime = 0.28f;
			LeanTween.cancel(card.gameObject);
			LeanTween.delayedCall(card.gameObject, delayTime, (Action)delegate
			{
				RogueCardGameMain.Instance.RefreshJoker();
			});
		}
	}
}
