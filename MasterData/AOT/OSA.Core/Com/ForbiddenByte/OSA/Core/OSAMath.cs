using System;
using Com.ForbiddenByte.OSA.Core.Data.Animations;

namespace Com.ForbiddenByte.OSA.Core;

public class OSAMath
{
	public static double Lerp_SinSlowOut(double t01)
	{
		return Math.Sin(t01 * Math.PI / 2.0);
	}

	public static double Lerp_SqrtFastInSlowOut(double t01)
	{
		return Math.Sqrt(t01);
	}

	public static double Lerp_ExpSlowInOut(double t01)
	{
		return t01 * t01 * (3.0 - 2.0 * t01);
	}

	public static double Lerp_Linear(double t01)
	{
		return t01;
	}

	public static Func<double, double> GetLerpFunction(AnimationFunctionType animationFunctionType)
	{
		return animationFunctionType switch
		{
			AnimationFunctionType.LINEAR => (Func<double, double>)Lerp_Linear, 
			AnimationFunctionType.SLOW_OUT => Lerp_SinSlowOut, 
			AnimationFunctionType.FAST_IN_SLOW_OUT => Lerp_SqrtFastInSlowOut, 
			AnimationFunctionType.SLOW_IN_OUT => Lerp_ExpSlowInOut, 
			_ => throw new OSAException("AnimationFunctionType not handled: " + animationFunctionType), 
		};
	}
}
