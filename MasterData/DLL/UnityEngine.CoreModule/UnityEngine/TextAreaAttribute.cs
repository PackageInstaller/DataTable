using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public sealed class TextAreaAttribute : PropertyAttribute
{
	public readonly int minLines;

	public readonly int maxLines;

	public TextAreaAttribute()
	{
		minLines = 3;
		maxLines = 3;
	}

	public TextAreaAttribute(int minLines, int maxLines)
	{
		this.minLines = minLines;
		this.maxLines = maxLines;
	}
}
