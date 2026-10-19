using System;

namespace ACT.Battle.Configs;

[Serializable]
public class PredicateItem<T>
{
	public ConfigPredicate[] predicates;

	public ConfigFunction<T> item;

	public T Match(ActionMemory memory)
	{
		ConfigPredicate[] array = predicates;
		foreach (ConfigPredicate configPredicate in array)
		{
			if (configPredicate.Inverse ? (!configPredicate.Check(memory)) : configPredicate.Check(memory))
			{
				return item.Return(memory);
			}
		}
		return default;
	}
}
