using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class DialogueJumpProcessor : DialogueNodeProcessor<DialogueJump>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		DialogueNodeResult result = await execution.JumpExecute(TData.targetAction);
		if (result.Type >= DialogueNodeResultType.Break)
		{
			return result;
		}
		return DialogueNodeResult.Break;
	}
}
