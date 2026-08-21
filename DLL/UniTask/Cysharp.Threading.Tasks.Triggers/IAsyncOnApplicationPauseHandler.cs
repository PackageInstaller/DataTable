namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnApplicationPauseHandler
{
	UniTask<bool> OnApplicationPauseAsync();
}
