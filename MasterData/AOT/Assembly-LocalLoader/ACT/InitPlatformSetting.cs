using UnityEngine;

namespace ACT;

internal class InitPlatformSetting : GameLoadingFlowBase
{
	private RuntimePlatform _runtimePlatform = Application.platform;

	internal override int TotalRetryCount => 0;

	internal override EGameLoadingStage Stage => EGameLoadingStage.InitPlatformSetting;

	internal override void Init(GameLoadingData data)
	{
		Application.runInBackground = true;
		Application.backgroundLoadingPriority = ThreadPriority.Normal;
		QualitySettings.vSyncCount = 0;
		Screen.sleepTimeout = -1;
		base.Init(data);
	}
}
