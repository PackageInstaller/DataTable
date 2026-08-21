using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class ShopViewBase : UGuiView
{
	[SerializeField]
	protected MoneyView moneyView;

	[SerializeField]
	protected TextMeshProUGUI refreshCountdown;

	[SerializeField]
	protected RectTransform subTabRoot;

	[SerializeField]
	protected TabItem subTabTpl;

	[SerializeField]
	protected LoopGridView loopGridView;

	[SerializeField]
	protected GameObject tips;

	[SerializeField]
	protected TextMeshProUGUI tipsText;

	protected GameObjectPool subTabItemPool;

	protected ShopViewDataBase _viewModel;

	protected override void OnInit(object userData)
	{
		bool flag = subTabTpl != null && subTabRoot != null;
		if (flag)
		{
			subTabItemPool = new GameObjectPool(subTabTpl.gameObject, subTabRoot);
		}
		base.OnInit(userData);
		_viewModel = GetUserData<ShopViewDataBase>(userData);
		BindingSet<ShopViewBase, ShopViewDataBase> bindingSet = this.CreateBindingSet(_viewModel);
		if (flag)
		{
			bindingSet.Bind().For((ShopViewBase v) => v.RefreshSubTabs).To((ShopViewDataBase vm) => vm.RefreshSubTabsRst);
		}
		if (tips != null && (UnityEngine.Object)(object)tipsText != null)
		{
			bindingSet.Bind(tips).For((GameObject v) => v.activeSelf).ToExpression((ShopViewDataBase vm) => !string.IsNullOrEmpty(vm.ShopTips));
			bindingSet.Bind<TextMeshProUGUI>(tipsText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopViewDataBase vm) => vm.ShopTips);
		}
		bindingSet.Bind().For((ShopViewBase v) => v.RefreshShopInfo).To((ShopViewDataBase vm) => vm.RefreshShopInfoRst);
		bindingSet.Bind<TextMeshProUGUI>(refreshCountdown).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShopViewDataBase vm) => vm.LeftRefreshTimeText);
		bindingSet.Build();
		InitMoneyView();
		InitShopInfo();
		LayoutSuitSetting();
		if (flag)
		{
			RefreshSubTabs();
		}
	}

	protected virtual void InitMoneyView()
	{
		if (moneyView != null)
		{
			moneyView.Init(new MoneyViewModel(_viewModel.Parent));
		}
	}

	protected virtual void LayoutSuitSetting()
	{
		int count = Mathf.FloorToInt((loopGridView.ViewPortWidth - (float)loopGridView.Padding.left + loopGridView.ItemPadding.x) / (loopGridView.ItemSize.x + loopGridView.ItemPadding.x));
		loopGridView.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, count);
	}

	protected void RefreshSubTabs(object sender = null, InteractionEventArgs e = null)
	{
		subTabItemPool.RecycleAll();
		int curTabIndex = _viewModel.CurTabIndex;
		List<ShopInfoData> list = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetShopDatas(curTabIndex)
			.Values.ToList();
		if (GameEntry.BuiltinData.OpenTestFlight)
		{
			list.RemoveAll((ShopInfoData p) => Constant.DisabledExchangeShopList.Contains(p.ShopId));
		}
		list.Sort((ShopInfoData a, ShopInfoData b) => 10 * a.Sort.CompareTo(b.Sort) + a.ShopId.CompareTo(b.ShopId));
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

	protected void InitShopInfo()
	{
		loopGridView.InitGridView(_viewModel.FilterDataList.Count, OnGetItemByIndex);
		if (!(moneyView != null) || _viewModel.CurShopInfoData == null)
		{
			return;
		}
		moneyView.HideAll();
		foreach (int consumeItemId in _viewModel.CurShopInfoData.ConsumeItemIds)
		{
			moneyView.SetShow(consumeItemId);
		}
	}

	protected void RefreshShopInfo(object sender = null, InteractionEventArgs e = null)
	{
		_viewModel.WaitRefreshShopInfo = false;
		loopGridView.SetListItemCount(_viewModel.FilterDataList.Count);
		loopGridView.RefreshAllShownItem();
		if (!(moneyView != null))
		{
			return;
		}
		ShopInfoData shopInfoData = null;
		if (e != null && e.Context != null)
		{
			shopInfoData = (ShopInfoData)e.Context;
		}
		else if (_viewModel.CurShopInfoData != null)
		{
			shopInfoData = _viewModel.CurShopInfoData;
		}
		if (shopInfoData == null)
		{
			return;
		}
		moneyView.HideAll();
		foreach (int consumeItemId in shopInfoData.ConsumeItemIds)
		{
			moneyView.SetShow(consumeItemId);
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (_viewModel != null && _viewModel.WaitRefreshShopInfo)
		{
			RefreshShopInfo();
		}
	}

	protected LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		if (dataIndex < 0 || dataIndex >= _viewModel.FilterDataList.Count)
		{
			return null;
		}
		ShopGoodItemData shopGoodItemData = _viewModel.FilterDataList[dataIndex];
		if (shopGoodItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = loopGridView.NewListViewItem("ShopGoodItem");
		ShopGoodItem component = loopGridViewItem.GetComponent<ShopGoodItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(shopGoodItemData);
		}
		else
		{
			component.RefreshData(shopGoodItemData);
		}
		return loopGridViewItem;
	}

	protected override void OnDestroy()
	{
		subTabItemPool?.Dispose();
		subTabItemPool = null;
		base.OnDestroy();
	}
}
