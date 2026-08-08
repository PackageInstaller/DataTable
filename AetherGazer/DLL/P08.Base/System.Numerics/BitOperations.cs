using System.Runtime.CompilerServices;

namespace System.Numerics;

internal static class BitOperations
{
	[MethodImpl((MethodImplOptions)256)]
	public static uint RotateLeft(uint value, int offset)
	{
		return (value << offset) | (value >> 32 - offset);
	}
}
