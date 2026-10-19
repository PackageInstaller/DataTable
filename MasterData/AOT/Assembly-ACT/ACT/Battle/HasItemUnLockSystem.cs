using Fundamental;

namespace ACT.Battle;

public class HasItemUnLockSystem : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return Singleton<SystemUnlockManager>.instance.IsHasItem(param[0]);
	}

	public override int GetCompleteCount(int[] param)
	{
		return 1;
	}

	public override float GetCompletePercent(int[] param)
	{
		return 0f;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
