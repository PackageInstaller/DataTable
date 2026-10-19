using System.IO;

namespace YooAsset;

internal class LoadCachePackageHashOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		LoadPackageHash,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly string _packageVersion;

	private ESteps _steps;

	public string PackageHash { get; private set; }

	internal LoadCachePackageHashOperation(DefaultCacheFileSystem fileSystem, string packageVersion)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.LoadPackageHash;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.LoadPackageHash)
		{
			return;
		}
		string cachePackageHashFilePath = _fileSystem.GetCachePackageHashFilePath(_packageVersion);
		if (!File.Exists(cachePackageHashFilePath))
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "Can not found cache package hash file : " + cachePackageHashFilePath;
			return;
		}
		PackageHash = FileUtility.ReadAllText(cachePackageHashFilePath);
		if (string.IsNullOrEmpty(PackageHash))
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Failed;
			Error = "Cache package hash file content is empty !";
		}
		else
		{
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}
}
