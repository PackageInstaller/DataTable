namespace System.Threading.Tasks;

internal sealed class ContinuationTaskFromResultTask<TAntecedentResult> : Task
{
	private Task<TAntecedentResult> m_antecedent;

	public ContinuationTaskFromResultTask(Task<TAntecedentResult> antecedent, Delegate action, object state, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions)
		: base(action, state, Task.InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, internalOptions, null)
	{
		m_antecedent = antecedent;
	}

	internal override void InnerInvoke()
	{
		Task<TAntecedentResult> antecedent = m_antecedent;
		m_antecedent = null;
		antecedent.NotifyDebuggerOfWaitCompletionIfNecessary();
		if (m_action is Action<Task<TAntecedentResult>> action)
		{
			action(antecedent);
		}
		else if (m_action is Action<Task<TAntecedentResult>, object> action2)
		{
			action2(antecedent, m_stateObject);
		}
	}
}
