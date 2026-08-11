using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankRewardWindow : UGuiWindow
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private LoopListView2 scrollRect;

	private RankRewardViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<RankRewardViewModel>();
		BindingSet<RankRewardWindow, RankRewardViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((RankRewardWindow v) => v.OpenUguiWindow).To((RankRewardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((RankRewardWindow v) => v.OnDismissRequest).To((RankRewardViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((RankRewardViewModel vm) => vm.Close);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((RankRewardViewModel vm) => vm.Close);
		bindingSet.Build();
		scrollRect.InitListView(_viewModel.RankRewards.Count, OnGetRewardItemByIndex);
		scrollRect.ScrollRect.vertical = _viewModel.RankRewards.Count > 3;
		scrollRect.ScrollRect.content.anchoredPosition = Vector2.zero;
		scrollRect.ResetListView();
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 arg1, int itemIndex)
	{
		if (itemIndex < 0 || itemIndex > _viewModel.RankRewards.Count)
		{
			return null;
		}
		DRRankReward dRRankReward = _viewModel.RankRewards[itemIndex];
		if (dRRankReward == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = arg1.NewListViewItem("rankRewardItem");
		RankRewardItem component = loopListViewItem.GetComponent<RankRewardItem>();
		RankRewardItemData data = new RankRewardItemData(_viewModel, dRRankReward);
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(data);
		}
		else
		{
			component.RefreshData(data);
		}
		return loopListViewItem;
	}
}
