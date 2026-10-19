using System;
using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class BlackScreenState : DialogueState
{
	private bool m_Active;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
		if (!conversationView)
		{
			return UniTask.CompletedTask;
		}
		if (m_Active)
		{
			UniTask task = conversationView.blackScreen.Show(0f);
			UniTask task2 = conversationView.normalView.HideAndClearContent();
			return LuminDialogueUtility.WhenAllPooled(task, task2);
		}
		UniTask task3 = conversationView.blackScreen.Hide(0f);
		UniTask task4 = conversationView.normalView.HideAndClearContent();
		return LuminDialogueUtility.WhenAllPooled(task3, task4);
	}

	public async UniTask ChangeActive(bool b, float speed, bool skipping, CancellationToken token = default(CancellationToken))
	{
		if (m_Active == b)
		{
			return;
		}
		m_Active = b;
		if (skipping)
		{
			return;
		}
		if (m_Active)
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			conversationView.blackScreen.Show(speed).Forget();
			UniTask task = LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(speed), token, () =>
			{
				conversationView?.blackScreen?.ForceShow();
			});
			UniTask task2 = conversationView.normalView.HideAndClearContent();
			await LuminDialogueUtility.WhenAllPooled(task, task2);
		}
		else
		{
			MonoConversationView conversationView2 = Singleton<ConversationManager>.instance.conversationView;
			conversationView2.blackScreen.Hide(speed).Forget();
			await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(speed), token, () =>
			{
				conversationView2?.blackScreen?.ForceHide();
			});
		}
	}
}
