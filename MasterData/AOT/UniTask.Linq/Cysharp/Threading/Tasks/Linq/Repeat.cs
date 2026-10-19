using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class Repeat<TElement> : IUniTaskAsyncEnumerable<TElement>
{
	private class _Repeat : IUniTaskAsyncEnumerator<TElement>, IUniTaskAsyncDisposable
	{
		private readonly TElement element;

		private readonly int count;

		private int remaining;

		private CancellationToken cancellationToken;

		public TElement Current => element;

		public _Repeat(TElement element, int count, CancellationToken cancellationToken)
		{
			this.element = element;
			this.count = count;
			this.cancellationToken = cancellationToken;
			remaining = count;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (remaining-- != 0)
			{
				return CompletedTasks.True;
			}
			return CompletedTasks.False;
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	private readonly TElement element;

	private readonly int count;

	public Repeat(TElement element, int count)
	{
		this.element = element;
		this.count = count;
	}

	public IUniTaskAsyncEnumerator<TElement> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Repeat(element, count, cancellationToken);
	}
}
