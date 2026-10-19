using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class CommsChatProcessor : DialogueNodeProcessor<CommsChatNode>
{
	private sealed class CommsChatItemState
	{
		public int ContentId;

		public MonoCommsChatItems.CommsChatPosition Position;

		public Vector2 Offset;
	}

	public sealed class CommsChatState : DialogueState
	{
		private readonly Dictionary<long, CommsChatItemState> m_States = new Dictionary<long, CommsChatItemState>();

		protected override async UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
		{
			MonoCommsChatItems items = GetCommsChatItems();
			if (items == null)
			{
				return;
			}
			foreach (KeyValuePair<long, CommsChatItemState> state in m_States)
			{
				CommsChatItemState value = state.Value;
				await items.ShowItem(state.Key, value.ContentId, value.Position, value.Offset, immediate: true, token);
			}
		}

		public async UniTask Show(long itemId, int contentId, MonoCommsChatItems.CommsChatPosition position, Vector2 offset, bool immediate, CancellationToken token)
		{
			if (!m_States.TryGetValue(itemId, out var value))
			{
				CommsChatItemState commsChatItemState = (m_States[itemId] = new CommsChatItemState());
				value = commsChatItemState;
			}
			value.ContentId = contentId;
			value.Position = position;
			value.Offset = offset;
			MonoCommsChatItems commsChatItems = GetCommsChatItems();
			if (commsChatItems != null)
			{
				await commsChatItems.ShowItem(itemId, contentId, position, offset, immediate, token);
			}
		}

		public async UniTask Hide(long itemId, bool immediate, CancellationToken token)
		{
			m_States.Remove(itemId);
			MonoCommsChatItems commsChatItems = GetCommsChatItems();
			if (commsChatItems != null)
			{
				await commsChatItems.HideItem(itemId, immediate, token);
			}
		}

		public void ForceHide(long itemId)
		{
			m_States.Remove(itemId);
			GetCommsChatItems()?.HideItemImmediate(itemId);
		}

		private static MonoCommsChatItems GetCommsChatItems()
		{
			MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
			if (!conversationView)
			{
				return null;
			}
			return conversationView.GetComponentInChildren<MonoCommsChatItems>(includeInactive: true);
		}
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueFlowProcessor obj = Flow as LuminDialogueFlowProcessor;
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		int genderContentId = obj.GetGenderContentId(TData.key);
		CommsChatState commsChatState = context.States.GetOrCreateState<CommsChatState>();
		if (luminDialogueContext.Skipping)
		{
			await commsChatState.Show(TData.id, genderContentId, TData.position, TData.positionOffset, immediate: true, token);
			await commsChatState.Hide(TData.id, immediate: true, token);
			return DialogueNodeResult.Continue;
		}
		if (TData.waitUntilHidden)
		{
			await RunLifecycle(commsChatState, genderContentId, token);
		}
		else
		{
			RunAsSubTask(luminDialogueContext, commsChatState, genderContentId, token);
		}
		return DialogueNodeResult.Continue;
	}

	private async UniTask RunLifecycle(CommsChatState state, int contentId, CancellationToken token)
	{
		await state.Show(TData.id, contentId, TData.position, TData.positionOffset, immediate: false, token);
		if (!token.IsCancellationRequested)
		{
			await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.duration, token);
			if (!token.IsCancellationRequested)
			{
				await state.Hide(TData.id, immediate: false, token);
			}
		}
	}

	private void RunAsSubTask(LuminDialogueContext context, CommsChatState state, int contentId, CancellationToken token)
	{
		CancellationTokenSource subTaskCts = CancellationTokenSource.CreateLinkedTokenSource(token);
		context.SubTasks.Run(new DialogueSubTask(RunSubTask(RunLifecycle(state, contentId, subTaskCts.Token), subTaskCts), () =>
		{
			SkipSubTask(state, subTaskCts);
		}));
	}

	private static async UniTask RunSubTask(UniTask task, CancellationTokenSource cts)
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

	private void SkipSubTask(CommsChatState state, CancellationTokenSource cts)
	{
		try
		{
			cts.Cancel();
		}
		catch
		{
		}
		state.ForceHide(TData.id);
	}
}
