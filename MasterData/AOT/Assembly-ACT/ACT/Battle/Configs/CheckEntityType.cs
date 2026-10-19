using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体类型", "Predicate", new string[] { "check", "entity", "type", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityType : ConfigPredicate
{
	public EntityType entityType;

	public bool more;

	public EntityType[] entityTypes;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		EntityType entityType = memory.target.entity.GetEntityType();
		if (more)
		{
			if (entityTypes == null)
			{
				return false;
			}
			for (int i = 0; i < entityTypes.Length; i++)
			{
				if (entityType == entityTypes[i])
				{
					result = true;
					break;
				}
			}
			return result;
		}
		return entityType == this.entityType;
	}
}
