using System;
using UnityEngine;

namespace Ase.Serializing.Helping;

public static class Quaternion64Compression
{
	private const float Maximum = 0.70710653f;

	private const int BitsPerAxis_H = 21;

	private const int BitsPerAxis_L = 20;

	private const int LargestComponentShift = 62;

	private const int AShift = 41;

	private const int BShift = 20;

	private const int IntScale_H = 1048575;

	private const int IntMask_H = 2097151;

	private const int IntScale_L = 524287;

	private const int IntMask_L = 1048575;

	public static ulong Compress(Quaternion quaternion)
	{
		float num = Mathf.Abs(quaternion.x);
		float num2 = Mathf.Abs(quaternion.y);
		float num3 = Mathf.Abs(quaternion.z);
		float num4 = Mathf.Abs(quaternion.w);
		ComponentType componentType = ComponentType.X;
		float num5 = num;
		float num6 = quaternion.x;
		if (num2 > num5)
		{
			num5 = num2;
			componentType = ComponentType.Y;
			num6 = quaternion.y;
		}
		if (num3 > num5)
		{
			num5 = num3;
			componentType = ComponentType.Z;
			num6 = quaternion.z;
		}
		if (num4 > num5)
		{
			componentType = ComponentType.W;
			num6 = quaternion.w;
		}
		float num7 = 0f;
		float num8 = 0f;
		float num9 = 0f;
		switch (componentType)
		{
		case ComponentType.X:
			num7 = quaternion.y;
			num8 = quaternion.z;
			num9 = quaternion.w;
			break;
		case ComponentType.Y:
			num7 = quaternion.x;
			num8 = quaternion.z;
			num9 = quaternion.w;
			break;
		case ComponentType.Z:
			num7 = quaternion.x;
			num8 = quaternion.y;
			num9 = quaternion.w;
			break;
		case ComponentType.W:
			num7 = quaternion.x;
			num8 = quaternion.y;
			num9 = quaternion.z;
			break;
		}
		if (num6 < 0f)
		{
			num7 = 0f - num7;
			num8 = 0f - num8;
			num9 = 0f - num9;
		}
		ulong num10 = ScaleToUint_H(num7);
		ulong num11 = ScaleToUint_H(num8);
		ulong num12 = ScaleToUint_L(num9);
		return ((ulong)componentType << 62) | (num10 << 41) | (num11 << 20) | num12;
	}

	private static ulong ScaleToUint_H(float v)
	{
		return (ulong)Mathf.RoundToInt(v / 0.70710653f * 1048575f) & 0x1FFFFFuL;
	}

	private static ulong ScaleToUint_L(float v)
	{
		return (ulong)Mathf.RoundToInt(v / 0.70710653f * 524287f) & 0xFFFFFuL;
	}

	private static float ScaleToFloat_H(ulong v)
	{
		float num = (float)v * 0.70710653f / 1048575f;
		if (num > 0.70710653f)
		{
			num -= 1.4142131f;
		}
		return num;
	}

	private static float ScaleToFloat_L(ulong v)
	{
		float num = (float)v * 0.70710653f / 524287f;
		if (num > 0.70710653f)
		{
			num -= 1.4142131f;
		}
		return num;
	}

	public static Quaternion Decompress(ulong compressed)
	{
		ComponentType componentType = (ComponentType)(compressed >> 62);
		ulong v = (compressed >> 41) & 0x1FFFFF;
		ulong v2 = (compressed >> 20) & 0x1FFFFF;
		ulong v3 = compressed & 0xFFFFF;
		float num = ScaleToFloat_H(v);
		float num2 = ScaleToFloat_H(v2);
		float num3 = ScaleToFloat_L(v3);
		Quaternion result = default(Quaternion);
		switch (componentType)
		{
		case ComponentType.X:
			result.y = num;
			result.z = num2;
			result.w = num3;
			result.x = Mathf.Sqrt(1f - result.y * result.y - result.z * result.z - result.w * result.w);
			break;
		case ComponentType.Y:
			result.x = num;
			result.z = num2;
			result.w = num3;
			result.y = Mathf.Sqrt(1f - result.x * result.x - result.z * result.z - result.w * result.w);
			break;
		case ComponentType.Z:
			result.x = num;
			result.y = num2;
			result.w = num3;
			result.z = Mathf.Sqrt(1f - result.x * result.x - result.y * result.y - result.w * result.w);
			break;
		case ComponentType.W:
			result.x = num;
			result.y = num2;
			result.z = num3;
			result.w = Mathf.Sqrt(1f - result.x * result.x - result.y * result.y - result.z * result.z);
			break;
		default:
			throw new ArgumentOutOfRangeException("Unknown rotation component type: " + componentType);
		}
		return result;
	}
}
