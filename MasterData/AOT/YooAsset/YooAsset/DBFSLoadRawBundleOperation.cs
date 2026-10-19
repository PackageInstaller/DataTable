namespace YooAsset;

internal class DBFSLoadRawBundleOperation : FSLoadBundleOperation
{
	private enum ESteps
	{
		None,
		LoadBuildinRawBundle,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private readonly PackageBundle _bundle;

	private ESteps _steps;

	internal DBFSLoadRawBundleOperation(DefaultBuildinFileSystem fileSystem, PackageBundle bundle)
	{
		_fileSystem = fileSystem;
		_bundle = bundle;
	}

	internal override void InternalStart()
	{
		DownloadProgress = 1f;
		DownloadedBytes = _bundle.FileSize;
		_steps = ESteps.LoadBuildinRawBundle;
	}

	internal override void InternalUpdate()
	{
		if (_steps != ESteps.None && _steps != ESteps.Done && _steps == ESteps.LoadBuildinRawBundle)
		{
			_steps = ESteps.Done;
			Result = new RawBundleResult(_fileSystem, _bundle);
			Status = EOperationStatus.Succeed;
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (!ExecuteWhileDone())
		{
		}
		_steps = ESteps.Done;
	}
}
