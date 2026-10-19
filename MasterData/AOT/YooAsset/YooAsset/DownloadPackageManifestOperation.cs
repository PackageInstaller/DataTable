using System.IO;

namespace YooAsset;

internal class DownloadPackageManifestOperation : AsyncOperationBase
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

	internal DownloadPackageManifestOperation(DefaultCacheFileSystem fileSystem, string packageVersion, int timeout)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
		_timeout = timeout;
	}

	internal override void InternalStart()
	{
		_requestCount = WebRequestCounter.GetRequestFailedCount(_fileSystem.PackageName, "DownloadPackageManifestOperation");
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
			if (File.Exists(_fileSystem.GetCachePackageManifestFilePath(_packageVersion)))
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
			string cachePackageManifestFilePath = _fileSystem.GetCachePackageManifestFilePath(_packageVersion);
			string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(_fileSystem.PackageName, _packageVersion);
			string downloadRequestURL = GetDownloadRequestURL(manifestBinaryFileName);
			_webFileRequestOp = new UnityWebFileRequestOperation(downloadRequestURL, cachePackageManifestFilePath, _timeout);
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
			WebRequestCounter.RecordRequestFailed(_fileSystem.PackageName, "DownloadPackageManifestOperation");
		}
	}

	private string GetDownloadRequestURL(string fileName)
	{
		if (_requestCount % 2 == 0)
		{
			return _fileSystem.RemoteServices.GetRemoteMainURL(fileName);
		}
		return _fileSystem.RemoteServices.GetRemoteFallbackURL(fileName);
	}
}
