using System;

namespace GameFramework.Runtime;

public class FieldTargetProxy : ValueTargetProxyBase
{
	protected readonly IProxyFieldInfo fieldInfo;

	public override Type Type => fieldInfo.ValueType;

	public override TypeCode TypeCode => fieldInfo.ValueTypeCode;

	public override BindingMode DefaultMode => BindingMode.OneWay;

	public FieldTargetProxy(object target, IProxyFieldInfo fieldInfo)
		: base(target)
	{
		this.fieldInfo = fieldInfo;
	}

	public override object GetValue()
	{
		object obj = Target;
		if (obj == null)
		{
			return null;
		}
		return fieldInfo.GetValue(obj);
	}

	public override TValue GetValue<TValue>()
	{
		object obj = Target;
		if (obj == null)
		{
			return default(TValue);
		}
		if (fieldInfo is IProxyFieldInfo<TValue>)
		{
			return ((IProxyFieldInfo<TValue>)fieldInfo).GetValue(obj);
		}
		return (TValue)fieldInfo.GetValue(obj);
	}

	public override void SetValue(object value)
	{
		object obj = Target;
		if (obj != null)
		{
			fieldInfo.SetValue(obj, value);
		}
	}

	public override void SetValue<TValue>(TValue value)
	{
		object obj = Target;
		if (obj != null)
		{
			if (fieldInfo is IProxyFieldInfo<TValue>)
			{
				((IProxyFieldInfo<TValue>)fieldInfo).SetValue(obj, value);
			}
			else
			{
				fieldInfo.SetValue(obj, value);
			}
		}
	}
}
