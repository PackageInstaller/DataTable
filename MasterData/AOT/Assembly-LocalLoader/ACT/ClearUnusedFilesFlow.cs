namespace ACT;

internal class ClearUnusedFilesFlow : DownloadAssetSubFlowBase
{
	internal override EGameLoadingStage Stage => EGameLoadingStage.ClearUnusedFiles;

	internal ClearUnusedFilesFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Succeed;
	}
}
