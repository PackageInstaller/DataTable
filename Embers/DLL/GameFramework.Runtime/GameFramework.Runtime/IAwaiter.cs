using System.Runtime.CompilerServices;

namespace GameFramework.Runtime;

public interface IAwaiter : ICriticalNotifyCompletion, INotifyCompletion
{
	bool IsCompleted { get; }

	void GetResult();
}
public interface IAwaiter<T> : ICriticalNotifyCompletion, INotifyCompletion
{
	bool IsCompleted { get; }

	T GetResult();
}
