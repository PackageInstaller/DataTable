using System;

namespace RogueCard;

public class ShopItemData
{
	public RogueCardItemCfg cfg;

	public ItemType type;

	public bool isSaled;

	public int index;

	public int versionID;

	public int GetPrice()
	{
		int num = cfg.price;
		if (versionID != 0)
		{
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[versionID];
			num += rogueCardEnhanceCfg.ex_price;
		}
		return (int)Math.Ceiling((float)num * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopPriceRatio] / 100f));
	}
}
