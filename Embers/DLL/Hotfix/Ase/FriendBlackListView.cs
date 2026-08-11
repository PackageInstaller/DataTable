using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class FriendBlackListView : UGuiView
{
	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private GameObject nothing;

	private FriendViewModel _viewModel;

	public void Init(FriendViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<FriendBlackListView, FriendViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((FriendBlackListView v) => v.RefreshBlackList).To((FriendViewModel vm) => vm.BlackListChangeRequest);
		bindingSet.Build();
		scrollView.InitListView(_viewModel.BlackListData.Count, OnGetItemByIndex);
		nothing.SetActive(_viewModel.BlackListData.Count <= 0);
	}

	public void RefreshBlackList(object sender, InteractionEventArgs e)
	{
		scrollView.SetListItemCount(_viewModel.BlackListData.Count);
		scrollView.RefreshAllShownItem();
		nothing.SetActive(_viewModel.BlackListData.Count <= 0);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.BlackListData.Count)
		{
			return null;
		}
		PlayerData playerData = _viewModel.BlackListData[index];
		if (playerData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollView.NewListViewItem("BlackListItem");
		FriendBlackListItem component = loopListViewItem.GetComponent<FriendBlackListItem>();
		FriendBlackListItemData data = new FriendBlackListItemData(_viewModel, playerData);
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(data);
		}
		component.RefreshData(data);
		return loopListViewItem;
	}
}
