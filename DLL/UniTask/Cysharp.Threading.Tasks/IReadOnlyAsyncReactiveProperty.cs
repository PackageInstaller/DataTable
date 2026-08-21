using System.Threading;

namespace Cysharp.Threading.Tasks;

public interface IReadOnlyAsyncReactiveProperty<T> : IUniTaskAsyncEnumerable<T>
{
	T Value { get; }

	IUniTaskAsyncEnumerable<T> WithoutCurrent();

	UniTask<T> WaitAsync(CancellationToken cancellationToken = default(CancellationToken));
}
