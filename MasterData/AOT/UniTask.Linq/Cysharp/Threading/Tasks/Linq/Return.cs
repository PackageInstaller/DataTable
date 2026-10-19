using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class Return<TValue> : IUniTaskAsyncEnumerable<TValue>
{
	private class _Return : IUniTaskAsyncEnumerator<TValue>, IUniTaskAsyncDisposable
	{
		private readonly TValue value;

		private CancellationToken cancellationToken;

		private bool called;

		public TValue Current => value;

		public _Return(TValue value, CancellationToken cancellationToken)
		{
			this.value = value;
			this.cancellationToken = cancellationToken;
			called = false;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (!called)
			{
				called = true;
				return CompletedTasks.True;
			}
			return CompletedTasks.False;
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	private readonly TValue value;

	public Return(TValue value)
	{
		this.value = value;
	}

	public IUniTaskAsyncEnumerator<TValue> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Return(value, cancellationToken);
	}
}
