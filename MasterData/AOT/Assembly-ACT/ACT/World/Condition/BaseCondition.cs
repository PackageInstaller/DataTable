using System;
using ACT.Condition.Interface;
using UnityEngine;

namespace ACT.World.Condition;

[Serializable]
public abstract class BaseCondition : ICondition
{
	public enum ComparisonOperator
	{
		[InspectorName("大于")]
		GreaterThan,
		[InspectorName("小于")]
		LessThan,
		[InspectorName("等于")]
		Equal,
		[InspectorName("大于等于")]
		GreaterThanOrEqual,
		[InspectorName("小于等于")]
		LessThanOrEqual
	}

	public abstract string Description { get; }

	protected abstract bool Check();

	public bool IsPass()
	{
		return Check();
	}
}
