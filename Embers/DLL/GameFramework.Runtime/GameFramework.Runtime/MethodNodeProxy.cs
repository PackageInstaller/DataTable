using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class MethodNodeProxy : SourceProxyBase, IObtainable
{
	protected IProxyMethodInfo methodInfo;

	protected IProxyInvoker invoker;

	public override Type Type => typeof(IProxyInvoker);

	public MethodNodeProxy(IProxyMethodInfo methodInfo)
		: this(null, methodInfo)
	{
	}

	public MethodNodeProxy(object source, IProxyMethodInfo methodInfo)
		: base(source)
	{
		this.methodInfo = methodInfo;
		invoker = new ProxyInvoker(base.source, this.methodInfo);
	}

	public object GetValue()
	{
		return invoker;
	}

	public TValue GetValue<TValue>()
	{
		return (TValue)invoker;
	}
}
