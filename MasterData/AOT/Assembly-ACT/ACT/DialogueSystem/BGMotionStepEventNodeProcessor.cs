using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class BGMotionStepEventNodeProcessor : ChatStepEventNodeProcessor<BGMotionStepEventNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		if (luminDialogueContext.Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		UIConversationScene conversationScene = UIConversationScene.Instance;
		UniTask task = (conversationScene ? conversationScene.BgMotion(TData.bgScale, TData.bgOffset, TData.bgMotionDuration, TData.ease) : UniTask.CompletedTask);
		if (TData.waitEnd)
		{
			bool finished = false;
			task.ContinueWith(() => finished = true).Forget();
			await LuminDialogueUtility.WaitUntilOrForceNext(() => finished, token, () =>
			{
				conversationScene?.FinishBgMotion();
			});
		}
		else
		{
			luminDialogueContext.SubTasks.Run(new DialogueSubTask(task, () =>
			{
				conversationScene?.FinishBgMotion();
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
