using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ShowCenterTextNodeProcessor : DialogueNodeProcessor<ShowCenterTextNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		CenterTextState orCreateState = luminDialogueContext.States.GetOrCreateState<CenterTextState>();
		orCreateState.ShowText(TData.index, TData.speed, luminDialogueContext.Skipping);
		if (orCreateState.m_Texts != null && TData.index >= 0 && TData.index < orCreateState.m_Texts.Count)
		{
			CenterTextInfo centerTextInfo = orCreateState.m_Texts[TData.index];
			Singleton<ConversationManager>.instance.RecordHistory_Normal(luminDialogueContext.StoryGroupId, centerTextInfo.dialogueId, 0, centerTextInfo.contentId, 0, isPlayer: false);
		}
		if (luminDialogueContext.Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		IAVGDialogue iAVGDialogue = Singleton<ConversationManager>.instance.PlayingDialogue as IAVGDialogue;
		bool wantNext = false;
		DialogueInputHandle inputHandle = iAVGDialogue.RegisterInputHandler(new DialogueInputActions(OnTryNext, ForceNext));
		float timer = 0f;
		float delay = Mathf.Max(TData.autoNextDelay, 0.5f) + TData.speed;
		try
		{
			await LuminDialogueUtility.WaitUntilOrForceNext(() =>
			{
				if (wantNext)
				{
					return true;
				}
				if (TData.autoNext)
				{
					timer += Time.unscaledDeltaTime;
					if (timer >= delay)
					{
						return true;
					}
				}
				return false;
			}, token, ForceNext);
		}
		finally
		{
			inputHandle.Dispose();
		}
		return DialogueNodeResult.Continue;
		void ForceNext()
		{
			Singleton<ConversationManager>.instance.conversationView.centerText.FinishAnimating(TData.index);
			wantNext = true;
		}
		bool OnTryNext()
		{
			MonoConversationCenterText centerText = Singleton<ConversationManager>.instance.conversationView.centerText;
			if (centerText.IsAnimating(TData.index))
			{
				centerText.FinishAnimating(TData.index);
			}
			else
			{
				wantNext = true;
			}
			return true;
		}
	}
}
