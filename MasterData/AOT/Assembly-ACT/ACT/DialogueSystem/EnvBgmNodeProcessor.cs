using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class EnvBgmNodeProcessor : DialogueNodeProcessor<EnvBgmNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminDialogueContext = context as LuminDialogueContext;
		luminDialogueContext.States.GetOrCreateState<EnvBGMState>().ChangeBgm(TData.bgmId, luminDialogueContext.Skipping);
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}
}
