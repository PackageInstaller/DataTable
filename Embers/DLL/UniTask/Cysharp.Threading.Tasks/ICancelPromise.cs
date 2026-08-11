using System.Threading;

namespace Cysharp.Threading.Tasks;

public interface ICancelPromise
{
	bool TrySetCanceled(CancellationToken cancellationToken = default(CancellationToken));
}
