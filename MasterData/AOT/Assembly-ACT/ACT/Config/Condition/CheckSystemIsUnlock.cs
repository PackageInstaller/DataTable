using Fundamental;

namespace ACT.Config.Condition;

public class CheckSystemIsUnlock : GuideStepCondition
{
	public int SystemID;

	public override bool CheckCondition()
	{
		return Singleton<SystemUnlockManager>.instance.IsUnlock(SystemID);
	}
}
