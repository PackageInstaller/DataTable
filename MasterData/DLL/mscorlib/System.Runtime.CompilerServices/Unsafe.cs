namespace System.Runtime.CompilerServices;

internal static class Unsafe
{
	public static ref T Add<T>(ref T source, int elementOffset)
	{
		return ref Unsafe.Add(ref source, elementOffset);
	}

	public static ref T Add<T>(ref T source, IntPtr elementOffset)
	{
		return ref Unsafe.Add(ref source, elementOffset);
	}

	public unsafe static void* Add<T>(void* source, int elementOffset)
	{
		return (byte*)source + (nint)elementOffset * (nint)Unsafe.SizeOf<T>();
	}

	public static ref T AddByteOffset<T>(ref T source, IntPtr byteOffset)
	{
		return ref Unsafe.AddByteOffset(ref source, byteOffset);
	}

	public static bool AreSame<T>(ref T left, ref T right)
	{
		return Unsafe.AreSame(ref left, ref right);
	}

	public static T As<T>(object o) where T : class
	{
		return (T)o;
	}

	public static ref TTo As<TFrom, TTo>(ref TFrom source)
	{
		return ref Unsafe.As<TFrom, TTo>(ref source);
	}

	public unsafe static void* AsPointer<T>(ref T value)
	{
		return Unsafe.AsPointer(ref value);
	}

	public unsafe static ref T AsRef<T>(void* source)
	{
		return ref *(T*)source;
	}

	public static ref T AsRef<T>(in T source)
	{
		return ref source;
	}

	public static void InitBlockUnaligned(ref byte startAddress, byte value, uint byteCount)
	{
		// IL initblk instruction
		Unsafe.InitBlockUnaligned(ref startAddress, value, byteCount);
	}

	public unsafe static T Read<T>(void* source)
	{
		return Unsafe.Read<T>(source);
	}

	public static T ReadUnaligned<T>(ref byte source)
	{
		return Unsafe.ReadUnaligned<T>(ref source);
	}

	public static int SizeOf<T>()
	{
		return Unsafe.SizeOf<T>();
	}

	public static void WriteUnaligned<T>(ref byte destination, T value)
	{
		Unsafe.WriteUnaligned(ref destination, value);
	}

	public static bool IsAddressLessThan<T>(ref T left, ref T right)
	{
		return Unsafe.IsAddressLessThan(ref left, ref right);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal unsafe static ref T AddByteOffset<T>(ref T source, ulong byteOffset)
	{
		return ref AddByteOffset(ref source, (IntPtr)(void*)byteOffset);
	}
}
