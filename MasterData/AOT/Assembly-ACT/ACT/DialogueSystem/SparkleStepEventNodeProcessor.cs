using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class SparkleStepEventNodeProcessor : ChatStepEventNodeProcessor<SparkleStepEventNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		luminDialogueContext.States.GetOrCreateState<SparkleState>().SetActive(TData.active, luminDialogueContext.Skipping);
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (chatStep != ChatStep.OnUpdateScene)
		{
			return UniTask.CompletedTask;
		}
		Execute(execution, context, token);
		return UniTask.CompletedTask;
	}
}
