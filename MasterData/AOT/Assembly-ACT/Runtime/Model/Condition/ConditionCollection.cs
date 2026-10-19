using System.Collections.Generic;
using ACT.Condition.Interface;
using Fundamental;

namespace Runtime.Model.Condition;

internal class ConditionCollection<T>
{
	public Dictionary<T, List<ICondition>> conditions;

	public void Alloc()
	{
		conditions = DictionaryPool<T, List<ICondition>>.Get();
	}

	public void Free()
	{
		if (conditions == null)
		{
			return;
		}
		foreach (KeyValuePair<T, List<ICondition>> condition in conditions)
		{
			if (condition.Value != null)
			{
				ListPool<ICondition>.Release(condition.Value);
			}
		}
		DictionaryPool<T, List<ICondition>>.Release(conditions);
		conditions = null;
	}
}
