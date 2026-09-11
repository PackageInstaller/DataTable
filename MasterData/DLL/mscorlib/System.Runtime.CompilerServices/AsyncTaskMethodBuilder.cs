using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

public struct AsyncTaskMethodBuilder
{
	private static readonly Task<VoidTaskResult> s_cachedCompleted = AsyncTaskMethodBuilder<VoidTaskResult>.s_defaultResultTask;

	private AsyncTaskMethodBuilder<VoidTaskResult> m_builder;

	public Task Task => m_builder.Task;

	internal object ObjectIdForDebugger => Task;

	public static AsyncTaskMethodBuilder Create()
	{
		return default(AsyncTaskMethodBuilder);
	}

	[DebuggerStepThrough]
	public void Start<TStateMachine>(ref TStateMachine stateMachine) where TStateMachine : IAsyncStateMachine
	{
		if (stateMachine == null)
		{
			throw new ArgumentNullException("stateMachine");
		}
		ExecutionContextSwitcher ecsw = default(ExecutionContextSwitcher);
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			ExecutionContext.EstablishCopyOnWriteScope(ref ecsw);
			stateMachine.MoveNext();
		}
		finally
		{
			ecsw.Undo();
		}
	}

	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
		m_builder.SetStateMachine(stateMachine);
	}

	public void AwaitOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : INotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		m_builder.AwaitOnCompleted(ref awaiter, ref stateMachine);
	}

	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		m_builder.AwaitUnsafeOnCompleted(ref awaiter, ref stateMachine);
	}

	public void SetResult()
	{
		m_builder.SetResult(s_cachedCompleted);
	}

	public void SetException(Exception exception)
	{
		m_builder.SetException(exception);
	}

	internal void SetNotificationForWaitCompletion(bool enabled)
	{
		m_builder.SetNotificationForWaitCompletion(enabled);
	}
}
public struct AsyncTaskMethodBuilder<TResult>
{
	internal static readonly Task<TResult> s_defaultResultTask = AsyncTaskCache.CreateCacheableTask(default(TResult));

	private AsyncMethodBuilderCore m_coreState;

	private Task<TResult> m_task;

	public Task<TResult> Task
	{
		get
		{
			Task<TResult> task = m_task;
			if (task == null)
			{
				task = (m_task = new Task<TResult>());
			}
			return task;
		}
	}

	private object ObjectIdForDebugger => Task;

	public static AsyncTaskMethodBuilder<TResult> Create()
	{
		return default(AsyncTaskMethodBuilder<TResult>);
	}

	[DebuggerStepThrough]
	public void Start<TStateMachine>(ref TStateMachine stateMachine) where TStateMachine : IAsyncStateMachine
	{
		if (stateMachine == null)
		{
			throw new ArgumentNullException("stateMachine");
		}
		ExecutionContextSwitcher ecsw = default(ExecutionContextSwitcher);
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			ExecutionContext.EstablishCopyOnWriteScope(ref ecsw);
			stateMachine.MoveNext();
		}
		finally
		{
			ecsw.Undo();
		}
	}

	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
		m_coreState.SetStateMachine(stateMachine);
	}

	public void AwaitOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : INotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		try
		{
			AsyncMethodBuilderCore.MoveNextRunner runnerToInitialize = null;
			Action completionAction = m_coreState.GetCompletionAction(AsyncCausalityTracer.LoggingOn ? Task : null, ref runnerToInitialize);
			if (m_coreState.m_stateMachine == null)
			{
				Task<TResult> task = Task;
				m_coreState.PostBoxInitialization(stateMachine, runnerToInitialize, task);
			}
			awaiter.OnCompleted(completionAction);
		}
		catch (Exception exception)
		{
			AsyncMethodBuilderCore.ThrowAsync(exception, null);
		}
	}

	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		try
		{
			AsyncMethodBuilderCore.MoveNextRunner runnerToInitialize = null;
			Action completionAction = m_coreState.GetCompletionAction(AsyncCausalityTracer.LoggingOn ? Task : null, ref runnerToInitialize);
			if (m_coreState.m_stateMachine == null)
			{
				Task<TResult> task = Task;
				m_coreState.PostBoxInitialization(stateMachine, runnerToInitialize, task);
			}
			awaiter.UnsafeOnCompleted(completionAction);
		}
		catch (Exception exception)
		{
			AsyncMethodBuilderCore.ThrowAsync(exception, null);
		}
	}

	public void SetResult(TResult result)
	{
		Task<TResult> task = m_task;
		if (task == null)
		{
			m_task = GetTaskForResult(result);
			return;
		}
		if (AsyncCausalityTracer.LoggingOn)
		{
			AsyncCausalityTracer.TraceOperationCompletion(CausalityTraceLevel.Required, task.Id, AsyncCausalityStatus.Completed);
		}
		if (System.Threading.Tasks.Task.s_asyncDebuggingEnabled)
		{
			System.Threading.Tasks.Task.RemoveFromActiveTasks(task.Id);
		}
		if (task.TrySetResult(result))
		{
			return;
		}
		throw new InvalidOperationException(Environment.GetResourceString("An attempt was made to transition a task to a final state when it had already completed."));
	}

	internal void SetResult(Task<TResult> completedTask)
	{
		if (m_task == null)
		{
			m_task = completedTask;
		}
		else
		{
			SetResult(default(TResult));
		}
	}

	public void SetException(Exception exception)
	{
		if (exception == null)
		{
			throw new ArgumentNullException("exception");
		}
		Task<TResult> task = m_task;
		if (task == null)
		{
			task = Task;
		}
		if (!((exception is OperationCanceledException ex) ? task.TrySetCanceled(ex.CancellationToken, ex) : task.TrySetException(exception)))
		{
			throw new InvalidOperationException(Environment.GetResourceString("An attempt was made to transition a task to a final state when it had already completed."));
		}
	}

	internal void SetNotificationForWaitCompletion(bool enabled)
	{
		Task.SetNotificationForWaitCompletion(enabled);
	}

	internal static Task<TResult> GetTaskForResult(TResult result)
	{
		if (default(TResult) != null)
		{
			if (typeof(TResult) == typeof(bool))
			{
				return JitHelpers.UnsafeCast<Task<TResult>>(((bool)(object)result) ? AsyncTaskCache.TrueTask : AsyncTaskCache.FalseTask);
			}
			if (typeof(TResult) == typeof(int))
			{
				int num = (int)(object)result;
				if (num < 9 && num >= -1)
				{
					return JitHelpers.UnsafeCast<Task<TResult>>(AsyncTaskCache.Int32Tasks[num - -1]);
				}
			}
			else if ((typeof(TResult) == typeof(uint) && (uint)(object)result == 0) || (typeof(TResult) == typeof(byte) && (byte)(object)result == 0) || (typeof(TResult) == typeof(sbyte) && (sbyte)(object)result == 0) || (typeof(TResult) == typeof(char) && (char)(object)result == '\0') || (typeof(TResult) == typeof(long) && (long)(object)result == 0L) || (typeof(TResult) == typeof(ulong) && (ulong)(object)result == 0L) || (typeof(TResult) == typeof(short) && (short)(object)result == 0) || (typeof(TResult) == typeof(ushort) && (ushort)(object)result == 0) || (typeof(TResult) == typeof(IntPtr) && (IntPtr)0 == (IntPtr)(object)result) || (typeof(TResult) == typeof(UIntPtr) && (UIntPtr)0u == (UIntPtr)(object)result))
			{
				return s_defaultResultTask;
			}
		}
		else if (result == null)
		{
			return s_defaultResultTask;
		}
		return new Task<TResult>(result);
	}
}
