using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class ToUniTaskAsyncEnumerable<T> : IUniTaskAsyncEnumerable<T>
{
	private class _ToUniTaskAsyncEnumerable : IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private readonly IEnumerable<T> source;

		private CancellationToken cancellationToken;

		private IEnumerator<T> enumerator;

		public T Current => enumerator.Current;

		public _ToUniTaskAsyncEnumerable(IEnumerable<T> source, CancellationToken cancellationToken)
		{
			this.source = source;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (enumerator == null)
			{
				enumerator = source.GetEnumerator();
			}
			if (enumerator.MoveNext())
			{
				return CompletedTasks.True;
			}
			return CompletedTasks.False;
		}

		public UniTask DisposeAsync()
		{
			enumerator.Dispose();
			return default;
		}
	}

	private readonly IEnumerable<T> source;

	public ToUniTaskAsyncEnumerable(IEnumerable<T> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _ToUniTaskAsyncEnumerable(source, cancellationToken);
	}
}
