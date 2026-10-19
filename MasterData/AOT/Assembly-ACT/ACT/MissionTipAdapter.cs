using ACT.MissionSystem;
using Fundamental;

namespace ACT;

public class MissionTipAdapter
{
	public MissionStateAdapter GetTaskTipState(int missionId)
	{
		if (missionId == 0)
		{
			return null;
		}
		return new NewMissionStateAdapter(Singleton<MissionManager>.instance.GetMissionData(missionId));
	}

	public virtual MissionStateAdapter GetTracingTaskTipState()
	{
		return GetTaskTipState(Singleton<MissionManager>.instance.GetTracingMission());
	}

	public virtual bool HaveTracingMission()
	{
		return Singleton<MissionManager>.instance.GetTracingMission() != 0;
	}
}
