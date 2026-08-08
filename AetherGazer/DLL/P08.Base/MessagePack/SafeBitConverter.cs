using System;
using System.Runtime.InteropServices;

namespace MessagePack;

internal static class SafeBitConverter
{
	internal static long ToInt64(ReadOnlySpan<byte> value)
	{
		return MemoryMarshal.Cast<byte, long>(value)[0];
	}

	internal static ulong ToUInt64(ReadOnlySpan<byte> value)
	{
		return (ulong)ToInt64(value);
	}

	internal static ushort ToUInt16(ReadOnlySpan<byte> value)
	{
		return MemoryMarshal.Cast<byte, ushort>(value)[0];
	}

	internal static uint ToUInt32(ReadOnlySpan<byte> value)
	{
		return MemoryMarshal.Cast<byte, uint>(value)[0];
	}
}
