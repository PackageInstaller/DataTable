using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Skip<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Skip : AsyncEnumeratorBase<TSource, TSource>
	{
		private readonly int count;

		private int index;

		public _Skip(IUniTaskAsyncEnumerable<TSource> source, int count, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.count = count;
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				if (count <= checked(index++))
				{
					Current = SourceCurrent;
					result = true;
					return true;
				}
				result = false;
				return false;
			}
			result = false;
			return true;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly int count;

	public Skip(IUniTaskAsyncEnumerable<TSource> source, int count)
	{
		this.source = source;
		this.count = count;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Skip(source, count, cancellationToken);
	}
}
