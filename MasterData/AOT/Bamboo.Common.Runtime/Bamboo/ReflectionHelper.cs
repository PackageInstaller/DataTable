using System;
using System.Collections.Generic;
using System.Reflection;

namespace Bamboo;

public static class ReflectionHelper
{
	public static Type GetTypeFromBaseType(Type baseType)
	{
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		foreach (Assembly assembly in assemblies)
		{
			if (assembly.FullName.StartsWith("UnityEngine.CoreModule") || !assembly.FullName.Contains("Version=0.0.0"))
			{
				continue;
			}
			Type[] types = assembly.GetTypes();
			foreach (Type type in types)
			{
				if (type.IsClass && !type.IsAbstract && baseType.IsAssignableFrom(type))
				{
					return type;
				}
			}
		}
		return null;
	}

	public static List<Type> GetTypesFromBaseType(Type baseType)
	{
		List<Type> list = new List<Type>();
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		foreach (Assembly assembly in assemblies)
		{
			if (assembly.FullName.StartsWith("UnityEngine.CoreModule") || !assembly.FullName.Contains("Version=0.0.0"))
			{
				continue;
			}
			Type[] types = assembly.GetTypes();
			foreach (Type type in types)
			{
				if (type.IsClass && !type.IsAbstract && baseType.IsAssignableFrom(type))
				{
					list.Add(type);
				}
			}
		}
		return list;
	}
}
