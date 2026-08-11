using System;
using System.Collections.Generic;
using System.Reflection;

namespace GameFramework.Runtime;

public class ListProxyItemInfo<T, TValue> : ProxyItemInfo, IProxyItemInfo<T, int, TValue>, IProxyItemInfo<int, TValue>, IProxyItemInfo, IProxyMemberInfo where T : IList<TValue>
{
	public ListProxyItemInfo(PropertyInfo propertyInfo)
		: base(propertyInfo)
	{
		if (!typeof(TValue).Equals(base.propertyInfo.PropertyType) || !typeof(IList<TValue>).IsAssignableFrom(propertyInfo.DeclaringType))
		{
			throw new ArgumentException("The property types do not match!");
		}
	}

	public TValue GetValue(T target, int key)
	{
		if (key < 0 || key >= target.Count)
		{
			throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {key}, it is not between 0 and {target.Count}");
		}
		return target[key];
	}

	public TValue GetValue(object target, int key)
	{
		return GetValue((T)target, key);
	}

	public void SetValue(T target, int key, TValue value)
	{
		if (key < 0 || key >= target.Count)
		{
			throw new ArgumentOutOfRangeException("key", $"The index is out of range, the key value is {key}, it is not between 0 and {target.Count}");
		}
		target[key] = value;
	}

	public void SetValue(object target, int key, TValue value)
	{
		SetValue((T)target, key, value);
	}
}
