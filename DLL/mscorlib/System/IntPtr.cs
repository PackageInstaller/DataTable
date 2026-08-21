using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[ComVisible(true)]
public readonly struct IntPtr : ISerializable, IEquatable<IntPtr>
{
	private unsafe readonly void* m_value;

	public static readonly IntPtr Zero;

	public unsafe static int Size
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return sizeof(void*);
		}
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe IntPtr(int value)
	{
		m_value = (void*)value;
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe IntPtr(long value)
	{
		m_value = (void*)value;
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	[CLSCompliant(false)]
	public unsafe IntPtr(void* value)
	{
		m_value = value;
	}

	private unsafe IntPtr(SerializationInfo info, StreamingContext context)
	{
		long @int = info.GetInt64("value");
		m_value = (void*)@int;
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("value", ToInt64());
	}

	public unsafe override bool Equals(object obj)
	{
		if (!(obj is IntPtr))
		{
			return false;
		}
		return ((IntPtr)obj).m_value == m_value;
	}

	public unsafe override int GetHashCode()
	{
		return (int)m_value;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe int ToInt32()
	{
		return (int)m_value;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe long ToInt64()
	{
		if (Size == 4)
		{
			return (int)m_value;
		}
		return (long)m_value;
	}

	[CLSCompliant(false)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe void* ToPointer()
	{
		return m_value;
	}

	public override string ToString()
	{
		return ToString(null);
	}

	public unsafe string ToString(string format)
	{
		if (Size == 4)
		{
			return ((int)m_value).ToString(format, null);
		}
		return ((long)m_value).ToString(format, null);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe static bool operator ==(IntPtr value1, IntPtr value2)
	{
		return value1.m_value == value2.m_value;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe static bool operator !=(IntPtr value1, IntPtr value2)
	{
		return value1.m_value != value2.m_value;
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public static explicit operator IntPtr(int value)
	{
		return new IntPtr(value);
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public static explicit operator IntPtr(long value)
	{
		return new IntPtr(value);
	}

	[CLSCompliant(false)]
	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe static explicit operator IntPtr(void* value)
	{
		return new IntPtr(value);
	}

	public unsafe static explicit operator int(IntPtr value)
	{
		return (int)value.m_value;
	}

	public static explicit operator long(IntPtr value)
	{
		return value.ToInt64();
	}

	[CLSCompliant(false)]
	public unsafe static explicit operator void*(IntPtr value)
	{
		return value.m_value;
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe static IntPtr Add(IntPtr pointer, int offset)
	{
		return (IntPtr)((byte*)(void*)pointer + offset);
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe static IntPtr Subtract(IntPtr pointer, int offset)
	{
		return (IntPtr)((byte*)(void*)pointer - offset);
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe static IntPtr operator +(IntPtr pointer, int offset)
	{
		return (IntPtr)((byte*)(void*)pointer + offset);
	}

	[ReliabilityContract(Consistency.MayCorruptInstance, Cer.MayFail)]
	public unsafe static IntPtr operator -(IntPtr pointer, int offset)
	{
		return (IntPtr)((byte*)(void*)pointer - offset);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal unsafe bool IsNull()
	{
		return m_value == null;
	}

	unsafe bool IEquatable<IntPtr>.Equals(IntPtr other)
	{
		return m_value == other.m_value;
	}
}
