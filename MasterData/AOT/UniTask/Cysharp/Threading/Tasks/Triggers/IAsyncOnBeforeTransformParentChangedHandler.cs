namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnBeforeTransformParentChangedHandler
{
	UniTask OnBeforeTransformParentChangedAsync();
}
