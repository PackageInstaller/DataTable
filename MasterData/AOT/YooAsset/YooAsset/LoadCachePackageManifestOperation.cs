using System.IO;

namespace YooAsset;

internal class LoadCachePackageManifestOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		LoadFileData,
		VerifyFileData,
		LoadManifest,
		Done
	}

	private readonly DefaultCacheFileSystem _fileSystem;

	private readonly string _packageVersion;

	private readonly string _packageHash;

	private DeserializeManifestOperation _deserializer;

	private byte[] _fileData;

	private ESteps _steps;

	public PackageManifest Manifest { get; private set; }

	internal LoadCachePackageManifestOperation(DefaultCacheFileSystem fileSystem, string packageVersion, string packageHash)
	{
		_fileSystem = fileSystem;
		_packageVersion = packageVersion;
		_packageHash = packageHash;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.LoadFileData;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.LoadFileData)
		{
			string cachePackageManifestFilePath = _fileSystem.GetCachePackageManifestFilePath(_packageVersion);
			if (File.Exists(cachePackageManifestFilePath))
			{
				_steps = ESteps.VerifyFileData;
				_fileData = File.ReadAllBytes(cachePackageManifestFilePath);
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Can not found cache manifest file : " + cachePackageManifestFilePath;
			}
		}
		if (_steps == ESteps.VerifyFileData)
		{
			if (ManifestTools.VerifyManifestData(_fileData, _packageHash))
			{
				_steps = ESteps.LoadManifest;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Failed to verify cache package manifest file!";
			}
		}
		if (_steps != ESteps.LoadManifest)
		{
			return;
		}
		if (_deserializer == null)
		{
			_deserializer = new DeserializeManifestOperation(_fileData);
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
}
