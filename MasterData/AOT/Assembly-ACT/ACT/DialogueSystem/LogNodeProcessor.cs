using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class LogNodeProcessor : DialogueNodeProcessor<LogNode>
{
	protected override UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if ((context as LuminDialogueContext).Skipping)
		{
			return UniTask.FromResult(DialogueNodeResult.Continue);
		}
		Debug.Log(TData.text);
		return UniTask.FromResult(DialogueNodeResult.Continue);
	}
}
