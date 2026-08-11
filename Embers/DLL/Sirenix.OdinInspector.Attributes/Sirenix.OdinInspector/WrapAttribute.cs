using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class WrapAttribute : Attribute
{
	public double Min;

	public double Max;

	public WrapAttribute(double min, double max)
	{
		Min = ((min < max) ? min : max);
		Max = ((max > min) ? max : min);
	}
}
