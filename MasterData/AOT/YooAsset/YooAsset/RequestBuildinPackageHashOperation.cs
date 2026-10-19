namespace YooAsset;

internal class RequestBuildinPackageHashOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestPackageHash,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private readonly string _packageVersion;

	private UnityWebTextRequestOperation _webTextRequestOp;

	private ESteps _steps;

	public string PackageHash { get; private set; }

	internal RequestBuildinPackageHashOperation(DefaultBuildinFileSystem fileSystem, string packageVersion)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.RequestPackageHash;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.RequestPackageHash)
		{
			return;
		}
		if (_webTextRequestOp == null)
		{
			string url = DownloadSystemHelper.ConvertToWWWPath(_fileSystem.GetBuildinPackageHashFilePath(_packageVersion));
			_webTextRequestOp = new UnityWebTextRequestOperation(url);
			_webTextRequestOp.StartOperation();
			AddChildOperation(_webTextRequestOp);
		}
		_webTextRequestOp.UpdateOperation();
		if (!_webTextRequestOp.IsDone)
		{
			return;
		}
		if (_webTextRequestOp.Status == EOperationStatus.Succeed)
		{
			PackageHash = _webTextRequestOp.Result;
			if (string.IsNullOrEmpty(PackageHash))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Buildin package hash file content is empty !";
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = _webTextRequestOp.Error;
		}
	}
}
