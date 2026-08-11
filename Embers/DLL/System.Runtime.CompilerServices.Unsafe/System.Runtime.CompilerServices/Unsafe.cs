using System.Runtime.Versioning;

namespace System.Runtime.CompilerServices;

public static class Unsafe
{
	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static T Read<T>(void* source)
	{
		return Unsafe.Read<T>(source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static T ReadUnaligned<T>(void* source)
	{
		return Unsafe.ReadUnaligned<T>(source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static T ReadUnaligned<T>(ref byte source)
	{
		return Unsafe.ReadUnaligned<T>(ref source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void Write<T>(void* destination, T value)
	{
		Unsafe.Write(destination, value);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void WriteUnaligned<T>(void* destination, T value)
	{
		Unsafe.WriteUnaligned(destination, value);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static void WriteUnaligned<T>(ref byte destination, T value)
	{
		Unsafe.WriteUnaligned(ref destination, value);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void Copy<T>(void* destination, ref T source)
	{
		Unsafe.Write(destination, source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void Copy<T>(ref T destination, void* source)
	{
		destination = Unsafe.Read<T>(source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void* AsPointer<T>(ref T value)
	{
		return Unsafe.AsPointer(ref value);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static void SkipInit<T>(out T value)
	{
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static int SizeOf<T>()
	{
		return Unsafe.SizeOf<T>();
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void CopyBlock(void* destination, void* source, uint byteCount)
	{
		// IL cpblk instruction
		Unsafe.CopyBlock(destination, source, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static void CopyBlock(ref byte destination, ref byte source, uint byteCount)
	{
		// IL cpblk instruction
		Unsafe.CopyBlock(ref destination, ref source, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void CopyBlockUnaligned(void* destination, void* source, uint byteCount)
	{
		// IL cpblk instruction
		Unsafe.CopyBlockUnaligned(destination, source, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static void CopyBlockUnaligned(ref byte destination, ref byte source, uint byteCount)
	{
		// IL cpblk instruction
		Unsafe.CopyBlockUnaligned(ref destination, ref source, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void InitBlock(void* startAddress, byte value, uint byteCount)
	{
		// IL initblk instruction
		Unsafe.InitBlock(startAddress, value, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static void InitBlock(ref byte startAddress, byte value, uint byteCount)
	{
		// IL initblk instruction
		Unsafe.InitBlock(ref startAddress, value, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void InitBlockUnaligned(void* startAddress, byte value, uint byteCount)
	{
		// IL initblk instruction
		Unsafe.InitBlockUnaligned(startAddress, value, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static void InitBlockUnaligned(ref byte startAddress, byte value, uint byteCount)
	{
		// IL initblk instruction
		Unsafe.InitBlockUnaligned(ref startAddress, value, byteCount);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static T As<T>(object o) where T : class
	{
		return (T)o;
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static ref T AsRef<T>(void* source)
	{
		return ref *(T*)source;
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T AsRef<T>(in T source)
	{
		return ref source;
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref TTo As<TFrom, TTo>(ref TFrom source)
	{
		return ref Unsafe.As<TFrom, TTo>(ref source);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T Unbox<T>(object box) where T : struct
	{
		return ref (T)box;
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T Add<T>(ref T source, int elementOffset)
	{
		return ref Unsafe.Add(ref source, elementOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void* Add<T>(void* source, int elementOffset)
	{
		return (byte*)source + (nint)elementOffset * (nint)Unsafe.SizeOf<T>();
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T Add<T>(ref T source, IntPtr elementOffset)
	{
		return ref Unsafe.Add(ref source, elementOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ref T Add<T>(ref T source, [System.Runtime.Versioning.NonVersionable] nuint elementOffset)
	{
		return ref Unsafe.Add(ref source, elementOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T AddByteOffset<T>(ref T source, IntPtr byteOffset)
	{
		return ref Unsafe.AddByteOffset(ref source, byteOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ref T AddByteOffset<T>(ref T source, [System.Runtime.Versioning.NonVersionable] nuint byteOffset)
	{
		return ref Unsafe.AddByteOffset(ref source, byteOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T Subtract<T>(ref T source, int elementOffset)
	{
		return ref Unsafe.Subtract(ref source, elementOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static void* Subtract<T>(void* source, int elementOffset)
	{
		return (byte*)source - (nint)elementOffset * (nint)Unsafe.SizeOf<T>();
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T Subtract<T>(ref T source, IntPtr elementOffset)
	{
		return ref Unsafe.Subtract(ref source, elementOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ref T Subtract<T>(ref T source, [System.Runtime.Versioning.NonVersionable] nuint elementOffset)
	{
		return ref Unsafe.Subtract(ref source, elementOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static ref T SubtractByteOffset<T>(ref T source, IntPtr byteOffset)
	{
		return ref Unsafe.SubtractByteOffset(ref source, byteOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ref T SubtractByteOffset<T>(ref T source, [System.Runtime.Versioning.NonVersionable] nuint byteOffset)
	{
		return ref Unsafe.SubtractByteOffset(ref source, byteOffset);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static IntPtr ByteOffset<T>(ref T origin, ref T target)
	{
		return Unsafe.ByteOffset(target: ref target, origin: ref origin);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static bool AreSame<T>(ref T left, ref T right)
	{
		return Unsafe.AreSame(ref left, ref right);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static bool IsAddressGreaterThan<T>(ref T left, ref T right)
	{
		return Unsafe.IsAddressGreaterThan(ref left, ref right);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public static bool IsAddressLessThan<T>(ref T left, ref T right)
	{
		return Unsafe.IsAddressLessThan(ref left, ref right);
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static bool IsNullRef<T>(ref T source)
	{
		return Unsafe.AsPointer(ref source) == null;
	}

	[MethodImpl((MethodImplOptions)256)]
	[System.Runtime.Versioning.NonVersionable]
	public unsafe static ref T NullRef<T>()
	{
		return ref *(T*)null;
	}
}
