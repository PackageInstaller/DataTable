using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能外冷却", "Predicate", new string[] { "skill", "out", "cd", "predicate", "check", "condition", "ability" })]
public class SkillOutCDPredicate : ConfigPredicate
{
	public string name;

	public override bool Check(ActionMemory memory)
	{
		foreach (Skill skill in memory.target.entity.GetCompMotion().skills)
		{
			if (skill.config.name == name)
			{
				return skill.NowCount > 0;
			}
		}
		return false;
	}
}
