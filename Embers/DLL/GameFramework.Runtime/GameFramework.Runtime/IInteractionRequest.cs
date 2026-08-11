using System;

namespace GameFramework.Runtime;

public interface IInteractionRequest
{
	event EventHandler<InteractionEventArgs> Raised;
}
