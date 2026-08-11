using UnityEngine.UIElements;

namespace GameFramework.Runtime;

public class VisualElementPropertyProxy<TValue> : PropertyTargetProxy
{
	private readonly INotifyValueChanged<TValue> notifyValueChanged;

	public override BindingMode DefaultMode => BindingMode.TwoWay;

	public VisualElementPropertyProxy(object target, IProxyPropertyInfo propertyInfo)
		: base(target, propertyInfo)
	{
		if (target is INotifyValueChanged<TValue>)
		{
			notifyValueChanged = (INotifyValueChanged<TValue>)target;
		}
		else
		{
			notifyValueChanged = null;
		}
	}

	protected override void DoSubscribeForValueChange(object target)
	{
		if (notifyValueChanged != null && target != null)
		{
			INotifyValueChangedExtensions.RegisterValueChangedCallback<TValue>(notifyValueChanged, (EventCallback<ChangeEvent<TValue>>)(object)new EventCallback<ChangeEvent<ChangeEvent<TValue>>>(OnValueChanged));
		}
	}

	protected override void DoUnsubscribeForValueChange(object target)
	{
		if (notifyValueChanged != null)
		{
			INotifyValueChangedExtensions.UnregisterValueChangedCallback<TValue>(notifyValueChanged, (EventCallback<ChangeEvent<TValue>>)(object)new EventCallback<ChangeEvent<ChangeEvent<TValue>>>(OnValueChanged));
		}
	}

	private void OnValueChanged(ChangeEvent<TValue> e)
	{
		RaiseValueChanged();
	}
}
