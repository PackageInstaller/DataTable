using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComeAllGiftView : UGuiView
{
	[SerializeField]
	private LoopGridView giftList;

	[SerializeField]
	private GameObject receiveState;

	[SerializeField]
	private Button jumpSignButton;

	[SerializeField]
	private Button jumpTaskButton;

	private HomeComeAllGiftViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HomeComeAllGiftViewModel>(userData);
		BindingSet<HomeComeAllGiftView, HomeComeAllGiftViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HomeComeAllGiftView v) => v.RefreshGiftList).To((HomeComeAllGiftViewModel vm) => vm.RefreshRewardListRequest);
		if (receiveState != null)
		{
			bindingSet.Bind(receiveState).For((GameObject v) => v.activeSelf).To((HomeComeAllGiftViewModel vm) => vm.ShowReceiveState);
		}
		if (jumpSignButton != null)
		{
			bindingSet.Bind(jumpSignButton).For((Button v) => v.onClick).To((HomeComeAllGiftViewModel vm) => vm.JumpSignCommand);
		}
		if (jumpTaskButton != null)
		{
			bindingSet.Bind(jumpTaskButton).For((Button v) => v.onClick).To((HomeComeAllGiftViewModel vm) => vm.JumpTaskCommand);
		}
		bindingSet.Build();
		if (giftList != null)
		{
			giftList.InitGridView(viewModel.RewardItems.Count, OnGetRewardItemByIndex);
		}
		RefreshGiftList();
	}

	private void RefreshGiftList(object sender = null, InteractionEventArgs e = null)
	{
		if (!(giftList == null) && viewModel != null)
		{
			giftList.SetListItemCount(viewModel.RewardItems.Count);
			giftList.RefreshAllShownItem();
		}
	}

	private LoopGridViewItem OnGetRewardItemByIndex(LoopGridView gridView, int itemIndex, int row, int column)
	{
		if (viewModel == null || itemIndex < 0 || itemIndex >= viewModel.RewardItems.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("GiftItem");
		HomeComeAllGiftItemView homeComeAllGiftItemView = loopGridViewItem.GetComponent<HomeComeAllGiftItemView>();
		if (homeComeAllGiftItemView == null)
		{
			homeComeAllGiftItemView = loopGridViewItem.gameObject.AddComponent<HomeComeAllGiftItemView>();
		}
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			homeComeAllGiftItemView.Init(viewModel.RewardItems[itemIndex]);
		}
		else
		{
			homeComeAllGiftItemView.RefreshData(viewModel.RewardItems[itemIndex]);
		}
		return loopGridViewItem;
	}
}
