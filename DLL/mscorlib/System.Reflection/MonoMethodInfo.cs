using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Reflection;

internal struct MonoMethodInfo
{
	private Type parent;

	private Type ret;

	internal MethodAttributes attrs;

	internal MethodImplAttributes iattrs;

	private CallingConventions callconv;

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void get_method_info(IntPtr handle, out MonoMethodInfo info);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int get_method_attributes(IntPtr handle);

	internal static MonoMethodInfo GetMethodInfo(IntPtr handle)
	{
		get_method_info(handle, out var info);
		return info;
	}

	internal static Type GetDeclaringType(IntPtr handle)
	{
		return GetMethodInfo(handle).parent;
	}

	internal static Type GetReturnType(IntPtr handle)
	{
		return GetMethodInfo(handle).ret;
	}

	internal static MethodAttributes GetAttributes(IntPtr handle)
	{
		return (MethodAttributes)get_method_attributes(handle);
	}

	internal static CallingConventions GetCallingConvention(IntPtr handle)
	{
		return GetMethodInfo(handle).callconv;
	}

	internal static MethodImplAttributes GetMethodImplementationFlags(IntPtr handle)
	{
		return GetMethodInfo(handle).iattrs;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern ParameterInfo[] get_parameter_info(IntPtr handle, MemberInfo member);

	internal static ParameterInfo[] GetParametersInfo(IntPtr handle, MemberInfo member)
	{
		return get_parameter_info(handle, member);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern MarshalAsAttribute get_retval_marshal(IntPtr handle);

	internal static ParameterInfo GetReturnParameterInfo(RuntimeMethodInfo method)
	{
		return RuntimeParameterInfo.New(GetReturnType(method.mhandle), method, get_retval_marshal(method.mhandle));
	}
}
