namespace ACT.Battle;

public class GetDailyReward : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		return 1;
	}

	public override int GetCompleteCount(int[] param)
	{
		return 0;
	}

	public override bool IsComplete(int[] param)
	{
		return false;
	}
}
