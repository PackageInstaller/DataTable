using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct ReturnToSynchronizationContext(SynchronizationContext syncContext, bool dontPostWhenSameContext, CancellationToken cancellationToken)
{
	private readonly SynchronizationContext syncContext = syncContext;

	private readonly bool dontPostWhenSameContext = dontPostWhenSameContext;

	private readonly CancellationToken cancellationToken = cancellationToken;
}
