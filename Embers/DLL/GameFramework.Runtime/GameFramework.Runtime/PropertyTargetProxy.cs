using System;
using System.ComponentModel;

namespace GameFramework.Runtime;

public class PropertyTargetProxy : ValueTargetProxyBase
{
	protected readonly IProxyPropertyInfo propertyInfo;

	public override Type Type => propertyInfo.ValueType;

	public override TypeCode TypeCode => propertyInfo.ValueTypeCode;

	public override BindingMode DefaultMode => BindingMode.TwoWay;

	public PropertyTargetProxy(object target, IProxyPropertyInfo propertyInfo)
		: base(target)
	{
		this.propertyInfo = propertyInfo;
	}

	public override object GetValue()
	{
		object obj = Target;
		if (obj == null)
		{
			return null;
		}
		return propertyInfo.GetValue(obj);
	}

	public override TValue GetValue<TValue>()
	{
		object obj = Target;
		if (obj == null)
		{
			return default(TValue);
		}
		if (propertyInfo is IProxyPropertyInfo<TValue>)
		{
			return ((IProxyPropertyInfo<TValue>)propertyInfo).GetValue(obj);
		}
		return (TValue)propertyInfo.GetValue(obj);
	}

	public override void SetValue(object value)
	{
		object obj = Target;
		if (obj != null)
		{
			propertyInfo.SetValue(obj, value);
		}
	}

	public override void SetValue<TValue>(TValue value)
	{
		object obj = Target;
		if (obj != null)
		{
			if (propertyInfo is IProxyPropertyInfo<TValue>)
			{
				((IProxyPropertyInfo<TValue>)propertyInfo).SetValue(obj, value);
			}
			else
			{
				propertyInfo.SetValue(obj, value);
			}
		}
	}

	protected override void DoSubscribeForValueChange(object target)
	{
		if (target is INotifyPropertyChanged)
		{
			INotifyPropertyChanged notifyPropertyChanged = target as INotifyPropertyChanged;
			notifyPropertyChanged.PropertyChanged += OnPropertyChanged;
		}
	}

	protected override void DoUnsubscribeForValueChange(object target)
	{
		if (target is INotifyPropertyChanged)
		{
			INotifyPropertyChanged notifyPropertyChanged = target as INotifyPropertyChanged;
			notifyPropertyChanged.PropertyChanged -= OnPropertyChanged;
		}
	}

	protected virtual void OnPropertyChanged(object sender, PropertyChangedEventArgs e)
	{
		string propertyName = e.PropertyName;
		if (string.IsNullOrEmpty(propertyName) || propertyName.Equals(propertyInfo.Name))
		{
			object obj = Target;
			if (obj != null)
			{
				RaiseValueChanged();
			}
		}
	}
}
