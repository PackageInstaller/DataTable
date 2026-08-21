#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Linq;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleTaskTargetViewModel : OptionBase, IUpdateActorPos
{
	private int levelId;

	private ISubscription<TaskChangeNotifyMessager> subscription;

	private bool taskBtnCanClik = true;

	private bool inBattleState;

	private int taskDirUIAlpha = 1;

	private bool taskDirUIBtnShowAlpha = true;

	private bool isShowTrackUI;

	private Vector3 heroPos;

	private bool showTaskUIPosBtn = true;

	private bool gamePause;

	private Transform root;

	private List<BattleTaskUIPosViewModel> taskUIPosViewModels;

	private int count;

	private List<BattleTaskTargetItemViewModel> itemList;

	private Dictionary<int, BattleTaskTargetItemViewModel> childList = new Dictionary<int, BattleTaskTargetItemViewModel>();

	private InteractionRequest<bool> updateTaskListRequest;

	private InteractionRequest updateTaskUIPosRequest;

	private InteractionRequest changeTrackCancelTimerRequest;

	private int enterCavernId;

	public Vector3 HeroPos => heroPos;

	public bool GamePause => gamePause;

	public Transform Root => root;

	public List<BattleTaskUIPosViewModel> TaskUIPosViewModels => taskUIPosViewModels;

	public bool TaskBtnCanClick
	{
		get
		{
			return taskBtnCanClik;
		}
		set
		{
			Set(ref taskBtnCanClik, value, "TaskBtnCanClick");
		}
	}

	public bool InBattleState
	{
		get
		{
			return inBattleState;
		}
		set
		{
			Set(ref inBattleState, value, "InBattleState");
			ChangeTaskDirUIAlpha();
		}
	}

	public int TaskDirUIAlpha
	{
		get
		{
			return taskDirUIAlpha;
		}
		set
		{
			Set(ref taskDirUIAlpha, value, "TaskDirUIAlpha");
		}
	}

	public bool ShowTaskUIPosBtn
	{
		get
		{
			return showTaskUIPosBtn;
		}
		set
		{
			Set(ref showTaskUIPosBtn, value, "ShowTaskUIPosBtn");
		}
	}

	public IInteractionRequest UpdateTaskListRequest => updateTaskListRequest;

	public IInteractionRequest UpdateTaskUIPosRequest => updateTaskUIPosRequest;

	public IInteractionRequest ChangeTrackCancelTimerRequest => changeTrackCancelTimerRequest;

	public List<BattleTaskTargetItemViewModel> ItemList => itemList;

	public int Count => count;

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && optionArg.OptionName.Equals("ClickChangeTrackItemView"))
		{
			Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().ChangeTaskTrack();
		}
	}

	public BattleTaskTargetViewModel()
	{
		taskUIPosViewModels = new List<BattleTaskUIPosViewModel>();
	}

	public BattleTaskTargetViewModel(OptionBase parent, int levelId, Transform parentRoot)
	{
		this.levelId = levelId;
		base.parent = parent;
		itemList = new List<BattleTaskTargetItemViewModel>();
		updateTaskListRequest = new InteractionRequest<bool>();
		updateTaskUIPosRequest = new InteractionRequest();
		changeTrackCancelTimerRequest = new InteractionRequest();
		subscription = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTaskMessager().Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
		taskUIPosViewModels = new List<BattleTaskUIPosViewModel>();
		root = parentRoot;
	}

	private void OnTaskChangeNotify(TaskChangeNotifyMessager msg)
	{
		ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
		isShowTrackUI = false;
		if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.Disconnect)
		{
			itemList.Clear();
			childList.Clear();
			count = 0;
			updateTaskListRequest.Raise(context: false);
			return;
		}
		if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.TrackSet || msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.Finished || msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.HideChangeTrackUI)
		{
			if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.Finished && msg.taskDataViewModel.ParentTaskId == 0 && msg.taskDataViewModel.TaskType != 1)
			{
				_ = msg.taskDataViewModel.TrackState;
			}
			if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.HideChangeTrackUI)
			{
				UpdateItemList(new List<TaskDataViewModel>());
				updateTaskListRequest.Raise(context: true);
				isShowTrackUI = false;
			}
			List<TaskDataViewModel> list = service.FilterTrackingTask(service.GetDisplayLevelTask(levelId));
			UpdateItemList(list);
			updateTaskListRequest.Raise(context: false);
		}
		else if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.ShowChangeTrackUI)
		{
			UpdateItemList(new List<TaskDataViewModel>());
			updateTaskListRequest.Raise(context: true);
			List<TaskDataViewModel> changeTrackTaskData = service.GetChangeTrackTaskData(service.GetDisplayLevelTask(levelId));
			UpdateItemList(changeTrackTaskData);
			AddClickTrackUI();
			updateTaskListRequest.Raise(context: true);
			isShowTrackUI = true;
		}
		UpdateTaskUIPos();
	}

	public void UpdateTaskUIPos()
	{
		ShowTaskUIPosBtn = itemList.Count > 0 && !isShowTrackUI;
		List<TaskDataViewModel> allLevelUnFinishTrackTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllLevelUnFinishTrackTask(levelId);
		if (allLevelUnFinishTrackTask == null)
		{
			if (taskUIPosViewModels != null)
			{
				taskUIPosViewModels.Clear();
			}
			return;
		}
		List<Vector3> list = new List<Vector3>(5);
		List<float> list2 = new List<float>(5);
		if (enterCavernId != 0)
		{
			for (int i = 0; i < allLevelUnFinishTrackTask.Count; i++)
			{
				if (allLevelUnFinishTrackTask[i].CaveId == enterCavernId)
				{
					AddTaskPoint(list, list2, allLevelUnFinishTrackTask[i]);
				}
			}
		}
		else
		{
			for (int j = 0; j < allLevelUnFinishTrackTask.Count; j++)
			{
				if (allLevelUnFinishTrackTask[j].CaveId != 0)
				{
					list.AddRange(allLevelUnFinishTrackTask[j].TaskUIPosCavern);
					for (int k = 0; k < allLevelUnFinishTrackTask[j].TaskUIPosCavern.Count; k++)
					{
						list2.Add(0f);
					}
				}
				else
				{
					AddTaskPoint(list, list2, allLevelUnFinishTrackTask[j]);
				}
			}
		}
		int num = list.Count;
		int num2 = taskUIPosViewModels.Count;
		if (num2 < num)
		{
			for (int l = num2 + 1; l <= num; l++)
			{
				taskUIPosViewModels.Add(new BattleTaskUIPosViewModel(this, Vector3.zero, 0f, 0));
			}
		}
		else if (num2 > num)
		{
			taskUIPosViewModels.RemoveRange(num, num2 - num);
		}
		for (int m = 0; m < list.Count; m++)
		{
			taskUIPosViewModels[m].UpdatePos(list[m], list2[m]);
		}
		updateTaskUIPosRequest.Raise();
	}

	private void AddTaskPoint(List<Vector3> uiPos, List<float> uiPosRadius, TaskDataViewModel taskDataViewModel)
	{
		if (taskDataViewModel == null || taskDataViewModel.TaskUIRadius == null)
		{
			return;
		}
		uiPos.AddRange(taskDataViewModel.TaskUIPosNormal);
		if (taskDataViewModel.TaskUIRadius.Count == 0)
		{
			for (int i = 0; i < taskDataViewModel.TaskUIPosNormal.Count; i++)
			{
				uiPosRadius.Add(0f);
			}
		}
		else
		{
			uiPosRadius.AddRange(taskDataViewModel.TaskUIRadius);
		}
	}

	private void AddClickTrackUI()
	{
		count++;
		BattleTaskTargetItemViewModel battleTaskTargetItemViewModel = new BattleTaskTargetItemViewModel(this, null);
		battleTaskTargetItemViewModel.ClickTrackUI = true;
		battleTaskTargetItemViewModel.Index = count - 1;
		itemList.Add(battleTaskTargetItemViewModel);
	}

	public void HideChangeTrackUI()
	{
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().HideChangeTaskTrack();
	}

	public void UpdateItemList(List<TaskDataViewModel> list)
	{
		if (itemList == null)
		{
			return;
		}
		int i;
		for (i = itemList.Count - 1; i >= 0; i--)
		{
			if (list.FindIndex((TaskDataViewModel p) => p.TaskId == itemList[i].Index) >= 0)
			{
				continue;
			}
			if (itemList[i].Data != null)
			{
				List<int> childTask = itemList[i].Data.GetChildTask();
				if (childTask != null && childTask.Count > 0)
				{
					for (int num = 0; num < childTask.Count; num++)
					{
						if (childList != null && childList.ContainsKey(childTask[num]))
						{
							childList.Remove(childTask[num]);
						}
					}
				}
			}
			itemList.RemoveAt(i);
		}
		int i2;
		for (i2 = 0; i2 < list.Count; i2++)
		{
			if (list[i2] != null && list[i2].ParentTaskId != 0)
			{
				TaskDataViewModel parent = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(list[i2].ParentTaskId);
				if (parent == null)
				{
					Log.Error($"任务{list[i2].TaskId} 找不到父任务 {list[i2].ParentTaskId}，请检查！");
				}
				else if (list.FindIndex((TaskDataViewModel p) => p.TaskId == parent.TaskId) < 0)
				{
					list.Add(parent);
				}
			}
			else
			{
				if (itemList.FindIndex((BattleTaskTargetItemViewModel p) => p.Data.TaskId == list[i2].TaskId) >= 0)
				{
					continue;
				}
				BattleTaskTargetItemViewModel battleTaskTargetItemViewModel = new BattleTaskTargetItemViewModel(this, list[i2]);
				itemList.Add(battleTaskTargetItemViewModel);
				if (list[i2].ParallelTaskType == 1 || list[i2].ParallelTaskType == 4)
				{
					battleTaskTargetItemViewModel.HasChild = false;
					continue;
				}
				List<int> childTask2 = list[i2].GetChildTask();
				if (childTask2 == null || childTask2.Count <= 0)
				{
					continue;
				}
				for (int num2 = 0; num2 < childTask2.Count; num2++)
				{
					if (childList.ContainsKey(childTask2[num2]))
					{
						continue;
					}
					TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(childTask2[num2]);
					if (task != null)
					{
						childList.Add(childTask2[num2], new BattleTaskTargetItemViewModel(this, task));
						if (list[i2].ChildTaskType == 2)
						{
							break;
						}
					}
				}
			}
		}
		itemList = itemList.OrderBy((BattleTaskTargetItemViewModel p) => p.Data.TaskType).ToList();
		int num3 = 0;
		for (int num4 = 0; num4 < itemList.Count; num4++)
		{
			if (itemList[num4] == null)
			{
				continue;
			}
			itemList[num4].Index = num3;
			num3++;
			if (itemList[num4].Data == null || itemList[num4].Data.ParallelTaskType == 1 || itemList[num4].Data.ParallelTaskType == 4)
			{
				continue;
			}
			List<int> childTask3 = itemList[num4].Data.GetChildTask();
			if (childTask3 != null && childTask3.Count > 0)
			{
				itemList[num4].HasChild = true;
				for (int num5 = 0; num5 < childTask3.Count; num5++)
				{
					if (childList.ContainsKey(childTask3[num5]))
					{
						childList[childTask3[num5]].Index = num3;
						num3++;
					}
				}
			}
			else
			{
				itemList[num4].HasChild = false;
			}
		}
		count = itemList.Count + childList.Count;
	}

	public BattleTaskTargetItemViewModel GetItemByIndex(int index)
	{
		if (index >= count)
		{
			Log.Error("任务追踪列表超出上限！");
			return null;
		}
		for (int i = 0; i < itemList.Count; i++)
		{
			if (itemList[i].Index == index)
			{
				return itemList[i];
			}
		}
		foreach (KeyValuePair<int, BattleTaskTargetItemViewModel> child in childList)
		{
			if (child.Value.Index == index)
			{
				return child.Value;
			}
		}
		return null;
	}

	public void OnTrackChange()
	{
		ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
		List<TaskDataViewModel> list = service.FilterTrackingTask(service.GetDisplayLevelTask(levelId));
		UpdateItemList(list);
		updateTaskListRequest.Raise(context: false);
	}

	public void OnClickTaskBtn()
	{
		parent.ItemOnClick(new OptionArg(this, "OpenTaskWindow"));
	}

	public void UpdateHeroPos(Vector3 entityTranPosition)
	{
		heroPos = entityTranPosition;
	}

	public override void Dispose()
	{
		base.Dispose();
		itemList.Clear();
		for (int i = 0; i < taskUIPosViewModels.Count; i++)
		{
			taskUIPosViewModels[i]?.Dispose();
		}
		taskUIPosViewModels.Clear();
	}

	public void ClickTaskDirUIBtn()
	{
		taskDirUIBtnShowAlpha = !taskDirUIBtnShowAlpha;
		ChangeTaskDirUIAlpha();
	}

	private void ChangeTaskDirUIAlpha()
	{
		TaskDirUIAlpha = ((taskDirUIBtnShowAlpha && !inBattleState) ? 1 : 0);
	}

	public void SetCavernID(int cavernId)
	{
		enterCavernId = cavernId;
		UpdateTaskUIPos();
	}

	public void SetPause(bool isPause)
	{
		gamePause = isPause;
	}

	public Vector3 GetActorPos()
	{
		return heroPos;
	}
}
