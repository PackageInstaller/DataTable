using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断连击数量", "Predicate", new string[] { "check", "combo", "count", "predicate", "condition", "skill", "ability", "cd" })]
public class CheckComboCount : ConfigPredicate
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
		int comboCount = Singleton<GameManager>.instance.ecsManager.systemComboCount.ComboCount;
		int num = (int)targetCount.Return(memory);
		return condition switch
		{
			Condition.Greater => comboCount > num, 
			Condition.Less => comboCount < num, 
			Condition.Equal => comboCount == num, 
			Condition.GreaterAndEqual => comboCount >= num, 
			Condition.LessAndEqual => comboCount <= num, 
			_ => false, 
		};
	}
}
