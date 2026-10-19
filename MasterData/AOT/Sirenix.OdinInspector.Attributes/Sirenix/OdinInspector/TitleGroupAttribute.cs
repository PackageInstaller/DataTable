using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class TitleGroupAttribute : PropertyGroupAttribute
{
	public string Subtitle;

	public TitleAlignments Alignment;

	public bool HorizontalLine;

	public bool BoldTitle;

	public bool Indent;

	public TitleGroupAttribute(string title, string subtitle = null, TitleAlignments alignment = TitleAlignments.Left, bool horizontalLine = true, bool boldTitle = true, bool indent = false, float order = 0f)
		: base(title, order)
	{
		Subtitle = subtitle;
		Alignment = alignment;
		HorizontalLine = horizontalLine;
		BoldTitle = boldTitle;
		Indent = indent;
	}

	protected override void CombineValuesWith(PropertyGroupAttribute other)
	{
		TitleGroupAttribute titleGroupAttribute = other as TitleGroupAttribute;
		if (Subtitle != null)
		{
			titleGroupAttribute.Subtitle = Subtitle;
		}
		else
		{
			Subtitle = titleGroupAttribute.Subtitle;
		}
		if (Alignment != TitleAlignments.Left)
		{
			titleGroupAttribute.Alignment = Alignment;
		}
		else
		{
			Alignment = titleGroupAttribute.Alignment;
		}
		if (!HorizontalLine)
		{
			titleGroupAttribute.HorizontalLine = HorizontalLine;
		}
		else
		{
			HorizontalLine = titleGroupAttribute.HorizontalLine;
		}
		if (!BoldTitle)
		{
			titleGroupAttribute.BoldTitle = BoldTitle;
		}
		else
		{
			BoldTitle = titleGroupAttribute.BoldTitle;
		}
		if (Indent)
		{
			titleGroupAttribute.Indent = Indent;
		}
		else
		{
			Indent = titleGroupAttribute.Indent;
		}
	}
}
