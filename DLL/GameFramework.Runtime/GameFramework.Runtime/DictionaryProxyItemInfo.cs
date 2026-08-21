using System;
using System.Collections.Generic;
using System.Reflection;

namespace GameFramework.Runtime;

public class DictionaryProxyItemInfo<T, TKey, TValue> : ProxyItemInfo, IProxyItemInfo<T, TKey, TValue>, IProxyItemInfo<TKey, TValue>, IProxyItemInfo, IProxyMemberInfo where T : IDictionary<TKey, TValue>
{
	public DictionaryProxyItemInfo(PropertyInfo propertyInfo)
		: base(propertyInfo)
	{
		if (!typeof(TValue).Equals(base.propertyInfo.PropertyType) || !typeof(IDictionary<TKey, TValue>).IsAssignableFrom(propertyInfo.DeclaringType))
		{
			throw new ArgumentException("The property types do not match!");
		}
	}

	public TValue GetValue(T target, TKey key)
	{
		if (!target.ContainsKey(key))
		{
			return default(TValue);
		}
		return target[key];
	}

	public TValue GetValue(object target, TKey key)
	{
		return GetValue((T)target, key);
	}

	public void SetValue(T target, TKey key, TValue value)
	{
		target[key] = value;
	}

	public void SetValue(object target, TKey key, TValue value)
	{
		SetValue((T)target, key, value);
	}
}
