using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断系统是否解锁", "Predicate", new string[] { "check", "System", "UnLock", "predicate", "condition" })]
public class CheckSystemUnLock : ConfigPredicate
{
	public int systemId;

	public override bool Check(ActionMemory memory)
	{
		return Singleton<SystemUnlockManager>.instance.IsUnlock(systemId);
	}
}
