using System;

namespace Cysharp.Threading.Tasks;

public abstract class MoveNextSource : IUniTaskSource<bool>, IUniTaskSource
{
	protected UniTaskCompletionSourceCore<bool> completionSource;

	public bool GetResult(short token)
	{
		return completionSource.GetResult(token);
	}

	public UniTaskStatus GetStatus(short token)
	{
		return completionSource.GetStatus(token);
	}

	public void OnCompleted(Action<object> continuation, object state, short token)
	{
		completionSource.OnCompleted(continuation, state, token);
	}

	public UniTaskStatus UnsafeGetStatus()
	{
		return completionSource.UnsafeGetStatus();
	}

	void IUniTaskSource.GetResult(short token)
	{
		completionSource.GetResult(token);
	}

	protected bool TryGetResult<T>(UniTask<T>.Awaiter awaiter, out T result)
	{
		try
		{
			result = awaiter.GetResult();
			return true;
		}
		catch (Exception error)
		{
			completionSource.TrySetException(error);
			result = default(T);
			return false;
		}
	}

	protected bool TryGetResult(UniTask.Awaiter awaiter)
	{
		try
		{
			awaiter.GetResult();
			return true;
		}
		catch (Exception error)
		{
			completionSource.TrySetException(error);
			return false;
		}
	}
}
