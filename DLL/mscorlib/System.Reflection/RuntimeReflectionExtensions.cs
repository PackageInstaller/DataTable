using System.Collections.Generic;

namespace System.Reflection;

public static class RuntimeReflectionExtensions
{
	public static IEnumerable<MethodInfo> GetRuntimeMethods(this Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return type.GetMethods(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
	}

	public static IEnumerable<PropertyInfo> GetRuntimeProperties(this Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return type.GetProperties(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
	}

	public static MethodInfo GetRuntimeMethod(this Type type, string name, Type[] parameters)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return type.GetMethod(name, parameters);
	}

	public static PropertyInfo GetRuntimeProperty(this Type type, string name)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return type.GetProperty(name);
	}

	public static MethodInfo GetRuntimeBaseDefinition(this MethodInfo method)
	{
		if (method == null)
		{
			throw new ArgumentNullException("method");
		}
		return method.GetBaseDefinition();
	}

	public static MethodInfo GetMethodInfo(this Delegate del)
	{
		if ((object)del == null)
		{
			throw new ArgumentNullException("del");
		}
		return del.Method;
	}
}
