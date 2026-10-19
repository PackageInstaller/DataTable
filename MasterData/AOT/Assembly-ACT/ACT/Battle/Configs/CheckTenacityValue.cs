using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断韧性值", "Predicate", new string[] { "check", "tenacity", "value", "predicate", "condition" })]
public class CheckTenacityValue : ConfigPredicate
{
	public Condition condition;

	public int targetValue;

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			return false;
		}
		int tenacityValue = component.tenacityValue;
		return condition switch
		{
			Condition.Greater => tenacityValue > targetValue, 
			Condition.Less => tenacityValue < targetValue, 
			Condition.Equal => tenacityValue == targetValue, 
			Condition.GreaterAndEqual => tenacityValue >= targetValue, 
			Condition.LessAndEqual => tenacityValue <= targetValue, 
			_ => false, 
		};
	}
}
