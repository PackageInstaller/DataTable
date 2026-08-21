using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class MaxValueAttribute : Attribute
{
	public double MaxValue;

	public string Expression;

	public MaxValueAttribute(double maxValue)
	{
		MaxValue = maxValue;
	}

	public MaxValueAttribute(string expression)
	{
		Expression = expression;
	}
}
