using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找实体", "FindTargets", new string[] { "find", "entity" })]
public class ConfigFindFunctionEntity : BaseFindTargets
{
	public ConfigFunction<EntityReference> configFunction;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		EntityReference entityReference = configFunction.Return(new ActionMemory(referenceEntity, referenceEntity, referenceEntity));
		if (entityReference.IsValid)
		{
			results.Add(FindTargetResult.EntityOnly(entityReference));
		}
	}
}
