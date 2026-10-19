using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class Empty<T> : IUniTaskAsyncEnumerable<T>
{
	private class _Empty : IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		public static readonly IUniTaskAsyncEnumerator<T> Instance = new _Empty();

		public T Current => default;

		private _Empty()
		{
		}

		public UniTask<bool> MoveNextAsync()
		{
			return CompletedTasks.False;
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	public static readonly IUniTaskAsyncEnumerable<T> Instance = new Empty<T>();

	private Empty()
	{
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return _Empty.Instance;
	}
}
