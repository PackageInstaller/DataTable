using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class FieldNodeProxy : SourceProxyBase, IObtainable, IModifiable
{
	protected IProxyFieldInfo fieldInfo;

	public override Type Type => fieldInfo.ValueType;

	public override TypeCode TypeCode => fieldInfo.ValueTypeCode;

	public FieldNodeProxy(IProxyFieldInfo fieldInfo)
		: this(null, fieldInfo)
	{
	}

	public FieldNodeProxy(object source, IProxyFieldInfo fieldInfo)
		: base(source)
	{
		this.fieldInfo = fieldInfo;
	}

	public virtual object GetValue()
	{
		return fieldInfo.GetValue(source);
	}

	public virtual TValue GetValue<TValue>()
	{
		if (fieldInfo is IProxyFieldInfo<TValue> proxyFieldInfo)
		{
			return proxyFieldInfo.GetValue(source);
		}
		return (TValue)fieldInfo.GetValue(source);
	}

	public virtual void SetValue(object value)
	{
		fieldInfo.SetValue(source, value);
	}

	public virtual void SetValue<TValue>(TValue value)
	{
		if (fieldInfo is IProxyFieldInfo<TValue> proxyFieldInfo)
		{
			proxyFieldInfo.SetValue(source, value);
		}
		else
		{
			fieldInfo.SetValue(source, value);
		}
	}
}
