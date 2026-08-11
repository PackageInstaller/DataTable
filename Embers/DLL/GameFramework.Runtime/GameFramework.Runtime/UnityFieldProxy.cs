using UnityEngine.Events;

namespace GameFramework.Runtime;

public class UnityFieldProxy<TValue> : FieldTargetProxy
{
	private UnityEvent<TValue> unityEvent;

	public override BindingMode DefaultMode => BindingMode.TwoWay;

	public UnityFieldProxy(object target, IProxyFieldInfo fieldInfo, UnityEvent<TValue> unityEvent)
		: base(target, fieldInfo)
	{
		this.unityEvent = unityEvent;
	}

	protected override void DoSubscribeForValueChange(object target)
	{
		if (unityEvent != null && target != null)
		{
			unityEvent.AddListener(OnValueChanged);
		}
	}

	protected override void DoUnsubscribeForValueChange(object target)
	{
		if (unityEvent != null)
		{
			unityEvent.RemoveListener(OnValueChanged);
		}
	}

	private void OnValueChanged(TValue value)
	{
		RaiseValueChanged();
	}
}
