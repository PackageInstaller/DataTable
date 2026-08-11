namespace Cysharp.Threading.Tasks.Triggers;

public interface IAsyncOnJointBreakHandler
{
	UniTask<float> OnJointBreakAsync();
}
