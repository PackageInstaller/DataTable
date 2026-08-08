using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Class)]
public class ColorAttribute : Attribute
{
	public readonly string hexColor;

	public ColorAttribute(string hexColor)
	{
		this.hexColor = hexColor;
	}
}
