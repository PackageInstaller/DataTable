namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnTransformChildrenChangedHandler
{
	UniTask OnTransformChildrenChangedAsync();
}
