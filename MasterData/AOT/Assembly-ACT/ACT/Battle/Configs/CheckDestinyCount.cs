using ACT.Game.Data;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Destiny数量", "Predicate", new string[] { "check", "destiny", "count", "predicate", "condition" })]
public class CheckDestinyCount : ConfigPredicate
{
	public int destinyCount = 6;

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompCharacter(out CompCharacter component) || !(component.characterSource is Character character))
		{
			return false;
		}
		return character.GetActiveDestinyCount() == destinyCount;
	}
}
