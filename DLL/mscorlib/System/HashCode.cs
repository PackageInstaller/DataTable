using System.Runtime.CompilerServices;

namespace System;

public struct HashCode
{
	private static readonly uint s_seed = GenerateGlobalSeed();

	private uint _v1;

	private uint _v2;

	private uint _v3;

	private uint _v4;

	private uint _queue1;

	private uint _queue2;

	private uint _queue3;

	private uint _length;

	private unsafe static uint GenerateGlobalSeed()
	{
		uint result = default(uint);
		Interop.GetRandomBytes((byte*)(&result), 4);
		return result;
	}

	public static int Combine<T1, T2>(T1 value1, T2 value2)
	{
		uint queuedValue = (uint)(value1?.GetHashCode() ?? 0);
		uint queuedValue2 = (uint)(value2?.GetHashCode() ?? 0);
		return (int)MixFinal(QueueRound(QueueRound(MixEmptyState() + 8, queuedValue), queuedValue2));
	}

	public static int Combine<T1, T2, T3, T4>(T1 value1, T2 value2, T3 value3, T4 value4)
	{
		uint input = (uint)(value1?.GetHashCode() ?? 0);
		uint input2 = (uint)(value2?.GetHashCode() ?? 0);
		uint input3 = (uint)(value3?.GetHashCode() ?? 0);
		uint input4 = (uint)(value4?.GetHashCode() ?? 0);
		Initialize(out var v, out var v2, out var v3, out var v4);
		v = Round(v, input);
		v2 = Round(v2, input2);
		v3 = Round(v3, input3);
		v4 = Round(v4, input4);
		return (int)MixFinal(MixState(v, v2, v3, v4) + 16);
	}

	public static int Combine<T1, T2, T3, T4, T5>(T1 value1, T2 value2, T3 value3, T4 value4, T5 value5)
	{
		uint input = (uint)(value1?.GetHashCode() ?? 0);
		uint input2 = (uint)(value2?.GetHashCode() ?? 0);
		uint input3 = (uint)(value3?.GetHashCode() ?? 0);
		uint input4 = (uint)(value4?.GetHashCode() ?? 0);
		uint queuedValue = (uint)(value5?.GetHashCode() ?? 0);
		Initialize(out var v, out var v2, out var v3, out var v4);
		v = Round(v, input);
		v2 = Round(v2, input2);
		v3 = Round(v3, input3);
		v4 = Round(v4, input4);
		return (int)MixFinal(QueueRound(MixState(v, v2, v3, v4) + 20, queuedValue));
	}

	[MethodImpl((MethodImplOptions)256)]
	private static uint Rol(uint value, int count)
	{
		return (value << count) | (value >> 32 - count);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void Initialize(out uint v1, out uint v2, out uint v3, out uint v4)
	{
		v1 = (uint)((int)s_seed + -1640531535 + -2048144777);
		v2 = s_seed + 2246822519u;
		v3 = s_seed;
		v4 = s_seed - 2654435761u;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static uint Round(uint hash, uint input)
	{
		hash += (uint)((int)input * -2048144777);
		hash = Rol(hash, 13);
		hash *= 2654435761u;
		return hash;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static uint QueueRound(uint hash, uint queuedValue)
	{
		hash += (uint)((int)queuedValue * -1028477379);
		return Rol(hash, 17) * 668265263;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static uint MixState(uint v1, uint v2, uint v3, uint v4)
	{
		return Rol(v1, 1) + Rol(v2, 7) + Rol(v3, 12) + Rol(v4, 18);
	}

	private static uint MixEmptyState()
	{
		return s_seed + 374761393;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static uint MixFinal(uint hash)
	{
		hash ^= hash >> 15;
		hash *= 2246822519u;
		hash ^= hash >> 13;
		hash *= 3266489917u;
		hash ^= hash >> 16;
		return hash;
	}

	[Obsolete("HashCode is a mutable struct and should not be compared with other HashCodes. Use ToHashCode to retrieve the computed hash code.", true)]
	public override int GetHashCode()
	{
		throw new NotSupportedException("HashCode is a mutable struct and should not be compared with other HashCodes. Use ToHashCode to retrieve the computed hash code.");
	}

	[Obsolete("HashCode is a mutable struct and should not be compared with other HashCodes.", true)]
	public override bool Equals(object obj)
	{
		throw new NotSupportedException("HashCode is a mutable struct and should not be compared with other HashCodes.");
	}
}
