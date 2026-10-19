namespace ACT.Battle;

public class PassLevelInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return SystemUnlockManager.playerLevel >= param[0];
	}

	public override float GetCompletePercent(int[] param)
	{
		return 0f;
	}

	public override int GetCompleteCount(int[] param)
	{
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
