using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class EffectState : DialogueState
{
	private int m_Effect;

	private UniTask ApplyImmediate(CancellationToken token)
	{
		UIConversationScene instance = UIConversationScene.Instance;
		if (!instance)
		{
			return UniTask.CompletedTask;
		}
		return instance.EffectTask(m_Effect, token);
	}

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		return ApplyImmediate(token);
	}

	public UniTask SetEffect(int effect, CancellationToken token, bool skipping)
	{
		m_Effect = effect;
		if (!skipping)
		{
			return ApplyImmediate(token);
		}
		return UniTask.CompletedTask;
	}
}
