using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

internal class DialogueSubTaskRuntime
{
	public readonly UniTaskCompletionSource CompletionSource = new UniTaskCompletionSource();

	private readonly DialogueSubTask m_Task;

	private bool m_SkippedToEnd;

	public bool Finished;

	public DialogueSubTaskRuntime(DialogueSubTask task)
	{
		m_Task = task;
	}

	public void SkipToEnd()
	{
		if (!m_SkippedToEnd)
		{
			m_SkippedToEnd = true;
			m_Task.SkipToEndAction?.Invoke();
		}
	}
}
