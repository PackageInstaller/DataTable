using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class CheckTargetEntityTag : ConfigPredicate
{
	public EntityTag entityTag;

	public override bool Check(ActionMemory memory)
	{
		return memory.target.entity.InTag(entityTag);
	}
}
