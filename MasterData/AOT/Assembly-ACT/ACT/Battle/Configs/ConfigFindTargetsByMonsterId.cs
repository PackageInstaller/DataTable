using System.Collections.Generic;
using System.Linq;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class ConfigFindTargetsByMonsterId : BaseFindTargets
{
	public int[] monsterIds;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			if (allEntity.TryGetCompMonster(out CompMonster component))
			{
				int[] array = monsterIds;
				if (array != null && array.Length > 0 && monsterIds.Contains(component.id))
				{
					FindTargetResult item = FindTargetResult.EntityOnly(allEntity);
					results.Add(item);
				}
			}
		}
	}
}
