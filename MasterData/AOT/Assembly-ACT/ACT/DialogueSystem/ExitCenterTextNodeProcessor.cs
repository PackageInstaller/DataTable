using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class ExitCenterTextNodeProcessor : DialogueNodeProcessor<ExitCenterTextNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		await luminDialogueContext.States.GetOrCreateState<CenterTextState>().End(TData.speed, luminDialogueContext.Skipping, token);
		return DialogueNodeResult.Continue;
	}
}
