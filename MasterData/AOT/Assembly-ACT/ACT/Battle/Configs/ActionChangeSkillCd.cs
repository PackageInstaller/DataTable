using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改技能冷却", "Action", new string[] { "change", "skill", "cd", "ability" })]
public class ActionChangeSkillCd : ConfigAction
{
	public string skill;

	public string skillName;

	[HideInInspector]
	public DynamicFloat value;

	public ConfigFunction<float> configFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public Operator Operator;

	public override void Do(ActionMemory memory)
	{
		float num = ((configFunction == null) ? value.value : configFunction.Return(memory));
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		if (!string.IsNullOrEmpty(this.skill))
		{
			foreach (Skill skill2 in compMotion.skills)
			{
				if (!(skill2.config.name != this.skill))
				{
					skill2.SetSkillCd(Operator switch
					{
						Operator.add => skill2.NowCd + num, 
						Operator.subtract => skill2.NowCd - num, 
						Operator.set => num, 
						_ => throw new ArgumentException(), 
					}, exceeds: true);
				}
			}
			return;
		}
		if (compMotion.skillLookup.TryGetValue(skillName, out var skill))
		{
			float cd = Operator switch
			{
				Operator.add => skill.NowCd + num, 
				Operator.subtract => skill.NowCd - num, 
				Operator.set => num, 
				_ => throw new ArgumentException(), 
			};
			skill.SetSkillCd(cd, exceeds: true);
		}
	}
}
