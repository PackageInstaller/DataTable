using System;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;

namespace GameFramework.Runtime;

public class CoroutineAwaiter : IAwaiter, ICriticalNotifyCompletion, INotifyCompletion
{
	protected object _lock = new object();

	protected bool done = false;

	protected Exception exception;

	protected Action continuation;

	public bool IsCompleted => done;

	public void GetResult()
	{
		lock (_lock)
		{
			if (!done)
			{
				throw new Exception("The task is not finished yet");
			}
		}
		if (exception != null)
		{
			ExceptionDispatchInfo.Capture(exception).Throw();
		}
	}

	public void SetResult(Exception exception)
	{
		lock (_lock)
		{
			if (done)
			{
				return;
			}
			this.exception = exception;
			done = true;
			try
			{
				if (continuation != null)
				{
					continuation();
				}
			}
			catch (Exception)
			{
			}
			finally
			{
				continuation = null;
			}
		}
	}

	public void OnCompleted(Action continuation)
	{
		UnsafeOnCompleted(continuation);
	}

	public void UnsafeOnCompleted(Action continuation)
	{
		if (continuation == null)
		{
			throw new ArgumentNullException("continuation");
		}
		lock (_lock)
		{
			if (done)
			{
				continuation();
			}
			else
			{
				this.continuation = (Action)Delegate.Combine(this.continuation, continuation);
			}
		}
	}
}
public class CoroutineAwaiter<T> : CoroutineAwaiter, IAwaiter<T>, ICriticalNotifyCompletion, INotifyCompletion
{
	protected T result;

	public new T GetResult()
	{
		lock (_lock)
		{
			if (!done)
			{
				throw new Exception("The task is not finished yet");
			}
		}
		if (exception != null)
		{
			ExceptionDispatchInfo.Capture(exception).Throw();
		}
		return result;
	}

	public void SetResult(T result, Exception exception)
	{
		lock (_lock)
		{
			if (done)
			{
				return;
			}
			this.result = result;
			base.exception = exception;
			done = true;
			try
			{
				if (continuation != null)
				{
					continuation();
				}
			}
			catch (Exception)
			{
			}
			finally
			{
				continuation = null;
			}
		}
	}
}
