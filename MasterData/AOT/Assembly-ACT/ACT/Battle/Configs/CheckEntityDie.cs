using System.Linq;
using ACT.Core;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断实体Die", "Predicate", new string[] { "check", "entity", "die", "target", "retarget", "aim", "predicate", "condition" })]
public class CheckEntityDie : ConfigPredicate
{
	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	public bool checkRange;

	public float checkRadius = 10f;

	public bool checkMonsterId;

	public int[] monsterIds;

	public bool checkCharacterId;

	public int[] characterIds;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtEntityDie { ownerEntity: var ownerEntity })
		{
			if (!ownerEntity.IsValid)
			{
				return false;
			}
			EntityType entityType = ownerEntity.GetEntityType();
			if (!filterEntityType.HasEntityType(entityType))
			{
				return false;
			}
			if (checkRange)
			{
				Vector3 physicsPosition = memory.owner.GetCompTransform().physicsPosition;
				Vector3 physicsPosition2 = ownerEntity.GetCompTransform().physicsPosition;
				if (Vector3.Distance(physicsPosition, physicsPosition2) > checkRadius)
				{
					return false;
				}
			}
			if (checkMonsterId && ownerEntity.TryGetCompMonster(out CompMonster component))
			{
				int[] array = monsterIds;
				if (array != null && array.Length > 0)
				{
					return monsterIds.Contains(component.id);
				}
			}
			if (checkCharacterId && ownerEntity.TryGetCompCharacter(out CompCharacter component2))
			{
				ICharacterSource characterSource = component2.characterSource;
				if (characterSource != null)
				{
					int[] array = characterIds;
					if (array != null && array.Length > 0)
					{
						return characterIds.Contains(characterSource.Id());
					}
				}
				return false;
			}
			return true;
		}
		return false;
	}
}
