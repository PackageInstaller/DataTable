using Unity.VisualScripting;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体记忆", "Function", new string[] { "entity", "memory", "target", "owner", "caster" })]
public class FunctionEntityMemory : ConfigFunction<EntityReference>
{
	public MemoryEntityRef memoryEntityRef;

	protected override EntityReference Evaluate(ActionMemory memory)
	{
		return memoryEntityRef switch
		{
			MemoryEntityRef.Caster => (EntityReference)memory.caster, 
			MemoryEntityRef.Owner => (EntityReference)memory.owner, 
			MemoryEntityRef.Target => (EntityReference)memory.target.entity, 
			_ => throw new InvalidImplementationException(), 
		};
	}
}
