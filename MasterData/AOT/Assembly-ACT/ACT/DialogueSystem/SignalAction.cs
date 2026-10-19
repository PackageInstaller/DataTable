using System;

namespace ACT.DialogueSystem;

[Serializable]
public abstract class SignalAction
{
	public abstract bool CanSkip { get; }

	public abstract void Invoke(ISignalEmitter emitter);
}
