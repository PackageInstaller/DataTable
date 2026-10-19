namespace System.Threading.Tasks;

internal sealed class ContinuationResultTaskFromResultTask<TAntecedentResult, TResult> : Task<TResult>
{
	private Task<TAntecedentResult> m_antecedent;

	public ContinuationResultTaskFromResultTask(Task<TAntecedentResult> antecedent, Delegate function, object state, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions)
		: base(function, state, Task.InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, internalOptions, (TaskScheduler)null)
	{
		m_antecedent = antecedent;
	}

	internal override void InnerInvoke()
	{
		Task<TAntecedentResult> antecedent = m_antecedent;
		m_antecedent = null;
		antecedent.NotifyDebuggerOfWaitCompletionIfNecessary();
		if (m_action is Func<Task<TAntecedentResult>, TResult> func)
		{
			m_result = func(antecedent);
		}
		else if (m_action is Func<Task<TAntecedentResult>, object, TResult> func2)
		{
			m_result = func2(antecedent, m_stateObject);
		}
	}
}
