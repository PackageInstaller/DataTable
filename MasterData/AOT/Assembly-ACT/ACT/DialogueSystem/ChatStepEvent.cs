using System;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

[Serializable]
public abstract class ChatStepEvent
{
	public abstract ChatStep AcceptStep { get; }

	public abstract UniTask Invoke(ChatNodeProcessor chat, LuminDialogueContext context, ChatStep step, CancellationToken token);
}
