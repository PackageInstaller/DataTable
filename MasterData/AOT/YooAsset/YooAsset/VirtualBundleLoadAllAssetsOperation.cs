namespace YooAsset;

internal class VirtualBundleLoadAllAssetsOperation : FSLoadAllAssetsOperation
{
	protected enum ESteps
	{
		None,
		CheckBundle,
		LoadAsset,
		CheckResult,
		Done
	}

	private readonly PackageBundle _packageBundle;

	private readonly AssetInfo _assetInfo;

	private ESteps _steps;

	public VirtualBundleLoadAllAssetsOperation(PackageBundle packageBundle, AssetInfo assetInfo)
	{
		_packageBundle = packageBundle;
		_assetInfo = assetInfo;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.Done;
		Error = "VirtualBundleLoadAllAssetsOperation only support unity editor platform !";
		Status = EOperationStatus.Failed;
	}

	internal override void InternalUpdate()
	{
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (!ExecuteWhileDone())
		{
		}
		_steps = ESteps.Done;
	}
}
