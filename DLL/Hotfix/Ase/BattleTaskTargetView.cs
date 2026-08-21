using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleTaskTargetView : UGuiView
{
	[SerializeField]
	private Transform root1;

	[SerializeField]
	private Transform root2;

	[SerializeField]
	private RectTransform panel;

	[SerializeField]
	private LoopListView2 taskList;

	[SerializeField]
	private Button openTaskBtn;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private CanvasGroup taskUIPosCanvasGroup;

	[SerializeField]
	private float changeTrackTime = 2f;

	private float changeTrackShowTimer;

	[SerializeField]
	private Transform taskUIPosParent;

	[SerializeField]
	private GameObject taskUIPosObj;

	private Coroutine CancelChangeTrack;

	private BattleTaskTargetViewModel viewModel;

	private List<TaskUIPointDirView> _taskUIPointDirViews;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<BattleTaskTargetViewModel>(userData);
		BindingSet<BattleTaskTargetView, BattleTaskTargetViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleTaskTargetView v) => v.UpdateTaskList).To((BattleTaskTargetViewModel vm) => vm.UpdateTaskListRequest);
		bindingSet.Bind(this).For((BattleTaskTargetView v) => v.UpdateTaskPos).To((BattleTaskTargetViewModel vm) => vm.UpdateTaskUIPosRequest);
		bindingSet.Bind(this).For((BattleTaskTargetView v) => v.OnCancelTimer).To((BattleTaskTargetViewModel vm) => vm.ChangeTrackCancelTimerRequest);
		bindingSet.Bind(openTaskBtn).For((Button v) => v.onClick).To((BattleTaskTargetViewModel vm) => vm.OnClickTaskBtn);
		bindingSet.Bind(openTaskBtn).For((Button v) => v.interactable).To((BattleTaskTargetViewModel vm) => vm.TaskBtnCanClick);
		bindingSet.Bind<CanvasGroup>(taskUIPosCanvasGroup).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((BattleTaskTargetViewModel vm) => vm.TaskDirUIAlpha);
		bindingSet.Build();
		base.transform.parent = viewModel.Root;
		taskList.InitListView(viewModel.Count, OnGetTaskItemByIndex);
		scrollRect.horizontal = false;
		scrollRect.vertical = false;
		ShowTaskUIPos();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleTaskTargetViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private void UpdateTaskPos(object sender, InteractionEventArgs e)
	{
		ShowTaskUIPos();
	}

	private void ShowTaskUIPos()
	{
		List<BattleTaskUIPosViewModel> taskUIPosViewModels = viewModel.TaskUIPosViewModels;
		if (taskUIPosViewModels == null)
		{
			return;
		}
		if (_taskUIPointDirViews == null)
		{
			_taskUIPointDirViews = new List<TaskUIPointDirView>(taskUIPosViewModels.Count);
		}
		int count = taskUIPosViewModels.Count;
		int count2 = _taskUIPointDirViews.Count;
		if (count2 < count)
		{
			for (int i = count2 + 1; i <= count; i++)
			{
				TaskUIPointDirView component = UnityEngine.Object.Instantiate(taskUIPosObj, taskUIPosParent).GetComponent<TaskUIPointDirView>();
				_taskUIPointDirViews.Add(component);
			}
		}
		else if (count2 > count)
		{
			for (int j = count; j < count2; j++)
			{
				_taskUIPointDirViews[j].gameObject.SetActive(value: false);
			}
		}
		for (int k = 0; k < count; k++)
		{
			_taskUIPointDirViews[k].gameObject.SetActive(value: true);
			if (!_taskUIPointDirViews[k].InitFinish)
			{
				_taskUIPointDirViews[k].Init(taskUIPosViewModels[k]);
			}
			else
			{
				_taskUIPointDirViews[k].RefreshData(taskUIPosViewModels[k]);
			}
		}
	}

	private void UpdateTaskList(object sender, InteractionEventArgs e)
	{
		CancelChangeTrackCoro();
		bool num = (bool)e.Context;
		taskList.SetListItemCount(viewModel.Count);
		taskList.RefreshAllShownItem();
		if (num)
		{
			changeTrackShowTimer = 0f;
			CancelChangeTrack = StartCoroutine(ChangeTrack());
		}
	}

	private IEnumerator ChangeTrack()
	{
		while (true)
		{
			if (viewModel != null && !viewModel.GamePause)
			{
				yield return null;
				changeTrackShowTimer += Time.deltaTime;
				if (changeTrackShowTimer >= changeTrackTime + 0.5f)
				{
					break;
				}
				if (changeTrackShowTimer >= changeTrackTime)
				{
					TrackDisappearPlayHideAn();
				}
			}
			else
			{
				yield return null;
			}
		}
		viewModel.HideChangeTrackUI();
		CancelChangeTrack = null;
	}

	private void CancelChangeTrackCoro()
	{
		if (CancelChangeTrack != null)
		{
			StopCoroutine(CancelChangeTrack);
			CancelChangeTrack = null;
		}
	}

	private void OnCancelTimer(object sender, InteractionEventArgs e)
	{
		CancelChangeTrackCoro();
	}

	private void TrackDisappearPlayHideAn()
	{
		List<LoopListViewItem2> itemList = taskList.ItemList;
		if (itemList == null)
		{
			return;
		}
		for (int i = 0; i < itemList.Count; i++)
		{
			if (itemList[i].gameObject.activeSelf)
			{
				itemList[i].TryGetComponent<BattleTaskTargetItemView>(out var component);
				if (component != null)
				{
					component.TrackDisappearPlayHideAn();
				}
			}
		}
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		BattleTaskTargetItemViewModel itemByIndex = viewModel.GetItemByIndex(index);
		loopListViewItem = (itemByIndex.ClickTrackUI ? listView2.NewListViewItem("ClickChangeTrackItemView") : ((itemByIndex.Data.ParentTaskId != 0 && itemByIndex.Data.ParallelTaskType != 4) ? listView2.NewListViewItem("TaskProgressItemView") : (itemByIndex.HasChild ? listView2.NewListViewItem("TaskTargetItemView") : listView2.NewListViewItem("TaskTargetItemView2"))));
		if (loopListViewItem != null)
		{
			BattleTaskTargetItemView component = loopListViewItem.GetComponent<BattleTaskTargetItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(itemByIndex);
			}
			else
			{
				component.RefreshData(itemByIndex);
			}
		}
		return loopListViewItem;
	}
}
