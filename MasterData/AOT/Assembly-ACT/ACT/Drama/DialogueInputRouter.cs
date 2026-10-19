using System.Collections.Generic;

namespace ACT.Drama;

public sealed class DialogueInputRouter
{
	private readonly List<IDialogueInputHandler> m_Handlers = new List<IDialogueInputHandler>();

	public DialogueInputHandle Register(IDialogueInputHandler handler)
	{
		if (handler == null)
		{
			return default;
		}
		m_Handlers.Add(handler);
		return new DialogueInputHandle(this, handler);
	}

	public void TryNext()
	{
		int num = m_Handlers.Count - 1;
		while (num >= 0 && (num >= m_Handlers.Count || !m_Handlers[num].TryNext()))
		{
			num--;
		}
	}

	public void ForceNext()
	{
		for (int num = m_Handlers.Count - 1; num >= 0; num--)
		{
			if (num < m_Handlers.Count)
			{
				m_Handlers[num].ForceNext();
			}
		}
	}

	internal void Unregister(IDialogueInputHandler handler)
	{
		if (handler != null)
		{
			m_Handlers.Remove(handler);
		}
	}

	internal void Clear()
	{
		m_Handlers.Clear();
	}
}
