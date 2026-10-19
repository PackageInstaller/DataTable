using Fundamental;

namespace ACT.World.Condition;

public class CheckSystemUnlockCondition : BaseCondition
{
	public int systemId;

	public bool unlock;

	public override string Description => "检查系统解锁状态";

	protected override bool Check()
	{
		bool flag = Singleton<SystemUnlockManager>.instance.IsUnlock(systemId);
		if (!unlock)
		{
			return !flag;
		}
		return flag;
	}
}
