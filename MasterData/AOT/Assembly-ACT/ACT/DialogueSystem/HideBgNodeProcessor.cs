using System;
using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class HideBgNodeProcessor : ChatStepEventNodeProcessor<HideBgNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		BGState orCreateState = luminDialogueContext.States.GetOrCreateState<BGState>();
		if (luminDialogueContext.Skipping)
		{
			await orCreateState.HideCurrentBg(0f, skipping: true);
			return DialogueNodeResult.Continue;
		}
		CancellationTokenSource cts = CancellationTokenSource.CreateLinkedTokenSource(token);
		bool releaseCts = true;
		DialogueInputHandle inputHandle = default;
		try
		{
			if (Singleton<ConversationManager>.instance.PlayingDialogue is IAVGDialogue iAVGDialogue)
			{
				inputHandle = iAVGDialogue.RegisterInputHandler(new DialogueInputActions(null, cts.Cancel));
			}
			UniTask<bool> uniTask = orCreateState.HideCurrentBg(TData.speed, skipping: false, cts.Token).SuppressCancellationThrow();
			if (TData.wait)
			{
				await uniTask;
			}
			else
			{
				releaseCts = false;
				luminDialogueContext.SubTasks.Run(new DialogueSubTask(RunHideBgSubTask(uniTask, cts), () =>
				{
					SkipHideBgSubTask(cts);
				}));
			}
		}
		finally
		{
			inputHandle.Dispose();
			if (releaseCts)
			{
				cts.Dispose();
			}
		}
		return DialogueNodeResult.Continue;
	}

	private static async UniTask RunHideBgSubTask(UniTask task, CancellationTokenSource cts)
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

	private static void SkipHideBgSubTask(CancellationTokenSource cts)
	{
		try
		{
			cts.Cancel();
		}
		catch (ObjectDisposedException)
		{
		}
		UIConversationScene.Instance?.FinishHidingBgs();
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((TData.step & chatStep) == 0)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}
}
