using Internal.Runtime.Augments;
using Internal.Threading.Tasks.Tracing;

namespace System.Threading.Tasks;

internal sealed class ThreadPoolTaskScheduler : TaskScheduler
{
	private static readonly ParameterizedThreadStart s_longRunningThreadWork = delegate(object s)
	{
		((Task)s).ExecuteEntry(bPreventDoubleExecution: false);
	};

	internal override bool RequiresAtomicStartTransition => false;

	internal ThreadPoolTaskScheduler()
	{
	}

	protected internal override void QueueTask(Task task)
	{
		if (TaskTrace.Enabled)
		{
			Task internalCurrent = Task.InternalCurrent;
			Task parent = task.m_parent;
			TaskTrace.TaskScheduled(base.Id, internalCurrent?.Id ?? 0, task.Id, parent?.Id ?? 0, (int)task.Options);
		}
		if ((task.Options & TaskCreationOptions.LongRunning) != TaskCreationOptions.None)
		{
			RuntimeThread runtimeThread = RuntimeThread.Create(s_longRunningThreadWork, 0);
			runtimeThread.IsBackground = true;
			runtimeThread.Start(task);
		}
		else
		{
			bool forceGlobal = (task.Options & TaskCreationOptions.PreferFairness) != 0;
			ThreadPool.UnsafeQueueCustomWorkItem(task, forceGlobal);
		}
	}

	protected override bool TryExecuteTaskInline(Task task, bool taskWasPreviouslyQueued)
	{
		if (taskWasPreviouslyQueued && !ThreadPool.TryPopCustomWorkItem(task))
		{
			return false;
		}
		bool flag = false;
		try
		{
			return task.ExecuteEntry(bPreventDoubleExecution: false);
		}
		finally
		{
			if (taskWasPreviouslyQueued)
			{
				NotifyWorkItemProgress();
			}
		}
	}

	protected internal override bool TryDequeue(Task task)
	{
		return ThreadPool.TryPopCustomWorkItem(task);
	}

	internal override void NotifyWorkItemProgress()
	{
		ThreadPool.NotifyWorkItemProgress();
	}
}
