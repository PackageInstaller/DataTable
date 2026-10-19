using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断目标ID", "Predicate", new string[] { "check", "target", "id", "retarget", "aim", "predicate", "condition" })]
public class CheckTargetID : ConfigPredicate
{
	public int entityID;

	public override bool Check(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (entity.IsBehaveEntity())
		{
			return entityID == entity.GetTableId();
		}
		return false;
	}
}
