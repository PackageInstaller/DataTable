using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class HomeComeSignRewardView : UGuiView
{
	[SerializeField]
	private LoopGridView signRewardList;

	private HomeComeSignRewardViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HomeComeSignRewardViewModel>(userData);
		BindingSet<HomeComeSignRewardView, HomeComeSignRewardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HomeComeSignRewardView v) => v.RefreshSignList).To((HomeComeSignRewardViewModel vm) => vm.RefreshSignListRequest);
		bindingSet.Build();
		if (signRewardList != null)
		{
			signRewardList.InitGridView(viewModel.SignItems.Count, OnGetSignItemByIndex);
		}
		RefreshSignList();
	}

	private void RefreshSignList(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel != null && !(signRewardList == null))
		{
			signRewardList.SetListItemCount(viewModel.SignItems.Count);
			signRewardList.RefreshAllShownItem();
		}
	}

	private LoopGridViewItem OnGetSignItemByIndex(LoopGridView gridView, int itemIndex, int row, int column)
	{
		if (viewModel == null || itemIndex < 0 || itemIndex >= viewModel.SignItems.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("SignItem");
		HomeComeSignItemView homeComeSignItemView = loopGridViewItem.GetComponent<HomeComeSignItemView>();
		if (homeComeSignItemView == null)
		{
			homeComeSignItemView = loopGridViewItem.gameObject.AddComponent<HomeComeSignItemView>();
		}
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			homeComeSignItemView.Init(viewModel.SignItems[itemIndex]);
		}
		else
		{
			homeComeSignItemView.RefreshData(viewModel.SignItems[itemIndex]);
		}
		return loopGridViewItem;
	}
}
