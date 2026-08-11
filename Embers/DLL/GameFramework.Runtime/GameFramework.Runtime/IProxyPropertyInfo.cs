using System;

namespace GameFramework.Runtime;

public interface IProxyPropertyInfo : IProxyMemberInfo
{
	bool IsValueType { get; }

	Type ValueType { get; }

	TypeCode ValueTypeCode { get; }

	object GetValue(object target);

	void SetValue(object target, object value);
}
public interface IProxyPropertyInfo<TValue> : IProxyPropertyInfo, IProxyMemberInfo
{
	new TValue GetValue(object target);

	void SetValue(object target, TValue value);
}
public interface IProxyPropertyInfo<T, TValue> : IProxyPropertyInfo<TValue>, IProxyPropertyInfo, IProxyMemberInfo
{
	TValue GetValue(T target);

	void SetValue(T target, TValue value);
}
