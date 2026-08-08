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

	public static int Combine<T1, T2, T3, T4, T5, T6, T7, T8>(T1 value1, T2 value2, T3 value3, T4 value4, T5 value5, T6 value6, T7 value7, T8 value8)
	{
		uint input = (uint)(value1?.GetHashCode() ?? 0);
		uint input2 = (uint)(value2?.GetHashCode() ?? 0);
		uint input3 = (uint)(value3?.GetHashCode() ?? 0);
		uint input4 = (uint)(value4?.GetHashCode() ?? 0);
		uint input5 = (uint)(value5?.GetHashCode() ?? 0);
		uint input6 = (uint)(value6?.GetHashCode() ?? 0);
		uint input7 = (uint)(value7?.GetHashCode() ?? 0);
		uint input8 = (uint)(value8?.GetHashCode() ?? 0);
		Initialize(out var v, out var v2, out var v3, out var v4);
		v = Round(v, input);
		v2 = Round(v2, input2);
		v3 = Round(v3, input3);
		v4 = Round(v4, input4);
		v = Round(v, input5);
		v2 = Round(v2, input6);
		v3 = Round(v3, input7);
		v4 = Round(v4, input8);
		return (int)MixFinal(MixState(v, v2, v3, v4) + 32);
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

	public void Add<T>(T value)
	{
		Add(value?.GetHashCode() ?? 0);
	}

	private void Add(int value)
	{
		uint num = _length++;
		switch (num % 4)
		{
		case 0u:
			_queue1 = (uint)value;
			return;
		case 1u:
			_queue2 = (uint)value;
			return;
		case 2u:
			_queue3 = (uint)value;
			return;
		}
		if (num == 3)
		{
			Initialize(out _v1, out _v2, out _v3, out _v4);
		}
		_v1 = Round(_v1, _queue1);
		_v2 = Round(_v2, _queue2);
		_v3 = Round(_v3, _queue3);
		_v4 = Round(_v4, (uint)value);
	}

	public int ToHashCode()
	{
		uint length = _length;
		uint num = length % 4;
		uint num2 = ((length < 4) ? MixEmptyState() : MixState(_v1, _v2, _v3, _v4));
		num2 += length * 4;
		if (num != 0)
		{
			num2 = QueueRound(num2, _queue1);
			if (num > 1)
			{
				num2 = QueueRound(num2, _queue2);
				if (num > 2)
				{
					num2 = QueueRound(num2, _queue3);
				}
			}
		}
		return (int)MixFinal(num2);
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
