using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public sealed class IndentAttribute : Attribute
{
	public int IndentLevel;

	public IndentAttribute(int indentLevel = 1)
	{
		IndentLevel = indentLevel;
	}
}
