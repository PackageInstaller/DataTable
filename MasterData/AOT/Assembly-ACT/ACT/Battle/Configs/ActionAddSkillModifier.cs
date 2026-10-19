using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("添加技能修正", "Action", new string[] { "add", "skill", "modifier", "ability", "cd" })]
public class ActionAddSkillModifier : ConfigAction
{
	public ISkillModifier skillModifier;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetCompAbility().AddSkillModifier(skillModifier, memory.ability);
	}
}
