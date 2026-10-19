using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断参数", "Predicate", new string[] { "check", "parameter", "predicate", "condition" })]
public class CheckParameter : ConfigPredicate
{
	public string name;

	public ConfigAnimParameterType type;

	public float tagetFloat;

	public int targetInt;

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompMotion(out CompMotion component) || !component.parameters.TryGetValue(name, out var value))
		{
			return false;
		}
		float num = 0f;
		float num2 = 0f;
		switch (type)
		{
		case ConfigAnimParameterType.Float:
			num = value.defaultFloat;
			num2 = tagetFloat;
			break;
		case ConfigAnimParameterType.Int:
			num = value.defaultInt;
			num2 = targetInt;
			break;
		case ConfigAnimParameterType.Bool:
			return value.defaultBool;
		case ConfigAnimParameterType.Trigger:
			return value.defaultBool;
		}
		return condition switch
		{
			Condition.Greater => num > num2, 
			Condition.GreaterAndEqual => num >= num2, 
			Condition.Equal => num == num2, 
			Condition.LessAndEqual => num <= num2, 
			Condition.Less => num < num2, 
			_ => false, 
		};
	}
}
