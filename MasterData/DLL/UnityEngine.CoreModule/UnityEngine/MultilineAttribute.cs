using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public sealed class MultilineAttribute : PropertyAttribute
{
	public readonly int lines;

	public MultilineAttribute()
	{
		lines = 3;
	}
}
