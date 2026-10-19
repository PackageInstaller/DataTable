using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public interface IDialogueStateInternal
{
	UniTask ApplyImmediate(DialogueContext context, CancellationToken token);
}
