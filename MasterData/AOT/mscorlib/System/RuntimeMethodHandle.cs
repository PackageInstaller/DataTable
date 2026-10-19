using System.Reflection;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;

namespace System;

[Serializable]
[ComVisible(true)]
public struct RuntimeMethodHandle : ISerializable
{
	private IntPtr value;

	public IntPtr Value => value;

	internal RuntimeMethodHandle(IntPtr v)
	{
		value = v;
	}

	private RuntimeMethodHandle(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		RuntimeMethodInfo runtimeMethodInfo = (RuntimeMethodInfo)info.GetValue("MethodObj", typeof(RuntimeMethodInfo));
		value = runtimeMethodInfo.MethodHandle.Value;
		if (value == IntPtr.Zero)
		{
			throw new SerializationException("Insufficient state.");
		}
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
		info.AddValue("MethodObj", (RuntimeMethodInfo)MethodBase.GetMethodFromHandle(this), typeof(RuntimeMethodInfo));
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public override bool Equals(object obj)
	{
		if (obj == null || GetType() != obj.GetType())
		{
			return false;
		}
		return value == ((RuntimeMethodHandle)obj).Value;
	}

	public override int GetHashCode()
	{
		return value.GetHashCode();
	}

	internal static string ConstructInstantiation(RuntimeMethodInfo method, TypeNameFormatFlags format)
	{
		StringBuilder stringBuilder = new StringBuilder();
		Type[] genericArguments = method.GetGenericArguments();
		stringBuilder.Append("[");
		for (int i = 0; i < genericArguments.Length; i++)
		{
			if (i > 0)
			{
				stringBuilder.Append(",");
			}
			stringBuilder.Append(genericArguments[i].Name);
		}
		stringBuilder.Append("]");
		return stringBuilder.ToString();
	}

	internal bool IsNullHandle()
	{
		return value == IntPtr.Zero;
	}
}
