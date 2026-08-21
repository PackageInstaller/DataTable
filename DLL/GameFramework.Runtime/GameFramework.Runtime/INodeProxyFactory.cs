namespace GameFramework.Runtime;

public interface INodeProxyFactory
{
	ISourceProxy Create(object source, PathToken token);
}
