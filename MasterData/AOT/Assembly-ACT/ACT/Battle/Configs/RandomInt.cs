using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("随机整数", "Function", new string[] { "random", "int", "value", "float" })]
public class RandomInt : ConfigFunction<float>
{
	public ConfigFunction<float> start = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public ConfigFunction<float> end = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	protected override float Evaluate(ActionMemory memory)
	{
		return (int)Random.Range(start.Return(memory), end.Return(memory) + 1f);
	}
}
