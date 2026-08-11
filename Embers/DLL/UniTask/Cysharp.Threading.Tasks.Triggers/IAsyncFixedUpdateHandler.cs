namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncFixedUpdateHandler
{
	UniTask FixedUpdateAsync();
}
