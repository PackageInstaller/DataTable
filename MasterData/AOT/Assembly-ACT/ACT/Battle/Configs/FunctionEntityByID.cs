using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体按ID", "Function", new string[] { "entity", "by", "id", "target", "owner", "caster" })]
public class FunctionEntityByID : ConfigFunction<EntityReference>
{
	public ConfigFunction<EntityId> configEntityId;

	[Obsolete("请改用 configEntityId，以保留 EntityId.Version")]
	public ConfigFunction<float> configId;

	protected override EntityReference Evaluate(ActionMemory memory)
	{
		if (configEntityId != null)
		{
			EntityId entityId = configEntityId.Return(memory);
			if (entityId == EntityId.Invalid)
			{
				return default;
			}
			Entity entity = GameManager.entities.GetEntity(entityId);
			return entity.IsValid ? entity : default(Entity);
		}
		_ = configId;
		return default;
	}
}
