#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaskMainViewModel : OptionBase
{
	private class SysOpenParam
	{
		public bool isOpen = true;

		public string desc = "暂无任务";
	}

	private List<TaskMainItemViewModel> allTasks;

	private TaskMainDetailViewModel detailVM;

	private TaskExtraViewModel extraVM;

	private int haveTask;

	private string haveTaskDesc = "";

	private SimpleCommand optCommand;

	private TaskRedPointData redPointData;

	private int taskCount;

	private Dictionary<int, TaskMainItemViewModel> taskItemDic = new Dictionary<int, TaskMainItemViewModel>();

	private Dictionary<int, Dictionary<int, TaskMainItemViewModel>> taskTitles = new Dictionary<int, Dictionary<int, TaskMainItemViewModel>>();

	private InteractionRequest<bool> showExtraRequest = new InteractionRequest<bool>();

	private InteractionRequest updateDetailRequest;

	private InteractionRequest updateTaskListRequest;

	private InteractionRequest updateToggleNewRequest;

	private bool taskUpdate;

	private IMessenger messenger;

	private ISubscription<TaskChangeNotifyMessager> subscription_TaskNotify;

	private List<TaskMainItemViewModel> lockTasks = new List<TaskMainItemViewModel>();

	public int openIndex;

	private int curSelType;

	private TaskMainItemViewModel curSelect;

	public bool disableToggleReselect;

	private Dictionary<int, SysOpenParam> sysOpenList;

	public int HaveTask
	{
		get
		{
			return haveTask;
		}
		private set
		{
			Set(ref haveTask, value, "HaveTask");
		}
	}

	public string HaveTaskDesc
	{
		get
		{
			return haveTaskDesc;
		}
		private set
		{
			Set(ref haveTaskDesc, value, "HaveTaskDesc");
		}
	}

	public int TaskCount
	{
		get
		{
			return taskCount;
		}
		private set
		{
			Set(ref taskCount, value, "TaskCount");
		}
	}

	public Dictionary<int, TaskMainItemViewModel> TaskItemDic => taskItemDic;

	public TaskExtraViewModel ExtraVm => extraVM;

	public TaskMainDetailViewModel DetailVm => detailVM;

	public IInteractionRequest UpdateDetailRequest => updateDetailRequest;

	public IInteractionRequest UpdateTaskListRequest => updateTaskListRequest;

	public IInteractionRequest UpdateToggleNewRequest => updateToggleNewRequest;

	public IInteractionRequest ShowExtraRequest => showExtraRequest;

	public TaskRedPointData RedPointData => redPointData;

	public TaskMainViewModel()
	{
	}

	public TaskMainViewModel(OptionBase parent, TaskRedPointData redPointData, List<TaskDataViewModel> tasks, int openIndex = 0, int selectTaskId = 0)
	{
		base.parent = parent;
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_TaskNotify = messenger.Subscribe<TaskChangeNotifyMessager>(GetTaskNotify);
		updateDetailRequest = new InteractionRequest();
		updateTaskListRequest = new InteractionRequest();
		updateToggleNewRequest = new InteractionRequest();
		detailVM = new TaskMainDetailViewModel(this);
		optCommand = new SimpleCommand(delegate
		{
		});
		allTasks = new List<TaskMainItemViewModel>();
		InitAllTask(redPointData, tasks, selectTaskId);
	}

	private void InitAllTask(TaskRedPointData redPointData, List<TaskDataViewModel> tasks, int selectTaskId = 0)
	{
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		this.redPointData = redPointData;
		Dictionary<int, int> enumInfo = new Dictionary<int, int>();
		redPointData.AddTaskEnumInfo(enumInfo);
		allTasks.Clear();
		taskTitles.Clear();
		taskItemDic.Clear();
		List<int> list = new List<int>();
		for (int i = 0; i < tasks.Count; i++)
		{
			if (tasks[i].ParentTaskId == 0 && !tasks[i].IsFinished() && tasks[i].IsShowInTaskUI())
			{
				list.Add(tasks[i].TaskId);
			}
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		int j;
		for (j = 0; j < tasks.Count; j++)
		{
			if ((tasks[j].ParentTaskId == 0 && tasks[j].IsFinished()) || !tasks[j].IsShowInTaskUI() || (tasks[j].ParentTaskId != 0 && list.IndexOf(tasks[j].ParentTaskId) < 0))
			{
				continue;
			}
			DRTask dataRow = GameEntry.DataTable.GetDataRow((DRTask p) => p.Id == tasks[j].TaskId);
			if (dataRow != null)
			{
				redPointData.UpdateTaskEnumInfo(dataRow.TaskType, dataRow.Id);
				if (dataRow.ParentTask != 0)
				{
					dictionary.Add(tasks[j].TaskId, tasks[j].Progress);
					continue;
				}
				TaskMainItemViewModel taskMainItemViewModel = new TaskMainItemViewModel(this);
				taskMainItemViewModel.InitTaskData(dataRow, tasks[j].Progress, level, GetTimeLockDesc(dataRow));
				if (taskMainItemViewModel.isTimeLock)
				{
					lockTasks.Add(taskMainItemViewModel);
				}
				allTasks.Add(taskMainItemViewModel);
				continue;
			}
			DRDailyTask dataRow2 = GameEntry.DataTable.GetDataRow<DRDailyTask>(tasks[j].TaskId);
			if (dataRow2 != null)
			{
				redPointData.UpdateTaskEnumInfo(dataRow2.TaskType, dataRow2.Id);
				if (dataRow2.ParentTask != 0)
				{
					dictionary.Add(tasks[j].TaskId, tasks[j].Progress);
					continue;
				}
				TaskMainItemViewModel taskMainItemViewModel2 = new TaskMainItemViewModel(this);
				taskMainItemViewModel2.InitTaskData(dataRow2, tasks[j].Progress);
				allTasks.Add(taskMainItemViewModel2);
			}
		}
		allTasks = (from p in allTasks
			orderby p.TaskType, p.TaskTitleId, p.TaskId
			select p).ToList();
		foreach (KeyValuePair<int, int> item in dictionary)
		{
			DRTask dataRow3 = GameEntry.DataTable.GetDataRow<DRTask>(item.Key);
			if (dataRow3 != null)
			{
				TaskMainItemViewModel taskMainItemViewModel3 = new TaskMainItemViewModel(this);
				taskMainItemViewModel3.InitTaskData(dataRow3, item.Value, level, GetTimeLockDesc(dataRow3));
				if (taskMainItemViewModel3.isTimeLock)
				{
					lockTasks.Add(taskMainItemViewModel3);
				}
				for (int num = 0; num < allTasks.Count; num++)
				{
					if (allTasks[num].TaskId == dataRow3.ParentTask && allTasks[num].GetParallelTaskType() != 4)
					{
						allTasks[num].AddChildTask(taskMainItemViewModel3);
					}
				}
				continue;
			}
			DRDailyTask dataRow4 = GameEntry.DataTable.GetDataRow<DRDailyTask>(item.Key);
			if (dataRow4 == null)
			{
				continue;
			}
			TaskMainItemViewModel taskMainItemViewModel4 = new TaskMainItemViewModel(this);
			taskMainItemViewModel4.InitTaskData(dataRow4, item.Value);
			for (int num2 = 0; num2 < allTasks.Count; num2++)
			{
				if (allTasks[num2].TaskId == dataRow4.ParentTask)
				{
					allTasks[num2].AddChildTask(taskMainItemViewModel4);
				}
			}
		}
		for (int num3 = 0; num3 < allTasks.Count - 1; num3++)
		{
			List<int> areaIds = new List<int>();
			for (int num4 = 0; num4 < allTasks[num3].ChildTaskList.Count; num4++)
			{
				AppendList(areaIds, allTasks[num3].ChildTaskList[num4].GetAreaIds());
			}
			for (int num5 = num3 + 1; num5 < allTasks.Count; num5++)
			{
				allTasks[num5].CheckOccupied(areaIds, allTasks[num3]);
			}
		}
		Dictionary<int, List<TaskMainItemViewModel>> dictionary2 = new Dictionary<int, List<TaskMainItemViewModel>>();
		for (int num6 = 0; num6 < allTasks.Count; num6++)
		{
			if (dictionary2.ContainsKey(allTasks[num6].TaskTitleId))
			{
				dictionary2[allTasks[num6].TaskTitleId].Add(allTasks[num6]);
				continue;
			}
			dictionary2.Add(allTasks[num6].TaskTitleId, new List<TaskMainItemViewModel>());
			dictionary2[allTasks[num6].TaskTitleId].Add(allTasks[num6]);
		}
		foreach (KeyValuePair<int, List<TaskMainItemViewModel>> item2 in dictionary2)
		{
			TaskMainItemViewModel taskMainItemViewModel5 = new TaskMainItemViewModel(this);
			if (item2.Value[0].TaskType == 1 || item2.Value[0].TaskType == 2)
			{
				taskMainItemViewModel5.InitTaskTitle(item2.Value[0].TaskConfig, item2.Value);
			}
			else if (item2.Value[0].TaskType == 3)
			{
				taskMainItemViewModel5.InitTaskTitle(item2.Value[0].TaskDailyConfig, item2.Value);
			}
			int enumId = GetEnumId(taskMainItemViewModel5);
			if (!taskTitles.ContainsKey(enumId))
			{
				taskTitles.Add(enumId, new Dictionary<int, TaskMainItemViewModel>());
			}
			taskTitles[enumId].Add(item2.Key, taskMainItemViewModel5);
		}
		haveTask = ((taskTitles.Count > 0) ? 1 : 0);
		if (haveTask == 0)
		{
			haveTaskDesc = "暂无任务";
			return;
		}
		if (selectTaskId == -1)
		{
			List<TaskDataViewModel> list2 = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().FilterTrackingTask(Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask());
			bool flag = false;
			for (int num7 = 0; num7 < allTasks.Count; num7++)
			{
				foreach (TaskDataViewModel item3 in list2)
				{
					if (item3.TaskId == allTasks[num7].TaskId)
					{
						openIndex = GetEnumId(allTasks[num7]);
						redPointData.OnRead(openIndex, item3.TaskId);
						SelectTaskItem(allTasks[num7]);
						flag = true;
						break;
					}
				}
				if (flag)
				{
					break;
				}
			}
		}
		if (selectTaskId > 0)
		{
			for (int num8 = 0; num8 < allTasks.Count; num8++)
			{
				if (selectTaskId == allTasks[num8].TaskId)
				{
					openIndex = GetEnumId(allTasks[num8]);
					redPointData.OnRead(openIndex, selectTaskId);
					SelectTaskItem(allTasks[num8]);
					break;
				}
			}
		}
		if ((selectTaskId == -1 && curSelect == null) || selectTaskId == 0 || (selectTaskId > 0 && curSelect == null))
		{
			int newTaskId = redPointData.GetNewTaskId(0);
			foreach (TaskMainItemViewModel allTask in allTasks)
			{
				if (newTaskId != -1)
				{
					if (allTask.TaskId == newTaskId)
					{
						SelectTaskItem(allTask);
						redPointData.OnRead(0, newTaskId);
						break;
					}
				}
				else if (allTask.TaskConfig != null)
				{
					SelectTaskItem(allTask);
					break;
				}
			}
			if (curSelect == null && allTasks.Count > 0)
			{
				SelectTaskItem(allTasks[0]);
			}
		}
		string text = PlayerPrefs.GetString("_TaskMainFoldSaving", "");
		Dictionary<int, bool> dictionary3 = new Dictionary<int, bool>();
		if (!string.IsNullOrEmpty(text))
		{
			string[] array = text.Split(';');
			for (int num9 = 0; num9 < array.Length; num9++)
			{
				if (!string.IsNullOrEmpty(array[num9]))
				{
					string[] array2 = array[num9].Split('$');
					if (int.TryParse(array2[0], out var result) && int.TryParse(array2[1], out var result2))
					{
						dictionary3.Add(result, result2 == 1);
					}
				}
			}
		}
		if (dictionary3.Count > 0)
		{
			foreach (KeyValuePair<int, bool> item4 in dictionary3)
			{
				foreach (Dictionary<int, TaskMainItemViewModel> value in taskTitles.Values)
				{
					if (value.ContainsKey(item4.Key))
					{
						value[item4.Key].isFold = item4.Value;
					}
				}
			}
		}
		else
		{
			foreach (Dictionary<int, TaskMainItemViewModel> value2 in taskTitles.Values)
			{
				foreach (KeyValuePair<int, TaskMainItemViewModel> item5 in value2)
				{
					item5.Value.isFold = false;
				}
			}
		}
		taskItemDic = new Dictionary<int, TaskMainItemViewModel>();
		UpdateTaskList();
	}

	private void GetTaskNotify(TaskChangeNotifyMessager obj)
	{
		taskUpdate = true;
	}

	private string GetTimeLockDesc(DRTask task)
	{
		long num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().ServerOpenTime + task.TimeLock * 24 * 3600;
		long num2 = (long)(DateTime.Now - new DateTime(1970, 1, 1, 8, 0, 0)).TotalSeconds;
		if (num2 >= num)
		{
			return null;
		}
		float num3 = (float)(num - num2) / 3600f;
		if (num3 < 24f)
		{
			return $"{Mathf.CeilToInt(num3)}小时后解锁";
		}
		float num4 = num3 / 24f;
		if ((float)task.TimeLock > num4)
		{
			return $"{Mathf.Floor(num4)}天后解锁";
		}
		return null;
	}

	public void OnTimerUpdate()
	{
		for (int i = 0; i < lockTasks.Count; i++)
		{
			string timeLockDesc = GetTimeLockDesc(lockTasks[i].TaskConfig);
			if (timeLockDesc == null)
			{
				lockTasks[i].isTimeLock = false;
			}
			lockTasks[i].timeLockDesc = timeLockDesc;
		}
		if (detailVM != null)
		{
			detailVM.OnTimerUpdate();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TaskMainItemViewModel item)
		{
			if (optCommand.Enabled)
			{
				optCommand.Enabled = false;
				SelectTaskItem(item);
				optCommand.Enabled = true;
			}
		}
		else if (obj is TaskMainProgressItemViewModel progressItem)
		{
			if (optCommand.Enabled)
			{
				optCommand.Enabled = false;
				Jump2Map(progressItem);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if ("Close2Main".Equals(optionArg.OptionName))
			{
				Close();
			}
			else if ("ShowImg".Equals(optionArg.OptionName))
			{
				ShowImg((TaskMainDetailViewModel)optionArg.Obj);
			}
		}
		else if (obj is BattleSelectResult obj2)
		{
			parent?.ItemOnClick(obj2);
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is TaskExtraViewModel)
		{
			showExtraRequest.Raise(context: false);
		}
		else if (obj is LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
		{
			loadingToOtherLevelViewModel.AddCloseView(this);
			parent?.ItemOnClick(loadingToOtherLevelViewModel);
		}
	}

	private void AppendList(List<int> areaIds, List<int> getAreaIds)
	{
		for (int i = 0; i < getAreaIds.Count; i++)
		{
			if (!areaIds.Contains(getAreaIds[i]))
			{
				areaIds.Add(getAreaIds[i]);
			}
		}
	}

	private int GetEnumId(TaskMainItemViewModel item)
	{
		if (item == null)
		{
			return 0;
		}
		if (item.GetTaskType() == 1 || item.GetTaskType() == 2)
		{
			return 0;
		}
		if (item.GetTaskType() == 3)
		{
			return 1;
		}
		return 0;
	}

	public void OnSelectTaskType(int enumId)
	{
		if (enumId != curSelType)
		{
			curSelType = enumId;
			SysOpenParam sysOpenParam = GetSysOpenParam(enumId);
			HaveTaskDesc = sysOpenParam.desc;
			if (!sysOpenParam.isOpen)
			{
				taskItemDic.Clear();
				taskCount = 0;
				HaveTask = 0;
			}
			else if (enumId == 0 || enumId == 1)
			{
				UpdateTaskList(openFold: true);
			}
			else
			{
				taskItemDic.Clear();
				taskCount = 0;
				HaveTask = 0;
			}
			int newTaskId = redPointData.GetNewTaskId(enumId);
			if (enumId == 1)
			{
				redPointData.SetUnRed();
			}
			updateToggleNewRequest.Raise();
			if (disableToggleReselect)
			{
				disableToggleReselect = false;
			}
			else
			{
				SelectFirstInList(newTaskId);
			}
			updateTaskListRequest.Raise();
		}
	}

	private SysOpenParam GetSysOpenParam(int enumId)
	{
		if (sysOpenList.ContainsKey(enumId))
		{
			return sysOpenList[enumId];
		}
		return new SysOpenParam();
	}

	private void UpdateTaskList(bool openFold = false)
	{
		int num = 0;
		taskItemDic.Clear();
		if (taskTitles.ContainsKey(curSelType))
		{
			foreach (KeyValuePair<int, TaskMainItemViewModel> item in taskTitles[curSelType])
			{
				taskItemDic.Add(num, item.Value);
				num++;
				if (openFold)
				{
					item.Value.isFold = false;
				}
				if (item.Value.isFold)
				{
					continue;
				}
				foreach (TaskMainItemViewModel childTask in item.Value.ChildTaskList)
				{
					taskItemDic.Add(num, childTask);
					num++;
				}
			}
		}
		taskCount = num;
		HaveTask = ((taskCount > 0) ? 1 : 0);
	}

	private void SelectTaskItem(TaskMainItemViewModel item)
	{
		if (item.IsTitle)
		{
			item.isFold = !item.isFold;
			UpdateTaskList();
			updateTaskListRequest.Raise();
		}
		else
		{
			if (curSelect != null && curSelect == item)
			{
				return;
			}
			if (curSelect != null)
			{
				curSelect.SetSelect(isSelect: false);
			}
			curSelect = item;
			curSelect.SetSelect(isSelect: true);
			redPointData.OnRead(curSelType, curSelect.TaskId);
			if (curSelect.TaskConfig != null || curSelect.TaskDailyConfig != null)
			{
				foreach (KeyValuePair<int, Dictionary<int, TaskMainItemViewModel>> taskTitle in taskTitles)
				{
					foreach (KeyValuePair<int, TaskMainItemViewModel> item2 in taskTitle.Value)
					{
						item2.Value.SetSelect(item2.Value.TaskId == curSelect.TaskTitleId);
					}
				}
			}
			detailVM.RefreshData(curSelect);
			updateDetailRequest.Raise();
		}
	}

	private void SelectFirstInList(int newTaskId)
	{
		if (TaskItemDic.Count == 0)
		{
			return;
		}
		for (int i = 0; i < taskItemDic.Count; i++)
		{
			if (newTaskId != -1)
			{
				if (!taskItemDic[i].IsTitle && taskItemDic[i].TaskId == newTaskId)
				{
					SelectTaskItem(taskItemDic[i]);
					break;
				}
			}
			else if (!taskItemDic[i].IsTitle)
			{
				SelectTaskItem(taskItemDic[i]);
				break;
			}
		}
	}

	private async void Jump2Map(TaskMainProgressItemViewModel progressItem)
	{
		if (progressItem.isTimeLock && !(await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckTaskTimeLock(progressItem.taskId)))
		{
			Toast.ShowInfo("任务暂未开放！请等待任务开放！");
			optCommand.Enabled = true;
			return;
		}
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().SetTaskTrackState(progressItem.taskId, trackState: true);
		for (int i = 0; i < allTasks.Count; i++)
		{
			for (int j = 0; j < allTasks[i].ChildTaskList.Count; j++)
			{
				if (allTasks[i].ChildTaskList[j].TaskId != progressItem.taskId)
				{
					continue;
				}
				int mapDataLevel = allTasks[i].ChildTaskList[j].GetMapDataLevel();
				if (parent != null && parent is BattleViewModel battleViewModel)
				{
					battleViewModel.OpenMapWindow(mapDataLevel, Cb, progressItem.taskId, delegate(MapFunction mapFunction)
					{
						if (mapFunction == MapFunction.Teleport)
						{
							Close();
						}
					});
				}
				else
				{
					MapViewModel mapViewModel = new MapViewModel(this, MapMode.Outer, mapDataLevel);
					mapViewModel.TrackTaskId = progressItem.taskId;
					openWindowRequest.Raise(new OpenViewArg(typeof(MapWindow), mapViewModel), delegate
					{
						Cb();
					});
				}
				return;
			}
		}
		Log.Error($"找不到任务地点，taskId {progressItem.taskId}");
		Toast.ShowError("找不到任务地点");
		optCommand.Enabled = true;
		void Cb()
		{
			optCommand.Enabled = true;
			CheckRefresh();
		}
	}

	private void CheckRefresh()
	{
		if (taskUpdate)
		{
			List<TaskDataViewModel> allTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask();
			InitAllTask(redPointData, allTask, curSelect?.TaskId ?? 0);
			SelectFirstInList(curSelect?.TaskId ?? 0);
			updateTaskListRequest.Raise();
		}
	}

	public void SelectTrackingTask(List<TaskDataViewModel> allTrackingTasks)
	{
		bool flag = false;
		for (int i = 0; i < allTasks.Count; i++)
		{
			foreach (TaskDataViewModel allTrackingTask in allTrackingTasks)
			{
				if (allTrackingTask.TaskId == allTasks[i].TaskId)
				{
					redPointData.OnRead(openIndex, allTrackingTask.TaskId);
					SelectTaskItem(allTasks[i]);
					disableToggleReselect = true;
					flag = true;
					break;
				}
			}
			if (flag)
			{
				break;
			}
		}
	}

	private void ShowImg(TaskMainDetailViewModel detail)
	{
		if (extraVM == null)
		{
			extraVM = new TaskExtraViewModel(this);
		}
		extraVM.SetImg(detail.Data.TaskExtraRes);
		showExtraRequest.Raise(context: true);
	}

	public void AddSysOpenInfo(List<int> sysOpenIdList)
	{
		sysOpenList = new Dictionary<int, SysOpenParam>();
		for (int i = 0; i < sysOpenIdList.Count; i++)
		{
			SysOpenParam sysOpenParam = new SysOpenParam();
			sysOpenList.Add(i, sysOpenParam);
			if (sysOpenIdList[i] == 0)
			{
				continue;
			}
			bool state = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(sysOpenIdList[i]);
			sysOpenParam.isOpen = state;
			if (sysOpenParam.isOpen)
			{
				continue;
			}
			DRSystemOpen dataRow = GameEntry.DataTable.GetDataRow<DRSystemOpen>(sysOpenIdList[i]);
			if (dataRow == null)
			{
				break;
			}
			if (dataRow.OpenTask != 0)
			{
				DRTask dataRow2 = GameEntry.DataTable.GetDataRow<DRTask>(dataRow.OpenTask);
				if (dataRow2 == null)
				{
					break;
				}
				sysOpenParam.desc = "完成任务" + dataRow2.TaskName + "开启";
			}
		}
	}

	public override void Close()
	{
		string text = "";
		foreach (Dictionary<int, TaskMainItemViewModel> value in taskTitles.Values)
		{
			foreach (KeyValuePair<int, TaskMainItemViewModel> item in value)
			{
				text += $"{item.Key}${item.Value.GetFold()};";
			}
		}
		PlayerPrefs.SetString("_TaskMainFoldSaving", text);
		redPointData.OnCloseSave();
		base.Close();
	}

	public override void Dispose()
	{
		base.Dispose();
		messenger = null;
		if (subscription_TaskNotify != null)
		{
			subscription_TaskNotify.Dispose();
			subscription_TaskNotify = null;
		}
	}
}
