#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaskDataViewModel : ViewModelBase, IReference
{
	private InteractionRequest onCloseRequest;

	private int id;

	private bool empty;

	private string taskName;

	private string taskDesc;

	private string taskTitle;

	private int taskTitleId;

	private int taskType;

	private string targetDesc;

	private int targetLevelId;

	private int taskTargetType;

	private List<int> taskTargetIdList;

	private int targetValue;

	private int progress;

	private int monsterId;

	private List<TaskPosition> monsterPosition;

	private int parentTaskId;

	private List<int> chilidTaskList;

	private List<int> nextTaskId;

	private string mapdataAssetPath;

	private int mapdataLevel;

	private int caveId;

	private List<int> cavePoints = new List<int>();

	private int levelMapId;

	private int sectionId;

	private int worldId;

	private int copyOpen;

	private List<int> mapDataUsedAreaIds;

	private int priority;

	private int dailyTaskLevel;

	private bool finish;

	private bool questaccept;

	private bool questfinish;

	private bool chapterstart;

	private bool chapterend;

	private bool spaceChapter;

	private int childTaskType;

	private int taskExtra;

	private string taskExtraRes;

	private int timelineid;

	private List<string> stateSave;

	private bool trackState;

	private List<PropDataBase> taskRewardList;

	private List<TaskPosition> originTaskPosition = new List<TaskPosition>();

	private List<TaskPosition> taskPosition = new List<TaskPosition>();

	private List<Vector3> taskUIPosNormal;

	private List<Vector3> taskUIPosCavern;

	private List<float> taskUIRadius;

	private int parallelTaskType;

	private bool isNew;

	private bool isOpenTask;

	private string previousDesc;

	private bool isTimeLock;

	private int timeLockDays;

	private int clientTrigger;

	private TaskSystem.TaskCountDownData countDownTimeData;

	public IInteractionRequest OnCloseRequest => onCloseRequest;

	public int TaskId
	{
		get
		{
			return id;
		}
		set
		{
			id = value;
			Empty = true;
			onCloseRequest = new InteractionRequest();
			LoadTaskConfig();
			if (Empty)
			{
				Log.Error($"根据任务Id[{id}]. 没有找到相应的任务配置.");
				return;
			}
			sectionId = GameEntry.DataTable.GetDataRow<DRMap>(LevelMapId)?.MapId ?? 0;
			worldId = GameEntry.DataTable.GetDataRow<DRSectionMap>(sectionId)?.WorldId ?? 0;
		}
	}

	public int Progress
	{
		get
		{
			return progress;
		}
		set
		{
			Set(ref progress, value, "Progress");
		}
	}

	public int MonsterId
	{
		get
		{
			return monsterId;
		}
		set
		{
			Set(ref monsterId, value, "MonsterId");
		}
	}

	public List<TaskPosition> MonsterPosition
	{
		get
		{
			return monsterPosition;
		}
		set
		{
			Set(ref monsterPosition, value, "MonsterPosition");
		}
	}

	public int TargetValue
	{
		get
		{
			return targetValue;
		}
		set
		{
			Set(ref targetValue, value, "TargetValue");
		}
	}

	public int TargetLevelId => targetLevelId;

	public List<int> TaskTargetIdList => taskTargetIdList;

	public string TargetDesc
	{
		get
		{
			return targetDesc;
		}
		set
		{
			Set(ref targetDesc, value, "TargetDesc");
		}
	}

	public int TaskTargetType
	{
		get
		{
			return taskTargetType;
		}
		set
		{
			Set(ref taskTargetType, value, "TaskTargetType");
		}
	}

	public List<int> NextTaskId => nextTaskId;

	public string MapdataAssetPath => mapdataAssetPath;

	public List<int> MapDataUsedAreaIds => mapDataUsedAreaIds;

	public int MapdataLevel => mapdataLevel;

	public int CaveId => caveId;

	public List<int> CavePoints => cavePoints;

	public int LevelMapId => levelMapId;

	public int SectionId => sectionId;

	public int WorldId => worldId;

	public int CopyOpen => copyOpen;

	public int Priority => priority;

	public int DailyTaskLevel => dailyTaskLevel;

	public int TaskType
	{
		get
		{
			return taskType;
		}
		set
		{
			Set(ref taskType, value, "TaskType");
		}
	}

	public string TaskName
	{
		get
		{
			return taskName;
		}
		set
		{
			Set(ref taskName, value, "TaskName");
		}
	}

	public string TaskTitle
	{
		get
		{
			return taskTitle;
		}
		set
		{
			Set(ref taskTitle, value, "TaskTitle");
		}
	}

	public int TaskTitleId
	{
		get
		{
			return taskTitleId;
		}
		set
		{
			Set(ref taskTitleId, value, "TaskTitleId");
		}
	}

	public string TaskDesc
	{
		get
		{
			return taskDesc;
		}
		set
		{
			Set(ref taskDesc, value, "TaskDesc");
		}
	}

	public bool Finish
	{
		get
		{
			return finish;
		}
		set
		{
			Set(ref finish, value, "Finish");
		}
	}

	public bool Questaccept => questaccept;

	public bool Questfinish => questfinish;

	public bool Chapterstart => chapterstart;

	public bool Chapterend => chapterend;

	public bool SpaceChapter => spaceChapter;

	public int Timelineid => timelineid;

	public int ParentTaskId => parentTaskId;

	public List<PropDataBase> TaskRewardList => taskRewardList;

	public int ParallelTaskType => parallelTaskType;

	public int ChildTaskType => childTaskType;

	public List<Vector3> TaskUIPosNormal => taskUIPosNormal;

	public List<Vector3> TaskUIPosCavern => taskUIPosCavern;

	public List<float> TaskUIRadius => taskUIRadius;

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

	public bool Empty
	{
		get
		{
			return empty;
		}
		private set
		{
			Set(ref empty, value, "Empty");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public bool IsOpenTask
	{
		get
		{
			return isOpenTask;
		}
		set
		{
			Set(ref isOpenTask, value, "IsOpenTask");
		}
	}

	public string PreviousDesc
	{
		get
		{
			return previousDesc;
		}
		set
		{
			Set(ref previousDesc, value, "PreviousDesc");
		}
	}

	public bool TrackState
	{
		get
		{
			return trackState;
		}
		private set
		{
			Set(ref trackState, value, "TrackState");
		}
	}

	public bool IsTimeLock => isTimeLock;

	public int TimeLockDays => timeLockDays;

	public bool IsFinished()
	{
		return finish;
	}

	public bool IsShowInTaskUI()
	{
		return clientTrigger != 1;
	}

	public bool IsMainTask()
	{
		if (taskType == 1)
		{
			return parentTaskId == 0;
		}
		return false;
	}

	public bool IsSectionTask()
	{
		if (taskType == 1 && parentTaskId == 0)
		{
			return chapterstart;
		}
		return false;
	}

	public bool HasChildTask()
	{
		if (chilidTaskList != null)
		{
			return chilidTaskList.Count > 0;
		}
		return false;
	}

	public static TaskDataViewModel CreateEmpty()
	{
		TaskDataViewModel taskDataViewModel = ReferencePool.Acquire<TaskDataViewModel>();
		taskDataViewModel.Empty = true;
		return taskDataViewModel;
	}

	private void LoadTaskConfig()
	{
		DRTask dataRow = GameEntry.DataTable.GetDataRow<DRTask>(id);
		if (dataRow != null)
		{
			InitTaskData(dataRow);
		}
		DRDailyTask dataRow2 = GameEntry.DataTable.GetDataRow<DRDailyTask>(id);
		if (dataRow2 != null)
		{
			InitTaskData(dataRow2);
		}
		DRMonsterTask dataRow3 = GameEntry.DataTable.GetDataRow<DRMonsterTask>(id);
		if (dataRow3 != null)
		{
			InitTaskData(dataRow3);
		}
	}

	private void InitTaskData(DRTask taskDataConfig)
	{
		Empty = false;
		taskName = taskDataConfig.TaskName;
		taskType = taskDataConfig.TaskType;
		taskDesc = taskDataConfig.TaskDesc;
		taskTitle = taskDataConfig.TaskTitle;
		taskTitleId = taskDataConfig.TaskTitleID;
		targetDesc = taskDataConfig.TargetDesc;
		taskTargetType = taskDataConfig.TaskTargetType;
		taskTargetIdList = taskDataConfig.TargetIdList;
		targetValue = taskDataConfig.TargetValue;
		targetLevelId = taskDataConfig.TargetLevelId;
		parentTaskId = taskDataConfig.ParentTask;
		chilidTaskList = taskDataConfig.ChildTaskList;
		nextTaskId = taskDataConfig.NextTask;
		mapdataAssetPath = taskDataConfig.MapDataAssetPath;
		mapdataLevel = taskDataConfig.MapDataLevel;
		caveId = taskDataConfig.CavernId;
		cavePoints = taskDataConfig.CavernPoint;
		levelMapId = taskDataConfig.LevelMapId;
		copyOpen = taskDataConfig.CopyOpen;
		mapDataUsedAreaIds = taskDataConfig.MapDataUsedAreaIds;
		priority = taskDataConfig.Priority;
		dailyTaskLevel = taskDataConfig.DailyTaskLevel;
		questaccept = taskDataConfig.Questaccept;
		questfinish = taskDataConfig.Questfinish;
		chapterstart = taskDataConfig.Chapterstart;
		chapterend = taskDataConfig.Chapterend;
		taskExtra = taskDataConfig.TaskExtra;
		taskExtraRes = taskDataConfig.TaskExtraRes;
		childTaskType = taskDataConfig.ChildTaskType;
		spaceChapter = taskDataConfig.SpaceChapter;
		timelineid = taskDataConfig.Timelineid;
		taskRewardList = GetTaskReward(taskDataConfig.RewardId, taskDataConfig.RewardType, taskDataConfig.RewardQuantity);
		originTaskPosition = ConvertToTaskPositionData(taskDataConfig.TaskPosition, taskDataConfig.TaskRadius);
		parallelTaskType = taskDataConfig.ParallelTaskType;
		previousDesc = taskDataConfig.PreviousDesc;
		isTimeLock = taskDataConfig.TimeLock > 0;
		timeLockDays = taskDataConfig.TimeLock;
		clientTrigger = taskDataConfig.ClientTrigger;
		taskUIPosNormal = ConvertToListVector3(taskDataConfig.UIPosition);
		taskUIRadius = taskDataConfig.UIRadius;
		if (taskDataConfig.CavernId != 0 && taskDataConfig.CavernPoint.Count > 0)
		{
			for (int i = 0; i < taskDataConfig.CavernPoint.Count; i++)
			{
				DRCavernPoint dataRow = GameEntry.DataTable.GetDataRow<DRCavernPoint>(taskDataConfig.CavernPoint[i]);
				taskUIPosCavern = ConvertToListVector3(dataRow.CavernPosition);
			}
		}
	}

	private void InitTaskData(DRDailyTask taskDataConfig)
	{
		Empty = false;
		taskName = taskDataConfig.TaskName;
		taskType = taskDataConfig.TaskType;
		taskDesc = taskDataConfig.TaskDesc;
		taskTitle = taskDataConfig.TaskTitle;
		taskTitleId = taskDataConfig.TaskTitleId;
		targetDesc = taskDataConfig.TargetDesc;
		taskTargetType = taskDataConfig.TaskTargetType;
		taskTargetIdList = taskDataConfig.TargetIdList;
		targetValue = taskDataConfig.TargetValue;
		targetLevelId = taskDataConfig.TargetLevelId;
		parentTaskId = taskDataConfig.ParentTask;
		chilidTaskList = taskDataConfig.ChildTaskList;
		nextTaskId = null;
		mapdataAssetPath = taskDataConfig.MapDataAssetPath;
		mapdataLevel = taskDataConfig.MapDataLevel;
		levelMapId = taskDataConfig.DailyTaskLevel;
		mapDataUsedAreaIds = taskDataConfig.MapDataUsedAreaIds;
		priority = taskDataConfig.Priority;
		dailyTaskLevel = taskDataConfig.DailyTaskLevel;
		taskExtra = taskDataConfig.TaskExtra;
		taskExtraRes = taskDataConfig.TaskExtraRes;
		childTaskType = taskDataConfig.ChildTaskType;
		questaccept = taskDataConfig.Questaccept;
		questfinish = taskDataConfig.Questfinish;
		chapterstart = taskDataConfig.Chapterstart;
		chapterend = taskDataConfig.Chapterend;
		timelineid = 0;
		taskRewardList = GetTaskReward(taskDataConfig.RewardId, taskDataConfig.RewardType, taskDataConfig.RewardQuantity);
		originTaskPosition = ConvertToTaskPositionData(taskDataConfig.TaskPosition, taskDataConfig.TaskRadius);
		taskUIPosNormal = ConvertToListVector3(taskDataConfig.UIPosition);
		taskUIRadius = taskDataConfig.UIRadius;
	}

	private void InitTaskData(DRMonsterTask taskDataConfig)
	{
		Empty = false;
		taskName = taskDataConfig.TaskName;
		taskType = taskDataConfig.TaskType;
		taskDesc = "";
		taskTitle = "";
		taskTitleId = 0;
		targetDesc = "";
		taskTargetType = taskDataConfig.TaskTargetType;
		taskTargetIdList = taskDataConfig.TargetIdList;
		targetValue = taskDataConfig.TargetValue;
		targetLevelId = taskDataConfig.TargetLevelId;
		parentTaskId = 0;
		chilidTaskList = null;
		nextTaskId = null;
		levelMapId = taskDataConfig.MapDataLevel;
		mapdataAssetPath = taskDataConfig.MapDataAssetPath;
		mapdataLevel = taskDataConfig.MapDataLevel;
		mapDataUsedAreaIds = taskDataConfig.MapDataUsedAreaIds;
		priority = taskDataConfig.Priority;
		dailyTaskLevel = 0;
		taskExtra = 0;
		taskExtraRes = "";
		questaccept = false;
		questfinish = false;
		chapterstart = false;
		chapterend = false;
		timelineid = 0;
		monsterId = taskDataConfig.MonsterID;
		monsterPosition = ConvertToTaskPositionData(taskDataConfig.MonsterPosition);
		taskRewardList = new List<PropDataBase>();
	}

	private List<TaskPosition> ConvertToTaskPositionData(List<List<float>> posConfig, List<float> rangeConfig = null)
	{
		List<TaskPosition> list = new List<TaskPosition>();
		if (posConfig != null)
		{
			for (int i = 0; i < posConfig.Count; i++)
			{
				float rangeRadius = 0f;
				if (rangeConfig != null && rangeConfig.Count > i)
				{
					rangeRadius = rangeConfig[i];
				}
				list.Add(new TaskPosition(new Vector2((posConfig[i].Count > 0) ? posConfig[i][0] : 0f, (posConfig[i].Count > 1) ? posConfig[i][1] : 0f), active: true, rangeRadius));
			}
		}
		return list;
	}

	private List<Vector3> ConvertToListVector3(List<List<float>> posConfig)
	{
		List<Vector3> list = new List<Vector3>(posConfig.Count);
		for (int i = 0; i < posConfig.Count; i++)
		{
			list.Add(posConfig[i].ToVector3());
		}
		return list;
	}

	public List<int> GetChildTask()
	{
		return chilidTaskList;
	}

	public void UpdateData(int valid, int competeState, long targetValue, List<string> indexSaveData)
	{
		stateSave = indexSaveData;
		Progress = (int)targetValue;
		taskPosition = originTaskPosition;
		isNew = true;
		isOpenTask = valid == 1;
		Finish = competeState > 0;
		if (stateSave == null || stateSave.Count <= 0)
		{
			stateSave = new List<string>(16)
			{
				"00", "00", "00", "00", "00", "00", "00", "00", "00", "00",
				"00", "00", "00", "00", "00", "00"
			};
		}
	}

	public void UpdateState(int stateIndex, string stateValue)
	{
		if (stateSave.Count > stateIndex && stateIndex >= 0)
		{
			stateSave[stateIndex] = stateValue.ToString();
		}
	}

	public void UpdateProcess(int delta)
	{
		Progress = Mathf.Clamp(Progress + delta, 0, TargetValue);
		Finish = progress >= targetValue;
	}

	public List<string> GetStateData()
	{
		return stateSave;
	}

	public string GetStateData(int index)
	{
		if (index >= 0 && stateSave.Count > index)
		{
			return stateSave[index];
		}
		return "99";
	}

	public void SetTrackState(bool state)
	{
		TrackState = state;
	}

	public List<TaskPosition> GetTaskPosition()
	{
		return taskPosition;
	}

	public void UpdateTaskPosition(int index, Vector2 position)
	{
		if (taskPosition.Count <= index)
		{
			Toast.ShowError($"更新任务 {id} 的 第 {index} 号 失败！,因为任务本身 第 {index} 号 坐标不存在");
			return;
		}
		taskPosition[index].position = position;
		Context.GetApplicationContext().GetService<IMessenger>().Publish(new TaskChangeNotifyMessager(this, this, TaskSystem.TaskChangeNotifyType.UpdatePosition));
	}

	public void UpdateTaskPosition(int index, bool active)
	{
		if (taskPosition.Count <= index)
		{
			Toast.ShowError($"更新任务 {id} 的 第 {index} 号 失败！,因为任务本身 第 {index} 号 坐标不存在");
			return;
		}
		taskPosition[index].active = active;
		Context.GetApplicationContext().GetService<IMessenger>().Publish(new TaskChangeNotifyMessager(this, this, TaskSystem.TaskChangeNotifyType.UpdatePosition));
	}

	public void StopCountDownData()
	{
		countDownTimeData = null;
	}

	public void SetCountDownData(TaskSystem.TaskCountDownData countDownData)
	{
		countDownTimeData = countDownData;
	}

	public int GetCountTime()
	{
		if (countDownTimeData == null)
		{
			return 0;
		}
		return Mathf.Max(0, Mathf.RoundToInt(countDownTimeData.endTime));
	}

	public List<KnapsackItemViewModel> GetTaskRewardVM(OptionBase parent)
	{
		List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
		if (taskRewardList == null || taskRewardList.Count <= 0)
		{
			return list;
		}
		for (int i = 0; i < taskRewardList.Count; i++)
		{
			list.Add(new KnapsackItemViewModel(parent, taskRewardList[i]));
		}
		return list;
	}

	private List<PropDataBase> GetTaskReward(List<int> rewardIds, List<int> rewardTypes, List<int> rewardCounts)
	{
		List<PropDataBase> list = new List<PropDataBase>();
		for (int i = 0; i < rewardIds.Count; i++)
		{
			int num = ((rewardTypes.Count > i) ? rewardTypes[i] : 0);
			int num2 = ((rewardCounts.Count > i) ? rewardCounts[i] : 0);
			if (num == 0 || num2 == 0)
			{
				Toast.ShowError($"物品Id【{rewardIds[i]}】，找不到对应的【rewardType】 或 【rewardCount】 或 【rewardCount为0】");
				continue;
			}
			PropDataBase propDataBase = PropDataBase.CreateByType(num, rewardIds[i], num2);
			if (propDataBase == null)
			{
				Toast.ShowError($"物品类型【{num}】，找不到Id【{rewardIds[i]}】");
			}
			else
			{
				list.Add(propDataBase);
			}
		}
		return list;
	}

	public bool IsLockByTime(out float timeLockHours)
	{
		timeLockHours = -1f;
		if (!isTimeLock)
		{
			return false;
		}
		long num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().ServerOpenTime + TimeLockDays * 24 * 3600;
		long num2 = (long)(DateTime.Now - new DateTime(1970, 1, 1, 8, 0, 0)).TotalSeconds;
		if (num2 >= num)
		{
			timeLockHours = 0f;
			return false;
		}
		timeLockHours = (float)(num - num2) / 3600f;
		return true;
	}

	public void Clear()
	{
		empty = true;
		taskName = string.Empty;
		taskType = 0;
		taskDesc = string.Empty;
		taskTitle = string.Empty;
		taskTitleId = 0;
		targetDesc = string.Empty;
		taskTargetType = 0;
		taskTargetIdList = null;
		targetValue = 0;
		progress = 0;
		monsterId = 0;
		monsterPosition = null;
		targetLevelId = 0;
		parentTaskId = 0;
		chilidTaskList = null;
		cavePoints = null;
		nextTaskId = null;
		mapdataAssetPath = string.Empty;
		mapdataLevel = 0;
		caveId = 0;
		sectionId = 0;
		worldId = 0;
		copyOpen = 0;
		levelMapId = 0;
		mapDataUsedAreaIds = null;
		priority = 0;
		dailyTaskLevel = 0;
		taskExtra = 0;
		childTaskType = 0;
		taskExtraRes = string.Empty;
		previousDesc = string.Empty;
		questaccept = false;
		questfinish = false;
		chapterstart = false;
		finish = false;
		trackState = false;
		spaceChapter = false;
		chapterend = false;
		isOpenTask = false;
		isNew = false;
		isTimeLock = false;
		timelineid = 0;
		timeLockDays = 0;
		clientTrigger = 0;
		parallelTaskType = 0;
		taskRewardList = null;
		countDownTimeData = null;
		originTaskPosition = null;
		taskUIPosNormal = null;
		taskPosition = null;
		stateSave = null;
		taskUIPosCavern = null;
		taskUIRadius = null;
	}

	public void Close()
	{
		onCloseRequest.Raise();
	}

	public void UpdateTaksUIPosition(int index, Vector3 changePos)
	{
		if (taskUIPosNormal.Count > index)
		{
			taskUIPosNormal[index] = changePos;
		}
	}
}
