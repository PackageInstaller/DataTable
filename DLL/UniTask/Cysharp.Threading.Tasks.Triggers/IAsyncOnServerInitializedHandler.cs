namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnServerInitializedHandler
{
	UniTask OnServerInitializedAsync();
}
