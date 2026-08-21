using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace Cysharp.Threading.Tasks.CompilerServices;

[StructLayout(LayoutKind.Auto)]
public struct AsyncUniTaskMethodBuilder
{
	private IStateMachineRunnerPromise runnerPromise;

	private Exception ex;

	public UniTask Task
	{
		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		get
		{
			if (runnerPromise != null)
			{
				return runnerPromise.Task;
			}
			if (ex != null)
			{
				return UniTask.FromException(ex);
			}
			return UniTask.CompletedTask;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public static AsyncUniTaskMethodBuilder Create()
	{
		return default(AsyncUniTaskMethodBuilder);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void SetException(Exception exception)
	{
		if (runnerPromise == null)
		{
			ex = exception;
		}
		else
		{
			runnerPromise.SetException(exception);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void SetResult()
	{
		if (runnerPromise != null)
		{
			runnerPromise.SetResult();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void AwaitOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : INotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		if (runnerPromise == null)
		{
			AsyncUniTask<TStateMachine>.SetStateMachine(ref stateMachine, ref runnerPromise);
		}
		Action moveNext = runnerPromise.MoveNext;
		awaiter.OnCompleted(moveNext);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		if (runnerPromise == null)
		{
			AsyncUniTask<TStateMachine>.SetStateMachine(ref stateMachine, ref runnerPromise);
		}
		Action moveNext = runnerPromise.MoveNext;
		awaiter.UnsafeOnCompleted(moveNext);
	}

	[MethodImpl((MethodImplOptions)256)]
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
[StructLayout(LayoutKind.Auto)]
public struct AsyncUniTaskMethodBuilder<T>
{
	private IStateMachineRunnerPromise<T> runnerPromise;

	private Exception ex;

	private T result;

	public UniTask<T> Task
	{
		[MethodImpl((MethodImplOptions)256)]
		[DebuggerHidden]
		get
		{
			if (runnerPromise != null)
			{
				return runnerPromise.Task;
			}
			if (ex != null)
			{
				return UniTask.FromException<T>(ex);
			}
			return UniTask.FromResult(result);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public static AsyncUniTaskMethodBuilder<T> Create()
	{
		return default(AsyncUniTaskMethodBuilder<T>);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void SetException(Exception exception)
	{
		if (runnerPromise == null)
		{
			ex = exception;
		}
		else
		{
			runnerPromise.SetException(exception);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void SetResult(T result)
	{
		if (runnerPromise == null)
		{
			this.result = result;
		}
		else
		{
			runnerPromise.SetResult(result);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void AwaitOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : INotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		if (runnerPromise == null)
		{
			AsyncUniTask<TStateMachine, T>.SetStateMachine(ref stateMachine, ref runnerPromise);
		}
		Action moveNext = runnerPromise.MoveNext;
		awaiter.OnCompleted(moveNext);
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		if (runnerPromise == null)
		{
			AsyncUniTask<TStateMachine, T>.SetStateMachine(ref stateMachine, ref runnerPromise);
		}
		Action moveNext = runnerPromise.MoveNext;
		awaiter.UnsafeOnCompleted(moveNext);
	}

	[MethodImpl((MethodImplOptions)256)]
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
