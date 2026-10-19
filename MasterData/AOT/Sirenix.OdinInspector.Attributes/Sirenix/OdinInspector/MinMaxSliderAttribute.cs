using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class MinMaxSliderAttribute : Attribute
{
	public float MinValue;

	public float MaxValue;

	public string MinValueGetter;

	public string MaxValueGetter;

	public string MinMaxValueGetter;

	public bool ShowFields;

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use the MinValueGetter member instead.", false)]
	public string MinMember
	{
		get
		{
			return MinValueGetter;
		}
		set
		{
			MinValueGetter = value;
		}
	}

	[Obsolete("Use the MaxValueGetter member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string MaxMember
	{
		get
		{
			return MaxValueGetter;
		}
		set
		{
			MaxValueGetter = value;
		}
	}

	[Obsolete("Use the MinMaxValueGetter member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string MinMaxMember
	{
		get
		{
			return MinMaxValueGetter;
		}
		set
		{
			MinMaxValueGetter = value;
		}
	}

	public MinMaxSliderAttribute(float minValue, float maxValue, bool showFields = false)
	{
		MinValue = minValue;
		MaxValue = maxValue;
		ShowFields = showFields;
	}

	public MinMaxSliderAttribute(string minValueGetter, float maxValue, bool showFields = false)
	{
		MinValueGetter = minValueGetter;
		MaxValue = maxValue;
		ShowFields = showFields;
	}

	public MinMaxSliderAttribute(float minValue, string maxValueGetter, bool showFields = false)
	{
		MinValue = minValue;
		MaxValueGetter = maxValueGetter;
		ShowFields = showFields;
	}

	public MinMaxSliderAttribute(string minValueGetter, string maxValueGetter, bool showFields = false)
	{
		MinValueGetter = minValueGetter;
		MaxValueGetter = maxValueGetter;
		ShowFields = showFields;
	}

	public MinMaxSliderAttribute(string minMaxValueGetter, bool showFields = false)
	{
		MinMaxValueGetter = minMaxValueGetter;
		ShowFields = showFields;
	}
}
