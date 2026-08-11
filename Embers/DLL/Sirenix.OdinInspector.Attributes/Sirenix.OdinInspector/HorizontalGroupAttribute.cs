using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public class HorizontalGroupAttribute : PropertyGroupAttribute
{
	private const int DefaultHorizontalGroupGap = 3;

	public float Width;

	public float MarginLeft;

	public float MarginRight;

	public float PaddingLeft;

	public float PaddingRight;

	public float MinWidth;

	public float MaxWidth;

	public float Gap = 3f;

	public string Title;

	public bool DisableAutomaticLabelWidth;

	public float LabelWidth;

	public HorizontalGroupAttribute(string group, float width = 0f, int marginLeft = 0, int marginRight = 0, float order = 0f)
		: base(group, order)
	{
		Width = width;
		MarginLeft = marginLeft;
		MarginRight = marginRight;
	}

	public HorizontalGroupAttribute(float width = 0f, int marginLeft = 0, int marginRight = 0, float order = 0f)
		: this("_DefaultHorizontalGroup", width, marginLeft, marginRight, order)
	{
	}

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		if (other is HorizontalGroupAttribute horizontalGroupAttribute)
		{
			Title = Title ?? horizontalGroupAttribute.Title;
			DisableAutomaticLabelWidth = DisableAutomaticLabelWidth || horizontalGroupAttribute.DisableAutomaticLabelWidth;
			if (LabelWidth == 0f && horizontalGroupAttribute.LabelWidth != 0f)
			{
				LabelWidth = horizontalGroupAttribute.LabelWidth;
			}
			if (horizontalGroupAttribute.Gap != 3f)
			{
				Gap = horizontalGroupAttribute.Gap;
			}
		}
	}
}
