using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[ComVisible(true)]
public struct RuntimeFieldHandle : ISerializable
{
	private IntPtr value;

	public IntPtr Value => value;

	internal RuntimeFieldHandle(IntPtr v)
	{
		value = v;
	}

	private RuntimeFieldHandle(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		RuntimeFieldInfo runtimeFieldInfo = (RuntimeFieldInfo)info.GetValue("FieldObj", typeof(RuntimeFieldInfo));
		value = runtimeFieldInfo.FieldHandle.Value;
		if (value == IntPtr.Zero)
		{
			throw new SerializationException("Insufficient state.");
		}
	}

	internal bool IsNullHandle()
	{
		return value == IntPtr.Zero;
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		if (value == IntPtr.Zero)
		{
			throw new SerializationException("Object fields may not be properly initialized");
		}
		info.AddValue("FieldObj", (RuntimeFieldInfo)FieldInfo.GetFieldFromHandle(this), typeof(RuntimeFieldInfo));
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public override bool Equals(object obj)
	{
		if (obj == null || GetType() != obj.GetType())
		{
			return false;
		}
		return value == ((RuntimeFieldHandle)obj).Value;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public bool Equals(RuntimeFieldHandle handle)
	{
		return value == handle.Value;
	}

	public override int GetHashCode()
	{
		return value.GetHashCode();
	}

	public static bool operator ==(RuntimeFieldHandle left, RuntimeFieldHandle right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(RuntimeFieldHandle left, RuntimeFieldHandle right)
	{
		return !left.Equals(right);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetValueInternal(FieldInfo fi, object obj, object value);

	internal static void SetValue(RuntimeFieldInfo field, object obj, object value, RuntimeType fieldType, FieldAttributes fieldAttr, RuntimeType declaringType, ref bool domainInitialized)
	{
		SetValueInternal(field, obj, value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern object GetValueDirect(RuntimeFieldInfo field, RuntimeType fieldType, void* pTypedRef, RuntimeType contextType);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern void SetValueDirect(RuntimeFieldInfo field, RuntimeType fieldType, void* pTypedRef, object value, RuntimeType contextType);
}
