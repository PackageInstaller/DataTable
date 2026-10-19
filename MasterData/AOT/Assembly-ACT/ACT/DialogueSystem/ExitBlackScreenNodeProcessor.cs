using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class ExitBlackScreenNodeProcessor : DialogueNodeProcessor<ExitBlackScreenNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		UniTask task = luminDialogueContext.States.GetOrCreateState<BlackScreenState>().ChangeActive(b: false, TData.speed, luminDialogueContext.Skipping, token);
		if (TData.waitOut || luminDialogueContext.Skipping)
		{
			await task;
		}
		else
		{
			task.Forget();
		}
		return DialogueNodeResult.Continue;
	}
}
