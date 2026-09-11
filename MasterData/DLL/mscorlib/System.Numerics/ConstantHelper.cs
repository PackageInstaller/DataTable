using System.Runtime.CompilerServices;

namespace System.Numerics;

internal class ConstantHelper
{
	[MethodImpl((MethodImplOptions)256)]
	public static byte GetByteWithAllBitsSet()
	{
		byte result = 0;
		result = byte.MaxValue;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static sbyte GetSByteWithAllBitsSet()
	{
		sbyte result = 0;
		result = -1;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ushort GetUInt16WithAllBitsSet()
	{
		ushort result = 0;
		result = ushort.MaxValue;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static short GetInt16WithAllBitsSet()
	{
		short result = 0;
		result = -1;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static uint GetUInt32WithAllBitsSet()
	{
		uint result = 0u;
		result = uint.MaxValue;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int GetInt32WithAllBitsSet()
	{
		int result = 0;
		result = -1;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ulong GetUInt64WithAllBitsSet()
	{
		ulong result = 0uL;
		result = ulong.MaxValue;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static long GetInt64WithAllBitsSet()
	{
		long result = 0L;
		result = -1L;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static float GetSingleWithAllBitsSet()
	{
		float result = 0f;
		*(int*)(&result) = -1;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static double GetDoubleWithAllBitsSet()
	{
		double result = 0.0;
		*(long*)(&result) = -1L;
		return result;
	}
}
