using System.Linq;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断角色ID", "Predicate", new string[] { "check", "character", "id", "predicate", "condition" })]
public class CheckCharacterId : ConfigPredicate
{
	public int[] characterIds;

	public override bool Check(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			int[] array = characterIds;
			if (array != null && array.Length > 0)
			{
				int value = component.characterSource.Id();
				return characterIds.Contains(value);
			}
		}
		return false;
	}
}
