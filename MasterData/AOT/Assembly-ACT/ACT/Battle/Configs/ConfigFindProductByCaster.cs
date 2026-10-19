using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine.Rendering;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找产物按施法者", "FindTargets", new string[] { "find", "product", "by", "caster" })]
public class ConfigFindProductByCaster : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		List<Entity> list = ListPool<Entity>.Get();
		SystemProduct.GetCasterProductEntity(referenceEntity, ref list);
		foreach (Entity item in list)
		{
			results.Add(FindTargetResult.EntityOnly(item));
		}
		ListPool<Entity>.Release(list);
	}
}
