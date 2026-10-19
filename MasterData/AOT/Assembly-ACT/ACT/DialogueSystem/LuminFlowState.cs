using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class LuminFlowState : DialogueState
{
	public bool RootFinished;

	protected override UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		return UniTask.CompletedTask;
	}
}
