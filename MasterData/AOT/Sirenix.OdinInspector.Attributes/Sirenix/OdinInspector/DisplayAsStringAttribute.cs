using System;
using System.Diagnostics;
using UnityEngine;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class DisplayAsStringAttribute : Attribute
{
	public bool Overflow;

	public TextAlignment Alignment;

	public int FontSize;

	public bool EnableRichText;

	public string Format;

	public DisplayAsStringAttribute()
	{
		Overflow = true;
	}

	public DisplayAsStringAttribute(bool overflow)
	{
		Overflow = overflow;
	}

	public DisplayAsStringAttribute(TextAlignment alignment)
	{
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(int fontSize)
	{
		FontSize = fontSize;
	}

	public DisplayAsStringAttribute(bool overflow, TextAlignment alignment)
	{
		Overflow = overflow;
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(bool overflow, int fontSize)
	{
		Overflow = overflow;
		FontSize = fontSize;
	}

	public DisplayAsStringAttribute(int fontSize, TextAlignment alignment)
	{
		FontSize = fontSize;
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(bool overflow, int fontSize, TextAlignment alignment)
	{
		Overflow = overflow;
		FontSize = fontSize;
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(TextAlignment alignment, bool enableRichText)
	{
		Alignment = alignment;
		EnableRichText = enableRichText;
	}

	public DisplayAsStringAttribute(int fontSize, bool enableRichText)
	{
		FontSize = fontSize;
		EnableRichText = enableRichText;
	}

	public DisplayAsStringAttribute(bool overflow, TextAlignment alignment, bool enableRichText)
	{
		Overflow = overflow;
		Alignment = alignment;
		EnableRichText = enableRichText;
	}

	public DisplayAsStringAttribute(bool overflow, int fontSize, bool enableRichText)
	{
		Overflow = overflow;
		FontSize = fontSize;
		EnableRichText = enableRichText;
	}

	public DisplayAsStringAttribute(int fontSize, TextAlignment alignment, bool enableRichText)
	{
		FontSize = fontSize;
		Alignment = alignment;
		EnableRichText = enableRichText;
	}

	public DisplayAsStringAttribute(bool overflow, int fontSize, TextAlignment alignment, bool enableRichText)
	{
		Overflow = overflow;
		FontSize = fontSize;
		Alignment = alignment;
		EnableRichText = enableRichText;
	}
}
