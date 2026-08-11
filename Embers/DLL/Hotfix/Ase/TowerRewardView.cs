using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class TowerRewardView : UGuiView
{
	[SerializeField]
	private LoopListView2 rewardTaskList;

	private RewardViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = (RewardViewModel)userData;
		BindingSet<TowerRewardView, RewardViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerRewardView v) => v.OnOpt).To((RewardViewModel vm) => vm.InteractionRequest);
		bindingSet.Build();
		rewardTaskList.InitListView(viewModel.RewardItemDataList.Count, OnGetTaskItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = userData as RewardViewModel;
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 view, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = view.NewListViewItem("TowerRewardItem");
		if (loopListViewItem != null)
		{
			TowerRewardItem component = loopListViewItem.GetComponent<TowerRewardItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		rewardTaskList.SetListItemCount(viewModel.RewardItemDataList.Count);
		rewardTaskList.RefreshAllShownItem();
	}
}
