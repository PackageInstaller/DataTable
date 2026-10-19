using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[ComVisible(true)]
[CLSCompliant(false)]
public readonly struct UIntPtr : ISerializable, IEquatable<UIntPtr>
{
	public static readonly UIntPtr Zero = new UIntPtr(0u);

	private unsafe readonly void* _pointer;

	public unsafe static int Size => sizeof(void*);

	public unsafe UIntPtr(ulong value)
	{
		if (value > uint.MaxValue && Size < 8)
		{
			throw new OverflowException(Locale.GetText("This isn't a 64bits machine."));
		}
		_pointer = (void*)value;
	}

	public unsafe UIntPtr(uint value)
	{
		_pointer = (void*)value;
	}

	[CLSCompliant(false)]
	public unsafe UIntPtr(void* value)
	{
		_pointer = value;
	}

	public unsafe override bool Equals(object obj)
	{
		if (obj is UIntPtr uIntPtr)
		{
			return _pointer == uIntPtr._pointer;
		}
		return false;
	}

	public unsafe override int GetHashCode()
	{
		return (int)_pointer;
	}

	public unsafe override string ToString()
	{
		if (Size >= 8)
		{
			return ((ulong)_pointer).ToString();
		}
		return ((uint)_pointer).ToString();
	}

	unsafe void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("pointer", (ulong)_pointer);
	}

	public unsafe static bool operator ==(UIntPtr value1, UIntPtr value2)
	{
		return value1._pointer == value2._pointer;
	}

	public unsafe static bool operator !=(UIntPtr value1, UIntPtr value2)
	{
		return value1._pointer != value2._pointer;
	}

	public unsafe static explicit operator ulong(UIntPtr value)
	{
		return (ulong)value._pointer;
	}

	public static explicit operator UIntPtr(ulong value)
	{
		return new UIntPtr(value);
	}

	public static explicit operator UIntPtr(uint value)
	{
		return new UIntPtr(value);
	}

	unsafe bool IEquatable<UIntPtr>.Equals(UIntPtr other)
	{
		return _pointer == other._pointer;
	}
}
