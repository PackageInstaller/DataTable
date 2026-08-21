using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Runtime.ExceptionServices;
using System.Threading;
using System.Threading.Tasks;
using Internal.Threading.Tasks.Tracing;

namespace System.Runtime.CompilerServices;

public readonly struct TaskAwaiter : ICriticalNotifyCompletion, INotifyCompletion, ITaskAwaiter
{
	internal readonly Task m_task;

	public bool IsCompleted => m_task.IsCompleted;

	internal TaskAwaiter(Task task)
	{
		m_task = task;
	}

	public void OnCompleted(Action continuation)
	{
		OnCompletedInternal(m_task, continuation, continueOnCapturedContext: true, flowExecutionContext: true);
	}

	public void UnsafeOnCompleted(Action continuation)
	{
		OnCompletedInternal(m_task, continuation, continueOnCapturedContext: true, flowExecutionContext: false);
	}

	[StackTraceHidden]
	public void GetResult()
	{
		ValidateEnd(m_task);
	}

	[StackTraceHidden]
	internal static void ValidateEnd(Task task)
	{
		if (task.IsWaitNotificationEnabledOrNotRanToCompletion)
		{
			HandleNonSuccessAndDebuggerNotification(task);
		}
	}

	[StackTraceHidden]
	private static void HandleNonSuccessAndDebuggerNotification(Task task)
	{
		if (!task.IsCompleted)
		{
			task.InternalWait(-1, default(CancellationToken));
		}
		task.NotifyDebuggerOfWaitCompletionIfNecessary();
		if (!task.IsCompletedSuccessfully)
		{
			ThrowForNonSuccess(task);
		}
	}

	[StackTraceHidden]
	private static void ThrowForNonSuccess(Task task)
	{
		switch (task.Status)
		{
		case TaskStatus.Canceled:
			task.GetCancellationExceptionDispatchInfo()?.Throw();
			throw new TaskCanceledException(task);
		case TaskStatus.Faulted:
		{
			ReadOnlyCollection<ExceptionDispatchInfo> exceptionDispatchInfos = task.GetExceptionDispatchInfos();
			if (exceptionDispatchInfos.Count > 0)
			{
				exceptionDispatchInfos[0].Throw();
				break;
			}
			throw task.Exception;
		}
		}
	}

	internal static void OnCompletedInternal(Task task, Action continuation, bool continueOnCapturedContext, bool flowExecutionContext)
	{
		if (continuation == null)
		{
			throw new ArgumentNullException("continuation");
		}
		if (TaskTrace.Enabled)
		{
			continuation = OutputWaitEtwEvents(task, continuation);
		}
		task.SetContinuationForAwait(continuation, continueOnCapturedContext, flowExecutionContext);
	}

	private static Action OutputWaitEtwEvents(Task task, Action continuation)
	{
		Task internalCurrent = Task.InternalCurrent;
		TaskTrace.TaskWaitBegin_Asynchronous(internalCurrent?.m_taskScheduler.Id ?? TaskScheduler.Default.Id, internalCurrent?.Id ?? 0, task.Id);
		return delegate
		{
			if (TaskTrace.Enabled)
			{
				Task internalCurrent2 = Task.InternalCurrent;
				TaskTrace.TaskWaitEnd(internalCurrent2?.m_taskScheduler.Id ?? TaskScheduler.Default.Id, internalCurrent2?.Id ?? 0, task.Id);
			}
			continuation();
		};
	}
}
public readonly struct TaskAwaiter<TResult> : ICriticalNotifyCompletion, INotifyCompletion, ITaskAwaiter
{
	private readonly Task<TResult> m_task;

	public bool IsCompleted => m_task.IsCompleted;

	internal TaskAwaiter(Task<TResult> task)
	{
		m_task = task;
	}

	public void OnCompleted(Action continuation)
	{
		TaskAwaiter.OnCompletedInternal(m_task, continuation, continueOnCapturedContext: true, flowExecutionContext: true);
	}

	public void UnsafeOnCompleted(Action continuation)
	{
		TaskAwaiter.OnCompletedInternal(m_task, continuation, continueOnCapturedContext: true, flowExecutionContext: false);
	}

	[StackTraceHidden]
	public TResult GetResult()
	{
		TaskAwaiter.ValidateEnd(m_task);
		return m_task.ResultOnSuccess;
	}
}
