using System.Collections.Generic;
using ACT.UI.Interface;
using UnityEngine;

namespace ACT.UI.ShopSubView;

public class GiftCenterView : BaseShopFirstSubView
{
	public BundleShop bundleShop;

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		if (!(tabItem is ShopFirstTab))
		{
			return;
		}
		bundleShop.SetContentVisible(visible: false);
		tabListComponent.TabItems.Clear();
		foreach (KeyValuePair<int, GameObject> tab in _tabs)
		{
			GameObject value = tab.Value;
			ShopSecondTab component = value.GetComponent<ShopSecondTab>();
			value.SetActive(value: true);
			component.Content = bundleShop;
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
		base.OnTabDeActive(tabItem);
		bundleShop.FocusOut();
	}
}
