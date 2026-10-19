using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class SparkleState : DialogueState
{
	private bool m_Active;

	private UniTask ApplyImmediate(CancellationToken token)
	{
		UIConversationScene instance = UIConversationScene.Instance;
		if (!instance)
		{
			return UniTask.CompletedTask;
		}
		instance.Sparkle(m_Active);
		return UniTask.CompletedTask;
	}

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		return ApplyImmediate(token);
	}

	public void SetActive(bool activeFog, bool skipping)
	{
		if (activeFog != m_Active)
		{
			m_Active = activeFog;
			if (!skipping)
			{
				ApplyImmediate(CancellationToken.None);
			}
		}
	}
}
