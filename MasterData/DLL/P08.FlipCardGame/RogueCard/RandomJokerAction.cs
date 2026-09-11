using System;
using System.Collections.Generic;

namespace RogueCard;

public class RandomJokerAction : BaseAction
{
	public int buffID;

	public RandomJokerAction(int buffID)
	{
		this.buffID = buffID;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		RogueCardJokerData joker = effectEntity as RogueCardJokerData;
		List<RogueCardJokerData> jokerList = new List<RogueCardJokerData>();
		jokerList.AddRange(RogueCardGameMain.GameContext.jokerData.handCards);
		if (jokerList.Count <= 1)
		{
			joker.ResetToOriginalForm();
			RogueCardEffectManager.Instance.RegistEffect(buffID, joker);
			RefreshJokerDisplay();
			return;
		}
		jokerList.Remove(joker);
		int i = jokerList.Count - 1;
		while (i >= 0)
		{
			if (RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == jokerList[i].realID).no_copy)
			{
				jokerList.RemoveAt(i);
			}
			int num = i - 1;
			i = num;
		}
		if (jokerList.Count <= 0)
		{
			joker.ResetToOriginalForm();
			RogueCardEffectManager.Instance.RegistEffect(buffID, joker);
			RefreshJokerDisplay();
		}
		else
		{
			RogueCardJokerData target = RogueCardGameMain.Random.RandomChoice(jokerList);
			joker.ChangeSelf(target);
			RogueCardEffectManager.Instance.RegistEffect(buffID, joker);
			RefreshJokerDisplay();
		}
		void RefreshJokerDisplay()
		{
			RogueCard rogueCard = RogueCardGameMain.Instance.jokerHolder.cards.Find((RogueCard card) => card.ParentIndex() == RogueCardGameMain.GameContext.jokerData.GetDataIndex(joker));
			if (rogueCard != null && rogueCard.cardVisual != null)
			{
				(rogueCard.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_refresh");
				float delayTime = 0.28f;
				LeanTween.cancel(rogueCard.gameObject);
				LeanTween.delayedCall(rogueCard.gameObject, delayTime, (Action)delegate
				{
					RogueCardGameMain.Instance.RefreshJoker();
				});
			}
			else
			{
				RogueCardGameMain.Instance.RefreshJoker();
			}
		}
	}
}
