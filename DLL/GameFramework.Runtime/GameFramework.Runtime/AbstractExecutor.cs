namespace GameFramework.Runtime;

public abstract class AbstractExecutor
{
	static AbstractExecutor()
	{
		Executors.Create();
	}
}
