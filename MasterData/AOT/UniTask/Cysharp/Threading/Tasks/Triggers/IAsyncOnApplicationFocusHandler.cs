namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnApplicationFocusHandler
{
	UniTask<bool> OnApplicationFocusAsync();
}
