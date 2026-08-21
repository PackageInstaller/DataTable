namespace GameFramework.Runtime;

public interface ITargetProxyFactory
{
	ITargetProxy CreateProxy(object target, BindingDescription description);
}
