namespace Cysharp.Threading.Tasks;

public interface IUniTaskAsyncDisposable
{
	UniTask DisposeAsync();
}
