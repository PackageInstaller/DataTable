using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class HeroSkinShopView : UGuiView
{
	[SerializeField]
	protected MoneyView moneyView;

	[SerializeField]
	private TextMeshProUGUI refreshCountdown;

	[SerializeField]
	private RectTransform subTabRoot;

	[SerializeField]
	private TabItem subTabTpl;

	[SerializeField]
	private LoopListView2 loopListView;

	private GameObjectPool subTabItemPool;

	private HeroSkinShopViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		subTabItemPool = new GameObjectPool(subTabTpl.gameObject, subTabRoot);
		base.OnInit(userData);
		_viewModel = GetUserData<HeroSkinShopViewModel>(userData);
		BindingSet<HeroSkinShopView, HeroSkinShopViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((HeroSkinShopView v) => v.RefreshSubTabs).To((HeroSkinShopViewModel vm) => vm.RefreshSubTabsRst);
		bindingSet.Bind().For((HeroSkinShopView v) => v.RefreshShopInfo).To((HeroSkinShopViewModel vm) => vm.RefreshShopInfoRst);
		bindingSet.Bind<TextMeshProUGUI>(refreshCountdown).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinShopViewModel vm) => vm.LeftRefreshTimeText);
		bindingSet.Build();
		moneyView.Init(new MoneyViewModel(_viewModel.Parent));
		loopListView.InitListView(_viewModel.FilterDataList.Count, OnGetItemByIndex);
		RefreshSubTabs();
	}

	public override void OnShow()
	{
		base.OnShow();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (_viewModel != null)
		{
			RefreshShopInfo();
		}
	}

	private void RefreshSubTabs(object sender = null, InteractionEventArgs e = null)
	{
		subTabItemPool.RecycleAll();
		int heroSkinShopMainId = HeroDefinition.GetHeroSkinShopMainId();
		List<ShopInfoData> list = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetShopDatas(heroSkinShopMainId)
			.Values.ToList();
		list.Sort((ShopInfoData a, ShopInfoData b) => (a.ShopId >= b.ShopId) ? 1 : (-1));
		int num = 0;
		if (_viewModel.CurSubTabIndex != 0 && list.Exists((ShopInfoData p) => p.ShopId == _viewModel.CurSubTabIndex))
		{
			num = _viewModel.CurSubTabIndex;
		}
		for (int num2 = 0; num2 < list.Count; num2++)
		{
			TabItemData tabItemData = new TabItemData(_viewModel, list[num2].ShopId)
			{
				TextNormal = list[num2].Name,
				TextSelected = list[num2].Name,
				EnglishNormal = list[num2].EnglishName,
				EnglishSelected = list[num2].EnglishName
			};
			TabItem component = subTabItemPool.Allocate(out var newCreate).GetComponent<TabItem>();
			if (newCreate)
			{
				component.Init(tabItemData);
			}
			else
			{
				component.SetDataContext(tabItemData);
			}
			component.transform.SetSiblingIndex(subTabRoot.childCount - 1);
			component.GetComponent<UIRedPoint>()?.Dispose();
			component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ShopRed).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).SubShopReds.Contains(tabItemData.TabIndex))
				.Invoke();
			if ((num == 0 && num2 == 0) || num == list[num2].ShopId)
			{
				_viewModel.SetSubTabSelected(tabItemData, reRequest: false);
			}
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.FilterDataList.Count)
		{
			return null;
		}
		HeroSkinShopItemData heroSkinShopItemData = _viewModel.FilterDataList[index];
		if (heroSkinShopItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("HeroSkinShopItem");
		HeroSkinShopItem component = loopListViewItem.GetComponent<HeroSkinShopItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(heroSkinShopItemData);
		}
		else
		{
			component.RefreshData(heroSkinShopItemData);
		}
		return loopListViewItem;
	}

	private void RefreshShopInfo(object sender = null, InteractionEventArgs e = null)
	{
		loopListView.SetListItemCount(_viewModel.FilterDataList.Count);
		loopListView.RefreshAllShownItem();
		if (_viewModel.ShopInfoData == null)
		{
			return;
		}
		moneyView.HideAll();
		foreach (int consumeItemId in _viewModel.ShopInfoData.ConsumeItemIds)
		{
			moneyView.SetShow(consumeItemId);
		}
	}

	protected override void OnDestroy()
	{
		subTabItemPool?.Dispose();
		subTabItemPool = null;
		base.OnDestroy();
	}
}
