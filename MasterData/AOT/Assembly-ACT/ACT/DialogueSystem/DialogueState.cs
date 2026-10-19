using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public abstract class DialogueState : IDialogueStateInternal
{
	UniTask IDialogueStateInternal.ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		return ApplyImmediate(context, token);
	}

	protected abstract UniTask ApplyImmediate(DialogueContext context, CancellationToken token);
}
