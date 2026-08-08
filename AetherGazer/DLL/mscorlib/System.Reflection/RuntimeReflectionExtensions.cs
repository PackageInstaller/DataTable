using System.Collections.Generic;

namespace System.Reflection;

public static class RuntimeReflectionExtensions
{
	public static IEnumerable<FieldInfo> GetRuntimeFields(this Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return type.GetFields(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
	}

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

	public static FieldInfo GetRuntimeField(this Type type, string name)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return type.GetField(name);
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
}
