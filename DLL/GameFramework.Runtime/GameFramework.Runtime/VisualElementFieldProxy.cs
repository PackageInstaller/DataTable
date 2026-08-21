using UnityEngine.UIElements;

namespace GameFramework.Runtime;

public class VisualElementFieldProxy<TValue> : FieldTargetProxy
{
	private readonly INotifyValueChanged<TValue> notifyValueChanged;

	public override BindingMode DefaultMode => BindingMode.TwoWay;

	public VisualElementFieldProxy(object target, IProxyFieldInfo fieldInfo)
		: base(target, fieldInfo)
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
