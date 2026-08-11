using System;

namespace Spine;

public class Pow : IInterpolation
{
	public float Power { get; set; }

	public Pow(float power)
	{
		Power = power;
	}

	protected override float Apply(float a)
	{
		if (a <= 0.5f)
		{
			return (float)Math.Pow(a * 2f, Power) / 2f;
		}
		return (float)Math.Pow((a - 1f) * 2f, Power) / (float)((Power % 2f == 0f) ? (-2) : 2) + 1f;
	}
}
