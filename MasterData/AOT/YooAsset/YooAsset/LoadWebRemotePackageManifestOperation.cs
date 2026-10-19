namespace YooAsset;

internal class LoadWebRemotePackageManifestOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestFileData,
		VerifyFileData,
		LoadManifest,
		Done
	}

	private readonly DefaultWebRemoteFileSystem _fileSystem;

	private readonly string _packageVersion;

	private readonly string _packageHash;

	private UnityWebDataRequestOperation _webDataRequestOp;

	private DeserializeManifestOperation _deserializer;

	private int _requestCount;

	private ESteps _steps;

	public PackageManifest Manifest { get; private set; }

	internal LoadWebRemotePackageManifestOperation(DefaultWebRemoteFileSystem fileSystem, string packageVersion, string packageHash)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
		_packageHash = packageHash;
	}

	internal override void InternalStart()
	{
		_requestCount = WebRequestCounter.GetRequestFailedCount(_fileSystem.PackageName, "LoadWebRemotePackageManifestOperation");
		_steps = ESteps.RequestFileData;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.RequestFileData)
		{
			if (_webDataRequestOp == null)
			{
				string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(_fileSystem.PackageName, _packageVersion);
				string webRequestURL = GetWebRequestURL(manifestBinaryFileName);
				_webDataRequestOp = new UnityWebDataRequestOperation(webRequestURL);
				_webDataRequestOp.StartOperation();
				AddChildOperation(_webDataRequestOp);
			}
			_webDataRequestOp.UpdateOperation();
			if (!_webDataRequestOp.IsDone)
			{
				return;
			}
			if (_webDataRequestOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.VerifyFileData;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _webDataRequestOp.Error;
				WebRequestCounter.RecordRequestFailed(_fileSystem.PackageName, "LoadWebRemotePackageManifestOperation");
			}
		}
		if (_steps == ESteps.VerifyFileData)
		{
			if (ManifestTools.VerifyManifestData(_webDataRequestOp.Result, _packageHash))
			{
				_steps = ESteps.LoadManifest;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Failed to verify web remote package manifest file!";
			}
		}
		if (_steps != ESteps.LoadManifest)
		{
			return;
		}
		if (_deserializer == null)
		{
			_deserializer = new DeserializeManifestOperation(_webDataRequestOp.Result);
			_deserializer.StartOperation();
			AddChildOperation(_deserializer);
		}
		_deserializer.UpdateOperation();
		Progress = _deserializer.Progress;
		if (_deserializer.IsDone)
		{
			if (_deserializer.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.Done;
				Manifest = _deserializer.Manifest;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _deserializer.Error;
			}
		}
	}

	internal override string InternalGetDesc()
	{
		return "PackageVersion : " + _packageVersion + " PackageHash : " + _packageHash;
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
