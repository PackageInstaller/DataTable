using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class SpaceAttribute : DrawerAttribute
{
	public readonly string title;

	public readonly int space;

	public readonly int spaceAfter;

	public override bool isDecorator => true;

	public SpaceAttribute(int space)
	{
		this.space = space;
	}

	public SpaceAttribute(int space, string title)
	{
		this.space = space;
		this.title = title;
	}

	public SpaceAttribute(int space, string title, int spaceAfter)
	{
		this.space = space;
		this.title = title;
		this.spaceAfter = spaceAfter;
	}
}
