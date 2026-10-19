using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置技能等级", "Action", new string[] { "set", "ability", "skill", "level" })]
public class ActionSetAbilitySkillLevel : ConfigAction
{
	public string name;

	public ConfigFunction<float> level = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
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
			return;
		}
		byte b = (byte)Mathf.Clamp(Mathf.RoundToInt(level.Return(memory)), 0, 255);
		if (ability.skillLevelInfo.level != b)
		{
			ability.skillLevelInfo.level = b;
			if (ability.config != null)
			{
				ability.RemoveProperty();
				ability.AddProperty();
			}
		}
	}
}
