using System.IO;

namespace YooAsset;

internal class DownloadPackageHashOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		CheckExist,
		DownloadFile,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly string _packageVersion;

	private readonly int _timeout;

	private UnityWebFileRequestOperation _webFileRequestOp;

	private int _requestCount;

	private ESteps _steps;

	internal DownloadPackageHashOperation(DefaultCacheFileSystem fileSystem, string packageVersion, int timeout)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
		_timeout = timeout;
	}

	internal override void InternalStart()
	{
		_requestCount = WebRequestCounter.GetRequestFailedCount(_fileSystem.PackageName, "DownloadPackageHashOperation");
		_steps = ESteps.CheckExist;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.CheckExist)
		{
			if (File.Exists(_fileSystem.GetCachePackageHashFilePath(_packageVersion)))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.DownloadFile;
			}
		}
		if (_steps != ESteps.DownloadFile)
		{
			return;
		}
		if (_webFileRequestOp == null)
		{
			string cachePackageHashFilePath = _fileSystem.GetCachePackageHashFilePath(_packageVersion);
			string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(_fileSystem.PackageName, _packageVersion);
			string webRequestURL = GetWebRequestURL(packageHashFileName);
			_webFileRequestOp = new UnityWebFileRequestOperation(webRequestURL, cachePackageHashFilePath, _timeout);
			_webFileRequestOp.StartOperation();
			AddChildOperation(_webFileRequestOp);
		}
		_webFileRequestOp.UpdateOperation();
		if (_webFileRequestOp.IsDone)
		{
			if (_webFileRequestOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
				return;
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = _webFileRequestOp.Error;
			WebRequestCounter.RecordRequestFailed(_fileSystem.PackageName, "DownloadPackageHashOperation");
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
