using System;

namespace RogueCard;

public class ShopPackageData
{
	public RogueCardPackageCfg cfg;

	public bool isSaled;

	public int index;

	public int GetPrice()
	{
		if (RogueCardGameMain.GameContext.stageID == 102 && cfg.type == ItemType.Joker && cfg.id == 303 && RogueCardGameMain.GameContext.curStageState == StageType.Boss)
		{
			return cfg.price - 2;
		}
		if (cfg.type == ItemType.BlackWuChang)
		{
			return (int)Math.Ceiling((float)cfg.price * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BlackWuChangPriceRatio] / 100f) * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopPriceRatio] / 100f));
		}
		if (cfg.type == ItemType.WhiteWuChang)
		{
			return (int)Math.Ceiling((float)cfg.price * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangPriceRatio] / 100f) * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopPriceRatio] / 100f));
		}
		return (int)Math.Ceiling((float)cfg.price * ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopPriceRatio] / 100f));
	}
}
