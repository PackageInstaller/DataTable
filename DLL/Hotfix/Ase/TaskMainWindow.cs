using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskMainWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopListView2 taskList;

	[SerializeField]
	private StateItem haveTaskState;

	[SerializeField]
	private TextMeshProUGUI haveTaskDesc;

	[SerializeField]
	private TaskMainDetailView detailView;

	[SerializeField]
	private Transform toggleRoot;

	[SerializeField]
	private TaskExtraView extraView;

	[SerializeField]
	private List<int> toggleSysOpenIdList;

	private bool isInit;

	private List<TabToggle> toggleList;

	private TaskMainViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TaskMainViewModel>();
		BindingSet<TaskMainWindow, TaskMainViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TaskMainWindow v) => v.OpenUguiWindow).To((TaskMainViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((TaskMainWindow v) => v.OnDismissRequest).To((TaskMainViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TaskMainWindow v) => v.ShowExtra).To((TaskMainViewModel vm) => vm.ShowExtraRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((TaskMainViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(haveTaskState).For((StateItem v) => v.CurState).To((TaskMainViewModel vm) => vm.HaveTask);
		bindingSet.Bind<TextMeshProUGUI>(haveTaskDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainViewModel vm) => vm.HaveTaskDesc);
		bindingSet.Bind(this).For((TaskMainWindow v) => v.UpdateDetail).To((TaskMainViewModel vm) => vm.UpdateDetailRequest);
		bindingSet.Bind(this).For((TaskMainWindow v) => v.UpdateList).To((TaskMainViewModel vm) => vm.UpdateTaskListRequest);
		bindingSet.Bind(this).For((TaskMainWindow v) => v.UpdateToggleNew).To((TaskMainViewModel vm) => vm.UpdateToggleNewRequest);
		bindingSet.Build();
		taskList.InitListView(viewModel.TaskCount, OnGetTaskItemByIndex);
		InitToggles();
	}

	private void ShowExtra(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		if (flag)
		{
			extraView.Init(viewModel.ExtraVm);
		}
		extraView.gameObject.SetActive(flag);
	}

	private void UpdateToggleNew(object sender, InteractionEventArgs e)
	{
		for (int i = 0; i < toggleList.Count; i++)
		{
			toggleList[i].UpdateNewState(viewModel.RedPointData.GetNewTaskId(toggleList[i].enumId) != -1);
		}
	}

	private void UpdateList(object sender, InteractionEventArgs e)
	{
		taskList.SetListItemCount(viewModel.TaskCount, resetPos: false);
		taskList.RefreshAllShownItem();
	}

	private void InitToggles()
	{
		int childCount = toggleRoot.childCount;
		toggleList = new List<TabToggle>();
		viewModel.AddSysOpenInfo(toggleSysOpenIdList);
		for (int i = 0; i < childCount; i++)
		{
			TabToggle component = toggleRoot.GetChild(i).GetComponent<TabToggle>();
			if (component != null)
			{
				toggleList.Add(component);
				component.AddSelectedAction(viewModel.OnSelectTaskType);
				component.UpdateNewState(viewModel.RedPointData.GetNewTaskId(component.enumId) != -1);
			}
		}
	}

	private void UpdateDetail(object sender, InteractionEventArgs e)
	{
		if (!detailView.IsInit && !detailView.IsInit && viewModel.HaveTask == 1)
		{
			detailView.Init(viewModel.DetailVm);
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		if (viewModel.HaveTask == 1)
		{
			detailView.Init(viewModel.DetailVm);
		}
		OpenIndex();
	}

	private async void OpenIndex()
	{
		if (viewModel.openIndex == 0)
		{
			return;
		}
		if (toggleList.Count > viewModel.openIndex)
		{
			for (int i = 0; i < toggleList.Count; i++)
			{
				if (toggleList[i].enumId == viewModel.openIndex)
				{
					toggleList[i].isOn = true;
					break;
				}
			}
		}
		toggleList[0].CancelSelect();
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TaskCount)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = ((!viewModel.TaskItemDic[index].IsTitle) ? listView2.NewListViewItem("TaskItem_Small") : listView2.NewListViewItem("TaskItem_Big"));
		if (loopListViewItem != null)
		{
			TaskMainItemView component = loopListViewItem.GetComponent<TaskMainItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TaskItemDic[index]);
			}
			else
			{
				component.RefreshData(viewModel.TaskItemDic[index]);
			}
		}
		return loopListViewItem;
	}
}
