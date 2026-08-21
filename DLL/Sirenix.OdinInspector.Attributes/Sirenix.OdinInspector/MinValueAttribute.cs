using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
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
