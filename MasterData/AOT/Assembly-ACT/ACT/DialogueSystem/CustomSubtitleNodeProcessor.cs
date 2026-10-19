using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class CustomSubtitleNodeProcessor : DialogueNodeProcessor<CustomSubtitleNode>
{
	public class SubtitleState
	{
		public bool active;

		public MonoConversationNormal.SubtitlePosition position;

		public int contentId;

		public float fontSize;

		public Color color;

		public Vector2 positionOffset;

		public float rotation;

		public void Reset()
		{
			active = false;
			position = MonoConversationNormal.SubtitlePosition.Bottom;
			contentId = 0;
			fontSize = 0f;
			color = Color.white;
			positionOffset = Vector2.zero;
			rotation = 0f;
		}
	}

	public class CustomSubtitleState : DialogueState
	{
		private Dictionary<long, SubtitleState> m_States = new Dictionary<long, SubtitleState>();

		protected override async UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if (!conversationView || !conversationView.normalView)
			{
				return;
			}
			foreach (KeyValuePair<long, SubtitleState> state in m_States)
			{
				SubtitleState value = state.Value;
				if (value.active)
				{
					await Show(state.Key, value.position, value.contentId, value.fontSize, value.color, value.positionOffset, value.rotation, MonoConversationNormal.SubtitleAnimType.None, 0f, 0, skipping: false, token);
				}
			}
		}

		public async UniTask Show(long subtitleId, MonoConversationNormal.SubtitlePosition position, int contentId, float textFontSize, Color textColor, Vector2 textPositionOffset, float textRotation, MonoConversationNormal.SubtitleAnimType animType, float fadeTime, int interval, bool skipping, CancellationToken token)
		{
			if (!m_States.TryGetValue(subtitleId, out var value))
			{
				SubtitleState subtitleState = (m_States[subtitleId] = new SubtitleState());
				value = subtitleState;
			}
			value.active = true;
			value.position = position;
			value.contentId = contentId;
			value.fontSize = textFontSize;
			value.color = textColor;
			value.positionOffset = textPositionOffset;
			value.rotation = textRotation;
			if (skipping)
			{
				return;
			}
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if ((bool)conversationView)
			{
				MonoConversationNormal normalView = conversationView.normalView;
				if ((bool)normalView)
				{
					await normalView.UpdateSubtitle2(subtitleId, position, contentId, textFontSize, textColor, textPositionOffset, textRotation, animType, fadeTime, interval, token);
				}
			}
		}

		public async UniTask Hide(long subtitleId, float fadeTime, bool skipping, CancellationToken token)
		{
			if (!m_States.TryGetValue(subtitleId, out var value))
			{
				return;
			}
			value.Reset();
			m_States.Remove(subtitleId);
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if ((bool)conversationView)
			{
				MonoConversationNormal normalView = conversationView.normalView;
				if ((bool)normalView)
				{
					await normalView.HideAndClearSubtitle2(subtitleId, skipping ? 0f : fadeTime, token);
				}
			}
		}

		public void ForceHide(long subtitleId)
		{
			Hide(subtitleId, 0f, skipping: true, CancellationToken.None).Forget();
		}
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueFlowProcessor luminDialogueFlowProcessor = Flow as LuminDialogueFlowProcessor;
		LuminDialogueContext luminContext = context as LuminDialogueContext;
		int contentId = luminDialogueFlowProcessor.GetContentId(TData.key);
		CustomSubtitleState subtitleState = context.States.GetOrCreateState<CustomSubtitleState>();
		if (luminContext.Skipping)
		{
			await subtitleState.Show(TData.id, TData.textPosition, contentId, TData.textFontSize, TData.textColor, TData.textPositionOffset, TData.textRotation, TData.animType, TData.fadeInTime, TData.typeWriterInterval, skipping: true, token);
			await subtitleState.Hide(TData.id, 0f, skipping: true, token);
			return DialogueNodeResult.Continue;
		}
		switch (TData.waitMode)
		{
		case CustomSubtitleNode.SubtitleWaitMode.NoWait:
			RunSubtitleAsSubTask(luminContext, subtitleState, contentId, token, includeShowAndDelay: true);
			break;
		case CustomSubtitleNode.SubtitleWaitMode.WaitUntilHideStarts:
			await subtitleState.Show(TData.id, TData.textPosition, contentId, TData.textFontSize, TData.textColor, TData.textPositionOffset, TData.textRotation, TData.animType, TData.fadeInTime, TData.typeWriterInterval, skipping: false, token);
			if (!luminContext.Skipping)
			{
				await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.autoNextDelay, token);
			}
			if (luminContext.Skipping)
			{
				await subtitleState.Hide(TData.id, 0f, skipping: true, token);
			}
			else
			{
				RunSubtitleAsSubTask(luminContext, subtitleState, contentId, token, includeShowAndDelay: false);
			}
			break;
		default:
			await subtitleState.Show(TData.id, TData.textPosition, contentId, TData.textFontSize, TData.textColor, TData.textPositionOffset, TData.textRotation, TData.animType, TData.fadeInTime, TData.typeWriterInterval, skipping: false, token);
			if (!luminContext.Skipping)
			{
				await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.autoNextDelay, token);
			}
			await subtitleState.Hide(TData.id, TData.fadeOutTime, luminContext.Skipping, token);
			break;
		}
		return DialogueNodeResult.Continue;
	}

	private void RunSubtitleAsSubTask(LuminDialogueContext context, CustomSubtitleState subtitleState, int contentId, CancellationToken token, bool includeShowAndDelay)
	{
		CancellationTokenSource subTaskCts = CancellationTokenSource.CreateLinkedTokenSource(token);
		UniTask task = (includeShowAndDelay ? RunSubtitleLifecycle(subtitleState, contentId, subTaskCts.Token) : subtitleState.Hide(TData.id, TData.fadeOutTime, skipping: false, subTaskCts.Token));
		context.SubTasks.Run(new DialogueSubTask(RunSubtitleSubTask(task, subTaskCts), () =>
		{
			SkipSubtitleSubTask(subtitleState, subTaskCts);
		}));
	}

	private async UniTask RunSubtitleLifecycle(CustomSubtitleState subtitleState, int contentId, CancellationToken token)
	{
		await subtitleState.Show(TData.id, TData.textPosition, contentId, TData.textFontSize, TData.textColor, TData.textPositionOffset, TData.textRotation, TData.animType, TData.fadeInTime, TData.typeWriterInterval, skipping: false, token);
		if (!token.IsCancellationRequested)
		{
			await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.autoNextDelay, token);
			if (!token.IsCancellationRequested)
			{
				await subtitleState.Hide(TData.id, TData.fadeOutTime, skipping: false, token);
			}
		}
	}

	private static async UniTask RunSubtitleSubTask(UniTask task, CancellationTokenSource cts)
	{
		try
		{
			await task;
		}
		finally
		{
			cts.Dispose();
		}
	}

	private void SkipSubtitleSubTask(CustomSubtitleState subtitleState, CancellationTokenSource cts)
	{
		try
		{
			cts.Cancel();
		}
		catch
		{
		}
		subtitleState.ForceHide(TData.id);
	}
}
