namespace GameFramework.Runtime;

public interface IInvoker
{
	object Invoke(params object[] args);
}
