using System;

namespace GameFramework.Runtime;

public interface IMainLoopExecutor
{
	void RunOnMainThread(Action action, bool waitForExecution = false);

	TResult RunOnMainThread<TResult>(Func<TResult> func);
}
