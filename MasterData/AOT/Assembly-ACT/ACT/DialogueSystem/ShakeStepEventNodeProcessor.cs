using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class ShakeStepEventNodeProcessor : ChatStepEventNodeProcessor<ShakeStepEventNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		if (luminDialogueContext.Skipping)
		{
			return UniTask.FromResult(DialogueNodeResult.Continue);
		}
		UniTask uniTask = UIConversationScene.Instance.Shake(TData.strength, TData.duration, TData.vibrato);
		if (TData.waitEnd)
		{
			return WaitShake(uniTask, token);
		}
		luminDialogueContext.SubTasks.Run(new DialogueSubTask(uniTask, () =>
		{
			UIConversationScene.Instance?.FinishShake();
		}));
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	private static async UniTask<DialogueNodeResult> WaitShake(UniTask shakeTask, CancellationToken token)
	{
		bool finished = false;
		shakeTask.ContinueWith(() => finished = true).Forget();
		await LuminDialogueUtility.WaitUntilOrForceNext(() => finished, token, () =>
		{
			UIConversationScene.Instance?.FinishShake();
		});
		return DialogueNodeResult.Continue;
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (chatStep == ChatStep.None)
		{
			return UniTask.CompletedTask;
		}
		if ((context as LuminDialogueContext).Skipping)
		{
			return UniTask.CompletedTask;
		}
		if (chatStep == ChatStep.OnExit && TData.finishOnExit)
		{
			UIConversationScene.Instance.FinishShake();
		}
		if ((chatStep & TData.step) == 0)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}
}
