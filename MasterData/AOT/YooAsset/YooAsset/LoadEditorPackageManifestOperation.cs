using System.IO;

namespace YooAsset;

internal class LoadEditorPackageManifestOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		LoadFileData,
		VerifyFileData,
		LoadManifest,
		Done
	}

	private readonly DefaultEditorFileSystem _fileSystem;

	private readonly string _packageVersion;

	private readonly string _packageHash;

	private DeserializeManifestOperation _deserializer;

	private byte[] _fileData;

	private ESteps _steps;

	public PackageManifest Manifest { get; private set; }

	internal LoadEditorPackageManifestOperation(DefaultEditorFileSystem fileSystem, string packageVersion, string packageHash)
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
			string editorPackageManifestFilePath = _fileSystem.GetEditorPackageManifestFilePath(_packageVersion);
			if (File.Exists(editorPackageManifestFilePath))
			{
				_steps = ESteps.VerifyFileData;
				_fileData = FileUtility.ReadAllBytes(editorPackageManifestFilePath);
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Can not found simulation package manifest file : " + editorPackageManifestFilePath;
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
				Error = "Failed to verify simulation package manifest file !";
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
