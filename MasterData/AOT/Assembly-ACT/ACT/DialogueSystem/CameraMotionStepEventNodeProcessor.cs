using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class CameraMotionStepEventNodeProcessor : ChatStepEventNodeProcessor<CameraMotionStepEventNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		CameraMotionState orCreateState = luminDialogueContext.States.GetOrCreateState<CameraMotionState>();
		bool skipping = luminDialogueContext.Skipping;
		UniTask task = orCreateState.Update(TData.fovScale, TData.cameraOffset, TData.cameraMotionDuration, TData.ease, skipping);
		if (skipping)
		{
			return DialogueNodeResult.Continue;
		}
		UIConversationScene conversationScene = UIConversationScene.Instance;
		if (TData.waitEnd)
		{
			bool finished = false;
			task.ContinueWith(() => finished = true).Forget();
			await LuminDialogueUtility.WaitUntilOrForceNext(() => finished, token, () =>
			{
				conversationScene?.FinishCameraMotion();
			});
		}
		else
		{
			luminDialogueContext.SubTasks.Run(new DialogueSubTask(task, () =>
			{
				conversationScene?.FinishCameraMotion();
			}));
		}
		return DialogueNodeResult.Continue;
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
