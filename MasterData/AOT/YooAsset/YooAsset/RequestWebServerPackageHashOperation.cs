namespace YooAsset;

internal class RequestWebServerPackageHashOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestPackageHash,
		Done
	}

	private readonly DefaultWebServerFileSystem _fileSystem;

	private readonly string _packageVersion;

	private readonly int _timeout;

	private UnityWebTextRequestOperation _webTextRequestOp;

	private ESteps _steps;

	public string PackageHash { get; private set; }

	public RequestWebServerPackageHashOperation(DefaultWebServerFileSystem fileSystem, string packageVersion, int timeout)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
		_timeout = timeout;
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
			string url = DownloadSystemHelper.ConvertToWWWPath(_fileSystem.GetWebPackageHashFilePath(_packageVersion));
			_webTextRequestOp = new UnityWebTextRequestOperation(url, _timeout);
			_webTextRequestOp.StartOperation();
			AddChildOperation(_webTextRequestOp);
		}
		_webTextRequestOp.UpdateOperation();
		Progress = _webTextRequestOp.Progress;
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
				Error = "Web server package hash file content is empty !";
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
