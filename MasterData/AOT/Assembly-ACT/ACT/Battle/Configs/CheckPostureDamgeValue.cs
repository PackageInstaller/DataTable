namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断架势伤害值", "Predicate", new string[] { "check", "posture", "damge", "value", "before", "after", "predicate", "condition" })]
public class CheckPostureDamgeValue : ConfigPredicate
{
	public enum PostureCheckPhase
	{
		Before,
		After
	}

	public PostureCheckPhase checkPhase;

	public Condition condition;

	public ConfigFunction<float> value = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public override bool Check(ActionMemory memory)
	{
		if (!(memory.evt is EvtPostureDamage evtPostureDamage))
		{
			return false;
		}
		float num = ((checkPhase == PostureCheckPhase.After) ? evtPostureDamage.afterPosture : evtPostureDamage.beforePosture);
		int num2 = (int)(value?.Return(memory) ?? 0f);
		return condition switch
		{
			Condition.Greater => num > (float)num2, 
			Condition.Less => num < (float)num2, 
			Condition.Equal => (int)num == num2, 
			Condition.GreaterAndEqual => (int)num >= num2, 
			Condition.LessAndEqual => (int)num <= num2, 
			_ => false, 
		};
	}
}
