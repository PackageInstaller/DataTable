using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public sealed class RangeAttribute : PropertyAttribute
{
	public readonly float min;

	public readonly float max;

	public RangeAttribute(float min, float max)
	{
		this.min = min;
		this.max = max;
	}
}
