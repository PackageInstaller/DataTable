using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace Cysharp.Threading.Tasks.CompilerServices;

internal sealed class AsyncUniTaskVoid<TStateMachine> : IStateMachineRunner, ITaskPoolNode<AsyncUniTaskVoid<TStateMachine>>, IUniTaskSource where TStateMachine : IAsyncStateMachine
{
	private static TaskPool<AsyncUniTaskVoid<TStateMachine>> pool;

	private TStateMachine stateMachine;

	private AsyncUniTaskVoid<TStateMachine> nextNode;

	public Action ReturnAction { get; }

	public Action MoveNext { get; }

	public ref AsyncUniTaskVoid<TStateMachine> NextNode => ref nextNode;

	public AsyncUniTaskVoid()
	{
		MoveNext = Run;
		ReturnAction = Return;
	}

	public static void SetStateMachine(ref TStateMachine stateMachine, ref IStateMachineRunner runnerFieldRef)
	{
		if (!pool.TryPop(out var result))
		{
			result = new AsyncUniTaskVoid<TStateMachine>();
		}
		runnerFieldRef = result;
		result.stateMachine = stateMachine;
	}

	static AsyncUniTaskVoid()
	{
		TaskPool.RegisterSizeGetter(typeof(AsyncUniTaskVoid<TStateMachine>), () => pool.Size);
	}

	public void Return()
	{
		stateMachine = default(TStateMachine);
		pool.TryPush(this);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	private void Run()
	{
		stateMachine.MoveNext();
	}

	UniTaskStatus IUniTaskSource.GetStatus(short token)
	{
		return UniTaskStatus.Pending;
	}

	UniTaskStatus IUniTaskSource.UnsafeGetStatus()
	{
		return UniTaskStatus.Pending;
	}

	void IUniTaskSource.OnCompleted(Action<object> continuation, object state, short token)
	{
	}

	void IUniTaskSource.GetResult(short token)
	{
	}
}
