using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class OfType<TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _OfType : AsyncEnumeratorBase<object, TResult>
	{
		public _OfType(IUniTaskAsyncEnumerable<object> source, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				if (SourceCurrent is TResult current)
				{
					Current = current;
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

	private readonly IUniTaskAsyncEnumerable<object> source;

	public OfType(IUniTaskAsyncEnumerable<object> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _OfType(source, cancellationToken);
	}
}
