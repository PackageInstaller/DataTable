using System;
using System.Runtime.CompilerServices;

namespace Mono;

internal struct RuntimeClassHandle
{
	private unsafe RuntimeStructs.MonoClass* value;

	internal unsafe RuntimeStructs.MonoClass* Value => value;

	internal unsafe RuntimeClassHandle(RuntimeStructs.MonoClass* value)
	{
		this.value = value;
	}

	internal unsafe RuntimeClassHandle(IntPtr ptr)
	{
		value = (RuntimeStructs.MonoClass*)(void*)ptr;
	}

	public unsafe override bool Equals(object obj)
	{
		if (obj == null || GetType() != obj.GetType())
		{
			return false;
		}
		return value == ((RuntimeClassHandle)obj).Value;
	}

	public unsafe override int GetHashCode()
	{
		return ((IntPtr)value).GetHashCode();
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern IntPtr GetTypeFromClass(RuntimeStructs.MonoClass* klass);

	internal unsafe RuntimeTypeHandle GetTypeHandle()
	{
		return new RuntimeTypeHandle(GetTypeFromClass(value));
	}
}
