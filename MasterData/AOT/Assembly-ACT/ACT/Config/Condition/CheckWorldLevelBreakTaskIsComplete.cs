using ACT.Battle;
using ACT.Core;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckWorldLevelBreakTaskIsComplete : GuideStepCondition
{
	public int worldLevel = 1;

	public override bool CheckCondition()
	{
		PlayerWorldLevelDataNew data = CoreUtils.GetData(worldLevel, RuntimeConfigs.data.playerWorldLevelDataNews);
		if (data == null)
		{
			return false;
		}
		if (data.missionId != 0)
		{
			return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data.missionId);
		}
		return false;
	}
}
