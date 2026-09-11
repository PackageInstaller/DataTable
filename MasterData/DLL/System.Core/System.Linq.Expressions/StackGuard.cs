using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Linq.Expressions;

internal sealed class StackGuard
{
	private int _executionStackCount;

	public bool TryEnterOnCurrentStack()
	{
		if (RuntimeHelpers.TryEnsureSufficientExecutionStack())
		{
			return true;
		}
		if (_executionStackCount < 1024)
		{
			return false;
		}
		throw new InsufficientExecutionStackException();
	}

	public void RunOnEmptyStack<T1, T2>(Action<T1, T2> action, T1 arg1, T2 arg2)
	{
		RunOnEmptyStackCore(delegate(object s)
		{
			Tuple<Action<T1, T2>, T1, T2> tuple = (Tuple<Action<T1, T2>, T1, T2>)s;
			tuple.Item1(tuple.Item2, tuple.Item3);
			return (object)null;
		}, Tuple.Create(action, arg1, arg2));
	}

	private R RunOnEmptyStackCore<R>(Func<object, R> action, object state)
	{
		_executionStackCount++;
		try
		{
			Task<R> task = Task.Factory.StartNew(action, state, CancellationToken.None, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default);
			TaskAwaiter<R> awaiter = task.GetAwaiter();
			if (!awaiter.IsCompleted)
			{
				((IAsyncResult)task).AsyncWaitHandle.WaitOne();
			}
			return awaiter.GetResult();
		}
		finally
		{
			_executionStackCount--;
		}
	}
}
