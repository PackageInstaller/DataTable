using System.Runtime.CompilerServices;
using Internal.Runtime.Augments;

namespace System.Threading.Tasks;

internal class AwaitTaskContinuation : TaskContinuation, IThreadPoolWorkItem
{
	private readonly ExecutionContext m_capturedContext;

	protected readonly Action m_action;

	private static ContextCallback s_invokeActionCallback;

	internal static bool IsValidLocationForInlining
	{
		get
		{
			SynchronizationContext current = SynchronizationContext.Current;
			if (current != null && current.GetType() != typeof(SynchronizationContext))
			{
				return false;
			}
			TaskScheduler internalCurrent = TaskScheduler.InternalCurrent;
			if (internalCurrent != null)
			{
				return internalCurrent == TaskScheduler.Default;
			}
			return true;
		}
	}

	internal AwaitTaskContinuation(Action action, bool flowExecutionContext)
	{
		m_action = action;
		if (flowExecutionContext)
		{
			m_capturedContext = ExecutionContext.Capture();
		}
	}

	protected Task CreateTask(Action<object> action, object state, TaskScheduler scheduler)
	{
		return new Task(action, state, null, default(CancellationToken), TaskCreationOptions.None, InternalTaskOptions.QueuedByRuntime, scheduler);
	}

	internal override void Run(Task ignored, bool canInlineContinuationTask)
	{
		if (canInlineContinuationTask && IsValidLocationForInlining)
		{
			RunCallback(GetInvokeActionCallback(), m_action, ref Task.t_currentTask);
		}
		else
		{
			ThreadPool.UnsafeQueueCustomWorkItem(this, forceGlobal: false);
		}
	}

	void IThreadPoolWorkItem.ExecuteWorkItem()
	{
		if (m_capturedContext == null)
		{
			m_action();
		}
		else
		{
			ExecutionContext.Run(m_capturedContext, GetInvokeActionCallback(), m_action);
		}
	}

	private static void InvokeAction(object state)
	{
		((Action)state)();
	}

	[MethodImpl((MethodImplOptions)256)]
	protected static ContextCallback GetInvokeActionCallback()
	{
		return InvokeAction;
	}

	protected void RunCallback(ContextCallback callback, object state, ref Task currentTask)
	{
		Task task = currentTask;
		SynchronizationContext currentExplicit = SynchronizationContext.CurrentExplicit;
		try
		{
			if (task != null)
			{
				currentTask = null;
			}
			callback(state);
		}
		catch (Exception exc)
		{
			ThrowAsyncIfNecessary(exc);
		}
		finally
		{
			if (task != null)
			{
				currentTask = task;
			}
			SynchronizationContext.SetSynchronizationContext(currentExplicit);
		}
	}

	internal static void RunOrScheduleAction(Action action, bool allowInlining, ref Task currentTask)
	{
		if (!allowInlining || !IsValidLocationForInlining)
		{
			UnsafeScheduleAction(action);
			return;
		}
		Task task = currentTask;
		try
		{
			if (task != null)
			{
				currentTask = null;
			}
			action();
		}
		catch (Exception exc)
		{
			ThrowAsyncIfNecessary(exc);
		}
		finally
		{
			if (task != null)
			{
				currentTask = task;
			}
		}
	}

	internal static void UnsafeScheduleAction(Action action)
	{
		ThreadPool.UnsafeQueueCustomWorkItem(new AwaitTaskContinuation(action, flowExecutionContext: false), forceGlobal: false);
	}

	protected static void ThrowAsyncIfNecessary(Exception exc)
	{
		RuntimeAugments.ReportUnhandledException(exc);
	}

	internal override Delegate[] GetDelegateContinuationsForDebugger()
	{
		return new Delegate[1] { AsyncMethodBuilderCore.TryGetStateMachineForDebugger(m_action) };
	}

	public void MarkAborted(ThreadAbortException e)
	{
	}
}
