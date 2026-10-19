using System;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public readonly struct DialogueSubTask(UniTask task, Action skipToEndAction = null)
{
	public readonly UniTask Task = task;

	public readonly Action SkipToEndAction = skipToEndAction;
}
