using System;
using System.Collections.Generic;

namespace RogueCard;

public class RogueCardShopData
{
	public List<ShopItemData> shopItemDataList = new List<ShopItemData>();

	public List<ShopPackageData> shopPackageDataList = new List<ShopPackageData>();

	public int hashIndex;

	public int selectIndex = -1;

	public int curItemID = -1;

	public int curRefreshCost;

	public void InitShopData()
	{
		if (RogueCardGameMain.GameContext != null && RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		selectIndex = -1;
		curItemID = -1;
		shopItemDataList.Clear();
		shopPackageDataList.Clear();
		hashIndex = 0;
		curRefreshCost = RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopResetPrice];
		if (RogueCardGameMain.GameContext.stageID == 102)
		{
			curRefreshCost = 0;
		}
		if (RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.shop_card, ignoreGuideState: true))
		{
			foreach (RogueCardGuideItem guide in RogueCardGameMain.Instance.guideSystem.GetGuideItems(RogueCardGuideMoment.shop_card))
			{
				RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg rogueCardItemCfg2) => rogueCardItemCfg2.id == guide.id);
				ShopItemData item = new ShopItemData
				{
					cfg = rogueCardItemCfg,
					type = rogueCardItemCfg.type,
					isSaled = false,
					index = hashIndex,
					versionID = guide.versionID
				};
				shopItemDataList.Add(item);
				hashIndex++;
			}
		}
		else
		{
			shopItemDataList.AddRange(CreateItem(RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopCardNum]));
		}
		hashIndex = 100;
		if (RogueCardGameMain.GameContext.stageID == 101)
		{
			return;
		}
		if (RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.shop_package, ignoreGuideState: true))
		{
			foreach (int item3 in RogueCardGameMain.Instance.guideSystem.GetGuideID(RogueCardGuideMoment.shop_package))
			{
				RogueCardPackageCfg cfg = RogueCardDataManager.packageDatabase[item3];
				ShopPackageData item2 = new ShopPackageData
				{
					cfg = cfg,
					isSaled = false,
					index = hashIndex
				};
				shopPackageDataList.Add(item2);
				hashIndex++;
			}
			return;
		}
		shopPackageDataList.AddRange(CreatePackage(RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopPackNum]));
	}

	public void RefreshShopData()
	{
		if (RogueCardGameMain.GameContext != null && RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		selectIndex = -1;
		curItemID = -1;
		List<int> list = new List<int>();
		foreach (ShopItemData shopItemData in shopItemDataList)
		{
			list.Add(shopItemData.cfg.id);
			list.Add(1);
			list.Add(shopItemData.cfg.price);
			list.Add(0);
		}
		shopItemDataList.Clear();
		hashIndex = 0;
		if (RogueCardGameMain.GameContext.shopData.curRefreshCost == 1 && RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.refresh_card, ignoreGuideState: true))
		{
			foreach (RogueCardGuideItem guide in RogueCardGameMain.Instance.guideSystem.GetGuideItems(RogueCardGuideMoment.refresh_card))
			{
				RogueCardItemCfg cfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg rogueCardItemCfg) => rogueCardItemCfg.type == ItemType.Joker && rogueCardItemCfg.id == guide.id);
				ShopItemData item = new ShopItemData
				{
					cfg = cfg,
					type = ItemType.Joker,
					isSaled = false,
					index = hashIndex,
					versionID = guide.versionID
				};
				shopItemDataList.Add(item);
				hashIndex++;
			}
			return;
		}
		shopItemDataList.AddRange(CreateItem(RogueCardGameMain.GameContext.globalAttrDic[AttributeType.ShopCardNum], isRefresh: true, list));
		RogueCardGameMain.Instance.HideTips();
	}

	public void SelectItem(int index)
	{
		if (selectIndex == index)
		{
			selectIndex = -1;
		}
		else
		{
			selectIndex = index;
		}
		RogueCardGameMain.Instance.RefreshUI();
	}

	public bool ShopBuyItem()
	{
		if (selectIndex < 0)
		{
			return false;
		}
		int item = selectIndex;
		ShopItemData shopItemData = shopItemDataList.Find((ShopItemData x) => x.index == selectIndex);
		if (shopItemData == null)
		{
			ShopPackageData shopPackageData = shopPackageDataList.Find((ShopPackageData x) => x.index == selectIndex);
			if (RogueCardGameMain.Instance.gameContext.gold < shopPackageData.GetPrice())
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NO_MONEY");
				return false;
			}
			RogueCardGameMain.Instance.gameContext.gold -= shopPackageData.GetPrice();
			RogueCardGameMain.GameContext.settleContext.useGoldNum += shopPackageData.GetPrice();
			RogueCardSaveSystem.SendTrackingPoint3(RogueCardGameMain.Instance.saveSystem.GetGameData(), -shopPackageData.GetPrice(), 1, new List<int> { item });
			shopPackageDataList.Remove(shopPackageData);
			RogueCardGameMain.Instance.StartPackage(shopPackageData.cfg.id);
			try
			{
				RogueCardGameMain.Instance.saveSystem?.SaveGameData();
			}
			catch (Exception)
			{
			}
		}
		else
		{
			if (RogueCardGameMain.Instance.gameContext.gold < shopItemData.GetPrice())
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NO_MONEY");
				return false;
			}
			if (shopItemData.type == ItemType.Joker && RogueCardGameMain.GameContext.jokerData.HandCount >= RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] && (shopItemData.versionID != 304 || RogueCardGameMain.GameContext.jokerData.HandCount != RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum]))
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_POKER_NO_VACANCY");
				return false;
			}
			RogueCardGameMain.Instance.gameContext.gold -= shopItemData.GetPrice();
			RogueCardGameMain.GameContext.settleContext.useGoldNum += shopItemData.GetPrice();
			shopItemData.isSaled = true;
			curItemID = shopItemData.cfg.id;
			if (shopItemData.type == ItemType.Joker)
			{
				if (RogueCardGameMain.GameContext.jokerData.HandCount >= RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] && (RogueCardGameMain.GameContext.jokerData.HandCount != RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] || shopItemData.versionID != 304))
				{
					LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_POKER_NO_VACANCY");
					return false;
				}
				RogueCardJokerData jokerData = RogueCardJokerData.CreateJokerCard(shopItemData.cfg.id, shopItemData.versionID);
				RogueCardGameMain.Instance.GainJokerCard(jokerData);
			}
			else if (shopItemData.type == ItemType.BlackWuChang)
			{
				RogueCardGameMain.Instance.StartBuyWuChang(shopItemData.cfg.id);
			}
			else if (shopItemData.type == ItemType.WhiteWuChang)
			{
				RogueCardGameMain.Instance.StartBuyWuChang(shopItemData.cfg.id);
			}
			RogueCardSaveSystem.SendTrackingPoint3(RogueCardGameMain.Instance.saveSystem.GetGameData(), -shopItemData.GetPrice(), 1, new List<int> { item });
			shopItemDataList.Remove(shopItemData);
		}
		selectIndex = -1;
		return true;
	}

	private List<ShopItemData> CreateItem(int createNum, bool isRefresh = false, List<int> beforeList = null)
	{
		int num = 0;
		Dictionary<RogueCardItemCfg, float> dictionary = new Dictionary<RogueCardItemCfg, float>();
		Dictionary<RogueCardItemCfg, float> dictionary2 = new Dictionary<RogueCardItemCfg, float>();
		Dictionary<RogueCardItemCfg, float> dictionary3 = new Dictionary<RogueCardItemCfg, float>();
		List<RogueCardItemCfg> list = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg rogueCardItemCfg5) => rogueCardItemCfg5.type == ItemType.Joker);
		foreach (RogueCardItemCfg goods in list)
		{
			float num2 = 0f;
			num2 = ((goods.rare == 1) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare1Weight]) : ((goods.rare != 2) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare3Weight]) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare2Weight])));
			if (RogueCardGameMain.GameContext.jokerData.handCards.Find((RogueCardJokerData joker) => joker.realID == goods.id) == null)
			{
				dictionary.Add(goods, num2);
			}
		}
		list.Clear();
		list = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg rogueCardItemCfg5) => rogueCardItemCfg5.type == ItemType.WhiteWuChang);
		foreach (RogueCardItemCfg item5 in list)
		{
			float num3 = 0f;
			num3 = ((item5.rare != 1) ? ((item5.rare != 2) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare3Weight]) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangHighRatio])) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangLowRatio]));
			dictionary2.Add(item5, num3);
		}
		list.Clear();
		list = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg rogueCardItemCfg5) => rogueCardItemCfg5.type == ItemType.BlackWuChang);
		foreach (RogueCardItemCfg item6 in list)
		{
			float num4 = 0f;
			num4 = ((item6.rare != 1) ? ((item6.rare != 2) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare3Weight]) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BlackWuChangHighRatio])) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BlackWuChangLowRatio]));
			dictionary3.Add(item6, num4);
		}
		List<ShopItemData> list2 = new List<ShopItemData>();
		Random random = new Random();
		List<int> list3 = new List<int>();
		if (RogueCardGameMain.GameContext.stageType == LevelType.Challenge && RogueCardGameMain.GameContext.jokerData.HandCount == 0)
		{
			List<RogueCardItemCfg> list4 = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg rogueCardItemCfg5) => rogueCardItemCfg5.type == ItemType.Joker && rogueCardItemCfg5.price <= RogueCardGameMain.GameContext.gold);
			if (list4.Count > 0)
			{
				Dictionary<RogueCardItemCfg, float> dictionary4 = new Dictionary<RogueCardItemCfg, float>();
				foreach (RogueCardItemCfg goods2 in list4)
				{
					float num5 = 0f;
					num5 = ((goods2.rare == 1) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare1Weight]) : ((goods2.rare != 2) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare3Weight]) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare2Weight])));
					if (RogueCardGameMain.GameContext.jokerData.handCards.Find((RogueCardJokerData joker) => joker.id == goods2.id) == null)
					{
						dictionary4.Add(goods2, num5);
					}
				}
				RogueCardItemCfg rogueCardItemCfg = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary4);
				List<RogueCardEnhanceCfg> list5 = new List<RogueCardEnhanceCfg>();
				foreach (KeyValuePair<int, RogueCardEnhanceCfg> item7 in RogueCardDataManager.enhanceDatabase)
				{
					if (item7.Value.type == EnhanceType.Version)
					{
						list5.Add(item7.Value);
					}
				}
				int num6 = 0;
				ShopItemData item = new ShopItemData
				{
					cfg = rogueCardItemCfg,
					type = ItemType.Joker,
					isSaled = false,
					index = hashIndex,
					versionID = num6
				};
				list2.Add(item);
				dictionary.Remove(rogueCardItemCfg);
				if (isRefresh)
				{
					list3.Add(rogueCardItemCfg.id);
					list3.Add(1);
					list3.Add(rogueCardItemCfg.price);
					list3.Add(num6);
				}
				hashIndex++;
				num++;
			}
		}
		for (; num < createNum; num++)
		{
			int num7 = random.Next(RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerShopRatio] + RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangShopRatio] + RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BlackWuChangShopRatio]);
			if (num7 < RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerShopRatio])
			{
				RogueCardItemCfg rogueCardItemCfg2 = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary);
				List<RogueCardEnhanceCfg> list6 = new List<RogueCardEnhanceCfg>();
				foreach (KeyValuePair<int, RogueCardEnhanceCfg> item8 in RogueCardDataManager.enhanceDatabase)
				{
					if (item8.Value.type == EnhanceType.Version)
					{
						list6.Add(item8.Value);
					}
				}
				int num8 = random.Next(1, 1001);
				int num9 = 0;
				int num10 = 0;
				for (int num11 = 0; num11 < list6.Count; num11++)
				{
					num9 += list6[num11].rare;
					if (num8 <= num9)
					{
						num10 = list6[num11].id;
						break;
					}
				}
				ShopItemData item2 = new ShopItemData
				{
					cfg = rogueCardItemCfg2,
					type = ItemType.Joker,
					isSaled = false,
					index = hashIndex,
					versionID = num10
				};
				list2.Add(item2);
				if (isRefresh)
				{
					list3.Add(rogueCardItemCfg2.id);
					list3.Add(1);
					list3.Add(rogueCardItemCfg2.price);
					list3.Add(num10);
				}
				hashIndex++;
				dictionary.Remove(rogueCardItemCfg2);
			}
			else if (num7 < RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerShopRatio] + RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangShopRatio])
			{
				RogueCardItemCfg rogueCardItemCfg3 = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary2);
				ShopItemData item3 = new ShopItemData
				{
					cfg = rogueCardItemCfg3,
					type = ItemType.WhiteWuChang,
					isSaled = false,
					index = hashIndex
				};
				list2.Add(item3);
				if (isRefresh)
				{
					list3.Add(rogueCardItemCfg3.id);
					list3.Add(1);
					list3.Add(rogueCardItemCfg3.price);
					list3.Add(0);
				}
				hashIndex++;
				dictionary2.Remove(rogueCardItemCfg3);
			}
			else
			{
				RogueCardItemCfg rogueCardItemCfg4 = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary3);
				ShopItemData item4 = new ShopItemData
				{
					cfg = rogueCardItemCfg4,
					type = ItemType.BlackWuChang,
					isSaled = false,
					index = hashIndex
				};
				list2.Add(item4);
				if (isRefresh)
				{
					list3.Add(rogueCardItemCfg4.id);
					list3.Add(1);
					list3.Add(rogueCardItemCfg4.price);
					list3.Add(0);
				}
				hashIndex++;
				dictionary3.Remove(rogueCardItemCfg4);
			}
		}
		if (isRefresh)
		{
			RogueCardSaveSystem.SendTrackingPoint3(RogueCardGameMain.Instance.saveSystem.GetGameData(), -(curRefreshCost - 1), 3, list3, beforeList);
		}
		return list2;
	}

	private List<ShopPackageData> CreatePackage(int createNum)
	{
		List<ShopPackageData> list = new List<ShopPackageData>();
		Dictionary<RogueCardPackageCfg, float> dictionary = new Dictionary<RogueCardPackageCfg, float>();
		foreach (KeyValuePair<int, RogueCardPackageCfg> item2 in RogueCardDataManager.packageDatabase)
		{
			dictionary.Add(item2.Value, item2.Value.weight);
		}
		for (int i = 0; i < createNum; i++)
		{
			RogueCardPackageCfg rogueCardPackageCfg = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary);
			ShopPackageData item = new ShopPackageData
			{
				cfg = rogueCardPackageCfg,
				isSaled = false,
				index = hashIndex
			};
			list.Add(item);
			hashIndex++;
			dictionary.Remove(rogueCardPackageCfg);
		}
		return list;
	}
}
