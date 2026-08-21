using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text.RegularExpressions;

namespace GameFramework.Runtime;

public class TypeFinderUtils
{
	private static List<Assembly> assemblies = new List<Assembly>();

	public static Type FindType(string typeName)
	{
		if (string.IsNullOrEmpty(typeName))
		{
			return null;
		}
		List<Assembly> list = GetAssemblies();
		foreach (Assembly item in list)
		{
			Type type = item.GetType(typeName, throwOnError: false, ignoreCase: false);
			if (type != null)
			{
				return type;
			}
		}
		string value = $".{typeName}";
		foreach (Assembly item2 in list)
		{
			Type[] types = item2.GetTypes();
			foreach (Type type2 in types)
			{
				if (type2.FullName.EndsWith(value))
				{
					return type2;
				}
			}
		}
		return null;
	}

	private static List<Assembly> GetAssemblies()
	{
		if (assemblies.Count > 0)
		{
			return assemblies;
		}
		Assembly[] array = AppDomain.CurrentDomain.GetAssemblies();
		Assembly[] array2 = array;
		foreach (Assembly assembly in array2)
		{
			string fullName = assembly.FullName;
			if (!Regex.IsMatch(fullName, "^((mscorlib)|(nunit)|(System)|(UnityEngine))"))
			{
				assemblies.Add(assembly);
			}
		}
		return assemblies;
	}
}
