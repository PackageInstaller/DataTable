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
	public static Span<TTo> Cast<TFrom, TTo>(Span<TFrom> span) where TFrom : struct where TTo : struct
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<TFrom>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(TFrom));
		}
		if (RuntimeHelpers.IsReferenceOrContainsReferences<TTo>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(TTo));
		}
		uint num = (uint)Unsafe.SizeOf<TFrom>();
		uint num2 = (uint)Unsafe.SizeOf<TTo>();
		uint length = (uint)span.Length;
		return new Span<TTo>(length: (num == num2) ? ((int)length) : ((num != 1) ? checked((int)unchecked((ulong)((long)length * (long)num) / (ulong)num2)) : ((int)(length / num2))), ptr: ref Unsafe.As<TFrom, TTo>(ref span._pointer.Value));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ReadOnlySpan<TTo> Cast<TFrom, TTo>(ReadOnlySpan<TFrom> span) where TFrom : struct where TTo : struct
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<TFrom>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(TFrom));
		}
		if (RuntimeHelpers.IsReferenceOrContainsReferences<TTo>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(TTo));
		}
		uint num = (uint)Unsafe.SizeOf<TFrom>();
		uint num2 = (uint)Unsafe.SizeOf<TTo>();
		uint length = (uint)span.Length;
		return new ReadOnlySpan<TTo>(length: (num == num2) ? ((int)length) : ((num != 1) ? checked((int)unchecked((ulong)((long)length * (long)num) / (ulong)num2)) : ((int)(length / num2))), ptr: ref Unsafe.As<TFrom, TTo>(ref GetReference(span)));
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
}
