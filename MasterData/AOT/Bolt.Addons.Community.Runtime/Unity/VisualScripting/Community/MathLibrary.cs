using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

internal static class MathLibrary
{
	private const float Eulers = MathF.E;

	internal static float LinearFunction(float input, float min, float max)
	{
		return Mathf.Lerp(min, max, input);
	}

	internal static float ReverseLinearFunction(float input, float min, float max)
	{
		Mathf.Clamp(input, min, max);
		return Mathf.InverseLerp(min, max, input);
	}

	internal static float LinearFunctionOfRange(float input, float minValue, float maxValue, float minimum, float maximum)
	{
		return LinearFunction(ReverseLinearFunction(input, minValue, maxValue), minValue, maxValue);
	}

	internal static float ExponentialFunction(float value, float minWeight, float exponent, float scale)
	{
		return scale * Mathf.Pow(value, exponent) + minWeight;
	}

	internal static float ExponentialFunctionOfRange(float value, float minValue, float maxValue, float minWeight, float exponent, float scale)
	{
		exponent = Mathf.Max(1f, exponent);
		return ExponentialFunction(ReverseLinearFunction(value, minValue, maxValue), minWeight, exponent, scale);
	}

	internal static float LogarithmicFunction(float value, float minimum, float exponent, float scale)
	{
		exponent = Mathf.Clamp01(exponent);
		return scale * Mathf.Pow(value, exponent) + minimum;
	}

	internal static float LogarithmicFunctionOfRange(float value, float minValue, float maxValue, float minWeight, float exponent, float scale)
	{
		return LogarithmicFunction(ReverseLinearFunction(value, minValue, maxValue), minWeight, exponent, scale);
	}

	internal static float DecayFunction(float value, float minWeight, float decayFactor, float scale)
	{
		value = Mathf.Clamp01(value);
		return scale * Mathf.Pow(decayFactor, value) + minWeight;
	}

	internal static float DecayFunctionOfRange(float value, float minValue, float maxValue, float minWeight, float decayFactor, float scale)
	{
		return DecayFunction(ReverseLinearFunction(value, minValue, maxValue), minWeight, decayFactor, scale);
	}

	internal static float DecayingSigmoid(float value, float inflectionPoint, float minWeight, float decayFactor, float scale)
	{
		value = Mathf.Clamp01(value);
		inflectionPoint = Mathf.Clamp01(inflectionPoint);
		float num = 1f / (1f + Mathf.Pow(MathF.E, decayFactor * (value - inflectionPoint)));
		return scale * num + minWeight;
	}

	internal static float DecayingSigmoidOfRange(float value, float minValue, float maxValue, float inflectionPoint, float minWeight, float decayFactor, float scale)
	{
		float value2 = ReverseLinearFunction(value, minValue, maxValue);
		float inflectionPoint2 = ReverseLinearFunction(inflectionPoint, minValue, maxValue);
		return DecayingSigmoid(value2, inflectionPoint2, minWeight, decayFactor, scale);
	}
}
