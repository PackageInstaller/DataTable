using System;

namespace RogueCard;

public class ChangeGlobalDataAction : BaseAction
{
	public int type;

	public int attrID;

	public int num;

	public int changeNum;

	public ChangeGlobalDataAction(int type, int attrID, int num)
	{
		this.type = type;
		this.attrID = attrID;
		this.num = num;
		changeNum = 0;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		if (attrID == 2)
		{
			if (moment == TriggerMoment.OnRoundWin)
			{
				RogueCardGameMain.GameContext.GetJokerGold((effectEntity as RogueCardJokerData).id, num);
			}
			else
			{
				RogueCardGameMain.GameContext.gold += num;
			}
			if (effectEntity is RogueCardJokerData)
			{
				RogueCardJokerData joker = effectEntity as RogueCardJokerData;
				RogueCard rogueCard = RogueCardGameMain.Instance.jokerHolder.cards.Find((RogueCard card) => card.ParentIndex() == RogueCardGameMain.GameContext.jokerData.GetDataIndex(joker));
				if (rogueCard != null && rogueCard.cardVisual != null)
				{
					(rogueCard.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_chufa");
					(rogueCard.cardVisual as VisualJokerCard).PlayFlyNum(RogueCardTipSystem.GetTip("ROGUE_CARD_GAIN_GOLD"), FlyNumberType.Normal);
				}
			}
		}
		else
		{
			if (type == 0 || type == 2)
			{
				changeNum = num - RogueCardGameMain.GameContext.globalAttrDic[(AttributeType)attrID];
				RogueCardGameMain.GameContext.globalAttrDic[(AttributeType)attrID] = num;
			}
			else
			{
				changeNum = num;
				RogueCardGameMain.GameContext.globalAttrDic[(AttributeType)attrID] = Math.Max(0, RogueCardGameMain.GameContext.globalAttrDic[(AttributeType)attrID] + changeNum);
			}
			if (attrID == 3)
			{
				RogueCardGameMain.GameContext.discardNum = Math.Max(0, RogueCardGameMain.GameContext.discardNum + changeNum);
			}
		}
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.globalAttrDic[(AttributeType)attrID] = Math.Max(0, RogueCardGameMain.GameContext.globalAttrDic[(AttributeType)attrID] - changeNum);
	}
}
