using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class ActivityPointsView : UGuiView
{
	[SerializeField]
	private LoopListView2 activityTaskList;

	private ActivityPointsViewModel viewModel;

	public void Init(ActivityPointsViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ActivityPointsView, ActivityPointsViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((ActivityPointsView v) => v.RefreshTaskItemList).To((ActivityPointsViewModel vm) => vm.RefreshTaskRequest);
		bindingSet.Build();
		activityTaskList.InitListView(viewModel.ActivityTaskItemDataList.Count, OnGetTaskItemByIndex);
	}

	private void RefreshTaskItemList(object sender, InteractionEventArgs e)
	{
		activityTaskList.SetListItemCount(viewModel.ActivityTaskItemDataList.Count);
		activityTaskList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ActivityTaskItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityTaskItem");
		if (loopListViewItem != null)
		{
			ActivityTaskItem component = loopListViewItem.GetComponent<ActivityTaskItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ActivityTaskItemDataList[index]);
			}
			else
			{
				component.RefreshActivityTaskItem(viewModel.ActivityTaskItemDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
