using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class ToUniTaskAsyncEnumerableUniTask<T> : IUniTaskAsyncEnumerable<T>
{
	private class _ToUniTaskAsyncEnumerableUniTask : IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private readonly UniTask<T> source;

		private CancellationToken cancellationToken;

		private T current;

		private bool called;

		public T Current => current;

		public _ToUniTaskAsyncEnumerableUniTask(UniTask<T> source, CancellationToken cancellationToken)
		{
			this.source = source;
			this.cancellationToken = cancellationToken;
			called = false;
		}

		public async UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (called)
			{
				return false;
			}
			called = true;
			current = await source;
			return true;
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	private readonly UniTask<T> source;

	public ToUniTaskAsyncEnumerableUniTask(UniTask<T> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _ToUniTaskAsyncEnumerableUniTask(source, cancellationToken);
	}
}
