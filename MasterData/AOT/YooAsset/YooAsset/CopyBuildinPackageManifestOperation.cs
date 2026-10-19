using System.IO;

namespace YooAsset;

internal class CopyBuildinPackageManifestOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		RequestPackageVersion,
		CheckHashFile,
		UnpackHashFile,
		CheckManifestFile,
		UnpackManifestFile,
		Done
	}

	private readonly DefaultBuildinFileSystem _fileSystem;

	private RequestBuildinPackageVersionOperation _requestBuildinPackageVersionOp;

	private UnityWebFileRequestOperation _hashFileRequestOp;

	private UnityWebFileRequestOperation _manifestFileRequestOp;

	private string _buildinPackageVersion;

	private ESteps _steps;

	public CopyBuildinPackageManifestOperation(DefaultBuildinFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.RequestPackageVersion;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.RequestPackageVersion)
		{
			if (_requestBuildinPackageVersionOp == null)
			{
				_requestBuildinPackageVersionOp = new RequestBuildinPackageVersionOperation(_fileSystem);
				_requestBuildinPackageVersionOp.StartOperation();
				AddChildOperation(_requestBuildinPackageVersionOp);
			}
			_requestBuildinPackageVersionOp.UpdateOperation();
			if (!_requestBuildinPackageVersionOp.IsDone)
			{
				return;
			}
			if (_requestBuildinPackageVersionOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.CheckHashFile;
				_buildinPackageVersion = _requestBuildinPackageVersionOp.PackageVersion;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _requestBuildinPackageVersionOp.Error;
			}
		}
		if (_steps == ESteps.CheckHashFile)
		{
			if (File.Exists(GetCopyPackageHashDestPath(_buildinPackageVersion)))
			{
				_steps = ESteps.CheckManifestFile;
				return;
			}
			_steps = ESteps.UnpackHashFile;
		}
		if (_steps == ESteps.UnpackHashFile)
		{
			if (_hashFileRequestOp == null)
			{
				string buildinPackageHashFilePath = _fileSystem.GetBuildinPackageHashFilePath(_buildinPackageVersion);
				string copyPackageHashDestPath = GetCopyPackageHashDestPath(_buildinPackageVersion);
				string url = DownloadSystemHelper.ConvertToWWWPath(buildinPackageHashFilePath);
				_hashFileRequestOp = new UnityWebFileRequestOperation(url, copyPackageHashDestPath);
				_hashFileRequestOp.StartOperation();
				AddChildOperation(_hashFileRequestOp);
			}
			_hashFileRequestOp.UpdateOperation();
			if (!_hashFileRequestOp.IsDone)
			{
				return;
			}
			if (_hashFileRequestOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.CheckManifestFile;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _hashFileRequestOp.Error;
			}
		}
		if (_steps == ESteps.CheckManifestFile)
		{
			if (File.Exists(GetCopyPackageManifestDestPath(_buildinPackageVersion)))
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
				return;
			}
			_steps = ESteps.UnpackManifestFile;
		}
		if (_steps != ESteps.UnpackManifestFile)
		{
			return;
		}
		if (_manifestFileRequestOp == null)
		{
			string buildinPackageManifestFilePath = _fileSystem.GetBuildinPackageManifestFilePath(_buildinPackageVersion);
			string copyPackageManifestDestPath = GetCopyPackageManifestDestPath(_buildinPackageVersion);
			string url2 = DownloadSystemHelper.ConvertToWWWPath(buildinPackageManifestFilePath);
			_manifestFileRequestOp = new UnityWebFileRequestOperation(url2, copyPackageManifestDestPath);
			_manifestFileRequestOp.StartOperation();
			AddChildOperation(_manifestFileRequestOp);
		}
		_manifestFileRequestOp.UpdateOperation();
		if (_manifestFileRequestOp.IsDone)
		{
			if (_manifestFileRequestOp.Status == EOperationStatus.Succeed)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = _manifestFileRequestOp.Error;
			}
		}
	}

	private string GetCopyManifestFileRoot()
	{
		string text = _fileSystem.CopyBuildinPackageManifestDestRoot;
		if (string.IsNullOrEmpty(text))
		{
			text = PathUtility.Combine(YooAssetSettingsData.GetYooDefaultCacheRoot(), _fileSystem.PackageName, "ManifestFiles");
		}
		return text;
	}

	private string GetCopyPackageHashDestPath(string packageVersion)
	{
		string copyManifestFileRoot = GetCopyManifestFileRoot();
		string packageHashFileName = YooAssetSettingsData.GetPackageHashFileName(_fileSystem.PackageName, packageVersion);
		return PathUtility.Combine(copyManifestFileRoot, packageHashFileName);
	}

	private string GetCopyPackageManifestDestPath(string packageVersion)
	{
		string copyManifestFileRoot = GetCopyManifestFileRoot();
		string manifestBinaryFileName = YooAssetSettingsData.GetManifestBinaryFileName(_fileSystem.PackageName, packageVersion);
		return PathUtility.Combine(copyManifestFileRoot, manifestBinaryFileName);
	}
}
