namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncResetHandler
{
	UniTask ResetAsync();
}
