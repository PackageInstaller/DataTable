using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.All)]
public class DescriptionAttribute : Attribute
{
	public readonly string description;

	public DescriptionAttribute(string description)
	{
		this.description = description;
	}
}
