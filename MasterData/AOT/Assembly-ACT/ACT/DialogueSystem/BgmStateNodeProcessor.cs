using System.Threading;
using ACT.Sound.Core;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class BgmStateNodeProcessor : DialogueNodeProcessor<BgmStateNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		AudioCore.SetGlobalParameter("AVG_Music_Change", TData.bgmState);
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}
}
