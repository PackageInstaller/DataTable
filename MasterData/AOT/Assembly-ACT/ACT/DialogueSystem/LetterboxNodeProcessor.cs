using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class LetterboxNodeProcessor : DialogueNodeProcessor<LetterboxNode>
{
	public class LetterboxState : DialogueState
	{
		private bool m_ShowTop;

		private float m_TopPercent;

		private bool m_ShowBottom;

		private float m_BottomPercent;

		protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if (conversationView != null && conversationView.letterbox2 != null)
			{
				conversationView.letterbox2.SetState(new MonoConversationLetterBox2.LetterboxState
				{
					showTop = m_ShowTop,
					showBottom = m_ShowBottom,
					topPercent = m_TopPercent,
					bottomPercent = m_BottomPercent,
					duration = 0f
				});
			}
			return UniTask.CompletedTask;
		}

		public void SetState(bool showTop, float topPercent, bool showBottom, float bottomPercent, float time, bool skipping)
		{
			m_ShowTop = showTop;
			m_TopPercent = topPercent;
			m_ShowBottom = showBottom;
			m_BottomPercent = bottomPercent;
			if (!skipping)
			{
				MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
				if (conversationView != null && conversationView.letterbox2 != null)
				{
					conversationView.letterbox2.SetState(new MonoConversationLetterBox2.LetterboxState
					{
						showTop = m_ShowTop,
						showBottom = m_ShowBottom,
						topPercent = m_TopPercent,
						bottomPercent = m_BottomPercent,
						duration = time
					});
				}
			}
		}

		public void Reset()
		{
			SetState(showTop: false, 0f, showBottom: false, 0f, 0f, skipping: false);
		}
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		LetterboxState orCreateState = context.States.GetOrCreateState<LetterboxState>();
		float num = ((TData.showTop || TData.showBottom) ? TData.fadeInTime : TData.fadeOutTime);
		orCreateState.SetState(TData.showTop, TData.topPercent, TData.showBottom, TData.bottomPercent, num, luminDialogueContext.Skipping);
		if (TData.wait && !luminDialogueContext.Skipping)
		{
			await LuminDialogueUtility.WaitForSecondsOrForceNext(num, token);
		}
		return DialogueNodeResult.Continue;
	}
}
