using System.Threading;
using System.Threading.Tasks;

namespace Cysharp.Threading.Tasks.Linq;

internal class ToUniTaskAsyncEnumerableTask<T> : IUniTaskAsyncEnumerable<T>
{
	private class _ToUniTaskAsyncEnumerableTask : IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private readonly Task<T> source;

		private CancellationToken cancellationToken;

		private T current;

		private bool called;

		public T Current => current;

		public _ToUniTaskAsyncEnumerableTask(Task<T> source, CancellationToken cancellationToken)
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

	private readonly Task<T> source;

	public ToUniTaskAsyncEnumerableTask(Task<T> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _ToUniTaskAsyncEnumerableTask(source, cancellationToken);
	}
}
