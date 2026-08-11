using System;
using System.ComponentModel;
using System.Diagnostics;
using UnityEngine;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class ProgressBarAttribute : Attribute
{
	public double Min;

	public double Max;

	public string MinGetter;

	public string MaxGetter;

	public float R;

	public float G;

	public float B;

	public int Height;

	public string ColorGetter;

	public string BackgroundColorGetter;

	public bool Segmented;

	public string CustomValueStringGetter;

	private bool drawValueLabel;

	private TextAlignment valueLabelAlignment;

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use the MinGetter member instead.", false)]
	public string MinMember
	{
		get
		{
			return MinGetter;
		}
		set
		{
			MinGetter = value;
		}
	}

	[Obsolete("Use the MaxGetter member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string MaxMember
	{
		get
		{
			return MaxGetter;
		}
		set
		{
			MaxGetter = value;
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use the ColorGetter member instead.", false)]
	public string ColorMember
	{
		get
		{
			return ColorGetter;
		}
		set
		{
			ColorGetter = value;
		}
	}

	[Obsolete("Use the BackgroundColorGetter member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string BackgroundColorMember
	{
		get
		{
			return BackgroundColorGetter;
		}
		set
		{
			BackgroundColorGetter = value;
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use the CustomValueStringGetter member instead.", false)]
	public string CustomValueStringMember
	{
		get
		{
			return CustomValueStringGetter;
		}
		set
		{
			CustomValueStringGetter = value;
		}
	}

	public bool DrawValueLabel
	{
		get
		{
			return drawValueLabel;
		}
		set
		{
			drawValueLabel = value;
			DrawValueLabelHasValue = true;
		}
	}

	public bool DrawValueLabelHasValue { get; private set; }

	public TextAlignment ValueLabelAlignment
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return valueLabelAlignment;
		}
		set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			valueLabelAlignment = value;
			ValueLabelAlignmentHasValue = true;
		}
	}

	public bool ValueLabelAlignmentHasValue { get; private set; }

	public Color Color => new Color(R, G, B, 1f);

	public ProgressBarAttribute(double min, double max, float r = 0.15f, float g = 0.47f, float b = 0.74f)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		Min = min;
		Max = max;
		R = r;
		G = g;
		B = b;
		Height = 12;
		Segmented = false;
		drawValueLabel = true;
		DrawValueLabelHasValue = false;
		valueLabelAlignment = (TextAlignment)1;
		ValueLabelAlignmentHasValue = false;
	}

	public ProgressBarAttribute(string minGetter, double max, float r = 0.15f, float g = 0.47f, float b = 0.74f)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		MinGetter = minGetter;
		Max = max;
		R = r;
		G = g;
		B = b;
		Height = 12;
		Segmented = false;
		drawValueLabel = true;
		DrawValueLabelHasValue = false;
		valueLabelAlignment = (TextAlignment)1;
		ValueLabelAlignmentHasValue = false;
	}

	public ProgressBarAttribute(double min, string maxGetter, float r = 0.15f, float g = 0.47f, float b = 0.74f)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		Min = min;
		MaxGetter = maxGetter;
		R = r;
		G = g;
		B = b;
		Height = 12;
		Segmented = false;
		drawValueLabel = true;
		DrawValueLabelHasValue = false;
		valueLabelAlignment = (TextAlignment)1;
		ValueLabelAlignmentHasValue = false;
	}

	public ProgressBarAttribute(string minGetter, string maxGetter, float r = 0.15f, float g = 0.47f, float b = 0.74f)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		MinGetter = minGetter;
		MaxGetter = maxGetter;
		R = r;
		G = g;
		B = b;
		Height = 12;
		Segmented = false;
		drawValueLabel = true;
		DrawValueLabelHasValue = false;
		valueLabelAlignment = (TextAlignment)1;
		ValueLabelAlignmentHasValue = false;
	}
}
