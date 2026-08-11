using System;
using System.Collections.Concurrent;
using UnityEngine;

namespace GameFramework.Runtime;

public class ProxyFactory
{
	public static readonly ProxyFactory Default = new ProxyFactory();

	private readonly object _lock = new object();

	private readonly ConcurrentDictionary<Type, ProxyType> types = new ConcurrentDictionary<Type, ProxyType>();

	internal ConcurrentDictionary<Type, ProxyType> Types => types;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterAssembliesLoaded)]
	private static void OnInitialize()
	{
		Default.types.Clear();
	}

	internal virtual ProxyType GetType(Type type, bool create = true)
	{
		if (types.TryGetValue(type, out var value) && value != null)
		{
			return value;
		}
		return create ? types.GetOrAdd(type, (Type t) => new ProxyType(t, this)) : null;
	}

	public IProxyType Get(Type type)
	{
		return GetType(type);
	}

	public void Register(IProxyMemberInfo proxyMemberInfo)
	{
		if (proxyMemberInfo != null)
		{
			ProxyType type = GetType(proxyMemberInfo.DeclaringType);
			type.Register(proxyMemberInfo);
		}
	}

	public void Unregister(IProxyMemberInfo proxyMemberInfo)
	{
		if (proxyMemberInfo != null)
		{
			ProxyType type = GetType(proxyMemberInfo.DeclaringType);
			type.Unregister(proxyMemberInfo);
		}
	}
}
