using System;

namespace ACT.Drama;

public readonly struct DialogueInputHandle : IDisposable
{
	private readonly DialogueInputRouter m_Router;

	private readonly IDialogueInputHandler m_Handler;

	internal DialogueInputHandle(DialogueInputRouter router, IDialogueInputHandler handler)
	{
		m_Router = router;
		m_Handler = handler;
	}

	public void Dispose()
	{
		m_Router?.Unregister(m_Handler);
	}
}
