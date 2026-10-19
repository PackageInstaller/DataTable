using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public sealed class UnitSubtitleAttribute : Attribute
{
	public string subtitle { get; private set; }

	public UnitSubtitleAttribute(string subtitle)
	{
		this.subtitle = subtitle;
	}
}
