namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnDisableHandler
{
	UniTask OnDisableAsync();
}
