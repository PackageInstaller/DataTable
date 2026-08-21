using System;
using System.Collections.Generic;
using System.Reflection;

namespace GameFramework.Runtime;

public static class ProxyTypeExtentions
{
	private static readonly ProxyFactory factory = ProxyFactory.Default;

	public static IProxyType AsProxy(this Type type)
	{
		return factory.Get(type);
	}

	public static IProxyEventInfo AsProxy(this EventInfo info)
	{
		IProxyType proxyType = factory.Get(info.DeclaringType);
		return proxyType.GetEvent(info.Name);
	}

	public static IProxyFieldInfo AsProxy(this FieldInfo info)
	{
		IProxyType proxyType = factory.Get(info.DeclaringType);
		if (info.IsPublic)
		{
			return proxyType.GetField(info.Name);
		}
		return proxyType.GetField(info.Name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.NonPublic);
	}

	public static IProxyPropertyInfo AsProxy(this PropertyInfo info)
	{
		IProxyType proxyType = factory.Get(info.DeclaringType);
		if (info.GetGetMethod().IsPublic)
		{
			return proxyType.GetProperty(info.Name);
		}
		return proxyType.GetProperty(info.Name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.NonPublic);
	}

	public static IProxyMethodInfo AsProxy(this MethodInfo info)
	{
		IProxyType proxyType = factory.Get(info.DeclaringType);
		Type[] parameterTypes = info.GetParameterTypes().ToArray();
		if (info.IsPublic)
		{
			return proxyType.GetMethod(info.Name, parameterTypes);
		}
		return proxyType.GetMethod(info.Name, parameterTypes, BindingFlags.Instance | BindingFlags.Static | BindingFlags.NonPublic);
	}

	public static List<Type> GetParameterTypes(this MethodInfo info)
	{
		List<Type> list = new List<Type>();
		ParameterInfo[] parameters = info.GetParameters();
		foreach (ParameterInfo parameterInfo in parameters)
		{
			list.Add(parameterInfo.ParameterType);
		}
		return list;
	}
}
