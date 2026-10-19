using ACT.MissionSystem;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckMissionIsFinsh : GuideStepCondition
{
	public int MissionID;

	public override bool CheckCondition()
	{
		return Singleton<MissionManager>.instance.IsFinished(MissionID);
	}
}
