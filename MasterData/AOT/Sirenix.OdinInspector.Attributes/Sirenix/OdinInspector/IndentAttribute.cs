using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
public sealed class IndentAttribute : Attribute
{
	public int IndentLevel;

	public IndentAttribute(int indentLevel = 1)
	{
		IndentLevel = indentLevel;
	}
}
