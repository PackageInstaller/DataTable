using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.Drama;

public abstract class DialogueWrapper : IDialogueWrapper
{
	public enum DialogueStateEnum
	{
		Waiting,
		Playing,
		Finished,
		Aborted
	}

	private DialogueStateEnum m_State;

	private readonly DialogueInputRouter m_InputRouter = new DialogueInputRouter();

	private CancellationTokenSource m_CTS;

	async UniTask IDialogueWrapper.Play(CancellationToken externalCancellationToken)
	{
		if (m_State != DialogueStateEnum.Playing)
		{
			m_State = DialogueStateEnum.Playing;
			m_CTS?.Cancel();
			m_CTS = CancellationTokenSource.CreateLinkedTokenSource(externalCancellationToken);
			CancellationToken token = m_CTS.Token;
			try
			{
				await Play(token);
			}
			finally
			{
				m_InputRouter.Clear();
			}
			if (token.IsCancellationRequested)
			{
				m_CTS?.Cancel();
				m_CTS?.Dispose();
				m_CTS = null;
				m_State = DialogueStateEnum.Aborted;
			}
			else
			{
				m_CTS?.Cancel();
				m_CTS?.Dispose();
				m_CTS = null;
				m_State = DialogueStateEnum.Finished;
			}
		}
	}

	void IDialogueWrapper.Skip()
	{
		if (IsPlaying())
		{
			Skip();
		}
	}

	void IDialogueWrapper.Stop()
	{
		if (m_State != DialogueStateEnum.Aborted)
		{
			m_CTS?.Cancel();
			m_CTS?.Dispose();
			m_CTS = null;
			Stop();
		}
	}

	public bool IsPlaying()
	{
		if (m_State != DialogueStateEnum.Waiting)
		{
			return m_State == DialogueStateEnum.Playing;
		}
		return true;
	}

	public bool IsFinished()
	{
		return m_State == DialogueStateEnum.Finished;
	}

	public bool IsAborted()
	{
		return m_State == DialogueStateEnum.Aborted;
	}

	public void TryNext()
	{
		m_InputRouter.TryNext();
	}

	public void ForceNext()
	{
		m_InputRouter.ForceNext();
	}

	public DialogueInputHandle RegisterInputHandler(IDialogueInputHandler handler)
	{
		return m_InputRouter.Register(handler);
	}

	protected abstract UniTask Play(CancellationToken token);

	protected virtual void Stop()
	{
	}

	protected virtual void Skip()
	{
	}
}
