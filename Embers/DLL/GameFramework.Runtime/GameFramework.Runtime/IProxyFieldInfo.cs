using System;

namespace GameFramework.Runtime;

public interface IProxyFieldInfo : IProxyMemberInfo
{
	Type ValueType { get; }

	TypeCode ValueTypeCode { get; }

	object GetValue(object target);

	void SetValue(object target, object value);
}
public interface IProxyFieldInfo<TValue> : IProxyFieldInfo, IProxyMemberInfo
{
	new TValue GetValue(object target);

	void SetValue(object target, TValue value);
}
public interface IProxyFieldInfo<T, TValue> : IProxyFieldInfo<TValue>, IProxyFieldInfo, IProxyMemberInfo
{
	TValue GetValue(T target);

	void SetValue(T target, TValue value);
}
