namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断连击数量事件", "Predicate", new string[] { "check", "combo", "count", "event", "predicate", "condition", "skill", "ability", "cd" })]
public class CheckComboCountEvent : ConfigPredicate
{
	public Condition condition;

	public ConfigFunction<float> targetCount = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtComboCountChange { newComboCount: var newComboCount })
		{
			int num = (int)targetCount.Return(memory);
			return condition switch
			{
				Condition.Greater => newComboCount > num, 
				Condition.Less => newComboCount < num, 
				Condition.Equal => newComboCount == num, 
				Condition.GreaterAndEqual => newComboCount >= num, 
				Condition.LessAndEqual => newComboCount <= num, 
				_ => false, 
			};
		}
		return false;
	}
}
