using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体ID", "Function", new string[] { "entity", "id", "target", "owner", "caster" })]
public class FunctionEntityID : ConfigFunction<float>
{
	public ConfigFunction<EntityReference> configEntity;

	protected override float Evaluate(ActionMemory memory)
	{
		Entity entity = configEntity.Return(memory).entity;
		if (entity.IsValid)
		{
			return entity.Id.Index;
		}
		return -1f;
	}
}
[AbilityTypeMetadata("获取实体完整ID", "Function", new string[] { "entity", "id", "version", "target", "owner", "caster" })]
public class FunctionEntityId : ConfigFunction<EntityId>
{
	public ConfigFunction<EntityReference> configEntity;

	protected override EntityId Evaluate(ActionMemory memory)
	{
		if (configEntity == null)
		{
			return EntityId.Invalid;
		}
		Entity entity = configEntity.Return(memory).entity;
		if (!entity.IsValid)
		{
			return EntityId.Invalid;
		}
		return entity.Id;
	}
}
