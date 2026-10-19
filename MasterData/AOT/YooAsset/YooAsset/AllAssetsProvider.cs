namespace YooAsset;

internal sealed class AllAssetsProvider : ProviderOperation
{
	private FSLoadAllAssetsOperation _loadAllAssetsOp;

	public AllAssetsProvider(ResourceManager manager, string providerGUID, AssetInfo assetInfo)
		: base(manager, providerGUID, assetInfo)
	{
	}

	protected override void ProcessBundleResult()
	{
		if (_loadAllAssetsOp == null)
		{
			_loadAllAssetsOp = BundleResultObject.LoadAllAssetsAsync(MainAssetInfo);
			_loadAllAssetsOp.StartOperation();
			AddChildOperation(_loadAllAssetsOp);
		}
		if (IsWaitForAsyncComplete)
		{
			_loadAllAssetsOp.WaitForAsyncComplete();
		}
		_loadAllAssetsOp.UpdateOperation();
		Progress = _loadAllAssetsOp.Progress;
		if (_loadAllAssetsOp.IsDone)
		{
			if (_loadAllAssetsOp.Status != EOperationStatus.Succeed)
			{
				InvokeCompletion(_loadAllAssetsOp.Error, EOperationStatus.Failed);
				return;
			}
			AllAssetObjects = _loadAllAssetsOp.Result;
			InvokeCompletion(string.Empty, EOperationStatus.Succeed);
		}
	}
}
