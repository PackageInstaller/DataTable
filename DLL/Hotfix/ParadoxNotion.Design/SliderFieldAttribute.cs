using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class SliderFieldAttribute : DrawerAttribute
{
	public readonly float min;

	public readonly float max;

	public SliderFieldAttribute(float min, float max)
	{
		this.min = min;
		this.max = max;
	}

	public SliderFieldAttribute(int min, int max)
	{
		this.min = min;
		this.max = max;
	}
}
