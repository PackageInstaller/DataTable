namespace Cysharp.Threading.Tasks;

public interface IUniTaskAsyncEnumerator<out T> : IUniTaskAsyncDisposable
{
	T Current { get; }

	UniTask<bool> MoveNextAsync();
}
