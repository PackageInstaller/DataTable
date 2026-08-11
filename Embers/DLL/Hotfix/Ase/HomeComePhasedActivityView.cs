using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class HomeComePhasedActivityView : UGuiView
{
	[SerializeField]
	private LoopListView2 tagList;

	[SerializeField]
	private LoopListView2 taskItemList;

	private HomeComePhasedActivityViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		Cache();
		viewModel = GetUserData<HomeComePhasedActivityViewModel>(userData);
		BindingSet<HomeComePhasedActivityView, HomeComePhasedActivityViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HomeComePhasedActivityView v) => v.RefreshAll).To((HomeComePhasedActivityViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		if (tagList != null)
		{
			tagList.InitListView(viewModel.TabList.Count, OnGetTagItemByIndex);
		}
		if (taskItemList != null)
		{
			taskItemList.InitListView(viewModel.ShowTaskList.Count, OnGetTaskItemByIndex);
		}
		RefreshAll();
	}

	private void Cache()
	{
		if (tagList == null)
		{
			tagList = base.transform.Find("TagList")?.GetComponent<LoopListView2>();
		}
		if (taskItemList == null)
		{
			taskItemList = base.transform.Find("TaskItemList")?.GetComponent<LoopListView2>();
		}
	}

	private void RefreshAll(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel != null)
		{
			if (tagList != null)
			{
				tagList.SetListItemCount(viewModel.TabList.Count);
				tagList.RefreshAllShownItem();
			}
			if (taskItemList != null)
			{
				taskItemList.SetListItemCount(viewModel.ShowTaskList.Count);
				taskItemList.RefreshAllShownItem();
			}
		}
	}

	private LoopListViewItem2 OnGetTagItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.TabList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("PhasedItem");
		ActivityTabItem2 component = loopListViewItem.GetComponent<ActivityTabItem2>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel.TabList[index]);
		}
		else
		{
			component.RefreshData(viewModel.TabList[index]);
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.ShowTaskList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("ActivityTaskItem");
		ActivityTaskItem component = loopListViewItem.GetComponent<ActivityTaskItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel.ShowTaskList[index]);
		}
		else
		{
			component.RefreshActivityTaskItem(viewModel.ShowTaskList[index]);
		}
		return loopListViewItem;
	}
}
