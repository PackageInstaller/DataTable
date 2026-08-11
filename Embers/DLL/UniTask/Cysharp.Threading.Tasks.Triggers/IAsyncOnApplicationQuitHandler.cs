namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnApplicationQuitHandler
{
	UniTask OnApplicationQuitAsync();
}
