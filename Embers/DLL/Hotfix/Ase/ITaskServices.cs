using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public interface ITaskServices
{
	IMessenger GetTaskMessager();

	UniTask<bool> RequestTaskData();

	TaskDataViewModel GetTask(int taskId);

	TaskDataViewModel GetCurrentMainTask();

	TaskDataViewModel GetCurrentSectionTask();

	int GetCurrentCopyOpen();

	void OnTaskChangeNotify(TaskChangeNotify taskChangeNotify);

	UniTask<bool> UpdateTaskProcess(int taskId, int deltaData, bool finshParentTask);

	UniTask<bool> UpdateTaskProcess(int levelId, int taskType, int taskTargetType, int deltaData);

	UniTask<bool> UpdateTaskState(int taskId, int stateIndex, string stateValue);

	UniTask<bool> FinishTask(int taskId);

	List<TaskDataViewModel> GetAllTask();

	List<TaskDataViewModel> GetAllUnFinishedTask();

	List<TaskDataViewModel> GetAllLevelTask(int levelId);

	List<TaskDataViewModel> GetAllLevelUnFinishTrackTask(int levelId);

	List<TaskDataViewModel> GetUnFinishedTaskInLevelMap(int levelId);

	List<TaskDataViewModel> GetUnFinishedTaskInCave(int caveId);

	List<TaskDataViewModel> GetAllUnFinishedDisplayTask(bool needShowInTaskUi = true);

	List<TaskDataViewModel> GetDisplayLevelTask(int levelId, bool needShowInTaskUi = true);

	List<TaskDataViewModel> GetDisplayTaskInCave(int caveId, bool needShowInTaskUi = true);

	void SetTaskTrackState(int taskId, bool trackState);

	TaskRedPointData GetRedPoint();

	UniTask<bool> ReadTask(int taskId);

	bool CheckTaskFinished(int taskId);

	bool CheckMapDataNodeActived(List<OpenCondition> taskIds);

	bool CheckMapDataNodeActived(OpenCondition openCondition);

	UniTask<bool> ClientTriggerTask(int taskId);

	Task<bool> CheckTaskTimeLock(int taskId);

	bool CheckTaskIndexState(int taskId, int taskIndex, string state);

	List<TaskDataViewModel> FilterDisplayTask(List<TaskDataViewModel> tasks, bool needShowInTaskUi = true);

	List<TaskDataViewModel> FilterTrackingTask(List<TaskDataViewModel> tasks);

	List<TaskDataViewModel> GetChangeTrackTaskData(List<TaskDataViewModel> tasks);

	void ChangeTaskTrack();

	void HideChangeTaskTrack();

	void ChangeTaskUIPosition(int taskId, int index, Vector3 changePos);

	long GetRequestDataTime();

	void GetDailyNew();
}
