using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Reverse<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Reverse : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken;

		private TSource[] array;

		private int index;

		public TSource Current { get; private set; }

		public _Reverse(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
		{
			this.source = source;
			this.cancellationToken = cancellationToken;
		}

		public async UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (array == null)
			{
				array = await source.ToArrayAsync(cancellationToken);
				index = array.Length - 1;
			}
			if (index != -1)
			{
				Current = array[index];
				index--;
				return true;
			}
			return false;
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	public Reverse(IUniTaskAsyncEnumerable<TSource> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Reverse(source, cancellationToken);
	}
}
