using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改技能冷却数量", "Action", new string[] { "change", "skill", "cd", "count", "ability" })]
public class ActionChangeSkillCDCount : ConfigAction
{
	public enum State
	{
		Normal,
		AddALl,
		RemoveALL
	}

	public string name;

	public State state;

	public int count;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		foreach (Skill skill in compMotion.skills)
		{
			if (skill.config.name == name)
			{
				_ = skill.NowCount;
				_ = count;
				switch (state)
				{
				case State.Normal:
					skill.SetSkillCount(skill.NowCount + count);
					break;
				case State.AddALl:
					skill.SetSkillCount(skill.MaxCount);
					break;
				case State.RemoveALL:
					compMotion.ConsumeSkillCount(skill, useall: true);
					break;
				}
			}
		}
	}
}
