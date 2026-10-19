using Pb;

namespace ACT.MissionSystem;

public interface IMissionManagerServerCall
{
	void InitMissions(MissionRNtf missions);

	void InitTracingMission(int missionId);
}
