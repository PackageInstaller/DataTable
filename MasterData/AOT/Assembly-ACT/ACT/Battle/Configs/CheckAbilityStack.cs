using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能层数", "Predicate", new string[] { "check", "ability", "stack", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityStack : ConfigPredicate
{
	public string name;

	public Condition condition;

	public int CheckStack;

	public bool useFunctionValue;

	public ConfigFunction<float> targetValueFunc = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			return false;
		}
		Ability abilityByName = component.GetAbilityByName(name);
		if (abilityByName == null)
		{
			return false;
		}
		if (useFunctionValue)
		{
			CheckStack = (int)targetValueFunc.Return(memory);
		}
		return condition switch
		{
			Condition.Greater => abilityByName.stack > CheckStack, 
			Condition.Less => abilityByName.stack < CheckStack, 
			Condition.Equal => abilityByName.stack == CheckStack, 
			Condition.GreaterAndEqual => abilityByName.stack >= CheckStack, 
			Condition.LessAndEqual => abilityByName.stack <= CheckStack, 
			_ => false, 
		};
	}
}
