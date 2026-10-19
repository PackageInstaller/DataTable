namespace ACT.Battle;

public class WorldLevelInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return true;
	}

	public override float GetCompletePercent(int[] param)
	{
		return 1f;
	}

	public override int GetCompleteCount(int[] param)
	{
		return SystemUnlockManager.worldLevel;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
