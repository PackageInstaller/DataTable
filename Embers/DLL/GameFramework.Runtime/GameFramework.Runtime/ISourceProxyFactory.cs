namespace GameFramework.Runtime;

public interface ISourceProxyFactory
{
	ISourceProxy CreateProxy(object source, SourceDescription description);
}
