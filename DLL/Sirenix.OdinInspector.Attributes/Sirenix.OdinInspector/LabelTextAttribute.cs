using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public class LabelTextAttribute : Attribute
{
	public string Text;

	public bool NicifyText;

	public SdfIconType Icon;

	public string IconColor;

	public LabelTextAttribute(string text)
	{
		Text = text;
	}

	public LabelTextAttribute(SdfIconType icon)
	{
		Icon = icon;
	}

	public LabelTextAttribute(string text, bool nicifyText)
	{
		Text = text;
		NicifyText = nicifyText;
	}

	public LabelTextAttribute(string text, SdfIconType icon)
	{
		Text = text;
		Icon = icon;
	}

	public LabelTextAttribute(string text, bool nicifyText, SdfIconType icon)
	{
		Text = text;
		NicifyText = nicifyText;
		Icon = icon;
	}
}
