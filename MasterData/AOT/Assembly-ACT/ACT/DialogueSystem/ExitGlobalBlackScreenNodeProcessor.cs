using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class ExitGlobalBlackScreenNodeProcessor : DialogueNodeProcessor<ExitGlobalBlackScreenNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		GlobalBlackScreenState orCreateState = luminDialogueContext.States.GetOrCreateState<GlobalBlackScreenState>();
		orCreateState.End();
		if (luminDialogueContext.Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		UniTask task = orCreateState.Hide(TData.speed, token);
		if (TData.waitOut)
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
