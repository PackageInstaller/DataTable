using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace Cysharp.Threading.Tasks.CompilerServices;

[StructLayout(LayoutKind.Auto)]
public struct AsyncUniTaskVoidMethodBuilder
{
	private IStateMachineRunner runner;

	public UniTaskVoid Task
	{
		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		get
		{
			return default(UniTaskVoid);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public static AsyncUniTaskVoidMethodBuilder Create()
	{
		return default(AsyncUniTaskVoidMethodBuilder);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void SetException(Exception exception)
	{
		if (runner != null)
		{
			PlayerLoopHelper.AddContinuation(PlayerLoopTiming.LastPostLateUpdate, runner.ReturnAction);
			runner = null;
		}
		UniTaskScheduler.PublishUnobservedTaskException(exception);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void SetResult()
	{
		if (runner != null)
		{
			PlayerLoopHelper.AddContinuation(PlayerLoopTiming.LastPostLateUpdate, runner.ReturnAction);
			runner = null;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void AwaitOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : INotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		if (runner == null)
		{
			AsyncUniTaskVoid<TStateMachine>.SetStateMachine(ref stateMachine, ref runner);
		}
		Action moveNext = runner.MoveNext;
		awaiter.OnCompleted(moveNext);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		if (runner == null)
		{
			AsyncUniTaskVoid<TStateMachine>.SetStateMachine(ref stateMachine, ref runner);
		}
		Action moveNext = runner.MoveNext;
		awaiter.UnsafeOnCompleted(moveNext);
	}

	[DebuggerHidden]
	public void Start<TStateMachine>(ref TStateMachine stateMachine) where TStateMachine : IAsyncStateMachine
	{
		stateMachine.MoveNext();
	}

	[DebuggerHidden]
	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
	}
}
