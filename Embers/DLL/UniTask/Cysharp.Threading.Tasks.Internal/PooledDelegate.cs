using System;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.Internal;

internal sealed class PooledDelegate<T> : ITaskPoolNode<PooledDelegate<T>>
{
	private static TaskPool<PooledDelegate<T>> pool;

	private PooledDelegate<T> nextNode;

	private readonly Action<T> runDelegate;

	private Action continuation;

	public ref PooledDelegate<T> NextNode => ref nextNode;

	static PooledDelegate()
	{
		TaskPool.RegisterSizeGetter(typeof(PooledDelegate<T>), () => pool.Size);
	}

	private PooledDelegate()
	{
		runDelegate = Run;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Action<T> Create(Action continuation)
	{
		if (!pool.TryPop(out var result))
		{
			result = new PooledDelegate<T>();
		}
		result.continuation = continuation;
		return result.runDelegate;
	}

	[MethodImpl((MethodImplOptions)256)]
	private void Run(T _)
	{
		Action action = continuation;
		continuation = null;
		if (action != null)
		{
			pool.TryPush(this);
			action();
		}
	}
}
