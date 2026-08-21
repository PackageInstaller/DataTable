using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Versioning;

namespace System;

[DebuggerTypeProxy(typeof(SpanDebugView<>))]
[NonVersionable]
[DebuggerDisplay("{ToString(),raw}")]
public readonly ref struct ReadOnlySpan<T>
{
	internal readonly ByReference<T> _pointer;

	private readonly int _length;

	public ref readonly T this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		[Intrinsic]
		[NonVersionable]
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

	public bool IsEmpty
	{
		[NonVersionable]
		get
		{
			return _length == 0;
		}
	}

	public static ReadOnlySpan<T> Empty => default(ReadOnlySpan<T>);

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlySpan(T[] array)
	{
		if (array == null)
		{
			this = default(ReadOnlySpan<T>);
			return;
		}
		_pointer = new ByReference<T>(ref Unsafe.As<byte, T>(ref array.GetRawSzArrayData()));
		_length = array.Length;
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlySpan(T[] array, int start, int length)
	{
		if (array == null)
		{
			if (start != 0 || length != 0)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException();
			}
			this = default(ReadOnlySpan<T>);
			return;
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
	public unsafe ReadOnlySpan(void* pointer, int length)
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
	internal ReadOnlySpan(ref T ptr, int length)
	{
		_pointer = new ByReference<T>(ref ptr);
		_length = length;
	}

	public unsafe ref readonly T GetPinnableReference()
	{
		if (_length == 0)
		{
			return ref Unsafe.AsRef<T>(null);
		}
		return ref _pointer.Value;
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

	public unsafe override string ToString()
	{
		if (typeof(T) == typeof(char))
		{
			fixed (char* value = &Unsafe.As<T, char>(ref _pointer.Value))
			{
				return new string(value, 0, _length);
			}
		}
		return $"System.ReadOnlySpan<{typeof(T).Name}>[{_length}]";
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlySpan<T> Slice(int start)
	{
		if ((uint)start > (uint)_length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new ReadOnlySpan<T>(ref Unsafe.Add(ref _pointer.Value, start), _length - start);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ReadOnlySpan<T> Slice(int start, int length)
	{
		if ((uint)start > (uint)_length || (uint)length > (uint)(_length - start))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException();
		}
		return new ReadOnlySpan<T>(ref Unsafe.Add(ref _pointer.Value, start), length);
	}

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

	[Obsolete("Equals() on ReadOnlySpan will always throw an exception. Use == instead.")]
	public override bool Equals(object obj)
	{
		throw new NotSupportedException("Equals() on Span and ReadOnlySpan is not supported. Use operator== instead.");
	}

	[Obsolete("GetHashCode() on ReadOnlySpan will always throw an exception.")]
	public override int GetHashCode()
	{
		throw new NotSupportedException("GetHashCode() on Span and ReadOnlySpan is not supported.");
	}

	public static implicit operator ReadOnlySpan<T>(T[] array)
	{
		return new ReadOnlySpan<T>(array);
	}
}
