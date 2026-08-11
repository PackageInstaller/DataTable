namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncLateUpdateHandler
{
	UniTask LateUpdateAsync();
}
