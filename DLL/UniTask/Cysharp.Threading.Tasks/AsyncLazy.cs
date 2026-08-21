using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public class AsyncLazy
{
	private static Action<object> continuation = SetCompletionSource;

	private Func<UniTask> taskFactory;

	private UniTaskCompletionSource completionSource;

	private UniTask.Awaiter awaiter;

	private object syncLock;

	private bool initialized;

	public UniTask Task
	{
		get
		{
			EnsureInitialized();
			return completionSource.Task;
		}
	}

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

	public UniTask.Awaiter GetAwaiter()
	{
		return Task.GetAwaiter();
	}

	private void EnsureInitialized()
	{
		if (!Volatile.Read(ref initialized))
		{
			EnsureInitializedCore();
		}
	}

	private void EnsureInitializedCore()
	{
		lock (syncLock)
		{
			if (Volatile.Read(ref initialized))
			{
				return;
			}
			Func<UniTask> func = Interlocked.Exchange(ref taskFactory, null);
			if (func != null)
			{
				UniTask.Awaiter awaiter = func().GetAwaiter();
				if (awaiter.IsCompleted)
				{
					SetCompletionSource(in awaiter);
				}
				else
				{
					this.awaiter = awaiter;
					awaiter.SourceOnCompleted(continuation, this);
				}
				Volatile.Write(ref initialized, value: true);
			}
		}
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
			asyncLazy.awaiter = default(UniTask.Awaiter);
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

	public UniTask<T> Task
	{
		get
		{
			EnsureInitialized();
			return completionSource.Task;
		}
	}

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

	public UniTask<T>.Awaiter GetAwaiter()
	{
		return Task.GetAwaiter();
	}

	private void EnsureInitialized()
	{
		if (!Volatile.Read(ref initialized))
		{
			EnsureInitializedCore();
		}
	}

	private void EnsureInitializedCore()
	{
		lock (syncLock)
		{
			if (Volatile.Read(ref initialized))
			{
				return;
			}
			Func<UniTask<T>> func = Interlocked.Exchange(ref taskFactory, null);
			if (func != null)
			{
				UniTask<T>.Awaiter awaiter = func().GetAwaiter();
				if (awaiter.IsCompleted)
				{
					SetCompletionSource(in awaiter);
				}
				else
				{
					this.awaiter = awaiter;
					awaiter.SourceOnCompleted(continuation, this);
				}
				Volatile.Write(ref initialized, value: true);
			}
		}
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
			asyncLazy.awaiter = default(UniTask<T>.Awaiter);
		}
	}
}
