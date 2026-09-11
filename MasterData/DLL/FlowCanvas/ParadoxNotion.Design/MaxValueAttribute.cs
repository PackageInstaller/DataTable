using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class MaxValueAttribute : DrawerAttribute
{
	public readonly float max;

	public override int priority => 3;

	public MaxValueAttribute(float max)
	{
		this.max = max;
	}

	public MaxValueAttribute(int max)
	{
		this.max = max;
	}
}
