using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找实体行为", "Function", new string[] { "find", "entity", "behave", "target", "owner", "caster" })]
public class FunctionFindEntityBehave : ConfigFunction<EntityReference>
{
	public BaseFindTargets findTargets;

	[Tooltip("筛选的条件，可空（空表示不筛选）。")]
	public ConfigPredicate predicate = new FilterTargetPredicate();

	protected override EntityReference Evaluate(ActionMemory memory)
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		findTargets.FindTargets(memory.owner, list);
		if (predicate != null)
		{
			BaseFindTargets.Where(memory.owner, list, predicate);
		}
		Entity entity = ((list.Count > 0) ? list[0].entity : default(Entity));
		ListPool<FindTargetResult>.Release(list);
		return entity;
	}
}
