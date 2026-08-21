using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public class TaskDataGroup
{
	private int taskTargetType;

	private readonly Dictionary<int, TaskDataViewModel> taskList;

	private TaskDataGroup()
	{
		taskList = new Dictionary<int, TaskDataViewModel>();
	}

	public static TaskDataGroup Create(int taskTargetType)
	{
		return new TaskDataGroup
		{
			taskTargetType = taskTargetType
		};
	}

	public void AddTaskData(TaskDataViewModel taskDataViewModel)
	{
		if (taskDataViewModel.TaskId != 0)
		{
			taskList.Add(taskDataViewModel.TaskId, taskDataViewModel);
		}
	}

	public async UniTask<bool> UpdateTaskProgress(int levelId, int taskTargetType, int deltaData)
	{
		foreach (TaskDataViewModel value in taskList.Values)
		{
			if (value.TaskTargetIdList == null || value.TaskTargetIdList.Count == 0 || (value.TaskTargetIdList.Contains(taskTargetType) && levelId == value.TargetLevelId))
			{
				return await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().UpdateTaskProcess(value.TaskId, deltaData, finshParentTask: false);
			}
		}
		return false;
	}
}
