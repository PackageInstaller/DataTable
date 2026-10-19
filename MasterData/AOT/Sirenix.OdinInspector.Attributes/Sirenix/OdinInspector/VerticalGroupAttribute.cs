using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class VerticalGroupAttribute : PropertyGroupAttribute
{
	public float PaddingTop;

	public float PaddingBottom;

	public VerticalGroupAttribute(string groupId, float order = 0f)
		: base(groupId, order)
	{
	}

	public VerticalGroupAttribute(float order = 0f)
		: this("_DefaultVerticalGroup", order)
	{
	}

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		if (other is VerticalGroupAttribute verticalGroupAttribute)
		{
			if (verticalGroupAttribute.PaddingTop != 0f)
			{
				PaddingTop = verticalGroupAttribute.PaddingTop;
			}
			if (verticalGroupAttribute.PaddingBottom != 0f)
			{
				PaddingBottom = verticalGroupAttribute.PaddingBottom;
			}
		}
	}
}
