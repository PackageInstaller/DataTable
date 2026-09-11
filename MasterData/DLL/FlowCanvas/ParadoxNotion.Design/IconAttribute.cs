using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Class)]
public class IconAttribute : Attribute
{
	public readonly string iconName;

	public readonly bool fixedColor;

	public readonly string runtimeIconTypeCallback;

	public readonly Type fromType;

	public IconAttribute(string iconName = "", bool fixedColor = false, string runtimeIconTypeCallback = "")
	{
		this.iconName = iconName;
		this.fixedColor = fixedColor;
		this.runtimeIconTypeCallback = runtimeIconTypeCallback;
	}

	public IconAttribute(Type fromType)
	{
		this.fromType = fromType;
	}
}
