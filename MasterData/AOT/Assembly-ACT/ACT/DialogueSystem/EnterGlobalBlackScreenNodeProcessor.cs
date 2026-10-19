using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class EnterGlobalBlackScreenNodeProcessor : DialogueNodeProcessor<EnterGlobalBlackScreenNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		if (luminDialogueContext.Skipping && !TData.mustDo)
		{
			return DialogueNodeResult.Continue;
		}
		GlobalBlackScreenState orCreateState = luminDialogueContext.States.GetOrCreateState<GlobalBlackScreenState>();
		orCreateState.Begin();
		await orCreateState.Show(TData.speed, token);
		return DialogueNodeResult.Continue;
	}
}
