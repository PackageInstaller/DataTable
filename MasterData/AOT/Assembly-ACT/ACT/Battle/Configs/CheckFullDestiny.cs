using ACT.Game.Data;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断FullDestiny", "Predicate", new string[] { "check", "full", "destiny", "predicate", "condition" })]
public class CheckFullDestiny : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompCharacter(out CompCharacter component))
		{
			return false;
		}
		if (component.characterSource is Character character)
		{
			return character.GetActiveDestinyCount() == 6;
		}
		return false;
	}
}
