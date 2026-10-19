using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, Inherited = false)]
[Conditional("UNITY_EDITOR")]
public class InlinePropertyAttribute : Attribute
{
	public int LabelWidth;
}
