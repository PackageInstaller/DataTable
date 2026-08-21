using System.Collections.Generic;

namespace RogueCard;

public class AddJokerAction : BaseAction
{
	public int rare;

	public int num;

	public AddJokerAction(int rare, int num)
	{
		this.rare = rare;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave || RogueCardGameMain.GameContext.jokerData.handCards.Count >= RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum])
		{
			return;
		}
		List<RogueCardItemCfg> list = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg item) => item.rare == rare && item.type == ItemType.Joker);
		for (int num = 0; num < RogueCardGameMain.GameContext.jokerData.handCards.Count; num++)
		{
			for (int num2 = list.Count - 1; num2 >= 0; num2--)
			{
				RogueCardItemCfg rogueCardItemCfg = list[num2];
				if (RogueCardGameMain.GameContext.jokerData.handCards[num].id == rogueCardItemCfg.id)
				{
					list.RemoveAt(num2);
					break;
				}
			}
		}
		RogueCardJokerData jokerData = RogueCardJokerData.CreateJokerCard(RogueCardGameMain.Random.RandomChoice(list).id);
		RogueCardGameMain.Instance.GainJokerCard(jokerData);
		RogueCardGameMain.Instance.RefreshUI();
	}
}
