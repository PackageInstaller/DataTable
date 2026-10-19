using System;
using System.ComponentModel;

namespace Sirenix.Serialization;

[Obsolete("Use a RegisterFormatterAttribute applied to the containing assembly instead.", true)]
[AttributeUsage(AttributeTargets.Class)]
[EditorBrowsable(EditorBrowsableState.Never)]
public class CustomFormatterAttribute : Attribute
{
	public readonly int Priority;

	public CustomFormatterAttribute()
	{
		Priority = 0;
	}

	public CustomFormatterAttribute(int priority = 0)
	{
		Priority = priority;
	}
}
