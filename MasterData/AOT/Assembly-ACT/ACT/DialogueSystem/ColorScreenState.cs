using System;
using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ColorScreenState : DialogueState
{
	private bool m_Active;

	public Color m_Color;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
		if (!conversationView)
		{
			return UniTask.CompletedTask;
		}
		if (m_Active)
		{
			return conversationView.colorScreen.Show(m_Color, 0f);
		}
		return conversationView.colorScreen.Hide(0f);
	}

	public async UniTask Update(bool b, Color color, float speed, CancellationToken luminContextCancellationToken, bool skipping)
	{
		m_Active = b;
		m_Color = color;
		if (skipping)
		{
			return;
		}
		MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
		if (m_Active)
		{
			conversationView.colorScreen.Show(m_Color, speed).Forget();
			UniTask task = LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(speed), luminContextCancellationToken, () =>
			{
				conversationView?.colorScreen?.ForceShow(m_Color);
			});
			UniTask task2 = conversationView.normalView.HideAndClearContent();
			await LuminDialogueUtility.WhenAllPooled(task, task2);
		}
		else
		{
			conversationView.colorScreen.Hide(speed).Forget();
			await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(speed), luminContextCancellationToken, () =>
			{
				conversationView?.colorScreen?.ForceHide();
			});
		}
	}
}
