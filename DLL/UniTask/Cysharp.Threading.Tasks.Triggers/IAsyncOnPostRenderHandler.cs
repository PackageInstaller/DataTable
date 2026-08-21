namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnPostRenderHandler
{
	UniTask OnPostRenderAsync();
}
