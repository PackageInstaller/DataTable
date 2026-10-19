using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine.Rendering;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找产物按拥有者", "FindTargets", new string[] { "find", "product", "by", "owner" })]
public class ConfigFindProductByOwner : BaseFindTargets
{
	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		List<Entity> list = ListPool<Entity>.Get();
		SystemProduct.GetCasterProductEntity(referenceEntity, ref list, isCaster: false);
		foreach (Entity item in list)
		{
			results.Add(FindTargetResult.EntityOnly(item));
		}
		ListPool<Entity>.Release(list);
	}
}
