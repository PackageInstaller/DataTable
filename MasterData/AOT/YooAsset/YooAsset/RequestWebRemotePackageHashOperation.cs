namespace YooAsset;

internal class RequestWebRemotePackageHashOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestPackageHash,
		Done
	}

	private readonly DefaultWebRemoteFileSystem _fileSystem;

	private readonly string _packageVersion;

	private readonly int _timeout;

	private UnityWebTextRequestOperation _webTextRequestOp;

	private int _requestCount;

	private ESteps _steps;

	public string PackageHash { get; private set; }

	public RequestWebRemotePackageHashOperation(DefaultWebRemoteFileSystem fileSystem, string packageVersion, int timeout)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
		_timeout = timeout;
	}

	internal override void InternalStart()
	{
		_requestCount = WebRequestCounter.GetRequestFailedCount(_fileSystem.PackageName, "RequestWebRemotePackageHashOperation");
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
			string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(_fileSystem.PackageName, _packageVersion);
			string webRequestURL = GetWebRequestURL(packageHashFileName);
			_webTextRequestOp = new UnityWebTextRequestOperation(webRequestURL, _timeout);
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
				Error = "Web remote package hash file content is empty !";
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
			WebRequestCounter.RecordRequestFailed(_fileSystem.PackageName, "RequestWebRemotePackageHashOperation");
		}
	}

	private string GetWebRequestURL(string fileName)
	{
		if (_requestCount % 2 == 0)
		{
			return _fileSystem.RemoteServices.GetRemoteMainURL(fileName);
		}
		return _fileSystem.RemoteServices.GetRemoteFallbackURL(fileName);
	}
}
