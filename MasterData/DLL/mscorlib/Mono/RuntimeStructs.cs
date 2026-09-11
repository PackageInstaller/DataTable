using System;
using System.Runtime.InteropServices;

namespace Mono;

internal static class RuntimeStructs
{
	internal struct RemoteClass
	{
		internal IntPtr default_vtable;

		internal IntPtr xdomain_vtable;

		internal unsafe MonoClass* proxy_class;

		internal IntPtr proxy_class_name;

		internal uint interface_count;
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct MonoClass
	{
	}

	internal struct GenericParamInfo
	{
		internal unsafe MonoClass* pklass;

		internal IntPtr name;

		internal ushort flags;

		internal uint token;

		internal unsafe MonoClass** constraints;
	}

	internal struct GPtrArray
	{
		internal unsafe IntPtr* data;

		internal int len;
	}
}
