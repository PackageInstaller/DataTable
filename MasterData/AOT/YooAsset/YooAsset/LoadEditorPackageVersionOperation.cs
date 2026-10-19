using System.IO;

namespace YooAsset;

internal class LoadEditorPackageVersionOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		LoadVersion,
		Done
	}

	private readonly DefaultEditorFileSystem _fileSystem;

	private ESteps _steps;

	public string PackageVersion { get; private set; }

	internal LoadEditorPackageVersionOperation(DefaultEditorFileSystem fileSystem)
	{
		_fileSystem = fileSystem;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.LoadVersion;
	}

	internal override void InternalUpdate()
	{
		if (_steps != ESteps.None && _steps != ESteps.Done && _steps == ESteps.LoadVersion)
		{
			string editorPackageVersionFilePath = _fileSystem.GetEditorPackageVersionFilePath();
			if (File.Exists(editorPackageVersionFilePath))
			{
				_steps = ESteps.Done;
				PackageVersion = FileUtility.ReadAllText(editorPackageVersionFilePath);
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "Can not found simulation package version file : " + editorPackageVersionFilePath;
			}
		}
	}
}
