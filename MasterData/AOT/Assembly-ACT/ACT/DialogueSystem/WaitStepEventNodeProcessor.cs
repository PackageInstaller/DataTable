using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class WaitStepEventNodeProcessor : ChatStepEventNodeProcessor<WaitStepEventNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (context is LuminDialogueContext { Skipping: not false })
		{
			return DialogueNodeResult.Continue;
		}
		await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.duration, token);
		return DialogueNodeResult.Continue;
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((chatStep & TData.step) == 0)
		{
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}
}
