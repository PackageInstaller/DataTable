using System.Runtime.Versioning;

namespace System.Runtime.CompilerServices;

public static class Unsafe
{
	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static T ReadUnaligned<T>(ref byte source)
	{
		return Unsafe.ReadUnaligned<T>(ref source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref TTo As<TFrom, TTo>(ref TFrom source)
	{
		return ref Unsafe.As<TFrom, TTo>(ref source);
	}
}
