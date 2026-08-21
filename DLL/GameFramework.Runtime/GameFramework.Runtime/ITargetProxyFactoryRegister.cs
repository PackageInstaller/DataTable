namespace GameFramework.Runtime;

public interface ITargetProxyFactoryRegister
{
	void Register(ITargetProxyFactory factory, int priority = 100);

	void Unregister(ITargetProxyFactory factory);
}
