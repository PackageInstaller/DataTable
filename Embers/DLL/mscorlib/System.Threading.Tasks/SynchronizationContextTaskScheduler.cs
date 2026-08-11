namespace System.Threading.Tasks;

internal sealed class SynchronizationContextTaskScheduler : TaskScheduler
{
	private SynchronizationContext m_synchronizationContext;

	private static readonly SendOrPostCallback s_postCallback = delegate(object s)
	{
		((Task)s).ExecuteEntry(bPreventDoubleExecution: true);
	};

	internal SynchronizationContextTaskScheduler()
	{
		SynchronizationContext current = SynchronizationContext.Current;
		if (current == null)
		{
			throw new InvalidOperationException("The current SynchronizationContext may not be used as a TaskScheduler.");
		}
		m_synchronizationContext = current;
	}

	protected internal override void QueueTask(Task task)
	{
		m_synchronizationContext.Post(s_postCallback, task);
	}

	protected override bool TryExecuteTaskInline(Task task, bool taskWasPreviouslyQueued)
	{
		if (SynchronizationContext.Current == m_synchronizationContext)
		{
			return TryExecuteTask(task);
		}
		return false;
	}
}
