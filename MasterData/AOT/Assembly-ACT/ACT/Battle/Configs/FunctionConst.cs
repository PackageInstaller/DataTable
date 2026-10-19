using System;

namespace ACT.Battle.Configs;

[Serializable]
[AbilityTypeMetadata("泛型常量", "Function", new string[] { "const", "generic", "value" })]
public class FunctionConst<T> : ConfigFunction<T>
{
	public T value;

	protected override T Evaluate(ActionMemory memory)
	{
		return value;
	}
}
