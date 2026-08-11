using System.Threading;

namespace Cysharp.Threading.Tasks;

public abstract class ChannelReader<T>
{
	public abstract UniTask Completion { get; }

	public abstract bool TryRead(out T item);

	public abstract UniTask<bool> WaitToReadAsync(CancellationToken cancellationToken = default(CancellationToken));

	public virtual UniTask<T> ReadAsync(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (TryRead(out var item))
		{
			return UniTask.FromResult(item);
		}
		return ReadAsyncCore(cancellationToken);
	}

	private async UniTask<T> ReadAsyncCore(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (await WaitToReadAsync(cancellationToken) && TryRead(out var item))
		{
			return item;
		}
		throw new ChannelClosedException();
	}

	public abstract IUniTaskAsyncEnumerable<T> ReadAllAsync(CancellationToken cancellationToken = default(CancellationToken));
}
