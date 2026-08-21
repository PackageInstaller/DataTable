using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Versioning;

namespace System;

[DebuggerTypeProxy(typeof(SpanDebugView<>))]
[DebuggerDisplay("{ToString(),raw}")]
[NonVersionable]
public readonly ref struct Span<T>
{
	internal readonly ByReference<T> _pointer;

	private readonly int _length;

	public ref T this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		[NonVersionable]
		[Intrinsic]
		get
		{
			if ((uint)index >= (uint)_length)
			{
				ThrowHelper.ThrowIndexOutOfRangeException();
			}
			return ref Unsafe.Add(ref _pointer.Value, index);
		}
	}

	public int Length
	{
		[NonVersionable]
		get
		{
			return _length;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Span(T[] array)
	{
		if (array == null)
		{
			this = default(Span<T>);
			return;
		}
		if (default(T) == null && array.GetType() != typeof(T[]))
		{
			ThrowHelper.ThrowArrayTypeMismatchException();
		}
		_pointer = new ByReference<T>(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()));
		_length = array.Length;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Span(T[] array, int start, int length)
	{
		if (array == null)
		{
			if (start != 0 || length != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException();
			}
			this = default(Span<T>);
			return;
		}
		if (default(T) == null && array.GetType() != typeof(T[]))
		{
			ThrowHelper.ThrowArrayTypeMismatchException();
		}
		if ((uint)start > (uint)array.Length || (uint)length > (uint)(array.Length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		_pointer = new ByReference<T>(ref Unsafe.Add(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()), start));
		_length = length;
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public unsafe Span(void* pointer, int length)
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			ThrowHelper.ThrowInvalidTypeWithPointersNotSupported(typeof(T));
		}
		if (length < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		_pointer = new ByReference<T>(ref Unsafe.As<byte, T>(ref *(byte*)pointer));
		_length = length;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal Span(ref T ptr, int length)
	{
		_pointer = new ByReference<T>(ref ptr);
		_length = length;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Clear()
	{
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			SpanHelpers.ClearWithReferences(ref Unsafe.As<T, IntPtr>(ref _pointer.Value), (ulong)_length * (ulong)(Unsafe.SizeOf<T>() / IntPtr.Size));
		}
		else
		{
			SpanHelpers.ClearWithoutReferences(ref Unsafe.As<T, byte>(ref _pointer.Value), (ulong)_length * (ulong)Unsafe.SizeOf<T>());
		}
	}

	public void Fill(T value)
	{
		ByReference<T> pointer;
		if (Unsafe.SizeOf<T>() == 1)
		{
			uint length = (uint)_length;
			if (length != 0)
			{
				T source = value;
				pointer = _pointer;
				Unsafe.InitBlockUnaligned(ref Unsafe.As<T, byte>(ref pointer.Value), Unsafe.As<T, byte>(ref source), length);
			}
			return;
		}
		ulong num = (uint)_length;
		if (num != 0L)
		{
			pointer = _pointer;
			ref T value2 = ref pointer.Value;
			ulong num2 = (uint)Unsafe.SizeOf<T>();
			ulong num3;
			for (num3 = 0uL; num3 < (num & 0xFFFFFFFFFFFFFFF8uL); num3 += 8)
			{
				Unsafe.AddByteOffset(ref value2, num3 * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 1) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 2) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 3) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 4) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 5) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 6) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 7) * num2) = value;
			}
			if (num3 < (num & 0xFFFFFFFFFFFFFFFCuL))
			{
				Unsafe.AddByteOffset(ref value2, num3 * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 1) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 2) * num2) = value;
				Unsafe.AddByteOffset(ref value2, (num3 + 3) * num2) = value;
				num3 += 4;
			}
			for (; num3 < num; num3++)
			{
				Unsafe.AddByteOffset(ref value2, num3 * num2) = value;
			}
		}
	}

	public void CopyTo(Span<T> destination)
	{
		if ((uint)_length <= (uint)destination.Length)
		{
			ByReference<T> pointer = destination._pointer;
			ref T value = ref pointer.Value;
			pointer = _pointer;
			Buffer.Memmove(ref value, ref pointer.Value, (ulong)_length);
		}
		else
		{
			ThrowHelper.ThrowArgumentException_DestinationTooShort();
		}
	}

	public bool TryCopyTo(Span<T> destination)
	{
		bool result = false;
		if ((uint)_length <= (uint)destination.Length)
		{
			ByReference<T> pointer = destination._pointer;
			ref T value = ref pointer.Value;
			pointer = _pointer;
			Buffer.Memmove(ref value, ref pointer.Value, (ulong)_length);
			result = true;
		}
		return result;
	}

	public static bool operator ==(Span<T> left, Span<T> right)
	{
		if (left._length == right._length)
		{
			ByReference<T> pointer = left._pointer;
			ref T value = ref pointer.Value;
			pointer = right._pointer;
			return Unsafe.AreSame(ref value, ref pointer.Value);
		}
		return false;
	}

	public static implicit operator ReadOnlySpan<T>(Span<T> span)
	{
		return new ReadOnlySpan<T>(ref span._pointer.Value, span._length);
	}

	public unsafe override string ToString()
	{
		if (typeof(T) == typeof(char))
		{
			fixed (char* value = &Unsafe.As<T, char>(ref _pointer.Value))
			{
				return new string(value, 0, _length);
			}
		}
		return $"System.Span<{typeof(T).Name}>[{_length}]";
	}

	[MethodImpl((MethodImplOptions)256)]
	public Span<T> Slice(int start)
	{
		if ((uint)start > (uint)_length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new Span<T>(ref Unsafe.Add(ref _pointer.Value, start), _length - start);
	}

	[MethodImpl((MethodImplOptions)256)]
	public Span<T> Slice(int start, int length)
	{
		if ((uint)start > (uint)_length || (uint)length > (uint)(_length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new Span<T>(ref Unsafe.Add(ref _pointer.Value, start), length);
	}

	[MethodImpl((MethodImplOptions)256)]
	public T[] ToArray()
	{
		if (_length == 0)
		{
			return Array.Empty<T>();
		}
		T[] array = new T[_length];
		Buffer.Memmove(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()), ref _pointer.Value, (ulong)_length);
		return array;
	}

	[Obsolete("Equals() on Span will always throw an exception. Use == instead.")]
	public override bool Equals(object obj)
	{
		throw new NotSupportedException("Equals() on Span and ReadOnlySpan is not supported. Use operator== instead.");
	}

	[Obsolete("GetHashCode() on Span will always throw an exception.")]
	public override int GetHashCode()
	{
		throw new NotSupportedException("GetHashCode() on Span and ReadOnlySpan is not supported.");
	}

	public static implicit operator Span<T>(T[] array)
	{
		return new Span<T>(array);
	}

	public static implicit operator Span<T>(ArraySegment<T> segment)
	{
		return new Span<T>(segment.Array, segment.Offset, segment.Count);
	}
}
