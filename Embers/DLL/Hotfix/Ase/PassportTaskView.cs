using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportTaskView : UGuiView
{
	[SerializeField]
	private List<TabItemNormal> taskTabList;

	[SerializeField]
	private LoopListView2 taskList;

	[SerializeField]
	private Button btnGetAll;

	[SerializeField]
	private GameObject btnGetAllObj;

	private PassportTaskViewModel viewModel;

	public void Init(PassportTaskViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportTaskView, PassportTaskViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btnGetAll).For((Button v) => v.onClick).To((PassportTaskViewModel vm) => vm.GetAllCmd);
		bindingSet.Bind(this).For((PassportTaskView v) => v.RefreshTask).To((PassportTaskViewModel vm) => vm.RefreshTaskRequest);
		bindingSet.Bind(btnGetAllObj).For((GameObject v) => v.activeSelf).To((PassportTaskViewModel vm) => vm.RedPoint);
		bindingSet.Build();
		taskList.InitListView(viewModel.ShowTaskList.Count, OnGetTaskItemByIndex);
		for (int num = 0; num < taskTabList.Count; num++)
		{
			taskTabList[num].Init(viewModel.TaskTagList[num]);
		}
	}

	private void RefreshTask(object sender, InteractionEventArgs e)
	{
		taskList.SetListItemCount(viewModel.ShowTaskList.Count);
		taskList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ShowTaskList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TaskItem");
		if (loopListViewItem != null)
		{
			PassportTaskItem component = loopListViewItem.GetComponent<PassportTaskItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ShowTaskList[index]);
			}
			else
			{
				component.RefreshTaskItem(viewModel.ShowTaskList[index]);
			}
		}
		return loopListViewItem;
	}
}
