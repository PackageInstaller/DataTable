using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[NativeHeader("Runtime/Export/Hashing/Hash128.bindings.h")]
[NativeHeader("Runtime/Utilities/Hash128.h")]
[UsedByNativeCode]
public struct Hash128 : IComparable, IComparable<Hash128>, IEquatable<Hash128>
{
	internal ulong u64_0;

	internal ulong u64_1;

	private const ulong kConst = 16045690984833335023uL;

	public Hash128(uint u32_0, uint u32_1, uint u32_2, uint u32_3)
	{
		u64_0 = ((ulong)u32_1 << 32) | u32_0;
		u64_1 = ((ulong)u32_3 << 32) | u32_2;
	}

	public Hash128(ulong u64_0, ulong u64_1)
	{
		this.u64_0 = u64_0;
		this.u64_1 = u64_1;
	}

	public int CompareTo(Hash128 rhs)
	{
		if (this < rhs)
		{
			return -1;
		}
		if (this > rhs)
		{
			return 1;
		}
		return 0;
	}

	public override string ToString()
	{
		return Hash128ToStringImpl(this);
	}

	[FreeFunction("StringToHash128", IsThreadSafe = true)]
	public static Hash128 Parse(string hashString)
	{
		Parse_Injected(hashString, out var ret);
		return ret;
	}

	[FreeFunction("Hash128ToString", IsThreadSafe = true)]
	private static string Hash128ToStringImpl(Hash128 hash)
	{
		return Hash128ToStringImpl_Injected(ref hash);
	}

	public override bool Equals(object obj)
	{
		return obj is Hash128 && this == (Hash128)obj;
	}

	public bool Equals(Hash128 obj)
	{
		return this == obj;
	}

	public override int GetHashCode()
	{
		return u64_0.GetHashCode() ^ u64_1.GetHashCode();
	}

	public int CompareTo(object obj)
	{
		if (obj == null || !(obj is Hash128))
		{
			return 1;
		}
		Hash128 rhs = (Hash128)obj;
		return CompareTo(rhs);
	}

	public static bool operator ==(Hash128 hash1, Hash128 hash2)
	{
		return hash1.u64_0 == hash2.u64_0 && hash1.u64_1 == hash2.u64_1;
	}

	public static bool operator <(Hash128 x, Hash128 y)
	{
		if (x.u64_0 != y.u64_0)
		{
			return x.u64_0 < y.u64_0;
		}
		return x.u64_1 < y.u64_1;
	}

	public static bool operator >(Hash128 x, Hash128 y)
	{
		if (x < y)
		{
			return false;
		}
		if (x == y)
		{
			return false;
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Parse_Injected(string hashString, out Hash128 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string Hash128ToStringImpl_Injected(ref Hash128 hash);
}
