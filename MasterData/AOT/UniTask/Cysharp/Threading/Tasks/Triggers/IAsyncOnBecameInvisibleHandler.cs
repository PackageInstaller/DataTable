namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnBecameInvisibleHandler
{
	UniTask OnBecameInvisibleAsync();
}
