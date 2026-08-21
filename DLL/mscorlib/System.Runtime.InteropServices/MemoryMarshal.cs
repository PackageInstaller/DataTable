using System.Buffers;
using System.Runtime.CompilerServices;

namespace System.Runtime.InteropServices;

public static class MemoryMarshal
{
	[MethodImpl((MethodImplOptions)256)]
	public static Span<byte> AsBytes<T>(Span<T> span) where T : struct
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(T));
		}
		return new Span<byte>(ref Unsafe.As<T, byte>(ref GetReference(span)), checked(span.Length * Unsafe.SizeOf<T>()));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ReadOnlySpan<byte> AsBytes<T>(ReadOnlySpan<T> span) where T : struct
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(T));
		}
		return new ReadOnlySpan<byte>(ref Unsafe.As<T, byte>(ref GetReference(span)), checked(span.Length * Unsafe.SizeOf<T>()));
	}

	public static Memory<T> AsMemory<T>(ReadOnlyMemory<T> memory)
	{
		return Unsafe.As<ReadOnlyMemory<T>, Memory<T>>(ref memory);
	}

	public static ref T GetReference<T>(Span<T> span)
	{
		return ref span._pointer.Value;
	}

	public static ref T GetReference<T>(ReadOnlySpan<T> span)
	{
		return ref span._pointer.Value;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal unsafe static ref T GetNonNullPinnableReference<T>(Span<T> span)
	{
		if (span.Length == 0)
		{
			return ref Unsafe.AsRef<T>((void*)1);
		}
		return ref span._pointer.Value;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal unsafe static ref T GetNonNullPinnableReference<T>(ReadOnlySpan<T> span)
	{
		if (span.Length == 0)
		{
			return ref Unsafe.AsRef<T>((void*)1);
		}
		return ref span._pointer.Value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Span<T> CreateSpan<T>(ref T reference, int length)
	{
		return new Span<T>(ref reference, length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ReadOnlySpan<T> CreateReadOnlySpan<T>(ref T reference, int length)
	{
		return new ReadOnlySpan<T>(ref reference, length);
	}

	public static bool TryGetArray<T>(ReadOnlyMemory<T> memory, out ArraySegment<T> segment)
	{
		object objectStartLength = memory.GetObjectStartLength(out var start, out var length);
		if (start < 0)
		{
			if (((MemoryManager<T>)objectStartLength).TryGetArray(out var segment2))
			{
				segment = new ArraySegment<T>(segment2.Array, segment2.Offset + (start & 0x7FFFFFFF), length);
				return true;
			}
		}
		else if (objectStartLength is T[] array)
		{
			segment = new ArraySegment<T>(array, start, length & 0x7FFFFFFF);
			return true;
		}
		if ((length & 0x7FFFFFFF) == 0)
		{
			segment = ArraySegment<T>.Empty;
			return true;
		}
		segment = default(ArraySegment<T>);
		return false;
	}

	public static bool TryGetMemoryManager<T, TManager>(ReadOnlyMemory<T> memory, out TManager manager, out int start, out int length) where TManager : MemoryManager<T>
	{
		TManager val = (manager = memory.GetObjectStartLength(out start, out length) as TManager);
		start &= int.MaxValue;
		if (manager == null)
		{
			start = 0;
			length = 0;
			return false;
		}
		return true;
	}

	public static bool TryGetString(ReadOnlyMemory<char> memory, out string text, out int start, out int length)
	{
		if (memory.GetObjectStartLength(out var start2, out var length2) is string text2)
		{
			text = text2;
			start = start2;
			length = length2;
			return true;
		}
		text = null;
		start = 0;
		length = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void Write<T>(Span<byte> destination, ref T value) where T : struct
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(T));
		}
		if ((uint)Unsafe.SizeOf<T>() > (uint)destination.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.length);
		}
		Unsafe.WriteUnaligned(ref GetReference(destination), value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool TryWrite<T>(Span<byte> destination, ref T value) where T : struct
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(T));
		}
		if (Unsafe.SizeOf<T>() > (uint)destination.Length)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref GetReference(destination), value);
		return true;
	}
}
