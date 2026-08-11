using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class HeaderAttribute : DrawerAttribute
{
	public readonly string title;

	public override bool isDecorator => true;

	public HeaderAttribute(string title)
	{
		this.title = title;
	}
}
