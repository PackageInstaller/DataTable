using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public abstract class EventTargetProxyBase : TargetProxyBase, IModifiable
{
	public EventTargetProxyBase(object target)
		: base(target)
	{
	}

	public abstract void SetValue(object value);

	public abstract void SetValue<TValue>(TValue value);
}
