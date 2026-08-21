using UnityEngine;

namespace Ase;

public class TaskPointItemData : InteractivePointData
{
	private Vector3 taskRange;

	private Vector3 rangeScale;

	private TaskDataViewModel _taskViewModel;

	public Vector3 TaskRange
	{
		get
		{
			return taskRange;
		}
		private set
		{
			Set(ref taskRange, value, "TaskRange");
		}
	}

	public Vector3 RangeScale
	{
		get
		{
			return rangeScale;
		}
		private set
		{
			Set(ref rangeScale, value, "RangeScale");
		}
	}

	public TaskDataViewModel TaskViewModel
	{
		get
		{
			return _taskViewModel;
		}
		private set
		{
			Set(ref _taskViewModel, value, "TaskViewModel");
		}
	}

	public TaskPointItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public void RefreshData(TaskDataViewModel taskData, Vector2 worldPos, Vector2 posOffset, float configRange, Vector2 mapSize, float sceneRatio)
	{
		sceneRatio = ((sceneRatio > 0f) ? sceneRatio : GameEntry.Base.GameConfig.minimap_UISceneRatio);
		TaskViewModel = taskData;
		base.Icon = $"task_mark_{taskData.TaskType}";
		TaskRange = 2f * configRange * sceneRatio / 150f * Vector3.one;
		base.PointInfo = new InteractivePoint.PointInfo(InteractivePoint.GetTaskPointType(taskData.TaskType), taskData.TaskId, taskData.TaskTitle, worldPos, posOffset, mapSize, sceneRatio);
		base.Pos = base.PointInfo.Pos;
	}

	public override void SetScale(float scale)
	{
		base.SetScale(scale);
		RangeScale = ((scale == 0f) ? Vector3.zero : (Vector3.one * (1f / scale)));
	}
}
