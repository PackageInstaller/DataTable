using YooAsset;

namespace ACT;

internal class InitDebugGUIManager : GameLoadingFlowBase
{
	private const string DEBUGGUIMANAGER_NAME = "DebugGUIManager_MVP";

	private AssetHandle _handle;

	internal override EGameLoadingStage Stage => EGameLoadingStage.DebugGUIManager;

	internal override void Init(GameLoadingData data)
	{
		_handle = YooAssets.LoadAssetAsync("DebugGUIManager_MVP");
		_loadState = EGameLoadingState.Loading;
	}

	internal override void Update()
	{
		if (_handle.IsDone)
		{
			if (_handle.Status == EOperationStatus.Succeed)
			{
				_handle.InstantiateSync();
				_loadState = EGameLoadingState.Succeed;
			}
			else
			{
				Error("DebugGUIManager加载失败");
				_loadState = EGameLoadingState.Failed;
			}
		}
	}
}
