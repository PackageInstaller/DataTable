using System.Collections.Generic;
using ACT.Event;
using ACT.UI.Interface;
using Fundamental;
using UnityEngine;

namespace ACT.UI.ShopSubView;

public class ExchangeShopView : BaseShopFirstSubView
{
	public ExchangeShop exchangeShop;

	protected override void OnUnityDestroy()
	{
		RemoveExchangeShopSuccessListener();
		base.OnUnityDestroy();
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		if (!(tabItem is ShopFirstTab))
		{
			return;
		}
		AddExchangeShopSuccessListener();
		tabListComponent.TabItems.Clear();
		foreach (KeyValuePair<int, GameObject> tab in _tabs)
		{
			GameObject value = tab.Value;
			ShopSecondTab component = value.GetComponent<ShopSecondTab>();
			value.SetActive(value: true);
			component.Content = exchangeShop;
			tabListComponent.TabItems.Add(component);
		}
		tabListComponent.ActiveTab = GetDefaultSecondTab();
		ShopView.gamePadTipsComp.RegisterInputActions(new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeTable = "Common",
			localizeKey = 508
		}, new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeTable = "Common",
			localizeKey = 606
		});
		PlayFirstTabAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		RemoveExchangeShopSuccessListener();
		base.OnTabDeActive(tabItem);
	}

	private void AddExchangeShopSuccessListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ExchangeShopSuccess, OnExchangeShopSuccess);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ExchangeShopSuccess, OnExchangeShopSuccess);
	}

	private void RemoveExchangeShopSuccessListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ExchangeShopSuccess, OnExchangeShopSuccess);
	}

	private void OnExchangeShopSuccess(BaseEventContent _)
	{
		exchangeShop?.Refresh();
	}
}
