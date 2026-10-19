using System.Linq;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断怪物ID", "Predicate", new string[] { "check", "monster", "id", "predicate", "condition" })]
public class CheckMonsterId : ConfigPredicate
{
	public int[] monsterIds;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompMonster(out CompMonster component))
		{
			int[] array = monsterIds;
			if (array != null && array.Length > 0)
			{
				return monsterIds.Contains(component.id);
			}
		}
		return false;
	}
}
