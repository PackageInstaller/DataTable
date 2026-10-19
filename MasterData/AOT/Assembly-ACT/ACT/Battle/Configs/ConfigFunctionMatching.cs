using System;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigFunctionMatching<T> : ConfigFunction<T>
{
	public PredicateItem<T>[] predicates;

	public ConfigFunction<T> defaultValue;

	protected override T Evaluate(ActionMemory memory)
	{
		PredicateItem<T>[] array = predicates;
		for (int i = 0; i < array.Length; i++)
		{
			T val = array[i].Match(memory);
			if (!object.Equals(val, default(T)))
			{
				return val;
			}
		}
		return defaultValue.Return(memory);
	}
}
