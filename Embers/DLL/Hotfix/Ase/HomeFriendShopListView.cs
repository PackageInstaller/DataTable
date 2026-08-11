using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeFriendShopListView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI limitBuyText;

	[SerializeField]
	private LoopListView2 shopList;

	[SerializeField]
	private GameObject noFriend;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnOutsideArea;

	private HomeFriendShopListViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<HomeFriendShopListViewModel>(userData);
		BindingSet<HomeFriendShopListView, HomeFriendShopListViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((HomeFriendShopListView v) => v.OnVisibleChanged).To((HomeFriendShopListViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((HomeFriendShopListView v) => v.RefreshShopList).To((HomeFriendShopListViewModel vm) => vm.RefreshRst);
		bindingSet.Bind(noFriend).For((GameObject v) => v.activeSelf).To((HomeFriendShopListViewModel vm) => vm.NoFriend);
		bindingSet.Bind<TextMeshProUGUI>(limitBuyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HomeFriendShopListViewModel vm) => vm.LimitBuyText);
		bindingSet.Build();
		btnClose.onClick.AddListener(delegate
		{
			_viewModel.IsVisible = false;
		});
		btnOutsideArea.onClick.AddListener(delegate
		{
			_viewModel.IsVisible = false;
		});
		shopList.InitListView(_viewModel.ShopDatas.Count, OnGetItemByIndex);
	}

	private void RefreshShopList(object sender, InteractionEventArgs e)
	{
		shopList.SetListItemCount(_viewModel.ShopDatas.Count);
		shopList.RefreshAllShownItem();
		shopList.gameObject.SetActive(value: true);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (_viewModel.ShopDatas == null)
		{
			return null;
		}
		if (index < 0 || index >= _viewModel.ShopDatas.Count)
		{
			return null;
		}
		HomeShopInfoData homeShopInfoData = _viewModel.ShopDatas[index];
		if (homeShopInfoData == null)
		{
			return null;
		}
		PlayerData playerData = Singleton<ServiceSystem>.Instance.GetService<ISocialService>()?.GetTargetFriendData(homeShopInfoData.ShopId);
		if (playerData == null)
		{
			return null;
		}
		HomeShopListItemData homeShopListItemData = new HomeShopListItemData(_viewModel, playerData, homeShopInfoData, homeShopInfoData.ShopId.Equals((int)_viewModel.CurShopId));
		LoopListViewItem2 loopListViewItem = shopList.NewListViewItem("HomeShopListItem");
		HomeShopListItem component = loopListViewItem.GetComponent<HomeShopListItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(homeShopListItemData);
		}
		else
		{
			component.RefreshData(homeShopListItemData);
		}
		return loopListViewItem;
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		shopList.gameObject.SetActive(value: false);
	}
}
