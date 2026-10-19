using System.Collections.Generic;

namespace ACT.UI;

public sealed class TaskCategoryViewDataV3
{
	private readonly Dictionary<int, TaskMissionGroupViewDataV3> _chapterMap = new Dictionary<int, TaskMissionGroupViewDataV3>();

	public TaskCategoryV3 Category { get; }

	public List<TaskMissionViewDataV3> Missions { get; } = new List<TaskMissionViewDataV3>();

	public List<TaskMissionGroupViewDataV3> MissionGroups { get; } = new List<TaskMissionGroupViewDataV3>();

	public List<TaskMissionViewDataV3> StandaloneMissions { get; } = new List<TaskMissionViewDataV3>();

	public bool HasMission => Missions.Count > 0;

	public TaskCategoryViewDataV3(TaskCategoryV3 category)
	{
		Category = category;
	}

	public void AddMission(TaskMissionViewDataV3 mission, int chapterTitleId, int chapterSubtitleId)
	{
		Missions.Add(mission);
		if (mission.ChapterId == -1)
		{
			StandaloneMissions.Add(mission);
			return;
		}
		if (!_chapterMap.TryGetValue(mission.ChapterId, out var value))
		{
			value = new TaskMissionGroupViewDataV3(mission.ChapterId, chapterTitleId, chapterSubtitleId, Category);
			_chapterMap.Add(mission.ChapterId, value);
			MissionGroups.Add(value);
		}
		value.Missions.Add(mission);
	}

	public void Clear()
	{
		Missions.Clear();
		MissionGroups.Clear();
		StandaloneMissions.Clear();
		_chapterMap.Clear();
	}
}
