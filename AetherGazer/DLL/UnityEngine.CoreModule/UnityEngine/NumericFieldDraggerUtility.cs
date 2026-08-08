using System;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine;

[MovedFrom("UnityEditor")]
internal class NumericFieldDraggerUtility
{
	private static bool s_UseYSign;

	internal static float Acceleration(bool shiftPressed, bool altPressed)
	{
		return (float)((!shiftPressed) ? 1 : 4) * (altPressed ? 0.25f : 1f);
	}

	internal static float NiceDelta(Vector2 deviceDelta, float acceleration)
	{
		deviceDelta.y = 0f - deviceDelta.y;
		if (Mathf.Abs(Mathf.Abs(deviceDelta.x) - Mathf.Abs(deviceDelta.y)) / Mathf.Max(Mathf.Abs(deviceDelta.x), Mathf.Abs(deviceDelta.y)) > 0.1f)
		{
			if (Mathf.Abs(deviceDelta.x) > Mathf.Abs(deviceDelta.y))
			{
				s_UseYSign = false;
			}
			else
			{
				s_UseYSign = true;
			}
		}
		if (s_UseYSign)
		{
			return Mathf.Sign(deviceDelta.y) * deviceDelta.magnitude * acceleration;
		}
		return Mathf.Sign(deviceDelta.x) * deviceDelta.magnitude * acceleration;
	}

	internal static double CalculateFloatDragSensitivity(double value)
	{
		if (double.IsInfinity(value) || double.IsNaN(value))
		{
			return 0.0;
		}
		return Math.Max(1.0, Math.Pow(Math.Abs(value), 0.5)) * 0.029999999329447746;
	}

	internal static double CalculateFloatDragSensitivity(double value, double minValue, double maxValue)
	{
		if (double.IsInfinity(value) || double.IsNaN(value))
		{
			return 0.0;
		}
		double num = Math.Abs(maxValue - minValue);
		return num / 100.0 * 0.029999999329447746;
	}

	internal static long CalculateIntDragSensitivity(long value)
	{
		return (long)CalculateIntDragSensitivity((double)value);
	}

	internal static ulong CalculateIntDragSensitivity(ulong value)
	{
		return (ulong)CalculateIntDragSensitivity((double)value);
	}

	private static double CalculateIntDragSensitivity(double value)
	{
		return Math.Max(1.0, Math.Pow(Math.Abs(value), 0.5) * 0.029999999329447746);
	}

	internal static long CalculateIntDragSensitivity(long value, long minValue, long maxValue)
	{
		long num = Math.Abs(maxValue - minValue);
		return Math.Max(1L, (long)(0.03f * (float)num / 100f));
	}
}
