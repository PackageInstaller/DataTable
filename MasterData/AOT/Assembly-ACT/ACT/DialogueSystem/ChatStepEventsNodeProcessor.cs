using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ChatStepEventsNodeProcessor : ChatStepEventNodeProcessor<ChatStepEventsNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		return ExecuteStepEvents_Internal(execution, context, token);
	}

	public override async UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((TData.chatStep & chatStep) == 0)
		{
			return;
		}
		if (TData.waitEnd)
		{
			await Execute(execution, context, token);
		}
		else if (context is LuminDialogueContext luminDialogueContext)
		{
			CancellationTokenSource subTaskCts = CancellationTokenSource.CreateLinkedTokenSource(token);
			luminDialogueContext.SubTasks.Run(new DialogueSubTask(RunSubTask(execution, context, token, subTaskCts), () =>
			{
				SkipSubTask(subTaskCts);
			}));
		}
		else
		{
			Execute(execution, context, token).Forget();
		}
	}

	private async UniTask RunSubTask(DialogueFlowExecution execution, DialogueContext context, CancellationToken externalToken, CancellationTokenSource subTaskCts)
	{
		try
		{
			await ExecuteStepEvents_Internal(execution, context, externalToken, subTaskCts.Token);
		}
		finally
		{
			subTaskCts.Dispose();
		}
	}

	private static void SkipSubTask(CancellationTokenSource cts)
	{
		try
		{
			cts.Cancel();
		}
		catch (ObjectDisposedException)
		{
		}
	}

	private UniTask<DialogueNodeResult> ExecuteStepEvents_Internal(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		return ExecuteStepEvents_Internal(execution, context, token, token);
	}

	private async UniTask<DialogueNodeResult> ExecuteStepEvents_Internal(DialogueFlowExecution execution, DialogueContext context, CancellationToken externalToken, CancellationToken executeToken)
	{
		for (int i = 0; i < ChildrenCount; i++)
		{
			DialogueNodeProcessor child = GetChild(i);
			try
			{
				DialogueNodeResult result = await child.Execute(execution, context, executeToken);
				if (result.Type > DialogueNodeResultType.Continue)
				{
					return result;
				}
			}
			catch (OperationCanceledException) when (!externalToken.IsCancellationRequested && executeToken.IsCancellationRequested)
			{
				continue;
			}
			catch (Exception ex2)
			{
				Debug.LogError(ex2);
				return DialogueNodeResult.Error(ex2.Message);
			}
			if (externalToken.IsCancellationRequested)
			{
				break;
			}
		}
		return DialogueNodeResult.Continue;
	}
}
