using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[DontApplyToListElements]
public class LabelWidthAttribute : Attribute
{
	public float Width;

	public LabelWidthAttribute(float width)
	{
		Width = width;
	}
}
