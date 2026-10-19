using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Cast<TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private class _Cast : AsyncEnumeratorBase<object, TResult>
	{
		public _Cast(IUniTaskAsyncEnumerable<object> source, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				Current = (TResult)SourceCurrent;
				result = true;
				return true;
			}
			result = false;
			return true;
		}
	}

	private readonly IUniTaskAsyncEnumerable<object> source;

	public Cast(IUniTaskAsyncEnumerable<object> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Cast(source, cancellationToken);
	}
}
