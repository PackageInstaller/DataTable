using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class MultiLinePropertyAttribute : Attribute
{
	public int Lines;

	public MultiLinePropertyAttribute(int lines = 3)
	{
		Lines = Math.Max(1, lines);
	}
}
