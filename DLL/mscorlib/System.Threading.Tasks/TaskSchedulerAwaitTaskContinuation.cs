namespace System.Threading.Tasks;

internal sealed class TaskSchedulerAwaitTaskContinuation : AwaitTaskContinuation
{
	private readonly TaskScheduler m_scheduler;

	internal TaskSchedulerAwaitTaskContinuation(TaskScheduler scheduler, Action action, bool flowExecutionContext)
		: base(action, flowExecutionContext)
	{
		m_scheduler = scheduler;
	}

	internal sealed override void Run(Task ignored, bool canInlineContinuationTask)
	{
		if (m_scheduler == TaskScheduler.Default)
		{
			base.Run(ignored, canInlineContinuationTask);
			return;
		}
		bool num = canInlineContinuationTask && (TaskScheduler.InternalCurrent == m_scheduler || ThreadPool.IsThreadPoolThread);
		Task task = CreateTask(delegate(object state)
		{
			try
			{
				((Action)state)();
			}
			catch (Exception exc)
			{
				AwaitTaskContinuation.ThrowAsyncIfNecessary(exc);
			}
		}, m_action, m_scheduler);
		if (num)
		{
			TaskContinuation.InlineIfPossibleOrElseQueue(task, needsProtection: false);
			return;
		}
		try
		{
			task.ScheduleAndStart(needsProtection: false);
		}
		catch (TaskSchedulerException)
		{
		}
	}
}
