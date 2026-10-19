using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取技能冷却", "Function", new string[] { "get", "skill", "cd" })]
public class FunctionGetSkillCd : ConfigFunction<float>
{
	private enum SkillCdParamType
	{
		Current,
		Max
	}

	public string skillName;

	public string skillMotionName;

	private SkillCdParamType skillCdParamType;

	protected override float Evaluate(ActionMemory memory)
	{
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		if (!string.IsNullOrEmpty(skillName))
		{
			foreach (Skill skill in compMotion.skills)
			{
				if (!(skill.config.name != skillName))
				{
					return skillCdParamType switch
					{
						SkillCdParamType.Current => skill.NowCd, 
						SkillCdParamType.Max => skill.Cd, 
						_ => throw new ArgumentOutOfRangeException(), 
					};
				}
			}
		}
		if (compMotion.skillLookup.TryGetValue(skillMotionName, out var value))
		{
			return skillCdParamType switch
			{
				SkillCdParamType.Current => value.NowCd, 
				SkillCdParamType.Max => value.Cd, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
		}
		return 0f;
	}
}
