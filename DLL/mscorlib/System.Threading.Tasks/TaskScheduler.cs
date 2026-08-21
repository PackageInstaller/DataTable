using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace System.Threading.Tasks;

[DebuggerTypeProxy(typeof(SystemThreadingTasks_TaskSchedulerDebugView))]
[DebuggerDisplay("Id={Id}")]
public abstract class TaskScheduler
{
	internal sealed class SystemThreadingTasks_TaskSchedulerDebugView
	{
	}

	private static ConditionalWeakTable<TaskScheduler, object> s_activeTaskSchedulers;

	private static readonly TaskScheduler s_defaultTaskScheduler = new ThreadPoolTaskScheduler();

	internal static int s_taskSchedulerIdCounter;

	private volatile int m_taskSchedulerId;

	private static EventHandler<UnobservedTaskExceptionEventArgs> _unobservedTaskException;

	private static readonly Lock _unobservedTaskExceptionLockObject = new Lock();

	internal virtual bool RequiresAtomicStartTransition => true;

	public static TaskScheduler Default => s_defaultTaskScheduler;

	public static TaskScheduler Current => InternalCurrent ?? Default;

	internal static TaskScheduler InternalCurrent
	{
		get
		{
			Task internalCurrent = Task.InternalCurrent;
			if (internalCurrent == null || (internalCurrent.CreationOptions & TaskCreationOptions.HideScheduler) != TaskCreationOptions.None)
			{
				return null;
			}
			return internalCurrent.ExecutingTaskScheduler;
		}
	}

	public int Id
	{
		get
		{
			if (m_taskSchedulerId == 0)
			{
				int num = 0;
				do
				{
					num = Interlocked.Increment(ref s_taskSchedulerIdCounter);
				}
				while (num == 0);
				Interlocked.CompareExchange(ref m_taskSchedulerId, num, 0);
			}
			return m_taskSchedulerId;
		}
	}

	protected internal abstract void QueueTask(Task task);

	protected abstract bool TryExecuteTaskInline(Task task, bool taskWasPreviouslyQueued);

	internal bool TryRunInline(Task task, bool taskWasPreviouslyQueued)
	{
		TaskScheduler executingTaskScheduler = task.ExecutingTaskScheduler;
		if (executingTaskScheduler != this && executingTaskScheduler != null)
		{
			return executingTaskScheduler.TryRunInline(task, taskWasPreviouslyQueued);
		}
		StackGuard currentStackGuard;
		if (executingTaskScheduler == null || (object)task.m_action == null || task.IsDelegateInvoked || task.IsCanceled || !(currentStackGuard = Task.CurrentStackGuard).TryBeginInliningScope())
		{
			return false;
		}
		bool flag = false;
		try
		{
			flag = TryExecuteTaskInline(task, taskWasPreviouslyQueued);
		}
		finally
		{
			currentStackGuard.EndInliningScope();
		}
		if (flag && !task.IsDelegateInvoked && !task.IsCanceled)
		{
			throw new InvalidOperationException("The TryExecuteTaskInline call to the underlying scheduler succeeded, but the task body was not invoked.");
		}
		return flag;
	}

	protected internal virtual bool TryDequeue(Task task)
	{
		return false;
	}

	internal virtual void NotifyWorkItemProgress()
	{
	}

	public static TaskScheduler FromCurrentSynchronizationContext()
	{
		return new SynchronizationContextTaskScheduler();
	}

	protected bool TryExecuteTask(Task task)
	{
		if (task.ExecutingTaskScheduler != this)
		{
			throw new InvalidOperationException("ExecuteTask may not be called for a task which was previously queued to a different TaskScheduler.");
		}
		return task.ExecuteEntry(bPreventDoubleExecution: true);
	}

	internal static void PublishUnobservedTaskException(object sender, UnobservedTaskExceptionEventArgs ueea)
	{
		using (LockHolder.Hold(_unobservedTaskExceptionLockObject))
		{
			_unobservedTaskException?.Invoke(sender, ueea);
		}
	}
}
