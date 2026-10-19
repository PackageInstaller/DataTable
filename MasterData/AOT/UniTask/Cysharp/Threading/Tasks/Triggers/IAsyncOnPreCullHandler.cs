namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPreCullHandler
{
	UniTask OnPreCullAsync();
}
