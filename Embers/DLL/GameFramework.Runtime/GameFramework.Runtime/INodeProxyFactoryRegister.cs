namespace GameFramework.Runtime;

public interface INodeProxyFactoryRegister
{
	void Register(INodeProxyFactory factory, int priority = 100);

	void Unregister(INodeProxyFactory factory);
}
