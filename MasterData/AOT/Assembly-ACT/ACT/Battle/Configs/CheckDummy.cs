using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class CheckDummy : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		FindTargetResult target = memory.target;
		if (!target.IsValid)
		{
			return false;
		}
		return target.entity.IsDummy();
	}
}
