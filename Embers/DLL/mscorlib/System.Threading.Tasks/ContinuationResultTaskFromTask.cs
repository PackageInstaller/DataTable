namespace System.Threading.Tasks;

internal sealed class ContinuationResultTaskFromTask<TResult> : Task<TResult>
{
	private Task m_antecedent;

	public ContinuationResultTaskFromTask(Task antecedent, Delegate function, object state, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions)
		: base(function, state, Task.InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, internalOptions, (TaskScheduler)null)
	{
		m_antecedent = antecedent;
	}

	internal override void InnerInvoke()
	{
		Task antecedent = m_antecedent;
		m_antecedent = null;
		antecedent.NotifyDebuggerOfWaitCompletionIfNecessary();
		if (m_action is Func<Task, TResult> func)
		{
			m_result = func(antecedent);
		}
		else if (m_action is Func<Task, object, TResult> func2)
		{
			m_result = func2(antecedent, m_stateObject);
		}
	}
}
