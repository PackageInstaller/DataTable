using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, Inherited = false)]
public class InlinePropertyAttribute : Attribute
{
	public int LabelWidth;
}
