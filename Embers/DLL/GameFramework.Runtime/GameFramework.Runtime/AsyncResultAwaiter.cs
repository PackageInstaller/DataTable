using System;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;

namespace GameFramework.Runtime;

public struct AsyncResultAwaiter<T> : IAwaiter, ICriticalNotifyCompletion, INotifyCompletion where T : IAsyncResult
{
	private T asyncResult;

	public bool IsCompleted => asyncResult.IsDone;

	public AsyncResultAwaiter(T asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		this.asyncResult = asyncResult;
	}

	public void GetResult()
	{
		if (!IsCompleted)
		{
			throw new Exception("The task is not finished yet");
		}
		if (asyncResult.Exception != null)
		{
			ExceptionDispatchInfo.Capture(asyncResult.Exception).Throw();
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
		asyncResult.Callbackable().OnCallback(delegate
		{
			continuation();
		});
	}
}
public struct AsyncResultAwaiter<T, TResult> : IAwaiter<TResult>, ICriticalNotifyCompletion, INotifyCompletion where T : IAsyncResult<TResult>
{
	private T asyncResult;

	public bool IsCompleted => asyncResult.IsDone;

	public AsyncResultAwaiter(T asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		this.asyncResult = asyncResult;
	}

	public TResult GetResult()
	{
		if (!IsCompleted)
		{
			throw new Exception("The task is not finished yet");
		}
		if (asyncResult.Exception != null)
		{
			ExceptionDispatchInfo.Capture(asyncResult.Exception).Throw();
		}
		return asyncResult.Result;
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
		asyncResult.Callbackable().OnCallback(delegate
		{
			continuation();
		});
	}
}
