using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class MinValueAttribute : DrawerAttribute
{
	public readonly float min;

	public override int priority => 5;

	public MinValueAttribute(float min)
	{
		this.min = min;
	}

	public MinValueAttribute(int min)
	{
		this.min = min;
	}
}
