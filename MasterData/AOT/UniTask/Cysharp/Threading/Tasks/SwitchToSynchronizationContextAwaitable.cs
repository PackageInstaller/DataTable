using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct SwitchToSynchronizationContextAwaitable(SynchronizationContext synchronizationContext, CancellationToken cancellationToken)
{
	private readonly SynchronizationContext synchronizationContext = synchronizationContext;

	private readonly CancellationToken cancellationToken = cancellationToken;
}
