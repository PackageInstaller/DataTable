using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class DepthOfFieldState : DialogueState
{
	private UIConversationScene.DepthOfFieldMode m_Mode;

	private float m_Duration;

	private UniTask ApplyImmediate(CancellationToken token)
	{
		UIConversationScene instance = UIConversationScene.Instance;
		if (!instance)
		{
			return UniTask.CompletedTask;
		}
		return instance.SetDepthOfFields(m_Mode, m_Duration, token);
	}

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		return ApplyImmediate(token);
	}

	public UniTask Update(UIConversationScene.DepthOfFieldMode tDataMode, float tDataDuration, CancellationToken token, bool skipping)
	{
		m_Mode = tDataMode;
		m_Duration = tDataDuration;
		if (!skipping)
		{
			return ApplyImmediate(token);
		}
		return UniTask.CompletedTask;
	}
}
