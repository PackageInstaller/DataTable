using System;
using System.Collections.Generic;
using System.Reflection;

namespace LuaInterface;

public static class LuaMethodCache
{
	public static Dictionary<Type, Dictionary<string, List<MethodInfo>>> dict = new Dictionary<Type, Dictionary<string, List<MethodInfo>>>();

	private static MethodInfo GetMethod(Type t, string name, Type[] ts)
	{
		Dictionary<string, List<MethodInfo>> value = null;
		List<MethodInfo> value2 = null;
		if (!dict.TryGetValue(t, out value))
		{
			value = new Dictionary<string, List<MethodInfo>>();
			dict.Add(t, value);
		}
		if (!value.TryGetValue(name, out value2))
		{
			value2 = new List<MethodInfo>();
			MethodInfo[] methods = t.GetMethods();
			for (int i = 0; i < methods.Length; i++)
			{
				if (methods[i].Name == name)
				{
					value2.Add(methods[i]);
				}
			}
			value.Add(name, value2);
		}
		if (value2.Count == 1)
		{
			return value2[0];
		}
		for (int j = 0; j < value2.Count; j++)
		{
			ParameterInfo[] parameters = value2[j].GetParameters();
			bool flag = true;
			if (parameters.Length == 0 && (ts == null || ts.Length == 0))
			{
				return value2[j];
			}
			if (parameters.Length != ts.Length)
			{
				continue;
			}
			for (int k = 0; k < ts.Length; k++)
			{
				if (parameters[k].ParameterType != ts[k])
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				return value2[j];
			}
		}
		return null;
	}

	public static object CallSingleMethod(string name, object obj, params object[] args)
	{
		return GetMethod(obj.GetType(), name, null).Invoke(obj, args);
	}

	public static object CallMethod(string name, object obj, params object[] args)
	{
		Type[] array = new Type[args.Length];
		for (int i = 0; i < args.Length; i++)
		{
			array[i] = args[i].GetType();
		}
		return GetMethod(obj.GetType(), name, array).Invoke(obj, args);
	}
}
