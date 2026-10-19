using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("继承技能", "Action", new string[] { "inherit", "ability", "skill", "cd" })]
public class ActionInheritAbility : ConfigAction
{
	public string abilityName;

	public override void Do(ActionMemory memory)
	{
		if (memory.owner.GetCompAbility().TryGetAbility(abilityName, includeAdd: true, out var ab))
		{
			memory.target.entity.GetCompAbility().AddAbility(memory.owner, abilityName, AbilitySource.Ability, ab.skillLevelInfo, ab.stack);
		}
	}
}
