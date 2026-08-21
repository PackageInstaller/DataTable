using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeType("Runtime/Graphics/RefreshRate.h")]
public struct RefreshRate : IEquatable<RefreshRate>, IComparable<RefreshRate>
{
	public uint numerator;

	public uint denominator;

	public double value
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return (double)numerator / (double)denominator;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(RefreshRate other)
	{
		if (denominator == 0)
		{
			return other.denominator == 0;
		}
		if (other.denominator == 0)
		{
			return false;
		}
		return (long)numerator * (long)other.denominator == (long)denominator * (long)other.numerator;
	}

	[MethodImpl((MethodImplOptions)256)]
	public int CompareTo(RefreshRate other)
	{
		if (denominator == 0)
		{
			return (other.denominator != 0) ? 1 : 0;
		}
		if (other.denominator == 0)
		{
			return -1;
		}
		return ((ulong)numerator * (ulong)other.denominator).CompareTo((ulong)denominator * (ulong)other.numerator);
	}

	public override string ToString()
	{
		return value.ToString(CultureInfo.InvariantCulture.NumberFormat);
	}
}
