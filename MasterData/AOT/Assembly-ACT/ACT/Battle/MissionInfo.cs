using ACT.MissionSystem;
using Fundamental;

namespace ACT.Battle;

public class MissionInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (Singleton<MissionManager>.instance.IsFinished(param[0]))
		{
			return true;
		}
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		return 0f;
	}

	public override int GetCompleteCount(int[] param)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsCheckMission(param[0]))
		{
			return 0;
		}
		return 1;
	}

	public override int GetNeedCount(int[] param)
	{
		return 1;
	}
}
