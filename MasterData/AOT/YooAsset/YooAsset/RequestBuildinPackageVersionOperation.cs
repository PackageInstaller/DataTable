namespace YooAsset;

internal class RequestBuildinPackageVersionOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestPackageVersion,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private UnityWebTextRequestOperation _webTextRequestOp;

	private ESteps _steps;

	public string PackageVersion { get; private set; }

	internal RequestBuildinPackageVersionOperation(DefaultBuildinFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.RequestPackageVersion;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.RequestPackageVersion)
		{
			return;
		}
		if (_webTextRequestOp == null)
		{
			string url = DownloadSystemHelper.ConvertToWWWPath(_fileSystem.GetBuildinPackageVersionFilePath());
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
			PackageVersion = _webTextRequestOp.Result;
			if (string.IsNullOrEmpty(PackageVersion))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Buildin package version file content is empty !";
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
