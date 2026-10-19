using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class DialogueStopProcessor : DialogueNodeProcessor<DialogueJump>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		return UniTask.FromResult(DialogueNodeResult.Break);
	}
}
