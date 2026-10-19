using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class Throw<TValue> : IUniTaskAsyncEnumerable<TValue>
{
	private class _Throw : IUniTaskAsyncEnumerator<TValue>, IUniTaskAsyncDisposable
	{
		private readonly Exception exception;

		private CancellationToken cancellationToken;

		public TValue Current => default;

		public _Throw(Exception exception, CancellationToken cancellationToken)
		{
			this.exception = exception;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			return UniTask.FromException<bool>(exception);
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	private readonly Exception exception;

	public Throw(Exception exception)
	{
		this.exception = exception;
	}

	public IUniTaskAsyncEnumerator<TValue> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Throw(exception, cancellationToken);
	}
}
