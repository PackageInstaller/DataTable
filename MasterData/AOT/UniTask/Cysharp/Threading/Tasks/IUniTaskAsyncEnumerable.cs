using System.Threading;

namespace Cysharp.Threading.Tasks;

public interface IUniTaskAsyncEnumerable<out T>
{
	IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken));
}
