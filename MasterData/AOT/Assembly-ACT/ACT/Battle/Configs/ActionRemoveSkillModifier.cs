using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移除技能修正", "Action", new string[] { "remove", "skill", "modifier", "ability", "cd" })]
public class ActionRemoveSkillModifier : ConfigAction
{
	public SkillModifier skillModifier;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().RemoveSkillModifier(skillModifier, memory.ability);
	}
}
