namespace GameFramework.Runtime;

public class ProxyInvoker : IProxyInvoker, IInvoker
{
	private object target;

	private IProxyMethodInfo proxyMethodInfo;

	public virtual IProxyMethodInfo ProxyMethodInfo => proxyMethodInfo;

	public ProxyInvoker(object target, IProxyMethodInfo proxyMethodInfo)
	{
		this.target = target;
		this.proxyMethodInfo = proxyMethodInfo;
	}

	public object Invoke(params object[] args)
	{
		return proxyMethodInfo.Invoke(target, args);
	}
}
