using System;

namespace GameFramework.Runtime;

public interface IProxyItemInfo : IProxyMemberInfo
{
	Type ValueType { get; }

	TypeCode ValueTypeCode { get; }

	object GetValue(object target, object key);

	void SetValue(object target, object key, object value);
}
public interface IProxyItemInfo<TKey, TValue> : IProxyItemInfo, IProxyMemberInfo
{
	TValue GetValue(object target, TKey key);

	void SetValue(object target, TKey key, TValue value);
}
public interface IProxyItemInfo<T, TKey, TValue> : IProxyItemInfo<TKey, TValue>, IProxyItemInfo, IProxyMemberInfo
{
	TValue GetValue(T target, TKey key);

	void SetValue(T target, TKey key, TValue value);
}
