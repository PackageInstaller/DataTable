using ACT.Battle;

namespace ACT.World;

public class StateObjectCondition : ILoadCondition
{
	public int uid;

	public int stateId;

	public bool Return()
	{
		return MonoECS.instance.ruleManager.SharedGetState(uid) == stateId;
	}
}
