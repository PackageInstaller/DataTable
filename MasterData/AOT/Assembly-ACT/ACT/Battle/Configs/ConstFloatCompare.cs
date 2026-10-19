using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断常量浮点比较", "Predicate", new string[] { "const", "float", "compare", "predicate", "check", "condition" })]
public class ConstFloatCompare : ConfigPredicate
{
	public ConfigFunction<float> v1;

	public ConfigFunction<float> v2;

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		float num = v1.Return(memory);
		float num2 = v2.Return(memory);
		switch (condition)
		{
		case Condition.Greater:
			result = num > num2;
			break;
		case Condition.GreaterAndEqual:
			result = num >= num2;
			break;
		case Condition.Equal:
			result = num == num2 || Mathf.Abs(num - num2) < 0.01f;
			break;
		case Condition.LessAndEqual:
			result = num <= num2;
			break;
		case Condition.Less:
			result = num < num2;
			break;
		}
		return result;
	}
}
