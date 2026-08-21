using System.Threading;

namespace Cysharp.Threading.Tasks;

public static class UniTaskAsyncEnumerableExtensions
{
	public static UniTaskCancelableAsyncEnumerable<T> WithCancellation<T>(this IUniTaskAsyncEnumerable<T> source, CancellationToken cancellationToken)
	{
		return new UniTaskCancelableAsyncEnumerable<T>(source, cancellationToken);
	}
}
