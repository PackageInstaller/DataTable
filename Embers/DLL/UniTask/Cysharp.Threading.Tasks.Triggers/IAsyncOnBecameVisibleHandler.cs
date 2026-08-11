namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnBecameVisibleHandler
{
	UniTask OnBecameVisibleAsync();
}
