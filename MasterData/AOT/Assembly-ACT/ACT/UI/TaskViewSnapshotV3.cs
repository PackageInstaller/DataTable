using System.Collections.Generic;

namespace ACT.UI;

public sealed class TaskViewSnapshotV3
{
	private readonly Dictionary<TaskCategoryV3, TaskCategoryViewDataV3> _categoryMap = new Dictionary<TaskCategoryV3, TaskCategoryViewDataV3>();

	public Dictionary<int, TaskMissionViewDataV3> MissionMap { get; } = new Dictionary<int, TaskMissionViewDataV3>();

	public List<TaskCategoryViewDataV3> Categories { get; } = new List<TaskCategoryViewDataV3>(4);

	public bool HasMission => MissionMap.Count > 0;

	public TaskViewSnapshotV3()
	{
		AddCategory(TaskCategoryV3.Main);
		AddCategory(TaskCategoryV3.Side);
		AddCategory(TaskCategoryV3.Daily);
		AddCategory(TaskCategoryV3.Legend);
	}

	public TaskCategoryViewDataV3 GetCategory(TaskCategoryV3 category)
	{
		return _categoryMap[category];
	}

	public bool TryGetMission(int missionId, out TaskMissionViewDataV3 mission)
	{
		return MissionMap.TryGetValue(missionId, out mission);
	}

	public void AddMission(TaskMissionViewDataV3 mission, int chapterTitleId, int chapterSubtitleId)
	{
		MissionMap.Add(mission.MissionId, mission);
		_categoryMap[mission.Category].AddMission(mission, chapterTitleId, chapterSubtitleId);
	}

	public void Clear()
	{
		MissionMap.Clear();
		for (int i = 0; i < Categories.Count; i++)
		{
			Categories[i].Clear();
		}
	}

	private void AddCategory(TaskCategoryV3 category)
	{
		TaskCategoryViewDataV3 taskCategoryViewDataV = new TaskCategoryViewDataV3(category);
		Categories.Add(taskCategoryViewDataV);
		_categoryMap.Add(category, taskCategoryViewDataV);
	}
}
