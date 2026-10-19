using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能等级", "Predicate", new string[] { "check", "ability", "skill", "level", "predicate", "condition" })]
public class CheckAbilitySkillLevel : ConfigPredicate
{
	public string name;

	public Condition condition;

	public ConfigFunction<float> targetValue = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public override bool Check(ActionMemory memory)
	{
		Ability ability;
		if (string.IsNullOrEmpty(name))
		{
			ability = memory.ability;
		}
		else
		{
			ability = ((!memory.target.entity.TryGetCompAbility(out CompAbility component)) ? null : component.GetAbilityByName(name));
		}
		if (ability == null)
		{
			return false;
		}
		byte level = ability.skillLevelInfo.level;
		int num = Mathf.RoundToInt(targetValue.Return(memory));
		return condition switch
		{
			Condition.Greater => level > num, 
			Condition.Less => level < num, 
			Condition.Equal => level == num, 
			Condition.GreaterAndEqual => level >= num, 
			Condition.LessAndEqual => level <= num, 
			_ => false, 
		};
	}
}
