namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOneShotTrigger
{
	UniTask OneShotAsync();
}
