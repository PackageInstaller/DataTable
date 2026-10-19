using System.Collections.Generic;

namespace ACT.UI;

public sealed class TaskMissionGroupViewDataV3
{
	public int ChapterId { get; }

	public int TitleId { get; }

	public int ChapterSubtitleId { get; }

	public TaskCategoryV3 Category { get; }

	public List<TaskMissionViewDataV3> Missions { get; } = new List<TaskMissionViewDataV3>();

	public TaskMissionGroupViewDataV3(int chapterId, int titleId, int chapterSubtitleId, TaskCategoryV3 category)
	{
		ChapterId = chapterId;
		TitleId = titleId;
		ChapterSubtitleId = chapterSubtitleId;
		Category = category;
	}
}
