using System;

namespace GameFramework.Runtime;

public class WeakProxyInvoker : IProxyInvoker, IInvoker
{
	private WeakReference target;

	private IProxyMethodInfo proxyMethodInfo;

	public virtual IProxyMethodInfo ProxyMethodInfo => proxyMethodInfo;

	public WeakProxyInvoker(WeakReference target, IProxyMethodInfo proxyMethodInfo)
	{
		this.target = target;
		this.proxyMethodInfo = proxyMethodInfo;
	}

	public object Invoke(params object[] args)
	{
		if (proxyMethodInfo.IsStatic)
		{
			return proxyMethodInfo.Invoke(null, args);
		}
		if (target == null || !target.IsAlive)
		{
			return null;
		}
		object obj = target.Target;
		if (obj == null)
		{
			return null;
		}
		return proxyMethodInfo.Invoke(obj, args);
	}
}
