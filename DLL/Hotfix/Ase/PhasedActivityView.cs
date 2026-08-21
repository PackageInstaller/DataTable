using System;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class PhasedActivityView : ActivityViewBase
{
	[SerializeField]
	private LoopListView2 phasedItemList;

	[SerializeField]
	private LoopListView2 taskItemList;

	private PhasedActivityViewModel viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (PhasedActivityViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<PhasedActivityView, PhasedActivityViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((PhasedActivityView v) => v.RefreshTaskList).To((PhasedActivityViewModel vm) => vm.RefreshActivityTaskRequest);
		bindingSet.Build();
		phasedItemList.InitListView(this.viewModel.PhasedItemList.Count, OnGetPhasedItemByIndex);
		taskItemList.InitListView(this.viewModel.ShowActivityTaskItemDataList.Count, OnGetTaskItemByIndex);
	}

	private void RefreshTaskList(object sender, InteractionEventArgs e)
	{
		taskItemList.SetListItemCount(viewModel.ShowActivityTaskItemDataList.Count);
		taskItemList.RefreshAllShownItem();
	}

	public override void OnShow()
	{
		base.OnShow();
	}

	public override void Show(bool ignoreAnimation = false, Action onStartAction = null)
	{
		base.Show(ignoreAnimation, onStartAction);
		int itemIndex = viewModel.MoveToPhased();
		phasedItemList.MovePanelToItemIndex(itemIndex, 0f);
		taskItemList.MovePanelToItemIndex(0, 0f);
		viewModel.CheckRedPoint();
	}

	private LoopListViewItem2 OnGetPhasedItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PhasedItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PhasedItem");
		if (loopListViewItem != null)
		{
			ActivityTabItem2 component = loopListViewItem.GetComponent<ActivityTabItem2>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PhasedItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.PhasedItemList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ShowActivityTaskItemDataList.Count)
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
				component.Init(viewModel.ShowActivityTaskItemDataList[index]);
			}
			else
			{
				component.RefreshActivityTaskItem(viewModel.ShowActivityTaskItemDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
