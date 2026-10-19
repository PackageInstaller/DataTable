using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct ReturnToMainThread(PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken)
{
	private readonly PlayerLoopTiming playerLoopTiming = playerLoopTiming;

	private readonly CancellationToken cancellationToken = cancellationToken;
}
