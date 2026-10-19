using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("过滤已找到目标", "FindTargets", new string[] { "filter", "found", "targets" })]
public class FilterFoundTargets : BaseFindTargets
{
	public ConfigPredicate[] predicates = new ConfigPredicate[2]
	{
		new CheckAllianceIs(),
		new CheckEntityType()
	};

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		for (int num = results.Count - 1; num >= 0; num--)
		{
			FindTargetResult findTargetResult = results[num];
			if (findTargetResult.targetSourceType != FindTargetResult.TargetSourceType.Damageable && !findTargetResult.entity.IsAlive())
			{
				results.RemoveAt(num);
			}
		}
		if (predicates == null)
		{
			return;
		}
		for (int num2 = results.Count - 1; num2 >= 0; num2--)
		{
			for (int i = 0; i < predicates.Length; i++)
			{
				bool flag = predicates[i].Check(new ActionMemory(referenceEntity.TryGetCompProduct(out CompProduct component) ? component.caster : referenceEntity, referenceEntity, results[num2]));
				if (predicates[i].Inverse ? flag : (!flag))
				{
					results.RemoveAt(num2);
					break;
				}
			}
		}
	}
}
