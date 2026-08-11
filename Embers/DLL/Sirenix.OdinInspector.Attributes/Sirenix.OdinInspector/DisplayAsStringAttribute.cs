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
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(int fontSize)
	{
		FontSize = fontSize;
	}

	public DisplayAsStringAttribute(bool overflow, TextAlignment alignment)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
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
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		FontSize = fontSize;
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(bool overflow, int fontSize, TextAlignment alignment)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		Overflow = overflow;
		FontSize = fontSize;
		Alignment = alignment;
	}

	public DisplayAsStringAttribute(TextAlignment alignment, bool enableRichText)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
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
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
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
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		FontSize = fontSize;
		Alignment = alignment;
		EnableRichText = enableRichText;
	}

	public DisplayAsStringAttribute(bool overflow, int fontSize, TextAlignment alignment, bool enableRichText)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		Overflow = overflow;
		FontSize = fontSize;
		Alignment = alignment;
		EnableRichText = enableRichText;
	}
}
