using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;

namespace Fundamental;

public static class OptUtils
{
	private static Dictionary<Type, string> s_TypeNameMap = new Dictionary<Type, string>();

	private static Dictionary<Type, string> s_TypeQualifiedNameMap = new Dictionary<Type, string>();

	public static StringBuilder s_StringBuilder = new StringBuilder();

	public static string GetTypeName<T>()
	{
		return GetTypeName(typeof(T));
	}

	public static string GetTypeName(Type type)
	{
		if (!s_TypeNameMap.TryGetValue(type, out var value))
		{
			value = type.Name;
			s_TypeNameMap.Add(type, value);
		}
		return value;
	}

	public static string GetCachedName(this Type type)
	{
		return GetTypeName(type);
	}

	public static string GetTypeName(this object obj)
	{
		if (obj == null)
		{
			return "";
		}
		return GetTypeName(obj.GetType());
	}

	public static string GetTypeQualifiedName<T>()
	{
		return GetTypeQualifiedName(typeof(T));
	}

	public static string GetTypeQualifiedName(Type type)
	{
		if (!s_TypeQualifiedNameMap.TryGetValue(type, out var value))
		{
			value = type.AssemblyQualifiedName;
			s_TypeQualifiedNameMap.Add(type, value);
		}
		return value;
	}

	public static string GetCachedQualifiedName(this Type type)
	{
		return GetTypeQualifiedName(type);
	}

	public static string GetTypeQualifiedName(this object obj)
	{
		if (obj == null)
		{
			return "";
		}
		return GetTypeQualifiedName(obj.GetType());
	}

	public static string GetAssemblyName(Assembly assembly)
	{
		string fullName = assembly.FullName;
		int num = fullName.IndexOf(',');
		if (num != -1)
		{
			return fullName.Remove(num);
		}
		return fullName;
	}

	public static List<T> CreateList<T>(int capacity)
	{
		if (capacity == 0)
		{
			return new List<T>();
		}
		return new List<T>(capacity);
	}

	public static T[] CreateArray<T>(int length)
	{
		if (length == 0)
		{
			return EmptyList<T>.Array;
		}
		return new T[length];
	}

	public static string Concat(string a, int b)
	{
		s_StringBuilder.Append(a).Append(b);
		string result = s_StringBuilder.ToString();
		s_StringBuilder.Clear();
		return result;
	}
}
