using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找主控实体", "FindTargets", new string[] { "find", "main", "entity" })]
public class ConfigFindMainEntity : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		if (MonoECS.instance.mainEntity != null)
		{
			results.Add(FindTargetResult.EntityOnly(MonoECS.instance.mainEntity));
		}
	}
}
