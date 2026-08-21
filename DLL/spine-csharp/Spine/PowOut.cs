using System;

namespace Spine;

public class PowOut : Pow
{
	public PowOut(float power)
		: base(power)
	{
	}

	protected override float Apply(float a)
	{
		return (float)Math.Pow(a - 1f, base.Power) * (float)((base.Power % 2f != 0f) ? 1 : (-1)) + 1f;
	}
}
