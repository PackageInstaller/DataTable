using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class PropertyRangeAttribute : Attribute
{
	public double Min;

	public double Max;

	public string MinGetter;

	public string MaxGetter;

	[Obsolete("Use the MinGetter member instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
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

	public PropertyRangeAttribute(double min, double max)
	{
		Min = ((min < max) ? min : max);
		Max = ((max > min) ? max : min);
	}

	public PropertyRangeAttribute(string minGetter, double max)
	{
		MinGetter = minGetter;
		Max = max;
	}

	public PropertyRangeAttribute(double min, string maxGetter)
	{
		Min = min;
		MaxGetter = maxGetter;
	}

	public PropertyRangeAttribute(string minGetter, string maxGetter)
	{
		MinGetter = minGetter;
		MaxGetter = maxGetter;
	}
}
