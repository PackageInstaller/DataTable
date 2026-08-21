using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeShopWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private TextMeshProUGUI refreshCountdown;

	[SerializeField]
	private LoopGridView loopGridView;

	[SerializeField]
	private Button btnFriendList;

	[SerializeField]
	private Button btnOpenTips;

	[SerializeField]
	private GameObject tipsView;

	[SerializeField]
	private TextMeshProUGUI tipsText;

	[SerializeField]
	private Button btnTipsOutside;

	[SerializeField]
	private Button btnCloseTips;

	private HomeShopWindowViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HomeShopWindowViewModel>();
		BindingSet<HomeShopWindow, HomeShopWindowViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((HomeShopWindow v) => v.OpenUguiWindow).To((HomeShopWindowViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HomeShopWindow v) => v.SetChildViewVisibility).To((HomeShopWindowViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(this).For((HomeShopWindow v) => v.OnDismissRequest).To((HomeShopWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HomeShopWindowViewModel vm) => vm.OnBtnBackClick);
		bindingSet.Bind<TextMeshProUGUI>(tipsText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HomeShopWindowViewModel vm) => vm.TipsText);
		bindingSet.Bind().For((HomeShopWindow v) => v.RefreshShopInfo).To((HomeShopWindowViewModel vm) => vm.RefreshShopInfoRst);
		bindingSet.Bind<TextMeshProUGUI>(refreshCountdown).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HomeShopWindowViewModel vm) => vm.LeftRefreshTimeText);
		bindingSet.Bind(btnFriendList).For((Button v) => v.onClick).To((HomeShopWindowViewModel vm) => vm.OpenShopListCmd);
		bindingSet.Build();
		btnOpenTips.onClick.AddListener(delegate
		{
			tipsView.SetActive(value: true);
		});
		btnCloseTips.onClick.AddListener(delegate
		{
			tipsView.SetActive(value: false);
		});
		btnTipsOutside.onClick.AddListener(delegate
		{
			tipsView.SetActive(value: false);
		});
		Init();
		_viewModel.StartTimer();
	}

	private void Init()
	{
		moneyView.Init(new MoneyViewModel(_viewModel));
		loopGridView.InitGridView(_viewModel.FilterDataList.Count, OnGetItemByIndex);
		LayoutSuitSetting();
		moneyView.HideAll();
		moneyView.SetShow(new List<RoleMoneyEnum>
		{
			RoleMoneyEnum.Coin,
			RoleMoneyEnum.Diamond,
			RoleMoneyEnum.HomelandCoin
		});
		btnFriendList.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HomelandFriendShopRefreshRed).SetFuncOnMessage(delegate
		{
			IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
			bool valueOrDefault = service?.GetHomeShopViewModel()?.GetFriendHomeShopRefreshRed() == true;
			return (service?.GetHomeShopViewModel()?.CheckFriendHomeShopOpened() == true) & valueOrDefault;
		})
			.Invoke();
	}

	private void RefreshShopInfo(object sender, InteractionEventArgs e)
	{
		loopGridView.SetListItemCount(_viewModel.FilterDataList.Count);
		loopGridView.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
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

	private void LayoutSuitSetting()
	{
		int count = Mathf.FloorToInt((loopGridView.ViewPortWidth - (float)loopGridView.Padding.left + loopGridView.ItemPadding.x) / (loopGridView.ItemSize.x + loopGridView.ItemPadding.x));
		loopGridView.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, count);
	}
}
