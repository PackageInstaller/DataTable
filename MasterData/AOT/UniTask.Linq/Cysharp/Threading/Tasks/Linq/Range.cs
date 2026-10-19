using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class Range : IUniTaskAsyncEnumerable<int>
{
	private class _Range : IUniTaskAsyncEnumerator<int>, IUniTaskAsyncDisposable
	{
		private readonly int start;

		private readonly int end;

		private int current;

		private CancellationToken cancellationToken;

		public int Current => current;

		public _Range(int start, int end, CancellationToken cancellationToken)
		{
			this.start = start;
			this.end = end;
			this.cancellationToken = cancellationToken;
			current = start - 1;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			current++;
			if (current != end)
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

	private readonly int start;

	private readonly int end;

	public Range(int start, int count)
	{
		this.start = start;
		end = start + count;
	}

	public IUniTaskAsyncEnumerator<int> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Range(start, end, cancellationToken);
	}
}
