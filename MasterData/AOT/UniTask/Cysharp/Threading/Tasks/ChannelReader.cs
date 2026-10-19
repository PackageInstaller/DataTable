using System.Threading;

namespace Cysharp.Threading.Tasks;

public abstract class ChannelReader<T>
{
	public abstract bool TryRead(out T item);

	public abstract UniTask<bool> WaitToReadAsync(CancellationToken cancellationToken = default(CancellationToken));

	public abstract IUniTaskAsyncEnumerable<T> ReadAllAsync(CancellationToken cancellationToken = default(CancellationToken));
}
