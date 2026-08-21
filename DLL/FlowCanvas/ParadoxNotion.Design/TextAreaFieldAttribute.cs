using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class TextAreaFieldAttribute : DrawerAttribute
{
	public readonly int numberOfLines;

	public TextAreaFieldAttribute(int numberOfLines)
	{
		this.numberOfLines = numberOfLines;
	}
}
