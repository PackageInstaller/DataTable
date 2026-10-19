using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public class LabelWidthAttribute : Attribute
{
	public float Width;

	public LabelWidthAttribute(float width)
	{
		Width = width;
	}
}
