using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class Never<T> : IUniTaskAsyncEnumerable<T>
{
	private class _Never : IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private CancellationToken cancellationToken;

		public T Current => default;

		public _Never(CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			UniTaskCompletionSource<bool> uniTaskCompletionSource = new UniTaskCompletionSource<bool>();
			cancellationToken.Register((object state) =>
			{
				((UniTaskCompletionSource<bool>)state).TrySetCanceled(cancellationToken);
			}, uniTaskCompletionSource);
			return uniTaskCompletionSource.Task;
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	public static readonly IUniTaskAsyncEnumerable<T> Instance = new Never<T>();

	private Never()
	{
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Never(cancellationToken);
	}
}
