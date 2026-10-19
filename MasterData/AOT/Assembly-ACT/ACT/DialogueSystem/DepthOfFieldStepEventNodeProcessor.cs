using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class DepthOfFieldStepEventNodeProcessor : ChatStepEventNodeProcessor<DepthOfFieldStepEventNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		await luminDialogueContext.States.GetOrCreateState<DepthOfFieldState>().Update(TData.mode, TData.duration, token, luminDialogueContext.Skipping);
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
