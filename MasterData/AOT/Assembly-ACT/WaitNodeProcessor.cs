using System.Threading;
using ACT.DialogueSystem;
using Cysharp.Threading.Tasks;

public class WaitNodeProcessor : DialogueNodeProcessor<WaitNode>
{
	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (((LuminDialogueContext)context).Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.duration, token);
		return DialogueNodeResult.Continue;
	}
}
