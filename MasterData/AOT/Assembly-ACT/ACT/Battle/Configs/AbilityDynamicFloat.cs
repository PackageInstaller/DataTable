using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取技能动态浮点", "Function", new string[] { "ability", "dynamic", "float", "value", "int" })]
public class AbilityDynamicFloat : ConfigFunction<float>
{
	public string abilityName;

	public DynamicFloat value = new DynamicFloat
	{
		source = ParamSource.Const,
		value = 0f
	};

	protected override float Evaluate(ActionMemory memory)
	{
		if (memory.target.entity.TryGetCompAbility(out CompAbility component) && component.HasAbility(abilityName))
		{
			foreach (Ability ability in component.abilities)
			{
				if (ability.config.name == abilityName)
				{
					return value.GetFloat(ability);
				}
			}
		}
		return 0f;
	}
}
