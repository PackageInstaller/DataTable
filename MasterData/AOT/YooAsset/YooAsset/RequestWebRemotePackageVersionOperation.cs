using System;

namespace YooAsset;

internal class RequestWebRemotePackageVersionOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestPackageVersion,
		Done
	}

	private readonly DefaultWebRemoteFileSystem _fileSystem;

	private readonly bool _appendTimeTicks;

	private readonly int _timeout;

	private UnityWebTextRequestOperation _webTextRequestOp;

	private int _requestCount;

	private ESteps _steps;

	public string PackageVersion { get; private set; }

	internal RequestWebRemotePackageVersionOperation(DefaultWebRemoteFileSystem fileSystem, bool appendTimeTicks, int timeout)
	{
		_fileSystem = fileSystem;
		_appendTimeTicks = appendTimeTicks;
		_timeout = timeout;
	}

	internal override void InternalStart()
	{
		_requestCount = WebRequestCounter.GetRequestFailedCount(_fileSystem.PackageName, "RequestWebRemotePackageVersionOperation");
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
			string packageVersionFileName = YooAssetSettingsData.GetPackageVersionFileName(_fileSystem.PackageName);
			string webRequestURL = GetWebRequestURL(packageVersionFileName);
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
			PackageVersion = _webTextRequestOp.Result;
			if (string.IsNullOrEmpty(PackageVersion))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Web remote package version file content is empty !";
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
			WebRequestCounter.RecordRequestFailed(_fileSystem.PackageName, "RequestWebRemotePackageVersionOperation");
		}
	}

	private string GetWebRequestURL(string fileName)
	{
		string text = ((_requestCount % 2 != 0) ? _fileSystem.RemoteServices.GetRemoteFallbackURL(fileName) : _fileSystem.RemoteServices.GetRemoteMainURL(fileName));
		if (_appendTimeTicks)
		{
			return $"{text}?{DateTime.UtcNow.Ticks}";
		}
		return text;
	}
}
