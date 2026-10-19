using System;

namespace ACT.Drama;

public sealed class DialogueInputActions : IDialogueInputHandler
{
	private readonly Func<bool> m_OnTryNext;

	private readonly Action m_OnForceNext;

	public DialogueInputActions(Func<bool> onTryNext, Action onForceNext)
	{
		m_OnTryNext = onTryNext;
		m_OnForceNext = onForceNext;
	}

	public bool TryNext()
	{
		if (m_OnTryNext != null)
		{
			return m_OnTryNext();
		}
		return false;
	}

	public void ForceNext()
	{
		m_OnForceNext?.Invoke();
	}
}
