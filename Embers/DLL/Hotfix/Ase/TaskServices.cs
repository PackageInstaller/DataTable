#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaskServices : ITaskServices
{
	private List<TaskDataViewModel> taskDataTmp = new List<TaskDataViewModel>();

	private TaskRedPointData redPoint;

	private int currentCopyOpen;

	private Dictionary<int, TaskDataViewModel> taskDataViewModels;

	private readonly Dictionary<int, TaskDataGroup> taskGroups;

	private long requestDataTime;

	private readonly IMessenger taskMessenger;

	private ISubscription<TaskChangeNotify> subscription_TaskChangeNotify;

	private ISubscription<ChapterPassNotify> subscription_ChapterPassNotify;

	private ISubscription<RecvTaskRewardNotify> subscription_RecvTaskRewardNotify;

	private TaskDataViewModel currentSectionTask;

	private List<TaskDataViewModel> trackingTasks = new List<TaskDataViewModel>();

	private TaskDataViewModel curTrackingTask;

	private int changeBeforeTrackTaskId;

	private int changeAfterTrackTaskId;

	private int changeTrackTaskId;

	public long RequestTime => requestDataTime;

	public IMessenger GetTaskMessager()
	{
		return taskMessenger;
	}

	public TaskServices()
	{
		taskMessenger = Context.GetApplicationContext().GetService<IMessenger>();
		redPoint = new TaskRedPointData(this);
		taskDataViewModels = new Dictionary<int, TaskDataViewModel>();
		subscription_TaskChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<TaskChangeNotify>(OnTaskChangeNotify);
		subscription_ChapterPassNotify = Singleton<NetworkSystem>.Instance.Subscribe<ChapterPassNotify>(ChapterPassNotify);
		subscription_RecvTaskRewardNotify = Singleton<NetworkSystem>.Instance.Subscribe<RecvTaskRewardNotify>(RecvTaskRewardNotify);
		taskGroups = new Dictionary<int, TaskDataGroup>();
	}

	private void RecvTaskRewardNotify(RecvTaskRewardNotify recvTaskRewardNotify)
	{
		ReceiveTaskRewards(recvTaskRewardNotify.Rewards);
		Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.UpdateRoleLevelAndExp(recvTaskRewardNotify.UserLevel, recvTaskRewardNotify.UserExp);
	}

	private void ChapterPassNotify(ChapterPassNotify message)
	{
	}

	public async UniTask<bool> RequestTaskData()
	{
		GetTaskDataRequest request = GetTaskDataRequest.Create();
		GetTaskDataResponse response = null;
		bool flag = false;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetTaskDataResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求任务数据", "请求任务数据失败"))
			{
				foreach (TaskDataViewModel value in taskDataViewModels.Values)
				{
					ReferencePool.Release(value);
				}
				taskDataViewModels.Clear();
				taskGroups.Clear();
				taskMessenger.Publish(new TaskChangeNotifyMessager(this, null, TaskSystem.TaskChangeNotifyType.Disconnect));
				requestDataTime = TimeHelper.ClientNow();
				foreach (PbTaskData task in response.Tasks)
				{
					redPoint.RequestNew(task);
					if (taskDataViewModels.ContainsKey(task.TaskId))
					{
						Log.Error("任务数据中,有重复的任务ID");
						continue;
					}
					TaskDataViewModel taskDataViewModel = ReferencePool.Acquire<TaskDataViewModel>();
					taskDataViewModel.TaskId = task.TaskId;
					if (taskDataViewModel.Empty)
					{
						ReferencePool.Release(taskDataViewModel);
						continue;
					}
					taskDataViewModel.UpdateData(task.Valid, task.CompeteState, task.TargetValue, task.IndexSaveData);
					taskDataViewModels.Add(taskDataViewModel.TaskId, taskDataViewModel);
					AddTaskDataToGroup(taskDataViewModel);
					RefreshSectionTask(taskDataViewModel);
				}
				TaskDataViewModel currentMainTask = GetCurrentMainTask();
				if (currentMainTask != null)
				{
					SetTaskTrackState(currentMainTask.TaskId, state: true);
					currentCopyOpen = currentMainTask.CopyOpen;
				}
				flag = true;
			}
		}
		catch (Exception)
		{
			return flag;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return flag;
	}

	private void AddTaskDataToGroup(TaskDataViewModel taskDataViewModel)
	{
		taskGroups.TryGetValue(taskDataViewModel.TaskTargetType, out var value);
		if (value == null)
		{
			value = TaskDataGroup.Create(taskDataViewModel.TaskTargetType);
			taskGroups.Add(taskDataViewModel.TaskTargetType, value);
		}
		value.AddTaskData(taskDataViewModel);
	}

	private void RefreshSectionTask(TaskDataViewModel taskDataViewModel)
	{
		if (taskDataViewModel.IsSectionTask() && !taskDataViewModel.IsFinished())
		{
			currentSectionTask = taskDataViewModel;
		}
	}

	public TaskDataViewModel GetTask(int taskId)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value))
		{
			return value;
		}
		return null;
	}

	public TaskDataViewModel GetCurrentMainTask()
	{
		TaskDataViewModel curMainTask = null;
		taskDataViewModels.Values.ToList().FindAll((TaskDataViewModel p) => p.TaskType == 1).ForEach(delegate(TaskDataViewModel p)
		{
			if ((curMainTask == null || curMainTask.CopyOpen < p.CopyOpen || curMainTask.TaskId > p.TaskId) && !p.Finish)
			{
				curMainTask = p;
			}
		});
		return curMainTask;
	}

	public int GetCurrentCopyOpen()
	{
		return currentCopyOpen;
	}

	public TaskDataViewModel GetCurrentSectionTask()
	{
		return currentSectionTask;
	}

	public void OnTaskChangeNotify(TaskChangeNotify taskChangeNotify)
	{
		if (taskChangeNotify != null)
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().UpdateMaxCopyIdx(taskChangeNotify.NewMaxCopyIdx);
		}
		taskDataTmp.Clear();
		foreach (PbTaskData item in taskChangeNotify.OldTask)
		{
			if (!taskDataViewModels.ContainsKey(item.TaskId))
			{
				continue;
			}
			TaskDataViewModel taskDataViewModel = taskDataViewModels[item.TaskId];
			taskDataViewModel.UpdateData(item.Valid, item.CompeteState, item.TargetValue, item.IndexSaveData);
			if (taskDataViewModel.Finish)
			{
				if (taskDataViewModel.ParentTaskId != 0)
				{
					UpdateTaskProcess(taskDataViewModel.ParentTaskId, 1, finshParentTask: true);
				}
				if (taskDataViewModel.DailyTaskLevel > 0)
				{
					Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetPlayerData()?.ChangeMaxStoryLevel(taskDataViewModel.DailyTaskLevel);
				}
				taskDataTmp.Add(taskDataViewModel);
				taskMessenger.Publish(new TaskChangeNotifyMessager(this, taskDataViewModel, TaskSystem.TaskChangeNotifyType.Finished));
			}
			else
			{
				taskMessenger.Publish(new TaskChangeNotifyMessager(this, taskDataViewModel, TaskSystem.TaskChangeNotifyType.Updated));
			}
		}
		foreach (PbTaskData item2 in taskChangeNotify.NewTask)
		{
			if (taskDataViewModels.ContainsKey(item2.TaskId))
			{
				taskDataViewModels[item2.TaskId].UpdateData(item2.Valid, item2.CompeteState, item2.TargetValue, item2.IndexSaveData);
				continue;
			}
			TaskDataViewModel taskDataViewModel2 = ReferencePool.Acquire<TaskDataViewModel>();
			taskDataViewModel2.TaskId = item2.TaskId;
			if (!taskDataViewModel2.Empty)
			{
				taskDataViewModels.Add(item2.TaskId, taskDataViewModel2);
				taskDataViewModel2.UpdateData(item2.Valid, item2.CompeteState, item2.TargetValue, item2.IndexSaveData);
				AddTaskDataToGroup(taskDataViewModel2);
				RefreshSectionTask(taskDataViewModel2);
				taskMessenger.Publish(new TaskChangeNotifyMessager(this, taskDataViewModel2, TaskSystem.TaskChangeNotifyType.Received));
			}
		}
		TaskDataViewModel currentMainTask = GetCurrentMainTask();
		if (currentMainTask != null && currentMainTask.CopyOpen != currentCopyOpen)
		{
			currentCopyOpen = currentMainTask.CopyOpen;
			taskMessenger.Publish(new TaskChangeNotifyMessager(this, currentMainTask, TaskSystem.TaskChangeNotifyType.CopyOpenUpdate));
		}
		taskMessenger.Publish(new TaskChangeNotifyMessager(this, null, TaskSystem.TaskChangeNotifyType.LevelNodeCheck));
		OnTaskChangeForTracking(taskDataTmp, taskChangeNotify.NewTask);
	}

	public async UniTask<bool> UpdateTaskProcess(int taskId, int deltaData, bool finshParentTask)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var taskViewModel))
		{
			if (taskViewModel.IsFinished())
			{
				return true;
			}
			taskViewModel.UpdateProcess(deltaData);
			if (!taskViewModel.IsFinished())
			{
				bool num = await SendTaskState(deltaData, taskViewModel);
				if (num)
				{
					taskMessenger.Publish(new TaskChangeNotifyMessager(this, taskViewModel, TaskSystem.TaskChangeNotifyType.Updated));
					OnTaskChangeForTracking(new List<TaskDataViewModel> { taskViewModel }, null);
				}
				else
				{
					taskViewModel.UpdateProcess(-deltaData);
				}
				return num;
			}
			if (!finshParentTask)
			{
				bool num2 = await SendTaskState(deltaData, taskViewModel);
				if (!num2)
				{
					taskViewModel.UpdateProcess(-deltaData);
				}
				return num2;
			}
		}
		return false;
	}

	private async UniTask<bool> SendTaskState(int progress, TaskDataViewModel taskDataViewModel)
	{
		SendTaskCompleteStateRequest request = SendTaskCompleteStateRequest.Create();
		request.Count = progress;
		request.TaskType = taskDataViewModel.TaskType;
		request.TaskId = taskDataViewModel.TaskId;
		request.IndexSaveData = taskDataViewModel.GetStateData();
		SendTaskCompleteStateResponse response = null;
		bool result = false;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SendTaskCompleteStateResponse>(request);
			result = Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "更新任务", "更新任务失败");
		}
		catch (TimeoutException)
		{
			Log.Error("发送任务超时");
			result = false;
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error("发送任务失败：" + ex2);
			result = false;
			return result;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<bool> UpdateTaskProcess(int levelId, int taskType, int taskTargetType, int deltaData)
	{
		if (taskGroups.TryGetValue(taskType, out var value))
		{
			value.UpdateTaskProgress(levelId, taskTargetType, deltaData);
		}
		return false;
	}

	public async UniTask<bool> UpdateTaskState(int taskId, int stateIndex, string stateValue)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var taskViewModel))
		{
			if (taskViewModel.IsFinished())
			{
				return true;
			}
			string updateBeforeStateValue = taskViewModel.GetStateData(stateIndex);
			taskViewModel.UpdateState(stateIndex, stateValue);
			bool num = await SendTaskState(0, taskViewModel);
			if (!num)
			{
				taskViewModel.UpdateState(stateIndex, updateBeforeStateValue);
			}
			taskMessenger.Publish(new TaskChangeNotifyMessager(this, taskViewModel, TaskSystem.TaskChangeNotifyType.Updated));
			if (num)
			{
				taskMessenger.Publish(new TaskChangeNotifyMessager(this, taskViewModel, TaskSystem.TaskChangeNotifyType.IndexStateUpdate));
			}
		}
		return true;
	}

	public async UniTask<bool> FinishTask(int taskId)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value))
		{
			return await UpdateTaskProcess(taskId, value.TargetValue - value.Progress, finshParentTask: false);
		}
		return false;
	}

	public async UniTask<bool> ClientTriggerTask(int taskId)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value))
		{
			ClientTriggerTaskRequest request = ClientTriggerTaskRequest.Create();
			request.TaskId = value.TaskId;
			ClientTriggerTaskResponse response = null;
			bool result = false;
			try
			{
				response = await Singleton<NetworkSystem>.Instance.Call<ClientTriggerTaskResponse>(request);
				result = Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "接受任务", "接受任务失败");
			}
			catch (Exception)
			{
				return false;
			}
			finally
			{
				request.Dispose();
				response?.Dispose();
			}
			return result;
		}
		return false;
	}

	public List<TaskDataViewModel> GetAllTask()
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		foreach (TaskDataViewModel value in taskDataViewModels.Values)
		{
			list.Add(value);
		}
		return list;
	}

	public List<TaskDataViewModel> GetAllUnFinishedTask()
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		foreach (TaskDataViewModel value in taskDataViewModels.Values)
		{
			if (!value.IsFinished())
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<TaskDataViewModel> GetAllLevelTask(int levelId)
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		foreach (TaskDataViewModel value in taskDataViewModels.Values)
		{
			if (value.MapdataLevel == levelId)
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<TaskDataViewModel> GetAllLevelUnFinishTrackTask(int levelId)
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		foreach (TaskDataViewModel value in taskDataViewModels.Values)
		{
			if (value.MapdataLevel == levelId && !value.IsFinished() && value.TrackState && value.IsOpenTask)
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<TaskDataViewModel> GetUnFinishedTaskInLevelMap(int levelId)
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		foreach (TaskDataViewModel value in taskDataViewModels.Values)
		{
			if (!value.IsFinished() && value.LevelMapId == levelId)
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<TaskDataViewModel> GetUnFinishedTaskInCave(int caveId)
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		foreach (TaskDataViewModel value in taskDataViewModels.Values)
		{
			if (!value.IsFinished() && value.CaveId == caveId)
			{
				list.Add(value);
			}
		}
		return list;
	}

	public List<TaskDataViewModel> GetAllUnFinishedDisplayTask(bool needShowInTaskUi = true)
	{
		return FilterDisplayTask(GetAllUnFinishedTask(), needShowInTaskUi);
	}

	public List<TaskDataViewModel> GetDisplayLevelTask(int levelId, bool needShowInTaskUi = true)
	{
		List<TaskDataViewModel> unFinishedTaskInLevelMap = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetUnFinishedTaskInLevelMap(levelId);
		return FilterDisplayTask(unFinishedTaskInLevelMap, needShowInTaskUi);
	}

	public List<TaskDataViewModel> GetDisplayTaskInCave(int caveId, bool needShowInTaskUi = true)
	{
		List<TaskDataViewModel> unFinishedTaskInCave = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetUnFinishedTaskInCave(caveId);
		return FilterDisplayTask(unFinishedTaskInCave, needShowInTaskUi);
	}

	public void SetTaskTrackState(int taskId, bool state)
	{
		if (!taskDataViewModels.TryGetValue(taskId, out var value))
		{
			return;
		}
		if (value.ParentTaskId > 0)
		{
			SetTaskTrackState(value.ParentTaskId, state);
			return;
		}
		if (state)
		{
			if (curTrackingTask != null && curTrackingTask.TaskId != taskId)
			{
				DoSetTaskTrackState(curTrackingTask.TaskId, state: false);
				List<int> childTask = curTrackingTask.GetChildTask();
				if (childTask != null && childTask.Count > 0)
				{
					foreach (int item in childTask)
					{
						DoSetTaskTrackState(item, state: false);
					}
				}
			}
			curTrackingTask = value;
		}
		else
		{
			curTrackingTask = null;
		}
		DoSetTaskTrackState(taskId, state);
		List<int> childTask2 = value.GetChildTask();
		if (childTask2 != null && childTask2.Count > 0)
		{
			foreach (int item2 in childTask2)
			{
				DoSetTaskTrackState(item2, state);
			}
		}
		taskMessenger.Publish(new TaskChangeNotifyMessager(this, null, TaskSystem.TaskChangeNotifyType.TrackSet));
	}

	private void DoSetTaskTrackState(int taskId, bool state)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value))
		{
			trackingTasks.RemoveAll((TaskDataViewModel p) => p.TaskId == taskId);
			value.SetTrackState(state);
			if (state)
			{
				trackingTasks.Add(value);
			}
		}
	}

	private void OnTaskChangeForTracking(List<TaskDataViewModel> finishTaskDatas, List<PbTaskData> newTasks)
	{
		if (curTrackingTask != null && finishTaskDatas.FindIndex((TaskDataViewModel data) => data.ParentTaskId == curTrackingTask.TaskId) >= 0)
		{
			return;
		}
		if (curTrackingTask != null && curTrackingTask.IsFinished())
		{
			TaskDataViewModel preTrackTask = null;
			if (newTasks != null)
			{
				foreach (PbTaskData newTask in newTasks)
				{
					if (taskDataViewModels.TryGetValue(newTask.TaskId, out var value) && value.IsOpenTask && value.TaskType == curTrackingTask.TaskType && value.TaskTitleId == curTrackingTask.TaskTitleId && !value.IsFinished())
					{
						preTrackTask = value;
						break;
					}
				}
			}
			if (preTrackTask == null)
			{
				List<TaskDataViewModel> list = taskDataViewModels.Values.ToList().FindAll((TaskDataViewModel p) => p.IsOpenTask && p.TaskType == curTrackingTask.TaskType && p.TaskTitleId == curTrackingTask.TaskTitleId && !p.IsFinished());
				if (list == null || list.Count == 0)
				{
					list = taskDataViewModels.Values.ToList().FindAll((TaskDataViewModel p) => p.IsOpenTask && p.IsMainTask() && !p.IsFinished());
				}
				list.ForEach(delegate(TaskDataViewModel p)
				{
					if (preTrackTask == null || preTrackTask.TaskId > p.TaskId)
					{
						preTrackTask = p;
					}
				});
			}
			if (preTrackTask != null)
			{
				SetTaskTrackState(preTrackTask.TaskId, state: true);
			}
			else
			{
				SetTaskTrackState(curTrackingTask.TaskId, state: false);
			}
			return;
		}
		TaskDataViewModel taskView = null;
		foreach (TaskDataViewModel finishTaskData in finishTaskDatas)
		{
			if (taskView == null)
			{
				taskView = finishTaskData;
			}
			else if (taskView.ParentTaskId <= 0 && finishTaskData.ParentTaskId > 0)
			{
				taskView = finishTaskData;
			}
		}
		if (taskView == null)
		{
			return;
		}
		TaskDataViewModel preTrackTask2 = null;
		if (newTasks != null)
		{
			foreach (PbTaskData newTask2 in newTasks)
			{
				if (taskDataViewModels.TryGetValue(newTask2.TaskId, out var value2) && value2.IsOpenTask && value2.TaskType == taskView.TaskType && value2.TaskTitleId == taskView.TaskTitleId && !value2.IsFinished())
				{
					preTrackTask2 = value2;
					break;
				}
			}
		}
		if (preTrackTask2 == null)
		{
			taskDataViewModels.Values.ToList().FindAll((TaskDataViewModel p) => p.IsOpenTask && p.TaskType == taskView.TaskType && p.TaskTitleId == taskView.TaskTitleId && !p.IsFinished()).ForEach(delegate(TaskDataViewModel p)
			{
				if (preTrackTask2 == null || preTrackTask2.TaskId > p.TaskId)
				{
					preTrackTask2 = p;
				}
			});
		}
		if (preTrackTask2 != null)
		{
			ShowChangeTrackTaskUI(preTrackTask2.TaskId);
		}
		finishTaskDatas.Clear();
	}

	private void ShowChangeTrackTaskUI(int taskId)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value))
		{
			if (value.ParentTaskId > 0)
			{
				ShowChangeTrackTaskUI(value.ParentTaskId);
				return;
			}
			if (curTrackingTask == null || value.TaskId == curTrackingTask.TaskId)
			{
				SetTaskTrackState(taskId, state: true);
				return;
			}
			changeTrackTaskId = value.TaskId;
			taskMessenger.Publish(new TaskChangeNotifyMessager(this, null, TaskSystem.TaskChangeNotifyType.ShowChangeTrackUI));
		}
	}

	public void ChangeTaskTrack()
	{
		SetTaskTrackState(changeTrackTaskId, state: true);
	}

	public void HideChangeTaskTrack()
	{
		changeTrackTaskId = 0;
		taskMessenger.Publish(new TaskChangeNotifyMessager(this, null, TaskSystem.TaskChangeNotifyType.HideChangeTrackUI));
	}

	public void ChangeTaskUIPosition(int taskId, int index, Vector3 changePos)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value))
		{
			value.UpdateTaksUIPosition(index, changePos);
			taskMessenger.Publish(new TaskChangeNotifyMessager(this, null, TaskSystem.TaskChangeNotifyType.ChangeTaskUIPosition));
		}
	}

	public List<TaskDataViewModel> GetChangeTrackTaskData(List<TaskDataViewModel> tasks)
	{
		if (taskDataViewModels.TryGetValue(changeTrackTaskId, out var value))
		{
			List<int> childTasks = value.GetChildTask();
			tasks.RemoveAll((TaskDataViewModel p) => !childTasks.Contains(p.TaskId) && p.TaskId != changeTrackTaskId);
			return tasks;
		}
		return null;
	}

	public bool CheckTaskFinished(int taskId)
	{
		if (taskDataViewModels != null && taskDataViewModels.ContainsKey(taskId))
		{
			return taskDataViewModels[taskId].IsFinished();
		}
		return false;
	}

	public TaskRedPointData GetRedPoint()
	{
		return redPoint;
	}

	public async UniTask<bool> ReadTask(int taskId)
	{
		return false;
	}

	public async void ReceiveTaskRewards(PbDropThing rewards)
	{
		await PropHelper.AnalyzeRewardFromServer(rewards);
		taskMessenger.Publish(new TaskRewardsReceiveMessager(this, rewards));
	}

	public List<TaskDataViewModel> FilterDisplayTask(List<TaskDataViewModel> tasks, bool needShowInTaskUi = true)
	{
		tasks.RemoveAll((TaskDataViewModel p) => !p.IsOpenTask || p.TaskType == 4 || (needShowInTaskUi && !p.IsShowInTaskUI()));
		return tasks;
	}

	public List<TaskDataViewModel> FilterTrackingTask(List<TaskDataViewModel> tasks)
	{
		tasks.RemoveAll((TaskDataViewModel p) => !p.TrackState);
		return tasks;
	}

	public bool CheckMapDataNodeActived(OpenCondition openCondition)
	{
		if (openCondition == null)
		{
			return true;
		}
		if (taskDataViewModels.TryGetValue(openCondition.taskId, out var value) && !value.Finish && value.GetStateData(openCondition.taskStateValueIndex) == openCondition.taskStateIndexValue)
		{
			return true;
		}
		return false;
	}

	public bool CheckMapDataNodeActived(List<OpenCondition> taskIds)
	{
		if (taskIds.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < taskIds.Count; i++)
		{
			if (taskDataViewModels.TryGetValue(taskIds[i].taskId, out var value) && !value.Finish && value.GetStateData(taskIds[i].taskStateValueIndex) == taskIds[i].taskStateIndexValue)
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckTaskIndexState(int taskId, int taskIndex, string state)
	{
		if (taskDataViewModels.TryGetValue(taskId, out var value) && value.GetStateData(taskIndex) == state)
		{
			return true;
		}
		return false;
	}

	public async Task<bool> CheckTaskTimeLock(int taskId)
	{
		CheckTaskTimeLockRequest request = CheckTaskTimeLockRequest.Create();
		request.TaskId = taskId;
		CheckTaskTimeLockResponse response = null;
		bool flag = false;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CheckTaskTimeLockResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求校验任务时间解锁", "请求校验任务时间解锁失败"))
			{
				flag = response.Valid;
			}
		}
		catch (Exception ex)
		{
			Log.Error("检查任务时间解锁失败！" + ex.Message + " / " + ex.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return flag;
	}

	public long GetRequestDataTime()
	{
		return requestDataTime;
	}

	public void GetDailyNew()
	{
		redPoint.GetDailyNew();
	}
}
