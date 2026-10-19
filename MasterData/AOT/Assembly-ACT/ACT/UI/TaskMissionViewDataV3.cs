namespace ACT.UI;

public sealed class TaskMissionViewDataV3
{
	public int MissionId { get; }

	public TaskCategoryV3 Category { get; }

	public int ChapterId { get; }

	public int NameId { get; }

	public int TitleDescriptionId { get; }

	public int ContentDescriptionId { get; }

	public int ZoneDescriptionId { get; }

	public int PlaceDescriptionId { get; }

	public int RewardId { get; }

	public TaskMissionViewDataV3(int missionId, TaskCategoryV3 category, int chapterId, int nameId, int titleDescriptionId, int contentDescriptionId, int zoneDescriptionId, int placeDescriptionId, int rewardId)
	{
		MissionId = missionId;
		Category = category;
		ChapterId = chapterId;
		NameId = nameId;
		TitleDescriptionId = titleDescriptionId;
		ContentDescriptionId = contentDescriptionId;
		ZoneDescriptionId = zoneDescriptionId;
		PlaceDescriptionId = placeDescriptionId;
		RewardId = rewardId;
	}
}
