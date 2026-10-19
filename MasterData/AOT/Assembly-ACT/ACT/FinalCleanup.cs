using ACT.Battle;
using ACT.Event;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Rendering.Universal;

namespace ACT;

internal class FinalCleanup : WorldLoadStepOperation
{
	private bool _isWaiting = true;

	internal override void OnStart()
	{
		FinalCleanupAsync().Forget();
	}

	internal override void OnUpdate()
	{
		if (!_isWaiting)
		{
			State = OptionState.Succeed;
		}
	}

	private async UniTaskVoid FinalCleanupAsync()
	{
		SimpleLoadProgressHandle handle = Singleton<LoadManager>.instance.ActiveHandle as SimpleLoadProgressHandle;
		if (handle != null)
		{
			handle.Progress = 0.5f;
		}
		MonoECS.instance.RemoveNetworkListener();
		_ = LuminApplication.LogEnabled;
		GamepadRumbleManager.StopAll();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Game_Logout, null);
		TimeManager.EndGame();
		UniversalRenderPipeline.SetBaseCameraSkip(skip: true);
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LOGINWAITCLICK, true);
		await AssetStationManager.UnloadUnusedYooAssetsAsync("Assets");
		await AssetStationManager.UnloadUnusedUnityAssetsAsync();
		if (handle != null)
		{
			handle.Progress = 1f;
		}
		_isWaiting = false;
		await UniTask.WaitUntil(() => !Singleton<LoadManager>.instance.InLoading);
		UniversalRenderPipeline.SetBaseCameraSkip(skip: true);
		LuminApplication.RuntimeInfo.ResetRecording();
		LuminApplication.RuntimeInfo.SetChunkId(-1);
		LuminApplication.RuntimeInfo.SetUiType(-1);
		Singleton<GameState>.instance.SetGameRunningState(GameRunningState.Login);
	}
}
