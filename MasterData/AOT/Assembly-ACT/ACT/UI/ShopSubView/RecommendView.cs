using System;
using ACT.Model;
using ACT.UI.Interface;
using UnityEngine;

namespace ACT.UI.ShopSubView;

public class RecommendView : BaseShopFirstSubView
{
	[Header("子页面")]
	public VipSubShopView vipSubShopView;

	public CharacterSkinSubShopView characterSkinSubShopView;

	public BundleCenterSubShopView[] bundleCenterSubShopView;

	protected override void Awake()
	{
		base.Awake();
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnShopDataUpdate = (Action)Delegate.Combine(shopModel.OnShopDataUpdate, new Action(OnShopDataUpdated));
		PayModel payModel2 = Model<PayModel>.Interface;
		payModel2.OnExchangeSuccess = (Action<int>)Delegate.Combine(payModel2.OnExchangeSuccess, new Action<int>(OnExchangeSuccess));
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnShopDataUpdate = (Action)Delegate.Remove(shopModel.OnShopDataUpdate, new Action(OnShopDataUpdated));
		PayModel payModel2 = Model<PayModel>.Interface;
		payModel2.OnExchangeSuccess = (Action<int>)Delegate.Remove(payModel2.OnExchangeSuccess, new Action<int>(OnExchangeSuccess));
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		Refresh();
		PlayFirstTabAnimation();
	}

	private void Refresh()
	{
		vipSubShopView.SetContentVisible(visible: false);
		characterSkinSubShopView.SetContentVisible(visible: false);
		if (this.bundleCenterSubShopView != null)
		{
			BundleCenterSubShopView[] array = this.bundleCenterSubShopView;
			foreach (BundleCenterSubShopView bundleCenterSubShopView in array)
			{
				if (bundleCenterSubShopView != null)
				{
					bundleCenterSubShopView.SetContentVisible(visible: false);
				}
			}
		}
		if (!(Tab is ShopFirstTab shopFirstTab) || shopFirstTab.ShopData.subshopIds == null)
		{
			return;
		}
		tabListComponent.TabItems.Clear();
		int num = 0;
		int[] subshopIds = shopFirstTab.ShopData.subshopIds;
		foreach (int num2 in subshopIds)
		{
			if (!_tabs.TryGetValue(num2, out var value))
			{
				continue;
			}
			ShopSecondTab component = value.GetComponent<ShopSecondTab>();
			component.ParentTab = Tab as ShopFirstTab;
			switch (num2)
			{
			case 1100001:
				component.Content = vipSubShopView;
				break;
			case 901:
				component.Content = characterSkinSubShopView;
				break;
			default:
			{
				if (this.bundleCenterSubShopView == null || num >= this.bundleCenterSubShopView.Length)
				{
					Debug.LogError($"推荐商店礼包页签数量超过已配置的礼包中心视图数量，subShopId:{num2}");
					value.SetActive(value: false);
					continue;
				}
				BundleCenterSubShopView bundleCenterSubShopView2 = this.bundleCenterSubShopView[num++];
				if (bundleCenterSubShopView2 == null)
				{
					Debug.LogError($"推荐商店礼包中心视图未配置，index:{num - 1}, subShopId:{num2}");
					value.SetActive(value: false);
					continue;
				}
				component.Content = bundleCenterSubShopView2;
				break;
			}
			}
			value.SetActive(value: true);
			tabListComponent.TabItems.Add(component);
		}
		FocusIn();
		tabListComponent.ActiveTab = GetDefaultSecondTab();
		ShopView.gamePadTipsComp.RegisterInputActions(new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeTable = "Common",
			localizeKey = 606
		});
	}

	private void OnShopDataUpdated()
	{
		RefreshActiveView();
	}

	private void OnPaySuccess(string orderId)
	{
		RefreshActiveView();
	}

	private void OnExchangeSuccess(int commodityId)
	{
		RefreshActiveView();
	}

	private void RefreshActiveView()
	{
		if (IsActive)
		{
			Refresh();
		}
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		OnFocusOut();
	}
}
