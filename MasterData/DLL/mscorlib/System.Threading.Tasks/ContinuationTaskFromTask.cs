namespace System.Threading.Tasks;

internal sealed class ContinuationTaskFromTask : Task
{
	private Task m_antecedent;

	public ContinuationTaskFromTask(Task antecedent, Delegate action, object state, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions)
		: base(action, state, Task.InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, internalOptions, null)
	{
		m_antecedent = antecedent;
	}

	internal override void InnerInvoke()
	{
		Task antecedent = m_antecedent;
		m_antecedent = null;
		antecedent.NotifyDebuggerOfWaitCompletionIfNecessary();
		if (m_action is Action<Task> action)
		{
			action(antecedent);
		}
		else if (m_action is Action<Task, object> action2)
		{
			action2(antecedent, m_stateObject);
		}
	}
}
