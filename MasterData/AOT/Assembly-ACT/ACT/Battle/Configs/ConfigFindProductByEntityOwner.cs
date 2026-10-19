using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine.Rendering;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找产物按实体拥有者", "FindTargets", new string[] { "find", "product", "by", "entity", "owner" })]
public class ConfigFindProductByEntityOwner : BaseFindTargets
{
	public ConfigFunction<EntityReference> ownerEntity;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		List<Entity> list = ListPool<Entity>.Get();
		EntityReference entityReference = ownerEntity.Return(new ActionMemory(referenceEntity, referenceEntity, referenceEntity));
		if (entityReference.IsValid)
		{
			SystemProduct.GetCasterProductEntity(entityReference, ref list, isCaster: false);
			foreach (Entity item in list)
			{
				results.Add(FindTargetResult.EntityOnly(item));
			}
		}
		ListPool<Entity>.Release(list);
	}
}
