using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
public sealed class UnitTitleAttribute : Attribute
{
	public string title { get; private set; }

	public UnitTitleAttribute(string title)
	{
		this.title = title;
	}
}
