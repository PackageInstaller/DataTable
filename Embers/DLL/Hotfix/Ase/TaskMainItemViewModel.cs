using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TaskMainItemViewModel : OptionBase
{
	private int priority;

	private int taskId;

	private int taskExtra;

	private int taskType;

	private string taskExtraRes;

	private DRTask taskConfig;

	private DRDailyTask dailyTaskConfig;

	private bool isTitle;

	public bool isFold;

	private bool isSelect;

	private bool isFinish;

	private int taskState;

	private int timeLockState;

	private int taskTitleType;

	private int taskTitleId;

	private string name;

	private List<TaskMainItemViewModel> childTaskList;

	private InteractionRequest updateTaskInfoRequest;

	private int progress;

	private Dictionary<int, string> beOccupiedLoctions;

	public string timeLockDesc;

	public bool isTimeLock;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public bool IsTitle
	{
		get
		{
			return isTitle;
		}
		private set
		{
			Set(ref isTitle, value, "IsTitle");
		}
	}

	public int TaskState
	{
		get
		{
			return taskState;
		}
		private set
		{
			Set(ref taskState, value, "TaskState");
		}
	}

	public int TimeLockState
	{
		get
		{
			return timeLockState;
		}
		set
		{
			Set(ref timeLockState, value, "TimeLockState");
		}
	}

	public int TaskTitleType
	{
		get
		{
			return taskTitleType;
		}
		private set
		{
			Set(ref taskTitleType, value, "TaskTitleType");
		}
	}

	public int TaskTitleId
	{
		get
		{
			return taskTitleId;
		}
		private set
		{
			Set(ref taskTitleId, value, "TaskTitleId");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public int Progress
	{
		get
		{
			return progress;
		}
		private set
		{
			Set(ref progress, value, "Progress");
		}
	}

	public bool IsFinish
	{
		get
		{
			return isFinish;
		}
		private set
		{
			Set(ref isFinish, value, "IsFinish");
		}
	}

	public int TaskExtra
	{
		get
		{
			return taskExtra;
		}
		private set
		{
			Set(ref taskExtra, value, "TaskExtra");
		}
	}

	public int TaskType
	{
		get
		{
			return taskType;
		}
		private set
		{
			Set(ref taskType, value, "TaskType");
		}
	}

	public string TaskExtraRes
	{
		get
		{
			return taskExtraRes;
		}
		private set
		{
			Set(ref taskExtraRes, value, "TaskExtraRes");
		}
	}

	public DRTask TaskConfig => taskConfig;

	public DRDailyTask TaskDailyConfig => dailyTaskConfig;

	public int Priority => priority;

	public int TaskId => taskId;

	public Dictionary<int, string> BeOccupiedLoctions => beOccupiedLoctions;

	public List<TaskMainItemViewModel> ChildTaskList => childTaskList;

	public IInteractionRequest UpdateTaskInfoRequest => updateTaskInfoRequest;

	public override void ItemOnClick(object obj)
	{
	}

	public TaskMainItemViewModel()
	{
	}

	public TaskMainItemViewModel(OptionBase parent)
	{
		base.parent = parent;
		childTaskList = new List<TaskMainItemViewModel>();
	}

	public void InitTaskData(DRTask task, int progress, int roleLevel, string timeLockDesc)
	{
		name = task.TaskName;
		isTitle = false;
		taskType = task.TaskType;
		taskTitleType = task.TaskType;
		taskTitleId = task.TaskTitleID;
		taskConfig = task;
		priority = task.Priority;
		taskId = task.Id;
		taskExtra = task.TaskExtra;
		taskExtraRes = task.TaskExtraRes;
		isTimeLock = task.TimeLock > 0;
		this.progress = progress;
		isFinish = progress >= task.TargetValue;
		if (task.ParentTask == 0)
		{
			childTaskList.Add(this);
		}
		List<int> previousCondition = task.PreviousCondition;
		if (previousCondition != null)
		{
			for (int i = 0; i < previousCondition.Count; i++)
			{
				if (previousCondition[i] == 2)
				{
					if (task.PreviousParams[i] > roleLevel)
					{
						TaskState = 1;
					}
					break;
				}
			}
		}
		this.timeLockDesc = timeLockDesc;
		if (timeLockDesc != null)
		{
			TimeLockState = 1;
			isTimeLock = true;
		}
		else
		{
			TimeLockState = 0;
		}
	}

	public void InitTaskData(DRDailyTask task, int progress)
	{
		name = task.TaskName;
		isTitle = false;
		taskType = 3;
		taskTitleType = 3;
		taskTitleId = task.TaskTitleId;
		dailyTaskConfig = task;
		priority = task.Priority;
		taskId = task.Id;
		taskExtra = task.TaskExtra;
		taskExtraRes = task.TaskExtraRes;
		this.progress = progress;
		isFinish = progress >= task.TargetValue;
		if (task.ParentTask == 0)
		{
			childTaskList.Add(this);
		}
	}

	public void InitTaskTitle(DRTask task, List<TaskMainItemViewModel> childTasks)
	{
		name = task.TaskTitle;
		isTitle = true;
		taskTitleType = task.TaskType;
		childTaskList = childTasks;
		taskConfig = task;
		priority = task.Priority;
		taskId = task.TaskTitleID;
		taskExtra = task.TaskExtra;
		taskExtraRes = task.TaskExtraRes;
	}

	public void InitTaskTitle(DRDailyTask task, List<TaskMainItemViewModel> childTasks)
	{
		name = task.TaskTitle;
		isTitle = true;
		taskTitleType = task.TaskType;
		childTaskList = childTasks;
		dailyTaskConfig = task;
		priority = task.Priority;
		taskId = task.TaskTitleId;
		taskExtra = task.TaskExtra;
		taskExtraRes = task.TaskExtraRes;
	}

	public void AddChildTask(TaskMainItemViewModel child)
	{
		childTaskList.Add(child);
	}

	public void AddOccupyArea(int areaId, string s)
	{
		if (taskState != 1)
		{
			if (beOccupiedLoctions == null)
			{
				beOccupiedLoctions = new Dictionary<int, string>();
			}
			taskState = 2;
			if (!beOccupiedLoctions.ContainsKey(areaId))
			{
				beOccupiedLoctions.Add(areaId, s);
			}
		}
	}

	public void RefreshData()
	{
		updateTaskInfoRequest.Raise();
	}

	public void OnSelect()
	{
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public int GetTaskType()
	{
		if (dailyTaskConfig != null)
		{
			return 3;
		}
		if (taskConfig != null)
		{
			return taskConfig.TaskType;
		}
		return -1;
	}

	public string GetDesc()
	{
		if (taskConfig != null)
		{
			return taskConfig.TaskDesc;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.TaskDesc;
		}
		return "";
	}

	public int GetMapDataLevel()
	{
		if (taskConfig != null)
		{
			return taskConfig.LevelMapId;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.MapDataLevel;
		}
		return -1;
	}

	public int GetMapDataLevelOcc()
	{
		if (taskConfig != null)
		{
			return taskConfig.MapDataLevel;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.MapDataLevel;
		}
		return -1;
	}

	public string GetTargetDesc()
	{
		if (taskConfig != null)
		{
			return taskConfig.TargetDesc;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.TargetDesc;
		}
		return "";
	}

	public int GetTargetValue()
	{
		if (taskConfig != null)
		{
			return taskConfig.TargetValue;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.TargetValue;
		}
		return 0;
	}

	public List<int> GetPreviousCondition()
	{
		if (taskConfig != null)
		{
			return taskConfig.PreviousCondition;
		}
		_ = dailyTaskConfig;
		return null;
	}

	public int GetPreviousParams(int i)
	{
		if (taskConfig != null)
		{
			return taskConfig.PreviousParams[i];
		}
		_ = dailyTaskConfig;
		return -1;
	}

	public string GetPreviousDesc()
	{
		if (taskConfig != null)
		{
			return taskConfig.PreviousDesc;
		}
		_ = dailyTaskConfig;
		return "";
	}

	public int GetReward()
	{
		if (taskConfig != null)
		{
			return taskConfig.GetReward;
		}
		_ = dailyTaskConfig;
		return -1;
	}

	public List<int> GetRewardId()
	{
		if (taskConfig != null)
		{
			return taskConfig.RewardId;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.RewardId;
		}
		return new List<int>();
	}

	public List<int> GetRewardType()
	{
		if (taskConfig != null)
		{
			return taskConfig.RewardType;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.RewardType;
		}
		return new List<int>();
	}

	public List<int> GetRewardQuantity()
	{
		if (taskConfig != null)
		{
			return taskConfig.RewardQuantity;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.RewardQuantity;
		}
		return new List<int>();
	}

	public List<int> GetAreaIds()
	{
		if (taskConfig != null)
		{
			return taskConfig.MapDataUsedAreaIds;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.MapDataUsedAreaIds;
		}
		return new List<int>();
	}

	public int GetFold()
	{
		if (isTitle)
		{
			if (!isFold)
			{
				return 0;
			}
			return 1;
		}
		return 0;
	}

	public int GetParallelTaskType()
	{
		if (taskConfig != null)
		{
			return taskConfig.ParallelTaskType;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.ParallelTaskType;
		}
		return 3;
	}

	public bool IsChildTask()
	{
		if (taskConfig != null)
		{
			return taskConfig.ParentTask != 0;
		}
		if (dailyTaskConfig != null)
		{
			return dailyTaskConfig.ParentTask != 0;
		}
		return false;
	}

	public void CheckOccupied(List<int> areaIds, TaskMainItemViewModel task)
	{
		for (int i = 0; i < childTaskList.Count; i++)
		{
			for (int j = 0; j < areaIds.Count; j++)
			{
				if (childTaskList[i].GetAreaIds().Contains(areaIds[j]) && GetMapDataLevelOcc() == task.GetMapDataLevelOcc())
				{
					childTaskList[i].AddOccupyArea(areaIds[j], task.Name);
					break;
				}
			}
		}
	}
}
