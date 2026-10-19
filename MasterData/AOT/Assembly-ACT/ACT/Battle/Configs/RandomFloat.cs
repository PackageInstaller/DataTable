using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("随机浮点", "Function", new string[] { "random", "float", "value", "int" })]
public class RandomFloat : ConfigFunction<float>
{
	public bool isOpenEnd;

	public ConfigFunction<float> randomLeftrange = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public ConfigFunction<float> randomRightrange = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	protected override float Evaluate(ActionMemory memory)
	{
		if (isOpenEnd)
		{
			return Random.Range(randomLeftrange.Return(memory), randomRightrange.Return(memory) - 1E-05f);
		}
		return Random.Range(randomLeftrange.Return(memory), randomRightrange.Return(memory));
	}
}
