using ACT.Battle;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT;

internal class WaitAndPrepareDestroy : WorldLoadStepOperation
{
	private bool _isWaiting = true;

	internal override void OnStart()
	{
		WaitForLoadComplete().Forget();
	}

	internal override void OnUpdate()
	{
		if (!_isWaiting)
		{
			State = OptionState.Succeed;
		}
	}

	private async UniTaskVoid WaitForLoadComplete()
	{
		await UniTask.WaitUntil(() => Singleton<LoadManager>.instance.ActiveHandle == null || (Singleton<LoadManager>.instance.IsComplete && MonoECS.instance.isStartWorld));
		MonoECS.instance.SetStartWorldState(state: false);
		_isWaiting = false;
	}
}
