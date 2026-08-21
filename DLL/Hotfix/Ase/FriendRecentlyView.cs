using System;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class FriendRecentlyView : UGuiView
{
	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private GameObject nothing;

	private FriendViewModel _viewModel;

	private Action<long> chatWithFriend;

	public void Init(FriendViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<FriendRecentlyView, FriendViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((FriendRecentlyView v) => v.RefreshScrollRect).To((FriendViewModel vm) => vm.RecentlyPlayerChangeRst);
		bindingSet.Build();
		scrollView.InitListView(_viewModel.RecentlyPlayerData.Count, OnGetItemByIndex);
		nothing.SetActive(_viewModel.RecentlyPlayerData.Count <= 0);
	}

	public void RefreshScrollRect(object sender, InteractionEventArgs e)
	{
		scrollView.SetListItemCount(_viewModel.RecentlyPlayerData.Count);
		scrollView.RefreshAllShownItem();
		nothing.SetActive(_viewModel.RecentlyPlayerData.Count <= 0);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.RecentlyPlayerData.Count)
		{
			return null;
		}
		PlayerData playerData = _viewModel.RecentlyPlayerData[index];
		if (playerData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollView.NewListViewItem("FriendRecentlyItem");
		FriendRecentlyItem component = loopListViewItem.GetComponent<FriendRecentlyItem>();
		FriendRecentlyItemData data = new FriendRecentlyItemData(_viewModel, playerData);
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(data);
			component.SetChatFunction(chatWithFriend);
		}
		component.RefreshData(data);
		return loopListViewItem;
	}

	public void SetChatFunction(Action<long> action)
	{
		chatWithFriend = action;
	}
}
