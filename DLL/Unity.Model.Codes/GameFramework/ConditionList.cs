using System.Collections.Generic;

namespace GameFramework;

public class ConditionList<T> : List<T> where T : class
{
	public ConditionEnum conditionEnum;

	public bool InPool;

	public bool IsOrCondition()
	{
		return conditionEnum == ConditionEnum.Or;
	}
}
