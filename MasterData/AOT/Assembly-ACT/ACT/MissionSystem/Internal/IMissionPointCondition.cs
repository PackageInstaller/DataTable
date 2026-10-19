namespace ACT.MissionSystem.Internal;

public interface IMissionPointCondition
{
	bool ShowMissionPointIcon { get; set; }

	bool ShowMissionPointRadius { get; set; }

	float MissionPointRadius { get; set; }
}
