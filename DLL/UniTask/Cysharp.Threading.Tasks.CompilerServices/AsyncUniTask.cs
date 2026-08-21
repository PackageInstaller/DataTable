using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.CompilerServices;

internal sealed class AsyncUniTask<TStateMachine> : IStateMachineRunnerPromise, IUniTaskSource, ITaskPoolNode<AsyncUniTask<TStateMachine>> where TStateMachine : IAsyncStateMachine
{
	private static TaskPool<AsyncUniTask<TStateMachine>> pool;

	private readonly Action returnDelegate;

	private TStateMachine stateMachine;

	private UniTaskCompletionSourceCore<AsyncUnit> core;

	private AsyncUniTask<TStateMachine> nextNode;

	public Action MoveNext { get; }

	public ref AsyncUniTask<TStateMachine> NextNode => ref nextNode;

	public UniTask Task
	{
		[DebuggerHidden]
		get
		{
			return new UniTask(this, core.Version);
		}
	}

	private AsyncUniTask()
	{
		MoveNext = Run;
		returnDelegate = Return;
	}

	public static void SetStateMachine(ref TStateMachine stateMachine, ref IStateMachineRunnerPromise runnerPromiseFieldRef)
	{
		if (!pool.TryPop(out var result))
		{
			result = new AsyncUniTask<TStateMachine>();
		}
		runnerPromiseFieldRef = result;
		result.stateMachine = stateMachine;
	}

	static AsyncUniTask()
	{
		TaskPool.RegisterSizeGetter(typeof(AsyncUniTask<TStateMachine>), () => pool.Size);
	}

	private void Return()
	{
		core.Reset();
		stateMachine = default(TStateMachine);
		pool.TryPush(this);
	}

	private bool TryReturn()
	{
		core.Reset();
		stateMachine = default(TStateMachine);
		return pool.TryPush(this);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	private void Run()
	{
		stateMachine.MoveNext();
	}

	[DebuggerHidden]
	public void SetResult()
	{
		core.TrySetResult(AsyncUnit.Default);
	}

	[DebuggerHidden]
	public void SetException(Exception exception)
	{
		core.TrySetException(exception);
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
			PlayerLoopHelper.AddContinuation(PlayerLoopTiming.LastPostLateUpdate, returnDelegate);
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
}
internal sealed class AsyncUniTask<TStateMachine, T> : IStateMachineRunnerPromise<T>, IUniTaskSource<T>, IUniTaskSource, ITaskPoolNode<AsyncUniTask<TStateMachine, T>> where TStateMachine : IAsyncStateMachine
{
	private static TaskPool<AsyncUniTask<TStateMachine, T>> pool;

	private readonly Action returnDelegate;

	private TStateMachine stateMachine;

	private UniTaskCompletionSourceCore<T> core;

	private AsyncUniTask<TStateMachine, T> nextNode;

	public Action MoveNext { get; }

	public ref AsyncUniTask<TStateMachine, T> NextNode => ref nextNode;

	public UniTask<T> Task
	{
		[DebuggerHidden]
		get
		{
			return new UniTask<T>(this, core.Version);
		}
	}

	private AsyncUniTask()
	{
		MoveNext = Run;
		returnDelegate = Return;
	}

	public static void SetStateMachine(ref TStateMachine stateMachine, ref IStateMachineRunnerPromise<T> runnerPromiseFieldRef)
	{
		if (!pool.TryPop(out var result))
		{
			result = new AsyncUniTask<TStateMachine, T>();
		}
		runnerPromiseFieldRef = result;
		result.stateMachine = stateMachine;
	}

	static AsyncUniTask()
	{
		TaskPool.RegisterSizeGetter(typeof(AsyncUniTask<TStateMachine, T>), () => pool.Size);
	}

	private void Return()
	{
		core.Reset();
		stateMachine = default(TStateMachine);
		pool.TryPush(this);
	}

	private bool TryReturn()
	{
		core.Reset();
		stateMachine = default(TStateMachine);
		return pool.TryPush(this);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	private void Run()
	{
		stateMachine.MoveNext();
	}

	[DebuggerHidden]
	public void SetResult(T result)
	{
		core.TrySetResult(result);
	}

	[DebuggerHidden]
	public void SetException(Exception exception)
	{
		core.TrySetException(exception);
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
			PlayerLoopHelper.AddContinuation(PlayerLoopTiming.LastPostLateUpdate, returnDelegate);
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
}
