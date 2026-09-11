using System.Reflection;
using System.Runtime.InteropServices;

namespace System;

[StructLayout(LayoutKind.Sequential)]
internal class MonoTypeInfo
{
	public string full_name;

	public RuntimeConstructorInfo default_ctor;
}
