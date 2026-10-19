using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class MinValueAttribute : Attribute
{
	public double MinValue;

	public string Expression;

	public MinValueAttribute(double minValue)
	{
		MinValue = minValue;
	}

	public MinValueAttribute(string expression)
	{
		Expression = expression;
	}
}
