using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.Interface;
using ACT.UI.ShopSubView;
using ACT.Utility;
using Fundamental;
using Runtime.Model;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class ExchangeShop : BaseShopSecondSubView<ExchangeSubShopViewInputController>
{
	public CommonScrollBagComponent itemBag;

	private List<ItemUnifierProxy> _shopItems = new List<ItemUnifierProxy>();

	private List<ACT.Config.ExchangeShop> _commodityIds = new List<ACT.Config.ExchangeShop>();

	private const int DailyLimitRefreshType = 1;

	private const int WeeklyLimitRefreshType = 2;

	private const int MonthlyLimitRefreshType = 3;

	private const int LimitRefreshHour = 4;

	private void Awake()
	{
		CommonScrollBagComponent commonScrollBagComponent = itemBag;
		commonScrollBagComponent.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemShow, new Action<ItemUIComponentBase>(OnItemShow));
		CommonScrollBagComponent commonScrollBagComponent2 = itemBag;
		commonScrollBagComponent2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent2.OnItemSelect, new Action<ItemUIComponentBase>(OnItemSelect));
		CommonScrollBagComponent commonScrollBagComponent3 = itemBag;
		commonScrollBagComponent3.OnUpdateEnd = (Action)Delegate.Remove(commonScrollBagComponent3.OnUpdateEnd, new Action(PlayExchangeItemAnimation));
		CommonScrollBagComponent commonScrollBagComponent4 = itemBag;
		commonScrollBagComponent4.OnUpdateEnd = (Action)Delegate.Combine(commonScrollBagComponent4.OnUpdateEnd, new Action(PlayExchangeItemAnimation));
	}

	protected override void OnRelease()
	{
		base.OnRelease();
		CommonScrollBagComponent commonScrollBagComponent = itemBag;
		commonScrollBagComponent.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Remove(commonScrollBagComponent.OnItemShow, new Action<ItemUIComponentBase>(OnItemShow));
		CommonScrollBagComponent commonScrollBagComponent2 = itemBag;
		commonScrollBagComponent2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Remove(commonScrollBagComponent2.OnItemSelect, new Action<ItemUIComponentBase>(OnItemSelect));
		CommonScrollBagComponent commonScrollBagComponent3 = itemBag;
		commonScrollBagComponent3.OnUpdateEnd = (Action)Delegate.Remove(commonScrollBagComponent3.OnUpdateEnd, new Action(PlayExchangeItemAnimation));
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		Refresh();
	}

	public void Refresh()
	{
		RefreshCommodityIds();
		RefreshShopItems();
		RefreshItemBag();
	}

	private bool RefreshCommodityIds()
	{
		_commodityIds.Clear();
		int[] commodityIds = ShopSecondTab.SubShopData.commodityIds;
		if (commodityIds == null)
		{
			return false;
		}
		int[] array = commodityIds;
		foreach (int num in array)
		{
			if (ShopSecondTab.SubShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
			{
				ACT.Config.ExchangeShop data = CoreUtils.GetData(num, RuntimeConfigs.data.exchangeShops);
				if (data != null)
				{
					_commodityIds.Add(data);
				}
			}
		}
		_commodityIds.RemoveAll(ShouldNotShow);
		_commodityIds.Sort(SortCommodity);
		return true;
	}

	private void RefreshShopItems()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_shopItems);
		foreach (ACT.Config.ExchangeShop commodityId in _commodityIds)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(commodityId.itemId, commodityId.itemCount);
			_shopItems.Add(item);
		}
	}

	private void RefreshItemBag()
	{
		itemBag.ClearBag();
		itemBag.ItemSource = _shopItems;
		itemBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
		itemBag.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
		itemBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
	}

	private void PlayExchangeItemAnimation()
	{
		int num = 0;
		for (int i = 0; i < _shopItems.Count; i++)
		{
			if (itemBag.GetItem(i) is ExchangeShopItemUIComponent { BetterAnimation: var betterAnimation })
			{
				betterAnimation?.GetSequence("ItemShow").Goto(0f).SetDelay(0.03f * (float)num)
					.Play();
				num++;
			}
		}
	}

	private void OnItemShow(ILoopScrollDataSource item)
	{
		if (!(item is ExchangeShopItemUIComponent exchangeShopItemUIComponent))
		{
			return;
		}
		ACT.Config.ExchangeShop exchangeShop = _commodityIds[exchangeShopItemUIComponent.Index];
		if (exchangeShop != null)
		{
			int leftCount = GetLeftCount(exchangeShop);
			bool active = exchangeShop.limitCount != 0 && leftCount <= 0;
			exchangeShopItemUIComponent.soldOutRoot.SetActive(active);
			if (exchangeShop.limitCount > 0 && leftCount > 0)
			{
				exchangeShopItemUIComponent.limitRoot.SetActive(value: true);
				exchangeShopItemUIComponent.limitText.SetTable("Common");
				exchangeShopItemUIComponent.limitText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Limit;
				exchangeShopItemUIComponent.limitText.GetVariable<int>("0").Value = leftCount;
			}
			else
			{
				exchangeShopItemUIComponent.limitRoot.SetActive(value: false);
			}
			exchangeShopItemUIComponent.priceComponent.gameObject.SetActive(value: true);
			ItemKv itemKv = exchangeShop.itemNeed.FirstOrDefault();
			if (itemKv != null)
			{
				exchangeShopItemUIComponent.priceComponent.Init(itemKv.id, itemKv.count);
			}
			exchangeShopItemUIComponent.SetItemCount(exchangeShop.itemCount);
			long num = ((ShopSecondTab.TabIdentify == 701) ? Model<RogueNewModel>.Interface.RemainRefreshTimeStamp : GetLimitRefreshLeftTime(exchangeShop));
			if (exchangeShop.permanentLimit)
			{
				exchangeShopItemUIComponent.commonTimerRoot.SetActive(value: false);
			}
			else if (num > 0)
			{
				exchangeShopItemUIComponent.commonTimerRoot.SetActive(value: true);
				exchangeShopItemUIComponent.commonTimer.IsCountDown = true;
				CommonTimerComponent commonTimer = exchangeShopItemUIComponent.commonTimer;
				System.DateTime minValue = System.DateTime.MinValue;
				commonTimer.Time = minValue.AddMilliseconds(num);
			}
			else
			{
				exchangeShopItemUIComponent.commonTimerRoot.SetActive(value: false);
			}
		}
	}

	private long GetLimitRefreshLeftTime(ACT.Config.ExchangeShop exchangeData)
	{
		System.DateTime now = TimeManager.ServerTime.Now;
		System.DateTime dateTime;
		switch (exchangeData.limitRefreshType)
		{
		case 1:
			dateTime = now.Date.AddDays(1.0).AddHours(4.0);
			break;
		case 2:
		{
			int num = (int)(1 - now.DayOfWeek + 7) % 7;
			if (num == 0)
			{
				num = 7;
			}
			dateTime = now.Date.AddDays(num).AddHours(4.0);
			break;
		}
		case 3:
			dateTime = now.Date.AddDays(1 - now.Day).AddMonths(1).AddHours(4.0);
			break;
		default:
			return -1L;
		}
		long num2 = (long)(dateTime - now).TotalMilliseconds;
		if (num2 <= 0)
		{
			return 0L;
		}
		return num2;
	}

	private void OnItemSelect(ItemUIComponentBase obj)
	{
		if (obj is ExchangeShopItemUIComponent exchangeShopItemUIComponent && (!exchangeShopItemUIComponent.soldOutRoot || !exchangeShopItemUIComponent.soldOutRoot.activeSelf))
		{
			int shopId = (Singleton<NewUIManager>.instance.GetTopActiveUI().GetUIView() as ShopView)?.tabListComponent.ActiveTab.TabIdentify ?? 0;
			int id = ShopSecondTab.SubShopData.id;
			int id2 = _commodityIds[exchangeShopItemUIComponent.Index].id;
			ShopEventTrackHelper.Dispatch(id, 3, id2);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BUYITEM, new ShopBuyPanelData
			{
				ShopId = shopId,
				SubShopId = id,
				SaleId = id2
			});
		}
	}

	private int SortCommodity(ACT.Config.ExchangeShop shop1, ACT.Config.ExchangeShop shop2)
	{
		ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(shop1.itemId, shop1.itemCount);
		ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(shop2.itemId, shop2.itemCount);
		int num;
		try
		{
			int leftCount = GetLeftCount(shop1);
			int leftCount2 = GetLeftCount(shop2);
			if (leftCount == 0)
			{
				if (leftCount2 == 0)
				{
					goto IL_0047;
				}
				num = 1;
			}
			else
			{
				if (leftCount2 != 0)
				{
					goto IL_0047;
				}
				num = -1;
			}
			goto IL_004a;
			IL_0047:
			num = 0;
			goto IL_004a;
			IL_004a:
			int num2 = num;
			if (num2 != 0)
			{
				num = num2;
			}
			else
			{
				int priority = shop2.priority;
				int num3 = priority.CompareTo(shop1.priority);
				num = ((num3 == 0) ? SortUtility.SortItemUnifierProxy1(item, item2) : num3);
			}
		}
		finally
		{
			ItemUnifierProxy.ItemUnifierPool.Release(ref item);
			ItemUnifierProxy.ItemUnifierPool.Release(ref item2);
		}
		return num;
	}

	private int GetLeftCount(ACT.Config.ExchangeShop exchangeShop)
	{
		int shopId = GetShopId();
		int id = ShopSecondTab.SubShopData.id;
		int num = Model<ShopModel>.Interface.ExchangeItemLeftCount(shopId, id, exchangeShop.id);
		if (num != -1)
		{
			return num;
		}
		SkinShop data = CoreUtils.GetData(exchangeShop.itemId, RuntimeConfigs.data.skinShops);
		if (data != null)
		{
			return Model<ShopModel>.Interface.SkinItemLeftCount(data.id);
		}
		return num;
	}

	private int GetShopId()
	{
		return ShopSecondTab.ParentTab?.TabIdentify ?? 0;
	}

	private bool ShouldNotShow(ACT.Config.ExchangeShop exchangeShop)
	{
		return Model<ShopModel>.Interface.CommodityLeftTime(exchangeShop.id) == 0;
	}
}
