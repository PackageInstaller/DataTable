namespace GameFramework.Runtime;

public interface IProxyInvoker : IInvoker
{
	IProxyMethodInfo ProxyMethodInfo { get; }
}
