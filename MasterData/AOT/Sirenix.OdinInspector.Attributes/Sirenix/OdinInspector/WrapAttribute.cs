using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
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
