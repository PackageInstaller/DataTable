using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("消耗技能", "Action", new string[] { "consume", "skill", "ability", "cd" })]
public class ActionConsumeSkill : ConfigAction
{
	public string name;

	public bool consumeAllNowCount;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		foreach (Skill skill in compMotion.skills)
		{
			if (skill.config.name == name)
			{
				if (skill.NowCount >= 0)
				{
					compMotion.ConsumeSkillCount(skill, consumeAllNowCount);
				}
				else
				{
					skill.SetSkillCd(skill.Cd, exceeds: false);
				}
				break;
			}
		}
	}
}
