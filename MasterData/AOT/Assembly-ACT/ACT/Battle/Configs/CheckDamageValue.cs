namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断伤害值", "Predicate", new string[] { "check", "damage", "value", "predicate", "condition" })]
public class CheckDamageValue : ConfigPredicate
{
	public Condition condition;

	public int targetValue;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			return ConditionCheck(getAttackData.GetAttackData().actualDamage);
		}
		return false;
	}

	public bool ConditionCheck(float value)
	{
		return condition switch
		{
			Condition.Greater => value > (float)targetValue, 
			Condition.Less => value < (float)targetValue, 
			Condition.Equal => value == (float)targetValue, 
			Condition.GreaterAndEqual => value >= (float)targetValue, 
			Condition.LessAndEqual => value <= (float)targetValue, 
			_ => false, 
		};
	}
}
