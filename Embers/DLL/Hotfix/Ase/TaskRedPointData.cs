using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TaskRedPointData : ViewModelBase
{
	private bool hasNew;

	private bool hasDailyNew;

	private bool hasDaily;

	private ISubscription<TaskChangeNotifyMessager> subscription_taskUpdate;

	private Dictionary<int, RedPointSave> taskNewList = new Dictionary<int, RedPointSave>();

	private Dictionary<int, int> taskEnumInfo = new Dictionary<int, int>();

	private bool hasInitRedPoint;

	private List<int> pendingNewTaskIds;

	public bool HasNew
	{
		get
		{
			return hasNew;
		}
		set
		{
			Set(ref hasNew, value, "HasNew");
		}
	}

	public bool HasDailyNew
	{
		get
		{
			return hasDailyNew;
		}
		set
		{
			hasDailyNew = value;
			HasNew = hasNew || hasDailyNew;
		}
	}

	public TaskRedPointData(ITaskServices services)
	{
		subscription_taskUpdate = services.GetTaskMessager().Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
	}

	public void InitRedPoint()
	{
		taskNewList = new Dictionary<int, RedPointSave>();
		List<RedPointSave> redPoint = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPoint("Task", forceLoading: true);
		for (int i = 0; i < redPoint.Count; i++)
		{
			taskNewList.Add((int)redPoint[i].keyId, redPoint[i]);
		}
		hasInitRedPoint = true;
		if (pendingNewTaskIds != null && pendingNewTaskIds.Count > 0)
		{
			for (int j = 0; j < pendingNewTaskIds.Count; j++)
			{
				RequestNewByTaskId(pendingNewTaskIds[j]);
			}
			pendingNewTaskIds.Clear();
		}
	}

	private void RequestNewByTaskId(int taskId)
	{
		if (taskNewList.ContainsKey(taskId))
		{
			return;
		}
		int num = 0;
		DRTask dataRow = GameEntry.DataTable.GetDataRow<DRTask>(taskId);
		if (dataRow == null)
		{
			DRDailyTask dataRow2 = GameEntry.DataTable.GetDataRow<DRDailyTask>(taskId);
			if (dataRow2 != null)
			{
				num = dataRow2.TaskType;
				hasDaily = true;
			}
		}
		else
		{
			num = dataRow.TaskType;
		}
		if (num != 0)
		{
			taskNewList.Add(taskId, new RedPointSave
			{
				isNew = true,
				keyId = taskId,
				param1 = num
			});
			HasNew = true;
		}
	}

	public void GetDailyNew()
	{
		if (hasDaily)
		{
			HasDailyNew = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPointDaily("TaskDailyRed");
		}
	}

	private void OnTaskChangeNotify(TaskChangeNotifyMessager messager)
	{
		if (messager.taskDataViewModel == null)
		{
			return;
		}
		int taskId = messager.taskDataViewModel.TaskId;
		if (messager.changeNotifyType == TaskSystem.TaskChangeNotifyType.Received)
		{
			if (taskNewList.ContainsKey(taskId))
			{
				taskNewList[taskId].isNew = true;
			}
			else
			{
				taskNewList.Add(taskId, new RedPointSave
				{
					isNew = true,
					keyId = taskId,
					param1 = messager.taskDataViewModel.TaskType
				});
			}
			if (GameEntry.DataTable.GetDataRow<DRDailyTask>(taskId) != null)
			{
				hasDaily = true;
				HasDailyNew = true;
			}
			HasNew = true;
		}
		else
		{
			if (messager.changeNotifyType != TaskSystem.TaskChangeNotifyType.Finished)
			{
				return;
			}
			if (taskNewList.ContainsKey(taskId))
			{
				taskNewList.Remove(taskId);
			}
			HasNew = taskNewList.Count > 0;
			bool flag = false;
			foreach (KeyValuePair<int, RedPointSave> taskNew in taskNewList)
			{
				if (taskNew.Value != null && GameEntry.DataTable.GetDataRow<DRDailyTask>(taskNew.Key) != null)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.SaveRedPointDaily("TaskDailyRed");
				HasDailyNew = false;
			}
		}
	}

	public void OnRead(int enumId, int taskId)
	{
		switch (enumId)
		{
		case 0:
			RemoveTaskNewByType(0);
			break;
		case 1:
			RemoveTaskNewByType(1);
			break;
		}
		if (taskEnumInfo != null && taskEnumInfo.ContainsKey(enumId))
		{
			taskEnumInfo.Remove(enumId);
		}
		bool flag = false;
		if (taskEnumInfo != null && taskEnumInfo.Count == 0)
		{
			HasNew = false;
			return;
		}
		foreach (KeyValuePair<int, RedPointSave> taskNew in taskNewList)
		{
			flag = taskNew.Value.isNew | flag;
		}
		HasNew = flag;
	}

	private void RemoveTaskNewByType(int enumId)
	{
		foreach (KeyValuePair<int, RedPointSave> taskNew in taskNewList)
		{
			taskNew.Value.isNew = (enumId != 0 || (taskNew.Value.param1 != 1 && taskNew.Value.param1 != 2)) && (enumId != 1 || taskNew.Value.param1 != 3) && taskNew.Value.isNew;
		}
	}

	public void RequestNew(PbTaskData data)
	{
		if (!hasInitRedPoint)
		{
			if (data != null && data.CompeteState == 0)
			{
				if (pendingNewTaskIds == null)
				{
					pendingNewTaskIds = new List<int>();
				}
				if (!pendingNewTaskIds.Contains(data.TaskId))
				{
					pendingNewTaskIds.Add(data.TaskId);
				}
			}
		}
		else
		{
			if (taskNewList.ContainsKey(data.TaskId) || data.CompeteState != 0)
			{
				return;
			}
			int num = 0;
			DRTask dataRow = GameEntry.DataTable.GetDataRow<DRTask>(data.TaskId);
			if (dataRow == null)
			{
				DRDailyTask dataRow2 = GameEntry.DataTable.GetDataRow<DRDailyTask>(data.TaskId);
				if (dataRow2 != null)
				{
					num = dataRow2.TaskType;
					hasDaily = true;
				}
			}
			else
			{
				num = dataRow.TaskType;
			}
			if (num != 0)
			{
				taskNewList.Add(data.TaskId, new RedPointSave
				{
					isNew = true,
					keyId = data.TaskId,
					param1 = num
				});
				HasNew = true;
			}
		}
	}

	public int GetNewTaskId(int enumId)
	{
		if (enumId == 1 && hasDailyNew)
		{
			return 1;
		}
		RemoveTaskNewByType(enumId);
		if (taskEnumInfo != null && taskEnumInfo.Count == 0)
		{
			return -1;
		}
		if (taskEnumInfo != null && taskEnumInfo.ContainsKey(enumId))
		{
			return taskEnumInfo[enumId];
		}
		return -1;
	}

	public void SetUnRed()
	{
		if (hasDailyNew)
		{
			Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPointDaily("TaskDailyRed");
			HasDailyNew = false;
		}
	}

	public void AddTaskEnumInfo(Dictionary<int, int> enumInfo)
	{
		taskEnumInfo = enumInfo;
	}

	public void UpdateTaskEnumInfo(int taskType, int taskId)
	{
		if (!taskNewList.ContainsKey(taskId) || !taskNewList[taskId].isNew)
		{
			return;
		}
		int key = ((taskType != 1 && taskType != 2) ? 1 : 0);
		if (taskEnumInfo.ContainsKey(key))
		{
			if (taskEnumInfo[key] < taskId)
			{
				taskEnumInfo[key] = taskId;
			}
		}
		else
		{
			taskEnumInfo.Add(key, taskId);
		}
	}

	public void OnCloseSave()
	{
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPoint(taskNewList.Values.ToList(), "Task");
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPointDaily("TaskDailyRed");
	}
}
