using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeType("Runtime/Graphics/RefreshRate.h")]
public struct RefreshRate : IEquatable<RefreshRate>
{
	public uint numerator;

	public uint denominator;

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(RefreshRate other)
	{
		return numerator == other.numerator && denominator == other.denominator;
	}
}
