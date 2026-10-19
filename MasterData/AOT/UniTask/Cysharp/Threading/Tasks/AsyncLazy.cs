using System;

namespace Cysharp.Threading.Tasks;

public class AsyncLazy
{
	private static Action<object> continuation = SetCompletionSource;

	private Func<UniTask> taskFactory;

	private UniTaskCompletionSource completionSource;

	private UniTask.Awaiter awaiter;

	private object syncLock;

	private bool initialized;

	public AsyncLazy(Func<UniTask> taskFactory)
	{
		this.taskFactory = taskFactory;
		completionSource = new UniTaskCompletionSource();
		syncLock = new object();
		initialized = false;
	}

	internal AsyncLazy(UniTask task)
	{
		taskFactory = null;
		completionSource = new UniTaskCompletionSource();
		syncLock = null;
		initialized = true;
		UniTask.Awaiter awaiter = task.GetAwaiter();
		if (awaiter.IsCompleted)
		{
			SetCompletionSource(in awaiter);
			return;
		}
		this.awaiter = awaiter;
		awaiter.SourceOnCompleted(continuation, this);
	}

	private void SetCompletionSource(in UniTask.Awaiter awaiter)
	{
		try
		{
			awaiter.GetResult();
			completionSource.TrySetResult();
		}
		catch (Exception exception)
		{
			completionSource.TrySetException(exception);
		}
	}

	private static void SetCompletionSource(object state)
	{
		AsyncLazy asyncLazy = (AsyncLazy)state;
		try
		{
			asyncLazy.awaiter.GetResult();
			asyncLazy.completionSource.TrySetResult();
		}
		catch (Exception exception)
		{
			asyncLazy.completionSource.TrySetException(exception);
		}
		finally
		{
			asyncLazy.awaiter = default;
		}
	}
}
public class AsyncLazy<T>
{
	private static Action<object> continuation = SetCompletionSource;

	private Func<UniTask<T>> taskFactory;

	private UniTaskCompletionSource<T> completionSource;

	private UniTask<T>.Awaiter awaiter;

	private object syncLock;

	private bool initialized;

	public AsyncLazy(Func<UniTask<T>> taskFactory)
	{
		this.taskFactory = taskFactory;
		completionSource = new UniTaskCompletionSource<T>();
		syncLock = new object();
		initialized = false;
	}

	internal AsyncLazy(UniTask<T> task)
	{
		taskFactory = null;
		completionSource = new UniTaskCompletionSource<T>();
		syncLock = null;
		initialized = true;
		UniTask<T>.Awaiter awaiter = task.GetAwaiter();
		if (awaiter.IsCompleted)
		{
			SetCompletionSource(in awaiter);
			return;
		}
		this.awaiter = awaiter;
		awaiter.SourceOnCompleted(continuation, this);
	}

	private void SetCompletionSource(in UniTask<T>.Awaiter awaiter)
	{
		try
		{
			T result = awaiter.GetResult();
			completionSource.TrySetResult(result);
		}
		catch (Exception exception)
		{
			completionSource.TrySetException(exception);
		}
	}

	private static void SetCompletionSource(object state)
	{
		AsyncLazy<T> asyncLazy = (AsyncLazy<T>)state;
		try
		{
			T result = asyncLazy.awaiter.GetResult();
			asyncLazy.completionSource.TrySetResult(result);
		}
		catch (Exception exception)
		{
			asyncLazy.completionSource.TrySetException(exception);
		}
		finally
		{
			asyncLazy.awaiter = default;
		}
	}
}
