using System;
using System.Diagnostics;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public class AutoResetUniTaskCompletionSource : IUniTaskSource, ITaskPoolNode<AutoResetUniTaskCompletionSource>, IPromise, IResolvePromise, IRejectPromise, ICancelPromise
{
	private static TaskPool<AutoResetUniTaskCompletionSource> pool;

	private AutoResetUniTaskCompletionSource nextNode;

	private UniTaskCompletionSourceCore<AsyncUnit> core;

	private short version;

	public ref AutoResetUniTaskCompletionSource NextNode => ref nextNode;

	public UniTask Task
	{
		[DebuggerHidden]
		get
		{
			return new UniTask(this, core.Version);
		}
	}

	static AutoResetUniTaskCompletionSource()
	{
		TaskPool.RegisterSizeGetter(typeof(AutoResetUniTaskCompletionSource), () => pool.Size);
	}

	private AutoResetUniTaskCompletionSource()
	{
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource Create()
	{
		if (!pool.TryPop(out var result))
		{
			result = new AutoResetUniTaskCompletionSource();
		}
		result.version = result.core.Version;
		return result;
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource CreateFromCanceled(CancellationToken cancellationToken, out short token)
	{
		AutoResetUniTaskCompletionSource autoResetUniTaskCompletionSource = Create();
		autoResetUniTaskCompletionSource.TrySetCanceled(cancellationToken);
		token = autoResetUniTaskCompletionSource.core.Version;
		return autoResetUniTaskCompletionSource;
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource CreateFromException(Exception exception, out short token)
	{
		AutoResetUniTaskCompletionSource autoResetUniTaskCompletionSource = Create();
		autoResetUniTaskCompletionSource.TrySetException(exception);
		token = autoResetUniTaskCompletionSource.core.Version;
		return autoResetUniTaskCompletionSource;
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource CreateCompleted(out short token)
	{
		AutoResetUniTaskCompletionSource autoResetUniTaskCompletionSource = Create();
		autoResetUniTaskCompletionSource.TrySetResult();
		token = autoResetUniTaskCompletionSource.core.Version;
		return autoResetUniTaskCompletionSource;
	}

	[DebuggerHidden]
	public bool TrySetResult()
	{
		if (version == core.Version)
		{
			return core.TrySetResult(AsyncUnit.Default);
		}
		return false;
	}

	[DebuggerHidden]
	public bool TrySetCanceled(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (version == core.Version)
		{
			return core.TrySetCanceled(cancellationToken);
		}
		return false;
	}

	[DebuggerHidden]
	public bool TrySetException(Exception exception)
	{
		if (version == core.Version)
		{
			return core.TrySetException(exception);
		}
		return false;
	}

	[DebuggerHidden]
	public void GetResult(short token)
	{
		try
		{
			core.GetResult(token);
		}
		finally
		{
			TryReturn();
		}
	}

	[DebuggerHidden]
	public UniTaskStatus GetStatus(short token)
	{
		return core.GetStatus(token);
	}

	[DebuggerHidden]
	public UniTaskStatus UnsafeGetStatus()
	{
		return core.UnsafeGetStatus();
	}

	[DebuggerHidden]
	public void OnCompleted(Action<object> continuation, object state, short token)
	{
		core.OnCompleted(continuation, state, token);
	}

	[DebuggerHidden]
	private bool TryReturn()
	{
		core.Reset();
		return pool.TryPush(this);
	}
}
public class AutoResetUniTaskCompletionSource<T> : IUniTaskSource<T>, IUniTaskSource, ITaskPoolNode<AutoResetUniTaskCompletionSource<T>>, IPromise<T>, IResolvePromise<T>, IRejectPromise, ICancelPromise
{
	private static TaskPool<AutoResetUniTaskCompletionSource<T>> pool;

	private AutoResetUniTaskCompletionSource<T> nextNode;

	private UniTaskCompletionSourceCore<T> core;

	private short version;

	public ref AutoResetUniTaskCompletionSource<T> NextNode => ref nextNode;

	public UniTask<T> Task
	{
		[DebuggerHidden]
		get
		{
			return new UniTask<T>(this, core.Version);
		}
	}

	static AutoResetUniTaskCompletionSource()
	{
		TaskPool.RegisterSizeGetter(typeof(AutoResetUniTaskCompletionSource<T>), () => pool.Size);
	}

	private AutoResetUniTaskCompletionSource()
	{
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource<T> Create()
	{
		if (!pool.TryPop(out var result))
		{
			result = new AutoResetUniTaskCompletionSource<T>();
		}
		result.version = result.core.Version;
		return result;
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource<T> CreateFromCanceled(CancellationToken cancellationToken, out short token)
	{
		AutoResetUniTaskCompletionSource<T> autoResetUniTaskCompletionSource = Create();
		autoResetUniTaskCompletionSource.TrySetCanceled(cancellationToken);
		token = autoResetUniTaskCompletionSource.core.Version;
		return autoResetUniTaskCompletionSource;
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource<T> CreateFromException(Exception exception, out short token)
	{
		AutoResetUniTaskCompletionSource<T> autoResetUniTaskCompletionSource = Create();
		autoResetUniTaskCompletionSource.TrySetException(exception);
		token = autoResetUniTaskCompletionSource.core.Version;
		return autoResetUniTaskCompletionSource;
	}

	[DebuggerHidden]
	public static AutoResetUniTaskCompletionSource<T> CreateFromResult(T result, out short token)
	{
		AutoResetUniTaskCompletionSource<T> autoResetUniTaskCompletionSource = Create();
		autoResetUniTaskCompletionSource.TrySetResult(result);
		token = autoResetUniTaskCompletionSource.core.Version;
		return autoResetUniTaskCompletionSource;
	}

	[DebuggerHidden]
	public bool TrySetResult(T result)
	{
		if (version == core.Version)
		{
			return core.TrySetResult(result);
		}
		return false;
	}

	[DebuggerHidden]
	public bool TrySetCanceled(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (version == core.Version)
		{
			return core.TrySetCanceled(cancellationToken);
		}
		return false;
	}

	[DebuggerHidden]
	public bool TrySetException(Exception exception)
	{
		if (version == core.Version)
		{
			return core.TrySetException(exception);
		}
		return false;
	}

	[DebuggerHidden]
	public T GetResult(short token)
	{
		try
		{
			return core.GetResult(token);
		}
		finally
		{
			TryReturn();
		}
	}

	[DebuggerHidden]
	void IUniTaskSource.GetResult(short token)
	{
		GetResult(token);
	}

	[DebuggerHidden]
	public UniTaskStatus GetStatus(short token)
	{
		return core.GetStatus(token);
	}

	[DebuggerHidden]
	public UniTaskStatus UnsafeGetStatus()
	{
		return core.UnsafeGetStatus();
	}

	[DebuggerHidden]
	public void OnCompleted(Action<object> continuation, object state, short token)
	{
		core.OnCompleted(continuation, state, token);
	}

	[DebuggerHidden]
	private bool TryReturn()
	{
		core.Reset();
		return pool.TryPush(this);
	}
}
