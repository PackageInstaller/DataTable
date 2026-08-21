using System;
using System.Runtime.CompilerServices;
using UnityEngine;

namespace GameFramework.Runtime;

public struct AsyncOperationAwaiter(AsyncOperation asyncOperation) : IAwaiter, ICriticalNotifyCompletion, INotifyCompletion
{
	private AsyncOperation asyncOperation = asyncOperation;

	private Action<AsyncOperation> continuationAction = null;

	public bool IsCompleted => asyncOperation.isDone;

	public void GetResult()
	{
		if (!IsCompleted)
		{
			throw new Exception("The task is not finished yet");
		}
		if (continuationAction != null)
		{
			asyncOperation.completed -= continuationAction;
		}
		continuationAction = null;
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
		if (asyncOperation.isDone)
		{
			continuation();
			return;
		}
		continuationAction = delegate
		{
			continuation();
		};
		asyncOperation.completed += continuationAction;
	}
}
public struct AsyncOperationAwaiter<T, TResult>(T asyncOperation, Func<T, TResult> getter) : IAwaiter<TResult>, ICriticalNotifyCompletion, INotifyCompletion where T : AsyncOperation
{
	private T asyncOperation = asyncOperation ?? throw new ArgumentNullException("asyncOperation");

	private Func<T, TResult> getter = getter ?? throw new ArgumentNullException("getter");

	private Action<AsyncOperation> continuationAction = null;

	public bool IsCompleted => asyncOperation.isDone;

	public TResult GetResult()
	{
		if (!IsCompleted)
		{
			throw new Exception("The task is not finished yet");
		}
		if (continuationAction != null)
		{
			asyncOperation.completed -= continuationAction;
			continuationAction = null;
		}
		return getter(asyncOperation);
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
		if (asyncOperation.isDone)
		{
			continuation();
			return;
		}
		continuationAction = delegate
		{
			continuation();
		};
		asyncOperation.completed += continuationAction;
	}
}
