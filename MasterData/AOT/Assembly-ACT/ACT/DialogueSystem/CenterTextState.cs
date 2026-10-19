using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class CenterTextState : DialogueState
{
	public bool m_Active;

	public List<CenterTextInfo> m_Texts;

	public int m_CurrentIndex;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		if (m_Active)
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if ((bool)conversationView)
			{
				conversationView.centerText.SetText(m_Texts);
				int num = ((m_Texts == null) ? (-1) : (m_Texts.Count - 1));
				int num2 = ((m_CurrentIndex < num) ? m_CurrentIndex : num);
				for (int i = 0; i <= num2; i++)
				{
					conversationView.centerText.ShowText(i, 0f);
				}
			}
		}
		else
		{
			MonoConversationView conversationView2 = Singleton<ConversationManager>.instance.conversationView;
			if ((bool)conversationView2)
			{
				conversationView2.centerText.ClearText();
			}
		}
		return UniTask.CompletedTask;
	}

	public void Begin(List<CenterTextInfo> texts, bool skipping)
	{
		m_Active = true;
		m_Texts = texts;
		m_CurrentIndex = -1;
		if (!skipping)
		{
			Singleton<ConversationManager>.instance.conversationView.centerText.SetText(texts);
		}
	}

	public async UniTask End(float speed, bool skipping, CancellationToken token)
	{
		m_Active = false;
		m_Texts = null;
		m_CurrentIndex = -1;
		if (!skipping)
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			conversationView.centerText.HideAllText(speed);
			await LuminDialogueUtility.WaitForSecondsOrForceNext(speed, token);
			conversationView.centerText.ClearText();
		}
	}

	public void ShowText(int index, float speed, bool skipping)
	{
		m_CurrentIndex = index;
		if (!skipping)
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if ((bool)conversationView)
			{
				conversationView.centerText.ShowText(index, speed);
			}
		}
	}
}
