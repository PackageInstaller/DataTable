using System;
using GameFramework.Runtime.Proxy;
using UnityEngine;

namespace GameFramework.Runtime;

public class MethodTargetProxy : TargetProxyBase, IObtainable, IProxyInvoker, IInvoker
{
	protected readonly IProxyMethodInfo methodInfo;

	protected IProxyInvoker invoker;

	public override BindingMode DefaultMode => BindingMode.OneWayToSource;

	public override Type Type => typeof(IProxyInvoker);

	public IProxyMethodInfo ProxyMethodInfo => methodInfo;

	public MethodTargetProxy(object target, IProxyMethodInfo methodInfo)
		: base(target)
	{
		this.methodInfo = methodInfo;
		if (!methodInfo.ReturnType.Equals(typeof(void)))
		{
			throw new ArgumentException("methodInfo");
		}
		invoker = this;
	}

	public object GetValue()
	{
		return invoker;
	}

	public TValue GetValue<TValue>()
	{
		return (TValue)invoker;
	}

	public object Invoke(params object[] args)
	{
		if (methodInfo.IsStatic)
		{
			return methodInfo.Invoke(null, args);
		}
		object obj = Target;
		if (obj == null)
		{
			return null;
		}
		if (obj is Behaviour { isActiveAndEnabled: false })
		{
			return null;
		}
		return methodInfo.Invoke(obj, args);
	}
}
